unit uContentTVSerieDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls, JD.Common,
  JD.Ctrls, JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  JD.Graphics,
  uCommonFormBase,
  uCommonCredits,
  uCommonImages,
  uCommonVideos,
  uCommonReviews,
  uCommonAlternativeTitles;

type
  TfrmContentTVSerieDetail = class(TfrmContentBase)
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tabAlternativeTitles: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    tabCredits: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    tabImages: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    tabReviews: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    tabVideos: TTabSheet;
    pTop: TPanel;
    Label1: TLabel;
    txtID: TEdit;
    btnSearch: TJDFontButton;
    lstDetail: TListView;
    Splitter1: TSplitter;
    txtOverview: TMemo;
    lblRating: TLabel;
    btnFavorite: TJDFontButton;
    btnWatchlist: TJDFontButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    FDetail: ITMDBTVSerieDetail;

    FCredits: TfrmCommonCredits;
    FImages: TfrmCommonImages;
    FVideos: TfrmCommonVideos;
    FReviews: TfrmCommonReviews;
    FAlternativeTitles: TfrmCommonAlternativeTitles;

    function GetSeriesDetail(const ID: Integer): ITMDBTVSerieDetail;
    procedure DisplayAccountStates(const Value: ITMDBAccountStates);

    procedure LoadTabContent;

    procedure LoadDetails;
    procedure LoadAccountStates;
    procedure LoadAlternativeTitles;
    procedure LoadCredits;
    procedure LoadExternalIDs;
    procedure LoadKeywords;
    //procedure LoadReleaseDates;
    procedure LoadReviews;
    procedure LoadVideos;
    procedure LoadImages;
    function EmbedFormIntoTab(AClass: TfrmCommonFormBaseClass;
      ATab: TTabSheet): TfrmCommonFormBase;
  public
    procedure LoadSeries(const SeriesID: Integer); overload;
    procedure LoadSeries(const Series: ITMDBTVSerieDetail); overload;
  end;

var
  frmContentTVSerieDetail: TfrmContentTVSerieDetail;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

procedure TfrmContentTVSerieDetail.btnSearchClick(Sender: TObject);
var
  ID: Integer;
begin
  inherited;
  ID:= StrToIntDef(txtID.Text, 0);
  if ID < 1 then
    raise Exception.Create('Please enter a valid series ID.');
  LoadSeries(ID);
end;

procedure TfrmContentTVSerieDetail.DisplayAccountStates(
  const Value: ITMDBAccountStates);
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

function TfrmContentTVSerieDetail.EmbedFormIntoTab(
  AClass: TfrmCommonFormBaseClass; ATab: TTabSheet): TfrmCommonFormBase;
begin
  Result:= AClass.Create(ATab);
  Result.Parent:= ATab;
  Result.BorderStyle:= bsNone;
  Result.Align:= alClient;
  Result.Show;
end;

