unit uContentMoviePage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf, JD.TMDB.Common,
  uContentMovieDetail;

type
  TMoviePageProc = reference to procedure(Sender: TObject;
    const Page: Integer; var Data: ITMDBMoviePage);

  TfrmContentMoviePage = class(TfrmContentPageBase)
    procedure btnRefreshClick(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;
    FBaseName: String;
    FOnGetPage: TMoviePageProc;
    procedure SetBaseName(const Value: String);
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

    procedure DoOnGetPage(const Page: Integer; var Data: ITMDBMoviePage); virtual;
  public
    property BaseName: String read FBaseName write SetBaseName;

    property OnGetPage: TMoviePageProc read FOnGetPage write FOnGetPage;
  end;

var
  frmContentMoviePage: TfrmContentMoviePage;

implementation

{$R *.dfm}

uses
  JD.TabController;

function GetMovieGenres(O: ITMDBMovieDetail): String;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to O.Genres.Count-1 do begin
    if Result <> '' then
      Result:= Result + ', ';
    Result:= Result + O.Genres[X].Name;
  end;
end;

{ TfrmContentPageBase1 }

procedure TfrmContentMoviePage.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Self.RefreshData;
end;

procedure TfrmContentMoviePage.DoOnGetPage(const Page: Integer;
  var Data: ITMDBMoviePage);
begin
  if Assigned(FOnGetPage) then
    FOnGetPage(Self, Page, Data);
  //
end;

function TfrmContentMoviePage.GetData(const APageNum: Integer): ITMDBPage;
var
  P: ITMDBMoviePage;
  //Q, L, R, PRY, Y: String;
  //A: TTMDBBoolean;
begin
  inherited;

  DoOnGetPage(APageNum, P);
  Result:= P;

  {
  Q:= txtSearchMoviesQuery.Text;
  A:= TTMDBBoolean(cboSearchMoviesAdult.ItemIndex);
  L:= AppSetup.Language;
  R:= cboSearchMoviesRegion.Text;
  PRY:= txtSearchMoviesPrimaryReleaseYear.Text;
  Y:= txtSearchMoviesYear.Text;
  }

  //Result:= TMDB.Client.Search.SearchMovies(Q, A, L, R, PRY, Y, APageNum);

  TabCaption:= Self.BaseName; // 'Search Movies - "'+Q+'"';

end;

function TfrmContentMoviePage.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBMoviePage;
begin
  P:= ITMDBMoviePage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentMoviePage.HideDetail;
begin
  inherited;
  pDetail.Visible:= False;
end;

procedure TfrmContentMoviePage.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  T: TJDTabRef;
  M: ITMDBMovie;
begin
  inherited;
  M:= Obj as ITMDBMovie;
  T:= TabController.CreateTab(TfrmContentMovieDetail);
  (T.Content as TfrmContentMovieDetail).LoadMovie(M.ID);
end;

function TfrmContentMoviePage.Page: ITMDBPage;
begin
  Result:= ITMDBMoviePage(inherited Page);
end;

procedure TfrmContentMoviePage.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBMovie;
begin
  inherited;
  O:= Obj as ITMDBMovie;
  Item.Caption:= O.Title;
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
end;

procedure TfrmContentMoviePage.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentMoviePage.SetBaseName(const Value: String);
begin
  FBaseName := Value;
end;

procedure TfrmContentMoviePage.SetupCols;
begin
  inherited;
  AddCol('Movie', 400);
  AddCol('Popularity', 100);
  AddCol('Genre', 150);
  AddCol('Released', 160);
  AddCol('Description', 700);
end;

procedure TfrmContentMoviePage.ShowDetail(const Index: Integer; Item: TListItem;
  Obj: ITMDBItem);
begin
  inherited;
  pDetail.Visible:= False;
end;

end.
