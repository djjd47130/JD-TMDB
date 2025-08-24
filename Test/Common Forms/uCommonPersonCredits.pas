unit uCommonPersonCredits;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common, JD.TMDB.Intf, JD.TMDB.Impl, JD.TabController;

type
  TCombinedCreditType = (cctMovie, cctTV, cctCombined);

  TCreditListObj = class(TObject)
    FMedium: ITMDBMedium;
    FType: TTMDBMediaType;
  end;

  TfrmCommonPersonCredits = class(TfrmCommonFormBase)
    lstResults: TListView;
  private
    FCredits: ITMDBCombinedCredits;
    FType: TCombinedCreditType;
    procedure ClearList;
    procedure PopulateList;
    procedure PopulateCastItem(AItem: TListItem; M: ITMDBCombinedCastCredit);
    procedure PopulateCrewItem(AItem: TListItem; M: ITMDBCombinedCrewCredit);
    function MediaTypeStr(T: TTMDBMediaType): String;
  public
    procedure LoadMovieCredits(ACredits: ITMDBCombinedCredits);
    procedure LoadTVCredits(ACredits: ITMDBCombinedCredits);
    procedure LoadCombinedCredits(ACredits: ITMDBCombinedCredits);
  end;

var
  frmCommonPersonCredits: TfrmCommonPersonCredits;

implementation

{$R *.dfm}

uses
  uMain;

{ TfrmCommonPersonCredits }

procedure TfrmCommonPersonCredits.ClearList;
begin
  for var X := 0 to lstResults.Items.Count-1 do begin
    TCreditListObj(lstResults.Items[X].Data).Free;
  end;
  lstResults.Items.Clear;
end;

procedure TfrmCommonPersonCredits.LoadCombinedCredits(
  ACredits: ITMDBCombinedCredits);
begin
  FCredits:= ACredits;
  FType:= TCombinedCreditType.cctCombined;
  PopulateList;
end;

procedure TfrmCommonPersonCredits.LoadMovieCredits(
  ACredits: ITMDBCombinedCredits);
begin
  FCredits:= ACredits;
  FType:= TCombinedCreditType.cctMovie;
  PopulateList;
end;

procedure TfrmCommonPersonCredits.LoadTVCredits(ACredits: ITMDBCombinedCredits);
begin
  FCredits:= ACredits;
  FType:= TCombinedCreditType.cctTV;
  PopulateList;
end;

function TfrmCommonPersonCredits.MediaTypeStr(T: TTMDBMediaType): String;
begin
  case FType of
    cctMovie: Result:= 'Movie';
    cctTV: Result:= 'TV Show';
    cctCombined: Result:= TMDBMediaTypeToStr(T);
  end;
end;

procedure TfrmCommonPersonCredits.PopulateCastItem(AItem: TListItem; M: ITMDBCombinedCastCredit);
begin
  AItem.Caption:= M.Title;
  AItem.SubItems.Add(MediaTypeStr(M.MediaType));
  AItem.SubItems.Add('Cast');
  AItem.SubItems.Add(M.Character);
  {
  if M.MediaType = TTMDBMediaType.mtMovie then
    AItem.SubItems.Add(M.AsMovie.Genres[0].GetText)
  else
    AItem.SubItems.Add(M.AsTVSeries.Genres[0].GetText);
  }
  AItem.SubItems.Add(''); //TODO: Genre(s)...
  AItem.SubItems.Add(''); //TODO: Release date...


end;

procedure TfrmCommonPersonCredits.PopulateCrewItem(AItem: TListItem; M: ITMDBCombinedCrewCredit);
begin
  AItem.Caption:= M.Title;
  AItem.SubItems.Add(MediaTypeStr(M.MediaType));
  AItem.SubItems.Add('Crew');
  AItem.SubItems.Add(M.Department + ' - ' + M.Job);
  {
  if M.MediaType = TTMDBMediaType.mtMovie then
    AItem.SubItems.Add(M.AsMovie.Genres[0].GetText)
  else
    AItem.SubItems.Add(M.AsTVSeries.Genres[0].GetText);
  }
  AItem.SubItems.Add(''); //TODO: Genre(s)...
  AItem.SubItems.Add(''); //TODO: Release date...

end;

procedure TfrmCommonPersonCredits.PopulateList;
//var
//  MCast: ITMDBCombinedCastCredit;
//  MCrew: ITMDBCombinedCrewCredit;
begin
  ClearList;

  //Cast
  for var X := 0 to FCredits.Cast.Count-1 do begin
    var MCast:= FCredits.Cast.Items[X]; //TODO: Why does this raise "Interface not supported" on combined credits?
    var I:= lstResults.Items.Add;
    var O:= TCreditListObj.Create;
    O.FMedium:= MCast;
    O.FType:= MCast.MediaType;
    I.Data:= O;
    PopulateCastItem(I, MCast);
  end;

  //Crew
  for var X := 0 to FCredits.Crew.Count-1 do begin
    var MCrew:= FCredits.Crew.Items[X];
    var I:= lstResults.Items.Add;
    var O:= TCreditListObj.Create;
    O.FMedium:= MCrew;
    O.FType:= MCrew.MediaType;
    I.Data:= O;
    PopulateCrewItem(I, MCrew);
  end;

end;

end.
