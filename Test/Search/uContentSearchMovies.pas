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
    Pages: TPageControl;
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
    lstAltTitles: TListView;
    ListView2: TListView;
    lstReleaseDates: TListView;
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;
    procedure LoadAccountStates;
    procedure LoadAlternativeTitles;
    procedure LoadCredits;
    procedure LoadKeywords;
    procedure LoadReleaseDates;
    procedure LoadDetails;
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
begin
  inherited;
  Screen.Cursor:= crHourglass;
  try
    FDetail:= nil;
    PrepAPI;
    O:= ITMDBMovieItem(Obj);
    ID:= O.ID;
    Inc:= [mrKeywords, mrCredits, mrAlternativeTitles, mrAccountStates, mrReleaseDates];
    FDetail:= API.Movies.GetDetails(ID, Inc, '', API.LoginState.SessionID);
  finally
    Screen.Cursor:= crDefault;
  end;

  PagesChange(nil);

  {
  //Details
  LoadDetails;

  //Account States
  LoadAccountStates;

  //Alternative Titles
  LoadAlternativeTitles;

  //Changes

  //Credits
  LoadCredits;

  //External IDs

  //Images

  //Keywords
  LoadKeywords;

  //Lists

  //Recommendations

  //Release Dates
  LoadReleaseDates;

  //Reviews

  //Similar

  //Translations

  //Videos

  }

end;

procedure TfrmContentSearchMovies.LoadDetails;
begin
  lblTitle.Caption:= FDetail.Title;
  lblReleaseDate.Caption:= 'Release Date: '+FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate);
  lblGenres.Caption:= 'Genres: '+GetGenres(FDetail);
  txtOverview.Lines.Text:= FDetail.Overview;
  lblTagline.Caption:= FDetail.Tagline;
end;

procedure TfrmContentSearchMovies.LoadAccountStates;
var
  S: ITMDBAccountStates;
begin
  S:= FDetail.AppendedAccountStates;
  if S.Favorite then
    lblFavorite.Caption:= 'Favorite: TRUE'
  else
    lblFavorite.Caption:= 'Favorite: FALSE';
  if S.Watchlist then
    lblWatchlist.Caption:= 'Watchlist: TRUE'
  else
    lblWatchlist.Caption:= 'Watchlist: FALSE';
  lblRating.Caption:= 'Rating: '+FormatFloat('0.0', S.RatedValue);
end;

procedure TfrmContentSearchMovies.LoadAlternativeTitles;
var
  AT: ITMDBAlternativeTitleList;
  T: ITMDBAlternativeTitleItem;
  X: Integer;
  I: TListItem;
  Country: ITMDBCountryItem;
begin
  lstAltTitles.Items.BeginUpdate;
  try
    lstAltTitles.Items.Clear;
    AT:= FDetail.AppendedAlternativeTitles;
    for X := 0 to AT.Count-1 do begin
      T:= AT[X];
      I:= lstAltTitles.Items.Add;
      I.Caption:= T.Title;
      Country:= API.Cache.Countries.GetByCode(T.ISO3166_1);
      if Country <> nil then
        I.SubItems.Add(Country.EnglishName)
      else
        I.SubItems.Add(T.ISO3166_1);
    end;
  finally
    lstAltTitles.Items.EndUpdate;
  end;
end;

procedure TfrmContentSearchMovies.LoadCredits;
var
  C: ITMDBCredits;
  Ca: ITMDBCastItem;
  Cr: ITMDBCrewItem;
  X: Integer;
  I: TListItem;
begin
  lstCredits.Items.BeginUpdate;
  try
    lstCredits.Items.Clear;
    C:= FDetail.AppendedCredits;
    //Credits - Cast
    for X := 0 to C.Cast.Count-1 do begin
      Ca:= C.Cast[X];
      I:= lstCredits.Items.Add;
      I.GroupID:= 0;
      I.Caption:= Ca.Name;
      I.SubItems.Add(Ca.Character);
    end;
    //Credits - Crew
    for X := 0 to C.Crew.Count-1 do begin
      Cr:= C.Crew[X];
      I:= lstCredits.Items.Add;
      I.GroupID:= 1;
      I.Caption:= Cr.Name;
      I.SubItems.Add(Cr.Job);
    end;
  finally
    lstCredits.Items.EndUpdate;
  end;
end;

procedure TfrmContentSearchMovies.LoadKeywords;
var
  X: Integer;
  L: ITMDBKeywordList;
  K: ITMDBKeywordItem;
begin
  lstKeywords.Items.BeginUpdate;
  try
    lstKeywords.Items.Clear;
    L:= FDetail.AppendedKeywords;
    for X := 0 to L.Count-1 do begin
      K:= L[X];
      lstKeywords.Items.Add(K.Name);
    end;
  finally
    lstKeywords.Items.EndUpdate;
  end;
end;

procedure TfrmContentSearchMovies.LoadReleaseDates;
var
  X, Y: Integer;
  I: TListItem;
  G: TListGroup;
  Country: ITMDBCountryItem;
  RD: ITMDBReleaseDateCountries;
  RC: ITMDBReleaseDateCountry;
  RI: ITMDBReleaseDateItem;
begin
  lstReleaseDates.Items.BeginUpdate;
  lstReleaseDates.Groups.BeginUpdate;
  try
    lstReleaseDates.Items.Clear;
    lstReleaseDates.Groups.Clear;
    RD:= FDetail.AppendedReleaseDates;
    for X := 0 to RD.Count-1 do begin
      RC:= RD[X];
      G:= lstReleaseDates.Groups.Add;
      Country:= API.Cache.Countries.GetByCode(RC.CountryCode);
      if Country = nil then
        G.Header:= RC.CountryCode
      else
        G.Header:= Country.EnglishName;
      G.State:= [lgsCollapsible,lgsCollapsed];
      for Y := 0 to RC.Count-1 do begin
        RI:= RC[Y];
        I:= lstReleaseDates.Items.Add;
        I.GroupID:= G.GroupID;
        I.Caption:= FormatDateTime('yyyy-mm-dd', RI.ReleaseDate);
        I.SubItems.Add(TMDBReleaseTypeToStr(RI.ReleaseType));
        I.SubItems.Add(RI.Note);
        I.SubItems.Add(RI.Certification);
        I.SubItems.Add(TMDBStrArrayToStr(RI.Descriptors));
        I.SubItems.Add(RI.ISO639_1); //TODO
      end;
    end;
  finally
    lstReleaseDates.Groups.EndUpdate;
    lstReleaseDates.Items.EndUpdate;
  end;
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

procedure TfrmContentSearchMovies.PagesChange(Sender: TObject);
begin
  inherited;
  //Refresh detail of selected tab...
  Screen.Cursor:= crHourglass;
  try
    case Pages.ActivePageIndex of
      0: LoadDetails;
      1: LoadAccountStates;
      2: LoadAlternativeTitles;
      3: ; //CHanges
      4: LoadCredits;
      5: ; //External IDs
      6: ; //Images
      7: LoadKeywords;
      8: ; //Lists
      9: ; //Recommendations
      10: LoadReleaseDAtes;
      11: ; //Reviews
      12: ; //Similar
      13: ; //Translations
      14: ; //Videos;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
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
