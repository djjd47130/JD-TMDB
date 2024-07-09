unit uContentSearchMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  JD.Graphics,
  JD.TMDB.Intf,
  JD.TMDB.Common,
  uContentMovieDetail,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton;

type
  TfrmContentSearchMovies = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtSearchMoviesQuery: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    cboSearchMoviesAdult: TComboBox;
    Panel10: TPanel;
    Label11: TLabel;
    cboSearchMoviesRegion: TComboBox;
    Panel13: TPanel;
    Label14: TLabel;
    txtSearchMoviesPrimaryReleaseYear: TEdit;
    Panel14: TPanel;
    Label15: TLabel;
    txtSearchMoviesYear: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;
    FDetailForm: TfrmContentMovieDetail;
    procedure DisplayMovieDetail(const Value: ITMDBMovieDetail);
    function GetMovieDetail(const ID: Integer): ITMDBMovieDetail;
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
  end;

var
  frmContentSearchMovies: TfrmContentSearchMovies;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

{ TfrmContentSearchMovies }

procedure TfrmContentSearchMovies.FormCreate(Sender: TObject);
begin
  inherited;
  FDetailForm:= TfrmContentMovieDetail.Create(pDetail);
  FDetailForm.Parent:= pDetail;
  FDetailForm.BorderStyle:= bsNone;
  FDetailForm.Align:= alClient;
  FDetailForm.pTop.Visible:= False;
  FDetailForm.Show;

end;

procedure TfrmContentSearchMovies.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchMovies.PrepSearch;
begin
  inherited;
  TMDB.ListCountries(cboSearchMoviesRegion.Items);
end;

procedure TfrmContentSearchMovies.SetupCols;
begin
  inherited;
  AddCol('Movie', 400);
  AddCol('Popularity', 100);
  AddCol('Genre', 150);
  AddCol('Released', 160);
  AddCol('Description', 700);
end;

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

function TfrmContentSearchMovies.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L, R, PRY, Y: String;
  A: TTMDBBoolean;
begin
  inherited;
  Q:= txtSearchMoviesQuery.Text;
  A:= TTMDBBoolean(cboSearchMoviesAdult.ItemIndex);
  L:= frmMain.cboLanguage.Text;
  R:= cboSearchMoviesRegion.Text;
  PRY:= txtSearchMoviesPrimaryReleaseYear.Text;
  Y:= txtSearchMoviesYear.Text;
  Result:= TMDB.Client.Search.SearchMovies(Q, A, L, R, PRY, Y, APageNum);

  TabCaption:= 'Search Movies - ' + Q;

end;

procedure TfrmContentSearchMovies.DisplayMovieDetail(const Value: ITMDBMovieDetail);
begin
  //Refresh detail of selected tab...
  FDetail:= Value;
  Screen.Cursor:= crHourglass;
  try
    FDetailForm.LoadMovie(Value);

  finally
    Screen.Cursor:= crDefault;
  end;
end;

function TfrmContentSearchMovies.GetMovieDetail(const ID: Integer): ITMDBMovieDetail;
var
  Inc: TTMDBMovieRequests;
begin
  PrepAPI;
  Inc:= [mrAccountStates, mrAlternativeTitles, mrChanges, mrCredits,
    mrExternalIDs, mrImages, mrKeywords, mrLists, mrRecommendations,
    mrReleaseDates, mrReviews, mrSimilar, mrTranslations, mrVideos];
  Result:= TMDB.Client.Movies.GetDetails(ID, Inc, frmMain.cboLanguage.Text,
    TMDB.LoginState.SessionID);
end;

procedure TfrmContentSearchMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  ID: Integer;
  O: ITMDBMovie;
begin
  Screen.Cursor:= crHourglass;
  try
    FDetail:= nil;
    PrepAPI;
    O:= (Obj) as ITMDBMovie;
    ID:= O.ID;
    FDetail:= GetMovieDetail(ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  DisplayMovieDetail(FDetail);
  inherited;
end;

function TfrmContentSearchMovies.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBMoviePage;
begin
  P:= ITMDBMoviePage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchMovies.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchMovies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  T: TJDTabRef;
  M: ITMDBMovie;
begin
  inherited;
  //TODO: Navigate to movie details tab within app...
  M:= Obj as ITMDBMovie;
  T:= TabController.CreateTab(TfrmContentMovieDetail);
  (T.Content as TfrmContentMovieDetail).pTop.Visible:= False;
  (T.Content as TfrmContentMovieDetail).LoadMovie(M.ID);
end;

function TfrmContentSearchMovies.Page: ITMDBPage;
begin
  Result:= ITMDBMoviePage(inherited Page);
end;

procedure TfrmContentSearchMovies.PagesChange(Sender: TObject);
begin
  inherited;
  DisplayMovieDetail(FDetail);
end;

procedure TfrmContentSearchMovies.PopulateItem(const Index: Integer;
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

end.