procedure TfrmContentTVSerieDetail.FormCreate(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
  Pages.Align:= alClient;
  Pages.ActivePageIndex:= 0;

  FVideos:= TfrmCommonVideos(EmbedFormIntoTab(TfrmCommonVideos, tabVideos));
  FImages:= TfrmCommonImages(EmbedFormIntoTab(TfrmCommonImages, tabImages));
  FCredits:= TfrmCommonCredits(EmbedFormIntoTab(TfrmCommonCredits, tabCredits));
  FReviews:= TfrmCommonReviews(EmbedFormIntoTab(TfrmCommonReviews, tabReviews));
  FAlternativeTitles:= TfrmCommonAlternativeTitles(EmbedFormIntoTab(TfrmCommonAlternativeTitles, tabAlternativeTitles));
end;

procedure TfrmContentTVSerieDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentTVSerieDetail.GetSeriesDetail(
  const ID: Integer): ITMDBTVSerieDetail;
var
  Inc: TTMDBTVSeriesRequests;
begin
  PrepAPI;
  //TODO: Change this whole form so each tab fetches its own data
  //  instead of relying on append_to_response for everything,
  //  which also opens the door for additional tabs which are not
  //  supported by append_to_response anyway.
  Inc:= [trAccountStates, trAggregateCredits, trAlternativeTitles,
    trChanges, trContentRatings, trCredits, trEpisodeGroups, trExternalIDs,
    trImages, trKeywords, trLists, trRecommendations, trReviews, trScreenedTheatrically,
    trSimilar, trTranslations, trVideos];
  Result:= TMDB.Client.TVSeries.GetDetails(ID, Inc, frmTMDBTestMain.cboLanguage.Text,
    TMDB.LoginState.SessionID);
end;

procedure TfrmContentTVSerieDetail.LoadSeries(const SeriesID: Integer);
begin
  Screen.Cursor:= crHourglass;
  try
    Pages.Visible:= False;
    FDetail:= GetSeriesDetail(SeriesID);
    if FDetail <> nil then begin
      Pages.Visible:= True;
      LoadTabContent;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentTVSerieDetail.LoadSeries(const Series: ITMDBTVSerieDetail);
begin
  Screen.Cursor:= crHourglass;
  try
    Pages.Visible:= False;
    FDetail:= Series;
    if FDetail <> nil then begin
      Pages.Visible:= True;
      LoadTabContent;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentTVSerieDetail.LoadAccountStates;
var
  S: ITMDBAccountStates;
begin
  S:= FDetail.AppendedAccountStates;
  DisplayAccountStates(S);
end;

procedure TfrmContentTVSerieDetail.LoadAlternativeTitles;
begin
  FAlternativeTitles.Load(FDetail.AppendedAlternativeTitles);
end;

procedure TfrmContentTVSerieDetail.LoadCredits;
begin
  FCredits.LoadCredits(FDetail.AppendedCredits);
end;

procedure TfrmContentTVSerieDetail.LoadDetails;
  function A(const N: String; const V: String): TListItem;
  begin
    Result:= lstDetail.Items.Add;
    Result.Caption:= N;
    Result.SubItems.Add(V);
  end;
var
  X: Integer;
  I: TListItem;
begin
  lstDetail.Items.BeginUpdate;
  try
    lstDetail.Items.Clear;

    A('Title', FDetail.Title);
    A('Tagline', FDetail.Tagline);
    if FDetail.Adult then
      A('Adult', 'True')
    else
      A('Adult', 'False');
    for X := 0 to FDetail.Genres.Count-1 do begin
      I:= A('Genre', FDetail.Genres[X].Name);
      I.Indent:= 1;
    end;
    A('First Air Date', FormatDateTime('yyyy-mm-dd', FDetail.FirstAirDate));
    A('Status', FDetail.Status);
    //A('Budget', FormatCurr('$#,###,###,##0.00', FDetail.Budget));
    //A('Revenue', FormatCurr('$#,###,###,##0.00', FDetail.Revenue));
    A('Homepage', FDetail.Homepage);
    A('Popularity', FormatFloat('0.000', FDetail.Popularity));
    A('Origin Country', TMDBStrArrayToStr(FDetail.OriginCountry));
    A('Original Language', TMDB.LanguageName(FDetail.OriginalLanguage));
    A('ID', IntToStr(FDetail.ID));
    //IMDB ID
    A('Backdrop Path', FDetail.BackdropPath);
    A('Poster Path', FDetail.PosterPath);
    for X := 0 to FDetail.ProductionCompanies.Count-1 do begin
      I:= A('Production Company', FDetail.ProductionCompanies[X].Name);
      I.Indent:= 1;
    end;
    for X := 0 to FDetail.ProductionCountries.Count-1 do begin
      I:= A('Production Country', TMDB.CountryName(FDetail.ProductionCountries[X].ISO3166_1));
      I.Indent:= 1;
    end;
    //A('Runtime', IntToStr(FDetail.Runtime));
    for X := 0 to FDetail.SpokenLanguages.Count-1 do begin
      I:= A('Spoken Language', TMDB.LanguageName(FDetail.SpokenLanguages[X].ISO639_1));
      I.Indent:= 1;
    end;
    //if FDetail.Video then
    //  A('Video', 'True')
    //else
    //  A('Video', 'False');
    A('Vote Average', FormatFloat('0.000', FDetail.VoteAverage));
    A('Vote Count', IntToStr(FDetail.VoteCount));

  finally
    lstDetail.Items.EndUpdate;
  end;

  txtOverview.Lines.Text:= FDetail.Overview;
end;

procedure TfrmContentTVSerieDetail.LoadExternalIDs;
begin

end;

procedure TfrmContentTVSerieDetail.LoadImages;
begin
  FImages.LoadImages(FDetail.AppendedImages);
end;

procedure TfrmContentTVSerieDetail.LoadKeywords;
begin

end;

procedure TfrmContentTVSerieDetail.LoadReviews;
begin

end;

procedure TfrmContentTVSerieDetail.LoadTabContent;
begin
  Screen.Cursor:= crHourglass;
  try
    case Pages.ActivePageIndex of
      0: LoadDetails;
      1: LoadAccountStates;
      2: ; //LoadAggregateCredits
      3: LoadAlternativeTitles;
      4: ; //Changes
      5: ; //ContentRatings
      6: LoadCredits;
      7: ; //EpisodeGroups
      8: LoadExternalIDs;
      9: LoadImages;
      10: LoadKeywords;
      11: ; //Lists
      12: ; //Recommendations
      13: LoadReviews;
      14: ; //ScreenedTheatrically
      15: ; //Similar
      16: ; //Translations
      17: LoadVideos;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentTVSerieDetail.LoadVideos;
begin
  FVideos.LoadVideoList(FDetail.AppendedVideos);
end;

procedure TfrmContentTVSerieDetail.PagesChange(Sender: TObject);
begin
  inherited;
  LoadTabContent;
end;

end.
