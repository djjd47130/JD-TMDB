unit JD.TMDB.API;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  Winapi.Windows,
  XSuperObject,
  IdHTTP;

const
  TMDB_API_ROOT = 'https://api.themoviedb.org/3/';
  TMDB_API_USERAGENT = 'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-TMDB)';

type
  TTMDBAPI = class;

  TTMDBService = class(TPersistent)
  private
    FOwner: TTMDBAPI;
    procedure AddParam(var S: String; const N, V: String);
  public
    constructor Create(AOwner: TTMDBAPI); virtual;
    destructor Destroy; override;
  end;

  TTMDBAccount = class(TTMDBService)
  public
    function GetDetails(const AccountID: Integer; const SessionID: String = ''): ISuperObject;
    function AddFavorite(const AccountID: Integer;
      const MediaType: String; const MediaID: Integer; const Favorite: Boolean;
      const SessionID: String = ''): ISuperObject;
    function AddToWatchlist(const AccountID: Integer;
      const MediaType: String; const MediaID: Integer; const Watchlist: Boolean;
      const SessionID: String = ''): ISuperObject;
    function GetFavoriteMovies(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetFavoriteTV(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetLists(const AccountID: Integer; const Page: Integer = 1;
      const SessionID: String = ''): ISuperObject;
    function GetRatedMovies(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetRatedTV(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetRatedTVEpisodes(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetWatchlistMovies(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
    function GetWatchlistTV(const AccountID: Integer; const Language: String = '';
      const Page: Integer = 1; const SessionID: String = '';
      const SortBy: String = ''): ISuperObject;
  end;

  TTMDBAuthentication = class(TTMDBService)
  public
    function CreateGuestSession: ISuperObject;
    function CreateRequestToken: ISuperObject;
    function CreateSession(const RequestToken: String): ISuperObject;
    function CreateSessionV4(const AccessToken: String): ISuperObject;
    function CreateSessionLogin(const Username, Password,
      RequestToken: String): ISuperObject;
    function DeleteSession(const SessionID: String): ISuperObject;
    function GetValidateKey: ISuperObject;
  end;

  TTMDBCertifications = class(TTMDBService)
  public
    function GetMovieCertifications: ISuperObject;
    function GetTVCertifications: ISuperObject;
  end;

  TTMDBChanges = class(TTMDBService)
  public
    function GetMovieList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
    function GetPeopleList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
    function GetTVList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
  end;

  TTMDBCollections = class(TTMDBService)
  public
    function GetDetails(const CollectionID: Integer; const Language: String = ''): ISuperObject;
    function GetImages(const CollectionID: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetTranslations(const CollectionID: Integer): ISuperObject;
  end;

  TTMDBCompanies = class(TTMDBService)
  public
    function GetDetails(const CompanyID: Integer): ISuperObject;
    function GetAlternativeNames(const CompanyID: Integer): ISuperObject;
    function GetImages(const CompanyID: Integer): ISuperObject;
  end;

  TTMDBConfiguration = class(TTMDBService)
  public
    function GetDetails: ISuperObject;
    function GetCountries: ISuperArray;
    function GetJobs: ISuperArray;
    function GetLanguages: ISuperArray;
    function GetPrimaryTranslations: ISuperArray;
    function GetTimeZones: ISuperArray;
  end;

  TTMDBCredits = class(TTMDBService)
  public
    function GetDetails(const CreditID: Integer): ISuperObject;
  end;

  TTMDBDiscover = class(TTMDBService)
  public
    //TODO: HUGE - COME BACK TO THIS LATER!!!
    //  Probably better to pass an object containing parameters instead of
    //  listing each and every one individually...

    //Movie
    //TV
  end;

  TTMDBFind = class(TTMDBService)
  public
    function GetFindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ISuperObject;
  end;

  TTMDBGenres = class(TTMDBService)
  public
    function GetMovieList(const Language: String = ''): ISuperArray;
    function GetTVList(const Language: String = ''): ISuperArray;
  end;

  TTMDBGuestSessions = class(TTMDBService)
  public
    function GetRatedMovies(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
    function GetRatedTV(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
    function GetRatedTVEpisodes(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
  end;

  TTMDBKeywords = class(TTMDBService)
  public
    function GetDetails(const KeywordID: Integer): ISuperObject;
    //DEPRECATED: GetMovies
  end;

  TTMDBLists = class(TTMDBService)
  public
    function AddMovie(const ListID: Integer; const SessionID: String;
      const MediaID: Integer): ISuperObject;
    function GetCheckItemStatus(const ListID: Integer; const Language: String = '';
      const MovieID: Integer = 0): ISuperObject;
    function Clear(const ListID: Integer; const SessionID: String;
      const Confirm: Boolean = False): ISuperObject;
    function CreateList(const SessionID: String; const Name, Description, Language: String): ISuperObject;
    function Delete(const ListID: Integer; const SessionID: String): ISuperObject;
    function GetDetails(const ListID: Integer; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function RemoveMovie(const ListID: Integer; const SessionID: String;
      const MediaID: Integer): ISuperObject;
  end;

  TTMDBMovieLists = class(TTMDBService)
  public
    function GetNowPlaying(const Language: String = ''; const Page: Integer = 1;
      const Region: String = ''): ISuperObject;
    function GetPopular(const Language: String = ''; const Page: Integer = 1;
      const Region: String = ''): ISuperObject;
    function GetTopRated(const Language: String = ''; const Page: Integer = 1;
      const Region: String = ''): ISuperObject;
    function GetUpcoming(const Language: String = ''; const Page: Integer = 1;
      const Region: String = ''): ISuperObject;
  end;

  TTMDBMovies = class(TTMDBService)
  public
    function GetDetails(const MovieID: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetAccountStates(const MovieID: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAlternativeTitles(const MovieID: Integer;
      const Country: String = ''): ISuperArray;
    function GetChanges(const MovieID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetCredits(const MovieID: Integer; const Language: String = ''): ISuperObject;
    function GetExternalIDs(const MovieID: Integer): ISuperObject;
    function GetImages(const MovieID: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetKeywords(const MovieID: Integer): ISuperArray;
    function GetLatest: ISuperObject;
    function GetLists(const MovieID: Integer; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetRecommendations(const MovieID: Integer; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetReleaseDates(const MovieID: Integer): ISuperArray;
    function GetReviews(const MovieID: Integer; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetSimilar(const MovieID: Integer; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetTranslations(const MovieID: Integer): ISuperArray;
    function GetVideos(const MovieID: Integer; const Language: String = ''): ISuperArray;
    function GetWatchProviders(const MovieID: Integer): ISuperObject;
    function AddRating(const MovieID: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const MovieID: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBNetworks = class(TTMDBService)
  public
    function GetDetails(const NetworkID: Integer): ISuperObject;
    function GetAlternativeNames(const NetworkID: Integer): ISuperArray;
    function GetImages(const NetworkID: Integer): ISuperArray;
  end;

  TTMDBPeopleLists = class(TTMDBService)
  public
    function GetPopular(const Language: String = ''; const Page: Integer = 1): ISuperObject;
  end;

  TTMDBGender = (gNotSpecified = 0, gFemale = 1, gMale = 2, gNonBinary = 3);

  TTMDBPeople = class(TTMDBService)
  public
    function GetDetails(const PersonID: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetChanges(const PersonID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetCombinedCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    function GetExternalIDs(const PersonID: Integer): ISuperObject;
    function GetImages(const PersonID: Integer): ISuperArray;
    function GetLatest: ISuperObject;
    function GetMovieCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    function GetTVCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    //DEPRECATED: GetTaggedImages
    function GetTranslations(const PersonID: Integer): ISuperArray;
  end;

  TTMDBReviews = class(TTMDBService)
  public
    function GetDetails(const ReviewID: Integer): ISuperObject;
  end;

  TTMDBSearch = class(TTMDBService)
  public
    function SearchCollections(const Query: String; const IncludeAdult: Boolean = False;
      const Language: String = ''; const Page: Integer = 1; const Region: String = ''): ISuperObject;
    function SearchCompanies(const Query: String; const Page: Integer = 1): ISuperObject;
    function SearchKeywords(const Query: String; const Page: Integer = 1): ISuperObject;
    function SearchMovies(const Query: String; const IncludeAdult: Boolean = False;
      const Language: String = ''; const PrimaryReleaseYear: String = '';
      const Page: Integer = 1; const Region: String = ''; const Year: String = ''): ISuperObject;
    function SearchMulti(const Query: String; const IncludeAdult: Boolean = False;
      const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function SearchPerson(const Query: String; const IncludeAdult: Boolean = False;
      const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function SearchTV(const Query: String; const FirstAirDateYear: String = '';
      const IncludeAdult: Boolean = False; const Language: String = '';
      const Page: Integer = 1; const Year: String = ''): ISuperObject;
  end;

  TTMDBTrending = class(TTMDBService)
  public
    function GetAll(const TimeWindow: String = 'day'; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetMovies(const TimeWindow: String = 'day'; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetPeople(const TimeWindow: String = 'day'; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
    function GetTV(const TimeWindow: String = 'day'; const Language: String = '';
      const Page: Integer = 1): ISuperObject;
  end;

  TTMDBTVSeriesLists = class(TTMDBService)
  public
    function GetAiringToday(const Language: String = ''; const Page: Integer = 1;
      const Timezone: String = ''): ISuperObject;
    function GetOnTheAir(const Language: String = ''; const Page: Integer = 1;
      const Timezone: String = ''): ISuperObject;
    function GetPopular(const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function GetTopRated(const Language: String = ''; const Page: Integer = 1): ISuperObject;
  end;

  TTMDBTVSeries = class(TTMDBService)
  public
    function GetDetails(const SeriesID: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetAccountStates(const SeriesID: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAggregateCredits(const SeriesID: Integer; const Language: String = ''): ISuperObject;
    function GetAlternativeTitles(const SeriesID: Integer): ISuperArray;
    function GetChanges(const SeriesID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetContentRatings(const SeriesID: Integer): ISuperArray;
    function GetCredits(const SeriesID: Integer; const Language: String = ''): ISuperObject;
    function GetEpisodeGroups(const SeriesID: Integer): ISuperArray;
    function GetExternalIDs(const SeriesID: Integer): ISuperObject;
    function GetImages(const SeriesID: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetKeywords(const SeriesID: Integer): ISuperArray;
    function GetLatest: ISuperObject;
    function GetLists(const SeriesID: Integer; const Language: String = '';
      const Page: Integer= 1): ISuperObject;
    function GetRecommendations(const SeriesID: Integer; const Language: String = '';
      const Page: Integer= 1): ISuperObject;
    function GetReviews(const SeriesID: Integer; const Language: String = '';
      const Page: Integer= 1): ISuperObject;
    function GetScreenedTheatrically(const SeriesID: Integer): ISuperArray;
    function GetSimilar(const SeriesID: Integer; const Language: String = '';
      const Page: Integer= 1): ISuperObject;
    function GetTranslations(const SeriesID: Integer): ISuperArray;
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: String = '';
      const Language: String = ''): ISuperArray;
    function GetWatchProviders(const SeriesID: Integer): ISuperObject;
    function AddRating(const SeriesID: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const SeriesID: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBTVSeasons = class(TTMDBService)
  public
    function GetDetails(const SeriesID: Integer; const SeasonNumber: Integer;
      const AppendToResponse: String = ''; const Language: String = ''): ISuperObject;
    function GetAccountStates(const SeriesID, SeasonNumber: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAggregateCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
    function GetChanges(const SeasonID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
    function GetExternalIDs(const SeriesID: Integer; const SeasonNumber: Integer): ISuperObject;
    function GetImages(const SeriesID: Integer; const SeasonNumber: Integer;
      const IncludeImageLanguage: String = ''; const Language: String = ''): ISuperObject;
    function GetTranslations(const SeriesID: Integer; const SeasonNumber: Integer): ISuperArray;
    function GetVideos(const SeriesID: Integer; const SeasonNumber: Integer;
      const IncludeVideoLanguage: String = ''; const Language: String = ''): ISuperObject;
    function GetWatchProviders(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
  end;

  TTMDBTVEpisodes = class(TTMDBService)
  public
    function GetDetails(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetAccountStates(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const SessionID: String = ''; const GuestSessionID: String = ''): ISuperObject;
    function GetChanges(const EpisodeID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const Language: String = ''): ISuperObject;
    function GetExternalIDs(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer): ISuperObject;
    function GetImages(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetTranslations(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer): ISuperArray;
    function GetVideos(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const IncludeVideoLanguage: String = '';
      const Language: String = ''): ISuperArray;
    function AddRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBEpisodeGroupType = (gtOrigAirDate = 1, gtAbsolute = 2, gtDVD = 3, gtDigital = 4,
    gtStoryArc = 5, gtProduction = 6, gtTV = 7);

  TTMDBTVEpisodeGroups = class(TTMDBService)
  public
    function GetEpisodeGroups(const TVEpisodeGroupID: String): ISuperObject;
  end;

  TTMDBWatchProviders = class(TTMDBService)
  public
    function GetAvailableRegions(const Language: String = ''): ISuperArray;
    function GetMovieProviders(const Language: String = '';
      const WatchRegion: String = ''): ISuperArray;
    function GetTVProviders(const Language: String = '';
      const WatchRegion: String = ''): ISuperArray;
  end;

  TTMDBAPI = class(TComponent)
  private
    FHTTP: TIdHTTP;
    FAPIKey: String;
    FAPIReadAccessToken: String;
    FConfiguration: TTMDBConfiguration;
    FGenres: TTMDBGenres;
    FMovies: TTMDBMovies;
    FPeople: TTMDBPeople;
    FNetworks: TTMDBNetworks;
    FSearch: TTMDBSearch;
    FTVSeries: TTMDBTVSeries;
    FTVSeasons: TTMDBTVSeasons;
    FWatchProviders: TTMDBWatchProviders;
    FTVEpisodes: TTMDBTVEpisodes;
    FCompanies: TTMDBCompanies;
    FCertifications: TTMDBCertifications;
    FCollections: TTMDBCollections;
    FAuthentication: TTMDBAuthentication;
    FChanges: TTMDBChanges;
    FCredits: TTMDBCredits;
    FAccount: TTMDBAccount;
    FTVEpisodeGroups: TTMDBTVEpisodeGroups;
    FDiscover: TTMDBDiscover;
    FFind: TTMDBFind;
    FGuestSessions: TTMDBGuestSessions;
    FKeywords: TTMDBKeywords;
    FLists: TTMDBLists;
    FMovieLists: TTMDBMovieLists;
    FPeopleLists: TTMDBPeopleLists;
    FTrending: TTMDBTrending;
    FReviews: TTMDBReviews;
    FTVSeriesLists: TTMDBTVSeriesLists;
    FAppUserAgent: String;
    procedure SetAPIKey(const Value: String);
    procedure SetAPIReadAccessToken(const Value: String);
    procedure SetAppUserAgent(const Value: String);
    procedure PrepareJSONRequest;
    function GetJSON(const Req: String; const Params: String = ''): ISuperObject;
    function PostJSON(const Req: String; const Params: String = '';
      const Body: ISuperObject = nil): ISuperObject;
    function DeleteJSON(const Req: String; const Params: String = '';
      const Body: ISuperObject = nil): ISuperObject;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property APIKey: String read FAPIKey write SetAPIKey;
    property APIReadAccessToken: String read FAPIReadAccessToken write SetAPIReadAccessToken;
    property AppUserAgent: String read FAppUserAgent write SetAppUserAgent;

    property Account: TTMDBAccount read FAccount;
    property Authentication: TTMDBAuthentication read FAuthentication;
    property Certifications: TTMDBCertifications read FCertifications;
    property Changes: TTMDBChanges read FChanges;
    property Collections: TTMDBCollections read FCollections;
    property Companies: TTMDBCompanies read FCompanies;
    property Configuration: TTMDBConfiguration read FConfiguration;
    property Credits: TTMDBCredits read FCredits;
    property Discover: TTMDBDiscover read FDiscover;
    property Find: TTMDBFind read FFind;
    property Genres: TTMDBGenres read FGenres;
    property GuestSessions: TTMDBGuestSessions read FGuestSessions;
    property Keywords: TTMDBKeywords read FKeywords;
    property Lists: TTMDBLists read FLists;
    property MovieLists: TTMDBMovieLists read FMovieLists;
    property Movies: TTMDBMovies read FMovies;
    property Networks: TTMDBNetworks read FNetworks;
    property PeopleLists: TTMDBPeopleLists read FPeopleLists;
    property People: TTMDBPeople read FPeople;
    property Reviews: TTMDBReviews read FReviews;
    property Search: TTMDBSearch read FSearch;
    property Trending: TTMDBTrending read FTrending;
    property TVSeriesLists: TTMDBTVSeriesLists read FTVSeriesLists;
    property TVSeries: TTMDBTVSeries read FTVSeries;
    property TVSeasons: TTMDBTVSeasons read FTVSeasons;
    property TVEpisodes: TTMDBTVEpisodes read FTVEpisodes;
    property TVEpisodeGroups: TTMDBTVEpisodeGroups read FTVEpisodeGroups;
    property WatchProviders: TTMDBWatchProviders read FWatchProviders;

  end;

implementation

type
  TIdHTTPAccess = class(TIdHTTP)
  end;

{ TTMDBService }

procedure TTMDBService.AddParam(var S: String; const N, V: String);
begin
  if V <> '' then
    S:= S + '&'+N+'='+V;
end;

constructor TTMDBService.Create(AOwner: TTMDBAPI);
begin
  FOwner:= AOwner;
end;

destructor TTMDBService.Destroy;
begin

  inherited;
end;

{ TTMDBAccount }

function TTMDBAccount.GetDetails(const AccountID: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID);
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.AddFavorite(const AccountID: Integer;
  const MediaType: String; const MediaID: Integer; const Favorite: Boolean;
  const SessionID: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  O:= SO;
  O.S['media_type']:= MediaType;
  O.I['media_id']:= MediaID;
  O.B['favorite']:= Favorite;
  U:= 'account/'+IntToStr(AccountID)+'/favorite';
  AddParam(P, 'session_id', SessionID);
  Result:= Fowner.PostJSON(U, P, O);
end;

function TTMDBAccount.AddToWatchlist(const AccountID: Integer;
  const MediaType: String; const MediaID: Integer; const Watchlist: Boolean;
  const SessionID: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  O:= SO;
  O.S['media_type']:= MediaType;
  O.I['media_id']:= MediaID;
  O.B['watchlist']:= Watchlist;
  U:= 'account/'+IntToStr(AccountID)+'/watchlist';
  AddParam(P, 'session_id', SessionID);
  Result:= Fowner.PostJSON(U, P, O);
end;

function TTMDBAccount.GetFavoriteMovies(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/favorite/movies';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetFavoriteTV(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/favorite/tv';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/lists';
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetRatedMovies(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/rated/movies';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetRatedTV(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/rated/tv';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetRatedTVEpisodes(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/rated/tv/episodes';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetWatchlistMovies(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/watchlist/movies';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAccount.GetWatchlistTV(const AccountID: Integer;
  const Language: String; const Page: Integer; const SessionID,
  SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/watchlist/tv';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAuthentication }

function TTMDBAuthentication.CreateGuestSession: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication/guest_session/new');
end;

function TTMDBAuthentication.CreateRequestToken: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication/token/new');
end;

function TTMDBAuthentication.CreateSession(
  const RequestToken: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['request_token']:= RequestToken;
  Result:= Fowner.PostJSON('authentication/session/new', '', O);
end;

function TTMDBAuthentication.CreateSessionV4(
  const AccessToken: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['access_token']:= AccessToken;
  Result:= Fowner.PostJSON('authentication/session/convert/4', '', O);
end;

function TTMDBAuthentication.CreateSessionLogin(const Username, Password,
  RequestToken: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['username']:= Username;
  O.S['password']:= Password;
  O.S['request_token']:= RequestToken;
  Result:= Fowner.PostJSON('authentication/token/validate_with_login', '', O);
end;

function TTMDBAuthentication.DeleteSession(const SessionID: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['session_id']:= SessionID;
  Result:= Fowner.DeleteJSON('authentication/session', '', O);
end;

function TTMDBAuthentication.GetValidateKey: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication');
end;

{ TTMDBCertifications }

function TTMDBCertifications.GetMovieCertifications: ISuperObject;
begin
  Result:= FOwner.GetJSON('certification/movie/list');
end;

function TTMDBCertifications.GetTVCertifications: ISuperObject;
begin
  Result:= FOwner.GetJSON('certification/tv/list');
end;

{ TTMDBChanges }

function TTMDBChanges.GetMovieList(const StartDate, EndDate: TDateTime;
  const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'movie/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBChanges.GetPeopleList(const StartDate, EndDate: TDateTime;
  const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'person/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBChanges.GetTVList(const StartDate, EndDate: TDateTime;
  const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'tv/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBCollections }

function TTMDBCollections.GetDetails(const CollectionID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'collection/'+IntToStr(CollectionID);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBCollections.GetImages(const CollectionID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'collection/'+IntToStr(CollectionID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBCollections.GetTranslations(
  const CollectionID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'collection/'+IntToStr(CollectionID)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBCompanies }

function TTMDBCompanies.GetDetails(const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID);
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBCompanies.GetAlternativeNames(
  const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID)+'/alternative_names';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBCompanies.GetImages(const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID)+'/images';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBConfiguration }

function TTMDBConfiguration.GetDetails: ISuperObject;
begin
  Result:= FOwner.GetJSON('configuration');
end;

function TTMDBConfiguration.GetCountries: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/countries').AsArray;
end;

function TTMDBConfiguration.GetJobs: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/jobs').AsArray;
end;

function TTMDBConfiguration.GetLanguages: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/languages').AsArray;
end;

function TTMDBConfiguration.GetPrimaryTranslations: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/primary_translations').AsArray;
end;

function TTMDBConfiguration.GetTimeZones: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/timezones').AsArray;
end;

{ TTMDBCredits }

function TTMDBCredits.GetDetails(const CreditID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'credit/'+IntToStr(CreditID);
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBFind }

function TTMDBFind.GetFindByID(const ExternalID, ExternalSource,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'find/'+ExternalID;
  AddParam(P, 'external_source', ExternalSource);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBGenres }

function TTMDBGenres.GetMovieList(const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'genre/movie/list';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['genres'];
end;

function TTMDBGenres.GetTVList(const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'genre/tv/list';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['genres'];
end;

{ TTMDBGuestSessions }

function TTMDBGuestSessions.GetRatedMovies(const GuestSessionID,
  Language: String; const Page: Integer; const SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'guest_session/'+GuestSessionID+'/rated/movies';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBGuestSessions.GetRatedTV(const GuestSessionID, Language: String;
  const Page: Integer; const SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'guest_session/'+GuestSessionID+'/rated/tv';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBGuestSessions.GetRatedTVEpisodes(const GuestSessionID,
  Language: String; const Page: Integer; const SortBy: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'guest_session/'+GuestSessionID+'/rated/tv/episodes';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'sort_by', SortBy);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBKeywords }

function TTMDBKeywords.GetDetails(const KeywordID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'keyword/'+IntToStr(KeywordID);
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBLists }

function TTMDBLists.AddMovie(const ListID: Integer; const SessionID: String;
  const MediaID: Integer): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'list/'+IntToStr(ListID)+'/add_item';

  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.I['media_id']:= MediaID;
  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBLists.GetCheckItemStatus(const ListID: Integer;
  const Language: String; const MovieID: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID)+'/item_status';
  AddParam(P, 'language', Language);
  AddParam(P, 'movie_id', IntToStr(MovieID));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBLists.Clear(const ListID: Integer; const SessionID: String;
  const Confirm: Boolean): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID)+'/clear';

  AddParam(P, 'session_id', SessionID);
  if Confirm then
    AddParam(P, 'confirm', 'true')
  else
    AddParam(P, 'confirm', 'false');

  Result:= FOwner.PostJSON(U, P, nil);
end;

function TTMDBLists.CreateList(const SessionID, Name, Description,
  Language: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'list';

  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.S['name']:= Name;
  O.S['description']:= Description;
  O.S['language']:= Language;

  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBLists.Delete(const ListID: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID);

  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

function TTMDBLists.GetDetails(const ListID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID);
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBLists.RemoveMovie(const ListID: Integer; const SessionID: String;
  const MediaID: Integer): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'list/'+IntToStr(ListID)+'/remove_item';

  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.I['media_id']:= MediaID;

  Result:= FOwner.PostJSON(U, P, O);
end;

{ TTMDBMovieLists }

function TTMDBMovieLists.GetNowPlaying(const Language: String;
  const Page: Integer; const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/now_playing';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovieLists.GetPopular(const Language: String; const Page: Integer;
  const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/popular';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovieLists.GetTopRated(const Language: String;
  const Page: Integer; const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/top_rated';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovieLists.GetUpcoming(const Language: String;
  const Page: Integer; const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/upcoming';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBMovies }

function TTMDBMovies.GetDetails(const MovieID: Integer; const AppendToResponse,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetAccountStates(const MovieID: Integer; const SessionID,
  GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetAlternativeTitles(const MovieID: Integer;
  const Country: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/alternative_titles';
  AddParam(P, 'country', Country);
  Result:= FOwner.GetJSON(U, P).A['titles'];
end;

function TTMDBMovies.GetChanges(const MovieID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetCredits(const MovieID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetExternalIDs(const MovieID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBMovies.GetImages(const MovieID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetKeywords(const MovieID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/keywords';
  Result:= FOwner.GetJSON(U, '').A['keywords'];
end;

function TTMDBMovies.GetLatest: ISuperObject;
var
  U: String;
begin
  U:= 'movie/latest';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBMovies.GetLists(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/lists';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetRecommendations(const MovieID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/recommendations';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetReleaseDates(const MovieID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/release_dates';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBMovies.GetReviews(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/reviews';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetSimilar(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/similar';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBMovies.GetTranslations(const MovieID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/translations';
  Result:= FOwner.GetJSON(U, '').A['translations'];
end;

function TTMDBMovies.GetVideos(const MovieID: Integer;
  const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/videos';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

function TTMDBMovies.GetWatchProviders(const MovieID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBMovies.AddRating(const MovieID: Integer; const Rating: Single;
  const GuestSessionID, SessionID: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.F['value']:= Rating;

  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBMovies.DeleteRating(const MovieID: Integer; const GuestSessionID,
  SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

{ TTMDBNetworks }

function TTMDBNetworks.GetDetails(const NetworkID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID);
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBNetworks.GetAlternativeNames(const NetworkID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID)+'/alternative_names';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBNetworks.GetImages(const NetworkID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID)+'/images';
  Result:= FOwner.GetJSON(U, '').A['logos'];
end;

{ TTMDBPeopleLists }

function TTMDBPeopleLists.GetPopular(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/popular';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBPeople }

function TTMDBPeople.GetDetails(const PersonID: Integer; const AppendToResponse,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBPeople.GetChanges(const PersonID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBPeople.GetCombinedCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/combined_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBPeople.GetExternalIDs(const PersonID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBPeople.GetImages(const PersonID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/images';
  Result:= FOwner.GetJSON(U, '').A['profiles'];
end;

function TTMDBPeople.GetLatest: ISuperObject;
begin
  Result:= FOwner.GetJSON('person/latest');
end;

function TTMDBPeople.GetMovieCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/movie_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBPeople.GetTVCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/tv_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBPeople.GetTranslations(const PersonID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/translations';
  Result:= FOwner.GetJSON(U, '').A['translations'];
end;

{ TTMDBReviews }

function TTMDBReviews.GetDetails(const ReviewID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'review/'+IntToStr(ReviewID);
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBSearch }

function TTMDBSearch.SearchCollections(const Query: String;
  const IncludeAdult: Boolean; const Language: String; const Page: Integer;
  const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/collection';
  AddParam(P, 'query', Query);
  if IncludeAdult then
    AddParam(P, 'include_adult', 'true')
  else
    AddParam(P, 'include_adult', 'false');
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchCompanies(const Query: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/company';
  AddParam(P, 'query', Query);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchKeywords(const Query: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/keyword';
  AddParam(P, 'query', Query);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchMovies(const Query: String;
  const IncludeAdult: Boolean; const Language, PrimaryReleaseYear: String;
  const Page: Integer; const Region, Year: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/movie';
  AddParam(P, 'query', Query);
  if IncludeAdult then
    AddParam(P, 'include_adult', 'true')
  else
    AddParam(P, 'include_adult', 'false');
  AddParam(P, 'language', Language);
  AddParam(P, 'primary_release_year', PrimaryReleaseYear);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  AddParam(P, 'year', Year);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchMulti(const Query: String;
  const IncludeAdult: Boolean; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/multi';
  AddParam(P, 'query', Query);
  if IncludeAdult then
    AddParam(P, 'include_adult', 'true')
  else
    AddParam(P, 'include_adult', 'false');
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchPerson(const Query: String;
  const IncludeAdult: Boolean; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/person';
  AddParam(P, 'query', Query);
  if IncludeAdult then
    AddParam(P, 'include_adult', 'true')
  else
    AddParam(P, 'include_adult', 'false');
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBSearch.SearchTV(const Query, FirstAirDateYear: String;
  const IncludeAdult: Boolean; const Language: String; const Page: Integer;
  const Year: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/tv';
  AddParam(P, 'query', Query);
  if IncludeAdult then
    AddParam(P, 'include_adult', 'true')
  else
    AddParam(P, 'include_adult', 'false');
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'year', Year);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBTrending }

function TTMDBTrending.GetAll(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/all/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTrending.GetMovies(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/movie/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTrending.GetPeople(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/person/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTrending.GetTV(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/tv/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBTVSeriesLists }

function TTMDBTVSeriesLists.GetAiringToday(const Language: String;
  const Page: Integer; const Timezone: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/airing_today';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'timezone', Timezone);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeriesLists.GetOnTheAir(const Language: String;
  const Page: Integer; const Timezone: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/on_the_air';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'timezone', Timezone);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeriesLists.GetPopular(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/popular';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeriesLists.GetTopRated(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/top_rated';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBTVSeries }

function TTMDBTVSeries.GetDetails(const SeriesID: Integer;
  const AppendToResponse, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetAccountStates(const SeriesID: Integer;
  const SessionID, GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetAggregateCredits(const SeriesID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/aggregate_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetAlternativeTitles(
  const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/alternative_titles';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBTVSeries.GetChanges(const SeriesID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetContentRatings(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/content_ratings';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBTVSeries.GetCredits(const SeriesID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetEpisodeGroups(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/episode_groups';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBTVSeries.GetExternalIDs(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBTVSeries.GetImages(const SeriesID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetKeywords(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/keywords';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBTVSeries.GetLatest: ISuperObject;
var
  U: String;
begin
  U:= 'tv/latest';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBTVSeries.GetLists(const SeriesID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/lists';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetRecommendations(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/recommendations';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetReviews(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/reviews';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetScreenedTheatrically(
  const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/screened_theatrically';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBTVSeries.GetSimilar(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/similar';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeries.GetTranslations(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/translations';
  Result:= FOwner.GetJSON(U, '').A['translations'];
end;

function TTMDBTVSeries.GetVideos(const SeriesID: Integer;
  const IncludeVideoLanguage, Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

function TTMDBTVSeries.GetWatchProviders(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBTVSeries.AddRating(const SeriesID: Integer; const Rating: Single;
  const GuestSessionID, SessionID: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.F['value']:= Rating;

  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBTVSeries.DeleteRating(const SeriesID: Integer;
  const GuestSessionID, SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

{ TTMDBTVSeasons }

function TTMDBTVSeasons.GetDetails(const SeriesID, SeasonNumber: Integer;
  const AppendToResponse, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetAccountStates(const SeriesID, SeasonNumber: Integer;
  const SessionID, GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetAggregateCredits(const SeriesID,
  SeasonNumber: Integer; const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/aggregate_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetChanges(const SeasonID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'tv/season/'+IntToStr(SeasonID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetCredits(const SeriesID, SeasonNumber: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetExternalIDs(const SeriesID,
  SeasonNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBTVSeasons.GetImages(const SeriesID, SeasonNumber: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetTranslations(const SeriesID,
  SeasonNumber: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/translations';
  Result:= FOwner.GetJSON(U, '').A['translations'];
end;

function TTMDBTVSeasons.GetVideos(const SeriesID, SeasonNumber: Integer;
  const IncludeVideoLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVSeasons.GetWatchProviders(const SeriesID, SeasonNumber: Integer;
  const Language: String): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBTVEpisodes }

function TTMDBTVEpisodes.GetDetails(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const AppendToResponse,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVEpisodes.GetAccountStates(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const SessionID,
  GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVEpisodes.GetChanges(const EpisodeID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'tv/episode/'+IntToStr(EpisodeID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVEpisodes.GetCredits(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVEpisodes.GetExternalIDs(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBTVEpisodes.GetImages(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const IncludeImageLanguage,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBTVEpisodes.GetTranslations(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/translations';
  Result:= FOwner.GetJSON(U, '').A['translations'];
end;

function TTMDBTVEpisodes.GetVideos(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const IncludeVideoLanguage,
  Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

function TTMDBTVEpisodes.AddRating(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const Rating: Single; const GuestSessionID,
  SessionID: String): ISuperObject;
var
  U, P: String;
  O: ISuperObject;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  O:= SO;
  O.F['value']:= Rating;

  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBTVEpisodes.DeleteRating(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const GuestSessionID,
  SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

{ TTMDBTVEpisodeGroups }

function TTMDBTVEpisodeGroups.GetEpisodeGroups(
  const TVEpisodeGroupID: String): ISuperObject;
var
  U: String;
begin
  U:= 'tv/episode_group/'+TVEpisodeGroupID;
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBWatchProviders }

function TTMDBWatchProviders.GetAvailableRegions(
  const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'watch/providers/regions';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

function TTMDBWatchProviders.GetMovieProviders(const Language,
  WatchRegion: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'watch/providers/movie';
  AddParam(P, 'language', Language);
  AddParam(P, 'watch_region', WatchRegion);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

function TTMDBWatchProviders.GetTVProviders(const Language,
  WatchRegion: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'watch/providers/tv';
  AddParam(P, 'language', Language);
  AddParam(P, 'watch_region', WatchRegion);
  Result:= FOwner.GetJSON(U, P).A['results'];
end;

{ TTMDBAPI }

constructor TTMDBAPI.Create(AOwner: TComponent);
begin
  inherited;
  FHTTP:= TIdHTTP.Create(nil);
  FAppUserAgent:= TMDB_API_USERAGENT;

  //TODO: HTTPS

  FAccount:= TTMDBAccount.Create(Self);
  FAuthentication:= TTMDBAuthentication.Create(Self);
  FCertifications:= TTMDBCertifications.Create(Self);
  FChanges:= TTMDBChanges.Create(Self);
  FCollections:= TTMDBCollections.Create(Self);
  FCompanies:= TTMDBCompanies.Create(Self);
  FConfiguration:= TTMDBConfiguration.Create(Self);
  FCredits:= TTMDBCredits.Create(Self);
  FDiscover:= TTMDBDiscover.Create(Self);
  FFind:= TTMDBFind.Create(Self);
  FGenres:= TTMDBGenres.Create(Self);
  FGuestSessions:= TTMDBGuestSessions.Create(Self);
  FKeywords:= TTMDBKeywords.Create(Self);
  FLists:= TTMDBLists.Create(Self);
  FMovieLists:= TTMDBMovieLists.Create(Self);
  FMovies:= TTMDBMovies.Create(Self);
  FNetworks:= TTMDBNetworks.Create(Self);
  FPeopleLists:= TTMDBPeopleLists.Create(Self);
  FPeople:= TTMDBPeople.Create(Self);
  FReviews:= TTMDBReviews.Create(Self);
  FSearch:= TTMDBSearch.Create(Self);
  FTrending:= TTMDBTrending.Create(Self);
  FTVSeriesLists:= TTMDBTVSeriesLists.Create(Self);
  FTVSeries:= TTMDBTVSeries.Create(Self);
  FTVSeasons:= TTMDBTVSeasons.Create(Self);
  FTVEpisodes:= TTMDBTVEpisodes.Create(Self);
  FTVEpisodeGroups:= TTMDBTVEpisodeGroups.Create(Self);
  FWatchProviders:= TTMDBWatchProviders.Create(Self);

end;

destructor TTMDBAPI.Destroy;
begin

  FreeAndNil(FWatchProviders);
  FreeAndNil(FTVEpisodeGroups);
  FreeAndNil(FTVEpisodes);
  FreeAndNil(FTVSeasons);
  FreeAndNil(FTVSeries);
  FreeAndNil(FTVSeriesLists);
  FreeAndNil(FTrending);
  FreeAndNil(FSearch);
  FreeAndNil(FReviews);
  FreeAndNil(FPeople);
  FreeAndNil(FPeopleLists);
  FreeAndNil(FNetworks);
  FreeAndNil(FMovies);
  FreeAndNil(FMovieLists);
  FreeAndNil(FLists);
  FreeAndNil(FKeywords);
  FreeAndNil(FGuestSessions);
  FreeAndNil(FGenres);
  FreeAndNil(FFind);
  FreeAndNil(FDiscover);
  FreeAndNil(FCredits);
  FreeAndNil(FConfiguration);
  FreeAndNil(FCompanies);
  FreeAndNil(FCollections);
  FreeAndNil(FChanges);
  FreeAndNil(FCertifications);
  FreeAndNil(FAuthentication);
  FreeAndNil(FAccount);

  FreeAndNil(FHTTP);
  inherited;
end;

procedure TTMDBAPI.PrepareJSONRequest;
begin
  FHTTP.Request.Accept:= 'application/json';
  FHTTP.Request.ContentType:= 'application/json;charset=utf-8';
  FHTTP.Request.RawHeaders.Values['User-Agent']:= FAppUserAgent;
  //TODO: API token header if applicable...

end;

function TTMDBAPI.GetJSON(const Req, Params: String): ISuperObject;
var
  R: String;
  U: String;
  S: String;
begin
  Result:= nil;
  PrepareJSONRequest;
  R:= Req;
  if Copy(R, 1, 1) = '/' then
    Delete(R, 1, 1);
  U:= TMDB_API_ROOT + R + '?api_key=' + FAPIKey + Params;
  S:= FHTTP.Get(U);
  Result:= SO(S);
end;

function TTMDBAPI.PostJSON(const Req, Params: String;
  const Body: ISuperObject): ISuperObject;
var
  R: String;
  U: String;
  S: String;
  B: TStringStream;
begin
  Result:= nil;
  PrepareJSONRequest;
  R:= Req;
  if Copy(R, 1, 1) = '/' then
    Delete(R, 1, 1);
  U:= TMDB_API_ROOT + R + '?api_key=' + FAPIKey + Params;
  B:= TStringStream.Create;
  try
    Body.SaveTo(B, True);
    B.Position:= 0;

    S:= FHTTP.Post(U, B);

    Result:= SO(S);
  finally
    B.Free;
  end;
end;

function TTMDBAPI.DeleteJSON(const Req, Params: String;
  const Body: ISuperObject): ISuperObject;
var
  R: String;
  U: String;
  S: String;
  B, Res: TStringStream;
begin
  Result:= nil;
  PrepareJSONRequest;
  R:= Req;
  if Copy(R, 1, 1) = '/' then
    Delete(R, 1, 1);
  U:= TMDB_API_ROOT + R + '?api_key=' + FAPIKey + Params;
  B:= TStringStream.Create;
  Res:= TStringStream.Create;
  try
    Body.SaveTo(B, True);
    B.Position:= 0;

    //NOTE: TIdHTTP.Delete does not support request body...
    TIdHTTPAccess(FHTTP).DoRequest('DELETE', U, B, Res, []);
    Res.Position:= 0;
    S:= Res.DataString;

    Result:= SO(S);
  finally
    B.Free;
    Res.Free;
  end;
end;

procedure TTMDBAPI.SetAPIKey(const Value: String);
begin
  FAPIKey := Value;
end;

procedure TTMDBAPI.SetAPIReadAccessToken(const Value: String);
begin
  FAPIReadAccessToken := Value;
end;

procedure TTMDBAPI.SetAppUserAgent(const Value: String);
begin
  FAppUserAgent:= Value;
end;

end.
