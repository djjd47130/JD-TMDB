unit uContentSearchMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf,
  JD.TMDB.Common;

type
  TfrmContentSearchMovies = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtSearchMoviesQuery: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    cboSearchMoviesAdult: TComboBox;
    Panel9: TPanel;
    Label10: TLabel;
    cboSearchMoviesLanguage: TComboBox;
    Panel10: TPanel;
    Label11: TLabel;
    cboSearchMoviesRegion: TComboBox;
    Panel13: TPanel;
    Label14: TLabel;
    txtSearchMoviesPrimaryReleaseYear: TEdit;
    Panel14: TPanel;
    Label15: TLabel;
    txtSearchMoviesYear: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lblTitle: TLabel;
    lblReleaseDate: TLabel;
    lblGenres: TLabel;
    lblTagline: TLabel;
    txtOverview: TMemo;
    TabSheet2: TTabSheet;
    lblFavorite: TLabel;
    lblWatchlist: TLabel;
    lblRating: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    lblIMDB: TLabel;
    lblWikidata: TLabel;
    lblFacebook: TLabel;
    lblInstagram: TLabel;
    lblTwitter: TLabel;
    TabSheet8: TTabSheet;
    lstKeywords: TListBox;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    lstCredits: TListView;
    ListView1: TListView;
    ListView2: TListView;
    procedure FormDestroy(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;
  protected
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBPageItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
  end;

var
  frmContentSearchMovies: TfrmContentSearchMovies;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentSearchMovies }

procedure TfrmContentSearchMovies.PrepSearch;
begin
  inherited;

  //TODO: This should rather be fetching "Primary Translations"...
  frmTMDBTestMain.ListLanguages(cboSearchMoviesLanguage.Items);

  frmTMDBTestMain.ListRegions(cboSearchMoviesRegion.Items);

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

function GetGenres(O: ITMDBMovieDetail): String;
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

procedure TfrmContentSearchMovies.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentSearchMovies.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L, R, PRY, Y: String;
  A: Boolean;
begin
  inherited;
  Q:= txtSearchMoviesQuery.Text;
  A:= cboSearchMoviesAdult.ItemIndex = 1;
  L:= cboSearchMoviesLanguage.Text;
  R:= cboSearchMoviesRegion.Text;
  PRY:= txtSearchMoviesPrimaryReleaseYear.Text;
  Y:= txtSearchMoviesYear.Text;
  Result:= API.Search.SearchMovies(Q, A, L, R, PRY, Y, APageNum);
end;

procedure TfrmContentSearchMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  ID: Integer;
  O: ITMDBMovieItem;
  Inc: TTMDBMovieRequests;
  X: Integer;
  K: ITMDBKeywordItem;
  //I: TListItem;
  //C: ITMDBCreditItem;
begin
  inherited;
  FDetail:= nil;
  pDetail.Visible:= True;
  pDetail.Top:= 1;
  PrepAPI;
  O:= ITMDBMovieItem(Obj);
  ID:= O.ID;
  Inc:= [mrKeywords];
  FDetail:= API.Movies.GetDetails(ID, Inc);

  //Details
  lblTitle.Caption:= FDetail.Title;
  lblReleaseDate.Caption:= 'Release Date: '+FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate);
  lblGenres.Caption:= 'Genres: '+GetGenres(FDetail);
  txtOverview.Lines.Text:= FDetail.Overview;
  lblTagline.Caption:= FDetail.Tagline;

  //Account States
  if FDetail.AppendedAccountStates.Favorite then
    lblFavorite.Caption:= 'Favorite: TRUE'
  else
    lblFavorite.Caption:= 'Favorite: FALSE';
  if FDetail.AppendedAccountStates.Watchlist then
    lblWatchlist.Caption:= 'Watchlist: TRUE'
  else
    lblWatchlist.Caption:= 'Watchlist: FALSE';
  lblRating.Caption:= 'Rating: '+FormatFloat('0.0', FDetail.AppendedAccountStates.RatedValue);

  //Alternative Titles

  //Changes

  //Credits
  lstCredits.Items.Clear;

  //External IDs

  //Images

  //Keywords
  lstKeywords.Items.Clear;
  for X := 0 to FDetail.AppendedKeywords.Count-1 do begin
    K:= FDetail.AppendedKeywords[X];
    lstKeywords.Items.Add(K.Name);
  end;

  //Lists

  //Recommendations

  //Release Dates

  //Reviews

  //Similar

  //Translations

  //Videos

end;

function TfrmContentSearchMovies.GetItem(const Index: Integer): ITMDBPageItem;
var
  P: ITMDBMoviePage;
begin
  P:= ITMDBMoviePage(Page);
  Result:= P.GetItem(Index);
end;

procedure TfrmContentSearchMovies.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchMovies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;
  //TODO: Navigate to movie details tab...

end;

function TfrmContentSearchMovies.Page: ITMDBPage;
begin
  Result:= ITMDBMoviePage(inherited Page);
end;

procedure TfrmContentSearchMovies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  O: ITMDBMovieItem;
begin
  inherited;
  O:= Obj as ITMDBMovieItem; // ITMDBMovieItem(Obj); //TODO: Can we not cast interface as its ancestor?
  Item.Caption:= O.Title; //TODO: ACCESS VIOLATION
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));
  if O.Genres.Count > 0 then
    Item.SubItems.Add(O.Genres[0].Name)
  else
    Item.SubItems.Add('(Unknown)');
  Item.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.ReleaseDate));
  Item.SubItems.Add(O.Overview);
end;

end.
