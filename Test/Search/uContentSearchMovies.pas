unit uContentSearchMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  JD.Graphics,
  JD.TMDB.Intf,
  JD.TMDB.Common, JD.Common, JD.Ctrls, JD.Ctrls.FontButton;

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
    btnFavorite: TJDFontButton;
    btnWatchlist: TJDFontButton;
    lstVideos: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure btnFavoriteClick(Sender: TObject);
    procedure btnWatchlistClick(Sender: TObject);
    procedure lstVideosDblClick(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;
    procedure LoadAccountStates;
    procedure LoadAlternativeTitles;
    procedure LoadCredits;
    procedure LoadKeywords;
    procedure LoadReleaseDates;
    procedure LoadDetails;
    procedure LoadVideos;
    procedure DisplayAccountStates(const Value: ITMDBAccountStates);
    procedure DisplayMovieDetail(const Value: ITMDBMovieDetail);
    function GetMovieDetail(const ID: Integer): ITMDBMovieDetail;
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
  TMDB.ListLanguages(cboSearchMoviesLanguage.Items);

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

procedure TfrmContentSearchMovies.btnFavoriteClick(Sender: TObject);
begin
  inherited;
  case btnFavorite.Tag of
    0: begin
      FDetail.AddToFavorites;
    end;
    1: begin
      FDetail.RemoveFromFavorites;
    end;
  end;
  //TODO: Refresh detail with new account states...
  FDetail:= GetMovieDetail(FDetail.ID);
  DisplayMovieDetail(FDetail);
end;

procedure TfrmContentSearchMovies.btnWatchlistClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor:= crHourglass;
  try
    case btnWatchlist.Tag of
      0: begin
        FDetail.AddToWatchlist;
      end;
      1: begin
        FDetail.RemoveFromWatchlist;
      end;
    end;
    //TODO: Refresh detail with new account states...
    FDetail:= GetMovieDetail(FDetail.ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  DisplayMovieDetail(FDetail);
end;

procedure TfrmContentSearchMovies.FormCreate(Sender: TObject);
begin
  inherited;
  Pages.ActivePageIndex:= 0;
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
  Result:= TMDB.Client.Search.SearchMovies(Q, A, L, R, PRY, Y, APageNum);
end;

procedure TfrmContentSearchMovies.DisplayMovieDetail(const Value: ITMDBMovieDetail);
begin
  //Refresh detail of selected tab...
  FDetail:= Value;
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
      14: LoadVideos;
    end;
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
  Result:= TMDB.Client.Movies.GetDetails(ID, Inc, cboSearchMoviesLanguage.Text,
    TMDB.LoginState.SessionID);
end;

procedure TfrmContentSearchMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  ID: Integer;
  O: ITMDBMovieItem;
begin
  inherited;
  Screen.Cursor:= crHourglass;
  try
    FDetail:= nil;
    PrepAPI;
    O:= ITMDBMovieItem(Obj);
    ID:= O.ID;
    FDetail:= GetMovieDetail(ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  DisplayMovieDetail(FDetail);
end;

procedure TfrmContentSearchMovies.LoadDetails;
begin
  lblTitle.Caption:= FDetail.Title;
  if FDetail.ReleaseDate <> 0 then
    lblReleaseDate.Caption:= 'Release Date: '+FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate)
  else
    lblReleaseDate.Caption:= 'Release Date: (NONE)';
  lblGenres.Caption:= 'Genres: '+GetGenres(FDetail);
  txtOverview.Lines.Text:= FDetail.Overview;
  lblTagline.Caption:= FDetail.Tagline;
end;

procedure TfrmContentSearchMovies.LoadAccountStates;
var
  S: ITMDBAccountStates;
begin
  S:= FDetail.AppendedAccountStates;
  DisplayAccountStates(S);

end;

procedure TfrmContentSearchMovies.DisplayAccountStates(const Value: ITMDBAccountStates);
begin
  if Value.Favorite then begin
    btnFavorite.Text:= 'Remove from Favorites';
    btnFavorite.Image.Text:= '';
    btnFavorite.Image.StandardColor:= fcRed;
    btnFavorite.Tag:= 1;
  end else begin
    btnFavorite.Text:= 'Add to Favorites';
    btnFavorite.Image.Text:= '';
    btnFavorite.Image.StandardColor:= fcBlue;
    btnFavorite.Tag:= 0;
  end;

  if Value.Watchlist then begin
    btnWatchlist.Text:= 'Remove from Watchlist';
    btnWatchlist.Image.Text:= '';
    btnWatchlist.Image.StandardColor:= fcRed;
    btnWatchlist.Tag:= 1;
  end else begin
    btnWatchlist.Text:= 'Add to Watchlist';
    btnWatchlist.Image.Text:= '';
    btnWatchlist.Image.StandardColor:= fcBlue;
    btnWatchlist.Tag:= 0;
  end;

  lblRating.Caption:= 'Rating: '+FormatFloat('0.0', Value.RatedValue);
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
      Country:= TMDB.Cache.Countries.GetByCode(T.ISO3166_1);
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
      Country:= TMDB.Cache.Countries.GetByCode(RC.CountryCode);
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

procedure TfrmContentSearchMovies.LoadVideos;
//var
  //L: ITMDBVideoList;
  //V: ITMDBVideoItem;
  //X: Integer;
  //I: TListItem;
begin
  lstVideos.Items.BeginUpdate;
  try
    lstVideos.Items.Clear;
    //L:= FDetail.AppendedVideos;
    //for X := 0 to L.Count-1 do begin
    //  V:= L[X];
    //  I:= lstVideos.Items.Add;
    //  I.Caption:= V.Name;
    //  I.SubItems.Add(V.Site);
    //  I.SubItems.Add(V.VideoType);
    //  I.SubItems.Add(FormatDateTime('yyyy-mm-dd', V.PublishedAt);
    //end;
  finally
    lstVideos.Items.EndUpdate;
  end;
end;

procedure TfrmContentSearchMovies.lstVideosDblClick(Sender: TObject);
begin
  inherited;
  //TODO: Open video in default browser...

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
  //TODO: Navigate to movie details tab within app...

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
  Item: TListItem; Obj: ITMDBPageItem);
var
  O: ITMDBMovieItem;
begin
  inherited;
  O:= Obj as ITMDBMovieItem;
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
