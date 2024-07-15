unit uContentMovieDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls,
  Vcl.StdCtrls, JD.Common, JD.Ctrls, JD.Ctrls.FontButton, Vcl.ExtCtrls,
  JD.Graphics,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  uCommonFormBase,
  uCommonVideos,
  uCommonCredits,
  uCommonImages,
  uCommonReviews,
  uCommonAlternativeTitles;

type
  TDetailRef = class;

  TDetailRefEvent = reference to procedure(Ref: TDetailRef);

  TDetailRef = class(TObject)
  private
    FOnClick: TDetailRefEvent;
    FItem: TListItem;
    procedure SetOnClick(const Value: TDetailRefEvent);
    function GetClickable: Boolean;
  public
    constructor Create(AItem: TListItem);
    property Clickable: Boolean read GetClickable;
    property Item: TListItem read FItem;
    property OnClick: TDetailRefEvent read FOnClick write SetOnClick;
  end;

  TfrmContentMovieDetail = class(TfrmContentBase)
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    txtOverview: TMemo;
    TabSheet2: TTabSheet;
    lblRating: TLabel;
    btnFavorite: TJDFontButton;
    btnWatchlist: TJDFontButton;
    tabAltTitles: TTabSheet;
    lstAltTitles: TListView;
    TabSheet4: TTabSheet;
    tabCredits: TTabSheet;
    TabSheet6: TTabSheet;
    tabImages: TTabSheet;
    TabSheet8: TTabSheet;
    lstKeywords: TListBox;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    tabReleaseDates: TTabSheet;
    lstReleaseDates: TListView;
    tabReviews: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    tabVideos: TTabSheet;
    lstDetail: TListView;
    Splitter1: TSplitter;
    lstExternalIDs: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure btnFavoriteClick(Sender: TObject);
    procedure btnWatchlistClick(Sender: TObject);
    procedure lstDetailCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure lstDetailDblClick(Sender: TObject);
  private
    FDetail: ITMDBMovieDetail;

    FCredits: TfrmCommonCredits;
    FImages: TfrmCommonImages;
    FVideos: TfrmCommonVideos;
    FReviews: TfrmCommonReviews;
    //FAlternativeTitles: TfrmCommonAlternativeTitles;

    function GetMovieDetail(const ID: Integer): ITMDBMovieDetail;
    procedure DisplayAccountStates(const Value: ITMDBAccountStates);

    procedure LoadTabContent;

    procedure LoadDetails;
    procedure LoadAccountStates;
    procedure LoadAlternativeTitles;
    procedure LoadCredits;
    procedure LoadExternalIDs;
    procedure LoadKeywords;
    procedure LoadReleaseDates;
    procedure LoadReviews;
    procedure LoadVideos;
    procedure LoadImages;
    function EmbedFormIntoTab(AClass: TfrmCommonFormBaseClass;
      ATab: TTabSheet): TfrmCommonFormBase;
    procedure ClearDetails;
  public
    procedure LoadMovie(const MovieID: Integer); overload;
    procedure LoadMovie(const Movie: ITMDBMovieDetail); overload;
  end;

var
  frmContentMovieDetail: TfrmContentMovieDetail;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

{ TDetailRef }

constructor TDetailRef.Create(AItem: TListItem);
begin
  FItem:= AItem;
end;

function TDetailRef.GetClickable: Boolean;
begin
  Result:= Assigned(FOnClick);
end;

procedure TDetailRef.SetOnClick(const Value: TDetailRefEvent);
begin
  FOnClick := Value;
end;

{ TfrmContentMovieDetail }

