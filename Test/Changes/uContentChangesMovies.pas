unit uContentChangesMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.API, JD.TMDB.Intf, JD.TMDB.Impl, JD.TMDB.Common;

type
  TfrmContentChangesMovies = class(TfrmContentPageBase)
  private
    FDetail: ITMDBChanges;
  protected
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
  public
    { Public declarations }
  end;

var
  frmContentChangesMovies: TfrmContentChangesMovies;

implementation

{$R *.dfm}

{ TfrmContentChangesMovies }

function TfrmContentChangesMovies.GetData(const APageNum: Integer): ITMDBPage;
begin
  inherited;
  //Q:= txtSearchMoviesQuery.Text;
  //A:= TTMDBBoolean(cboSearchMoviesAdult.ItemIndex);
  //L:= AppSetup.Language;
  //R:= cboSearchMoviesRegion.Text;
  //PRY:= txtSearchMoviesPrimaryReleaseYear.Text;
  //Y:= txtSearchMoviesYear.Text;
  //Result:= TMDB.Client.Search.SearchMovies(Q, A, L, R, PRY, Y, APageNum);
  Result:= TMDB.Client.Changes.MovieList(0, 0, APageNum);

  TabCaption:= 'Movie Changes';
end;

function TfrmContentChangesMovies.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBChangeRefPage;
begin
  P:= ITMDBChangeRefPage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentChangesMovies.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentChangesMovies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

function TfrmContentChangesMovies.Page: ITMDBPage;
begin
  Result:= ITMDBChangeRefPage(inherited Page);
end;

procedure TfrmContentChangesMovies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBChangeRef;
begin
  inherited;
  O:= Obj as ITMDBChangeRef;
  Item.Caption:= IntToStr(O.ID);
  if O.Adult then
    Item.SubItems.Add('Yes')
  else
    Item.SubItems.Add('');

  {
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));
  if O.Genres.Count > 0 then
    Item.SubItems.Add(O.Genres[0].Name)
  else
    Item.SubItems.Add('(Unknown)');
  if O.ReleaseDate <> 0 then
    Item.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.ReleaseDate))
  else
    Item.SubItems.Add('');
  Item.SubItems.Add(O.Overview);
  }
end;

procedure TfrmContentChangesMovies.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentChangesMovies.SetupCols;
begin
  inherited;
  AddCol('Movie ID', 400);
  AddCol('Adult', 150);

end;

procedure TfrmContentChangesMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

end.