procedure TfrmContentMovieDetail.FormCreate(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
  Pages.Align:= alClient;
  Pages.ActivePageIndex:= 0;

  FVideos:= TfrmCommonVideos(EmbedFormIntoTab(TfrmCommonVideos, tabVideos));
  FImages:= TfrmCommonImages(EmbedFormIntoTab(TfrmCommonImages, tabImages));
  FCredits:= TfrmCommonCredits(EmbedFormIntoTab(TfrmCommonCredits, tabCredits));
  FReviews:= TfrmCommonReviews(EmbedFormIntoTab(TfrmCommonReviews, tabReviews));
end;

procedure TfrmContentMovieDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentMovieDetail.EmbedFormIntoTab(AClass: TfrmCommonFormBaseClass;
  ATab: TTabSheet): TfrmCommonFormBase;
begin
  Result:= AClass.Create(ATab);
  Result.Parent:= ATab;
  Result.BorderStyle:= bsNone;
  Result.Align:= alClient;
  Result.Show;
end;

function TfrmContentMovieDetail.GetMovieDetail(const ID: Integer): ITMDBMovieDetail;
var
  Inc: TTMDBMovieRequests;
begin
  PrepAPI;
  //TODO: Change this whole form so each tab fetches its own data
  //  instead of relying on append_to_response for everything,
  //  which also opens the door for additional tabs which are not
  //  supported by append_to_response anyway.
  Inc:= [mrAccountStates, mrAlternativeTitles, mrChanges, mrCredits,
    mrExternalIDs, mrImages, mrKeywords, mrLists, mrRecommendations,
    mrReleaseDates, mrReviews, mrSimilar, mrTranslations, mrVideos];
  Result:= TMDB.Client.Movies.GetDetails(ID, Inc, AppSetup.Language,
    TMDB.LoginState.SessionID);
end;

procedure TfrmContentMovieDetail.btnFavoriteClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor:= crHourglass;
  try
    case btnFavorite.Tag of
      0: begin
        FDetail.AddToFavorites;
      end;
      1: begin
        FDetail.RemoveFromFavorites;
      end;
    end;
    FDetail:= GetMovieDetail(FDetail.ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  LoadMovie(FDetail.ID);
end;

procedure TfrmContentMovieDetail.btnWatchlistClick(Sender: TObject);
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
    FDetail:= GetMovieDetail(FDetail.ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  LoadMovie(FDetail.ID);
end;

procedure TfrmContentMovieDetail.PagesChange(Sender: TObject);
begin
  inherited;
  LoadTabContent;
end;

procedure TfrmContentMovieDetail.LoadTabContent;
begin
  Screen.Cursor:= crHourglass;
  try
    case Pages.ActivePageIndex of
      0: LoadDetails;
      1: LoadAccountStates;
      2: LoadAlternativeTitles;
      3: ; //Changes
      4: LoadCredits;
      5: LoadExternalIDs;
      6: LoadImages;
      7: LoadKeywords;
      8: ; //Lists
      9: ; //Recommendations
      10: LoadReleaseDates;
      11: LoadReviews;
      12: ; //Similar
      13: ; //Translations
      14: LoadVideos;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
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

procedure TfrmContentMovieDetail.ClearDetails;
begin
  while lstDetail.Items.Count > 0 do begin
    TDetailRef(lstDetail.Items[0].Data).Free;
    lstDetail.Items.Delete(0);
  end;
end;

procedure TfrmContentMovieDetail.LoadDetails;
  function A(const N: String; const V: String; OnClick: TDetailRefEvent = nil): TDetailRef;
  var
    I: TListItem;
  begin
    I:= lstDetail.Items.Add;
    I.Caption:= N;
    I.SubItems.Add(V);
    Result:= TDetailRef.Create(I);
    Result.OnClick:= OnClick;
    I.Data:= Result;
  end;
var
  X: Integer;
  I: TDetailRef;
  T1, T2: String;
begin
  lstDetail.Items.BeginUpdate;
  try
    ClearDetails;

    T1:= FDetail.Title;
    T2:= FDetail.OriginalTitle;
    A('Title', T1,
      procedure(Ref: TDetailRef)
      begin
        //Alternative Titles
        Pages.ActivePage:= tabAltTitles;
        PagesChange(Pages);
      end);
    if T1 <> T2 then
      A('Original Title', T2,
        procedure(Ref: TDetailRef)
        begin
          //Alternative Titles
          Pages.ActivePage:= tabAltTitles;
          PagesChange(Pages);
        end);
    A('Tagline', FDetail.Tagline);
    if FDetail.Collection <> nil then begin
      if FDetail.Collection.BelongsToCollection then begin
        A('Collection', FDetail.Collection.Name,
          procedure(Ref: TDetailRef)
          begin
            //TabController.CreateTab(TfrmContentCollectionDetail);
          end);
      end;
    end;
    A('Popularity', FormatFloat('0.000', FDetail.Popularity));
    A('Vote Average', FormatFloat('0.000', FDetail.VoteAverage));
    A('Vote Count', IntToStr(FDetail.VoteCount));
    for X := 0 to FDetail.Genres.Count-1 do begin
      I:= A('Genre', FDetail.Genres[X].Name);
      I.Item.Indent:= 1;
    end;
    A('Release Date', FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate),
      procedure(Ref: TDetailRef)
      begin
        //Relase Dates
        Pages.ActivePage:= tabReleaseDates;
        PagesChange(Pages);
      end);
    A('Status', FDetail.Status);
    A('Budget', FormatCurr('$#,###,###,##0.00', FDetail.Budget));
    A('Revenue', FormatCurr('$#,###,###,##0.00', FDetail.Revenue));
    for X := 0 to FDetail.ProductionCompanies.Count-1 do begin
      I:= A('Production Company', FDetail.ProductionCompanies[X].Name,
        procedure(Ref: TDetailRef)
        begin
          //Company Detail
        end);
      I.Item.Indent:= 1;
    end;
    A('Origin Country', TMDBStrArrayToStr(FDetail.OriginalCountry));
    for X := 0 to FDetail.ProductionCountries.Count-1 do begin
      I:= A('Production Country', TMDB.CountryName(FDetail.ProductionCountries[X].ISO3166_1));
      I.Item.Indent:= 1;
    end;
    A('Original Language', TMDB.LanguageName(FDetail.OriginalLanguage));
    for X := 0 to FDetail.SpokenLanguages.Count-1 do begin
      I:= A('Spoken Language', TMDB.LanguageName(FDetail.SpokenLanguages[X].ISO639_1));
      I.Item.Indent:= 1;
    end;
    A('Homepage', FDetail.Homepage,
      procedure(Ref: TDetailRef)
      begin
        //Web Browser
      end);
    A('Runtime', IntToStr(FDetail.Runtime));
    A('Backdrop Path', FDetail.BackdropPath,
      procedure(Ref: TDetailRef)
      begin
        //Image Detail
      end);
    A('Poster Path', FDetail.PosterPath,
      procedure(Ref: TDetailRef)
      begin
        //Image Detail
      end);
    if FDetail.Video then
      A('Video', 'True')
    else
      A('Video', 'False');
    if FDetail.Adult then
      A('Adult', 'True')
    else
      A('Adult', 'False');
    A('ID', IntToStr(FDetail.ID));
    A('IMDB ID', FDetail.IMDBID,
      procedure(Ref: TDetailRef)
      begin
        //IMDB Movie Detail
      end);

  finally
    lstDetail.Items.EndUpdate;
  end;

  txtOverview.Lines.Text:= FDetail.Overview;
end;

procedure TfrmContentMovieDetail.LoadExternalIDs;
var
  O: ITMDBExternalIDs;
  function A(const N, V: String): TListItem;
  begin
    Result:= lstExternalIDs.Items.Add;
    Result.Caption:= N;
    Result.SubItems.Add(V);
  end;
begin
  lstExternalIDs.Items.Clear;
  O:= FDetail.AppendedExternalIDs;
  A('IMDB', O.IMDBID);
  A('WikiData', O.WikiDataID);
  A('Facebook', O.FacebookID);
  A('Instagram', O.InstagramID);
  A('Twitter', O.TwitterID);
end;

procedure TfrmContentMovieDetail.LoadAccountStates;
var
  S: ITMDBAccountStates;
begin
  S:= FDetail.AppendedAccountStates;
  DisplayAccountStates(S);
end;

procedure TfrmContentMovieDetail.DisplayAccountStates(const Value: ITMDBAccountStates);
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

procedure TfrmContentMovieDetail.LoadAlternativeTitles;
var
  AT: ITMDBAlternativeTitles;
  T: ITMDBAlternativeTitle;
  X: Integer;
  I: TListItem;
  Country: ITMDBCountry;
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

procedure TfrmContentMovieDetail.LoadCredits;
begin
  FCredits.LoadCredits(FDetail.AppendedCredits);
end;

procedure TfrmContentMovieDetail.LoadImages;
begin
  FImages.LoadImages(FDetail.AppendedImages);
end;

procedure TfrmContentMovieDetail.LoadKeywords;
var
  X: Integer;
  L: ITMDBKeywords;
  K: ITMDBKeyword;
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

procedure TfrmContentMovieDetail.LoadMovie(const Movie: ITMDBMovieDetail);
begin
  Screen.Cursor:= crHourglass;
  try
    Pages.Visible:= False;
    FDetail:= Movie;
    if FDetail <> nil then begin
      TabCaption:= 'Movie: '+FDetail.Title;
      Pages.Visible:= True;
      LoadTabContent;
    end else begin
      TabCaption:= 'Movie Detail';
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentMovieDetail.LoadMovie(const MovieID: Integer);
begin
  Screen.Cursor:= crHourglass;
  try
    Pages.Visible:= False;
    FDetail:= GetMovieDetail(MovieID);
    if FDetail <> nil then begin
      TabCaption:= 'Movie: '+FDetail.Title;
      Pages.Visible:= True;
      LoadTabContent;
    end else begin
      TabCaption:= 'Movie Detail';
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentMovieDetail.LoadReleaseDates;
var
  X, Y: Integer;
  I: TListItem;
  G: TListGroup;
  Country: ITMDBCountry;
  RD: ITMDBReleaseDateCountries;
  RC: ITMDBReleaseDateCountry;
  RI: ITMDBReleaseDate;
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

procedure TfrmContentMovieDetail.LoadReviews;
begin
  FReviews.LoadReviewList(FDetail.AppendedReviews);
end;

procedure TfrmContentMovieDetail.LoadVideos;
begin
  FVideos.LoadVideoList(FDetail.AppendedVideos);
end;

procedure TfrmContentMovieDetail.lstDetailCustomDrawSubItem(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  I: TDetailRef;
  function IsName(const N: String): Boolean;
  begin
    Result:= SameText(N, Item.Caption);
  end;
  procedure Chk(const N: String);
  begin
    if IsName(N) then begin
      Sender.Canvas.Font.Color:= clBlue;
      Sender.Canvas.Font.Style:= [fsBold,fsUnderline];
    end;
  end;
begin
  inherited;
  Sender.Canvas.Brush.Color:= clBlack;
  Sender.Canvas.Font.Color:= clWhite;
  Sender.Canvas.Font.Style:= [fsBold];
  if SubItem = 1 then begin
    I:= TDetailRef(Item.Data);
    if I.Clickable then begin
      Sender.Canvas.Font.Color:= clBlue;
      Sender.Canvas.Font.Style:= [fsBold,fsUnderline];
    end;

    {
    Chk('Collection'); //Collection Detail
    Chk('Release Date'); //Release Dates
    Chk('Production Company'); //Company Detail
    Chk('Homepage'); //URL in Default Browser
    Chk('Backdrop Path'); //Image Detail
    Chk('Poster Path'); //Image Detail
    Chk('Title'); //Alternative Titles
    Chk('Original Title'); //Alternative Titles
    }
  end;

end;

procedure TfrmContentMovieDetail.lstDetailDblClick(Sender: TObject);
var
  I: TDetailRef;
begin
  inherited;
  //Execute procedure associated with corresponding detail reference...
  if lstDetail.Selected <> nil then begin
    I:= TDetailRef(lstDetail.Selected.Data);
    if Assigned(I.OnClick) then
      I.OnClick(I);
  end;
end;

end.
