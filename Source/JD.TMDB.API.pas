unit JD.TMDB.API;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  ----------------------------------------------------------------------------
  Core API Wrapper using JSON via XSuperObject
  ----------------------------------------------------------------------------

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

  TODO:
  - Images - Use image base URL from configuration instead of hard-coding - Issue #43

  REMARKS:
  - This unit is fully functional at this point, with the exception of a few
    specific Namespaces and capabilities missing as described above.
  - Many requests are still untested.
  - The "Intf" / "Impl" layer is still a major work in progress, with many
    TMDB specific interfaces and corresponding implementation objects.
    That is meant to be the primary means of using this library - this unit
    shouldn't have to be referenced in practical usage at all.

*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  Winapi.Windows,
  XSuperObject, XSuperJSON,
  JD.TMDB.Common,
  IdURI, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.NetEncoding;

type
  TTMDBAPI = class;

  TTMDBAPINamespace = class(TPersistent)
  private
    FOwner: TTMDBAPI;
    procedure AddParam(var S: String; const N, V: String);
  public
    constructor Create(AOwner: TTMDBAPI); virtual;
    destructor Destroy; override;
  end;

  TTMDBAPIAccount = class(TTMDBAPINamespace)
  public
    function GetDetails(const AccountID: Integer; const SessionID: String = ''): ISuperObject;
    function GetDetailsBySession(const SessionID: String): ISuperObject;
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

  TTMDBAPIAuthentication = class(TTMDBAPINamespace)
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

  TTMDBAPICertifications = class(TTMDBAPINamespace)
  public
    function GetMovieCertifications: ISuperObject;
    function GetTVCertifications: ISuperObject;
  end;

  TTMDBAPIChanges = class(TTMDBAPINamespace)
  public
    function GetMovieList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
    function GetPeopleList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
    function GetTVList(const StartDate: TDateTime = 0; const EndDate: TDateTime = 0;
      const Page: Integer = 1): ISuperObject;
  end;

  TTMDBAPICollections = class(TTMDBAPINamespace)
  public
    function GetDetails(const CollectionID: Integer; const Language: String = ''): ISuperObject;
    function GetImages(const CollectionID: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetTranslations(const CollectionID: Integer): ISuperObject;
  end;

  TTMDBAPICompanies = class(TTMDBAPINamespace)
  public
    function GetDetails(const CompanyID: Integer): ISuperObject;
    function GetAlternativeNames(const CompanyID: Integer): ISuperObject;
    function GetImages(const CompanyID: Integer): ISuperObject;
  end;

  TTMDBAPIConfiguration = class(TTMDBAPINamespace)
  public
    function GetDetails: ISuperObject;
    function GetCountries: ISuperArray;
    function GetJobs: ISuperArray;
    function GetLanguages: ISuperArray;
    function GetPrimaryTranslations: ISuperArray;
    function GetTimeZones: ISuperArray;
  end;

  TTMDBAPICredits = class(TTMDBAPINamespace)
  public
    function GetDetails(const CreditID: WideString): ISuperObject;
  end;

  TTMDBAPIDiscoverMovieReq = record
  private
    FObj: ISuperObject;
    procedure EnsureObj;

    function GetCertification: WideString;
    function GetCertificationGTE: WideString;
    function GetCertificationLTE: WideString;
    function GetCertificationCountry: WideString;
    function GetIncludeAdult: TTMDBBoolean;
    function GetIncludeVideo: TTMDBBoolean;
    function GetLanguage: WideString;
    function GetPrimaryReleaseYear: Integer;
    function GetPrimaryReleaseDateGTE: TDateTime;
    function GetPrimaryReleaseDateLTE: TDateTime;
    function GetRegion: WideString;
    function GetReleaseDateGTE: TDateTime;
    function GetReleaseDateLTE: TDateTime;
    function GetSortBy: WideString;
    function GetVoteAverageGTE: Single;
    function GetVoteAverageLTE: Single;
    function GetVoteCountGTE: Single;
    function GetVoteCountLTE: Single;
    function GetWatchRegion: WideString;
    function GetWithCast: WideString;
    function GetWithCompanies: WideString;
    function GetWithCrew: WideString;
    function GetWithGenres: WideString;
    function GetWithKeywords: WideString;
    function GetWithOriginCountry: WideString;
    function GetWithOriginalLanguage: WideString;
    function GetWithPeople: WideString;
    function GetWithReleaseType: WideString;
    function GetWithRuntimeGTE: Integer;
    function GetWithRuntimeLTE: Integer;
    function GetWithWatchMonetizationTypes: WideString;
    function GetWithWatchProviders: WideString;
    function GetWithoutCompanies: WideString;
    function GetWithoutGenres: WideString;
    function GetWithoutKeywords: WideString;
    function GetWithoutWatchProviders: WideString;
    function GetYear: Integer;

    procedure SetCertification(const AValue: WideString);
    procedure SetCertificationGTE(const AValue: WideString);
    procedure SetCertificationLTE(const AValue: WideString);
    procedure SetCertificationCountry(const AValue: WideString);
    procedure SetIncludeAdult(const AValue: TTMDBBoolean);
    procedure SetIncludeVideo(const AValue: TTMDBBoolean);
    procedure SetLanguage(const AValue: WideString);
    procedure SetPrimaryReleaseYear(const AValue: Integer);
    procedure SetPrimaryReleaseDateGTE(const AValue: TDateTime);
    procedure SetPrimaryReleaseDateLTE(const AValue: TDateTime);
    procedure SetRegion(const AValue: WideString);
    procedure SetReleaseDateGTE(const AValue: TDateTime);
    procedure SetReleaseDateLTE(const AValue: TDateTime);
    procedure SetSortBy(const AValue: WideString);
    procedure SetVoteAverageGTE(const AValue: Single);
    procedure SetVoteAverageLTE(const AValue: Single);
    procedure SetVoteCountGTE(const AValue: Single);
    procedure SetVoteCountLTE(const AValue: Single);
    procedure SetWatchRegion(const AValue: WideString);
    procedure SetWithCast(const AValue: WideString);
    procedure SetWithCompanies(const AValue: WideString);
    procedure SetWithCrew(const AValue: WideString);
    procedure SetWithGenres(const AValue: WideString);
    procedure SetWithKeywords(const AValue: WideString);
    procedure SetWithOriginCountry(const AValue: WideString);
    procedure SetWithOriginalLanguage(const AValue: WideString);
    procedure SetWithPeople(const AValue: WideString);
    procedure SetWithReleaseType(const AValue: WideString);
    procedure SetWithRuntimeGTE(const AValue: Integer);
    procedure SetWithRuntimeLTE(const AValue: Integer);
    procedure SetWithWatchMonetizationTypes(const AValue: WideString);
    procedure SetWithWatchProviders(const AValue: WideString);
    procedure SetWithoutCompanies(const AValue: WideString);
    procedure SetWithoutGenres(const AValue: WideString);
    procedure SetWithoutKeywords(const AValue: WideString);
    procedure SetWithoutWatchProviders(const AValue: WideString);
    procedure SetYear(const AValue: Integer);
  public
    constructor Create(AObj: ISuperObject);

    function GetParamStr: WideString;

    property Certification: WideString read GetCertification write SetCertification;
    property CertificationGTE: WideString read GetCertificationGTE write SetCertificationGTE;
    property CertificationLTE: WideString read GetCertificationLTE write SetCertificationLTE;
    property CertificationCountry: WideString read GetCertificationCountry write SetCertificationCountry;
    property IncludeAdult: TTMDBBoolean read GetIncludeAdult write SetIncludeAdult;
    property IncludeVideo: TTMDBBoolean read GetIncludeVideo write SetIncludeVideo;
    property Language: WideString read GetLanguage write SetLanguage;
    property PrimaryReleaseYear: Integer read GetPrimaryReleaseYear write SetPrimaryReleaseYear;
    property PrimaryReleaseDateGTE: TDateTime read GetPrimaryReleaseDateGTE write SetPrimaryReleaseDateGTE;
    property PrimaryReleaseDateLTE: TDateTime read GetPrimaryReleaseDateLTE write SetPrimaryReleaseDateLTE;
    property Region: WideString read GetRegion write SetRegion;
    property ReleaseDateGTE: TDateTime read GetReleaseDateGTE write SetReleaseDateGTE;
    property ReleaseDateLTE: TDateTime read GetReleaseDateLTE write SetReleaseDateLTE;
    property SortBy: WideString read GetSortBy write SetSortBy;
    property VoteAverageGTE: Single read GetVoteAverageGTE write SetVoteAverageGTE;
    property VoteAverageLTE: Single read GetVoteAverageLTE write SetVoteAverageLTE;
    property VoteCountGTE: Single read GetVoteCountGTE write SetVoteCountGTE;
    property VoteCountLTE: Single read GetVoteCountLTE write SetVoteCountLTE;
    property WatchRegion: WideString read GetWatchRegion write SetWatchRegion;
    property WithCast: WideString read GetWithCast write SetWithCast;
    property WithCompanies: WideString read GetWithCompanies write SetWithCompanies;
    property WithCrew: WideString read GetWithCrew write SetWithCrew;
    property WithGenres: WideString read GetWithGenres write SetWithGenres;
    property WithKeywords: WideString read GetWithKeywords write SetWithKeywords;
    property WithOriginCountry: WideString read GetWithOriginCountry write SetWithOriginCountry;
    property WithOriginalLanguage: WideString read GetWithOriginalLanguage write SetWithOriginalLanguage;
    property WithPeople: WideString read GetWithPeople write SetWithPeople;
    property WithReleaseType: WideString read GetWithReleaseType write SetWithReleaseType;
    property WithRuntimeGTE: Integer read GetWithRuntimeGTE write SetWithRuntimeGTE;
    property WithRuntimeLTE: Integer read GetWithRuntimeLTE write SetWithRuntimeLTE;
    property WithWatchMonetizationTypes: WideString read GetWithWatchMonetizationTypes write SetWithWatchMonetizationTypes;
    property WithWatchProviders: WideString read GetWithWatchProviders write SetWithWatchProviders;
    property WithoutCompanies: WideString read GetWithoutCompanies write SetWithoutCompanies;
    property WithoutGenres: WideString read GetWithoutGenres write SetWithoutGenres;
    property WithoutKeywords: WideString read GetWithoutKeywords write SetWithoutKeywords;
    property WithoutWatchProviders: WideString read GetWithoutWatchProviders write SetWithoutWatchProviders;
    property Year: Integer read GetYear write SetYear;
  end;

  TTMDBAPIDiscoverTVReq = record
  private
    FObj: ISuperObject;
    procedure EnsureObj;

    function GetAirDateGTE: TDateTime;
    function GetAirDateLTE: TDateTime;
    function GetFirstAirDateYear: Integer;
    function GetFirstAirDateGTE: TDateTime;
    function GetFirstAirDateLTE: TDateTime;
    function GetIncludeAdult: TTMDBBoolean;
    function GetIncludeNullFirstAirDates: TTMDBBoolean;
    function GetLanguage: WideString;
    function GetScreenedTheatrically: TTMDBBoolean;
    function GetSortBy: WideString;
    function GetTimezone: WideString;
    function GetVoteAverageGTE: Single;
    function GetVoteAverageLTE: Single;
    function GetVoteCountGTE: Single;
    function GetVoteCountLTE: Single;
    function GetWatchRegion: WideString;
    function GetWithCompanies: WideString;
    function GetWithGenres: WideString;
    function GetWithKeywords: WideString;
    function GetWithNetworks: WideString;
    function GetWithOriginCountry: WideString;
    function GetWithOriginalLanguage: WideString;
    function GetWithRuntimeGTE: Integer;
    function GetWithRuntimeLTE: Integer;
    function GetWithStatus: WideString;
    function GetWithWatchMonetizationTypes: WideString;
    function GetWithWatchProviders: WideString;
    function GetWithoutCompoanies: WideString;
    function GetWithoutGenres: WideString;
    function GetWithoutKeywords: WideString;
    function GetWithoutWatchProviders: WideString;
    function GetWithType: WideString;

    procedure SetAirDateGTE(const AValue: TDateTime);
    procedure SetAirDateLTE(const AValue: TDateTime);
    procedure SetFirstAirDateYear(const AValue: Integer);
    procedure SetFirstAirDateGTE(const AValue: TDateTime);
    procedure SetFirstAirDateLTE(const AValue: TDateTime);
    procedure SetIncludeAdult(const AValue: TTMDBBoolean);
    procedure SetIncludeNullFirstAirDates(const AValue: TTMDBBoolean);
    procedure SetLanguage(const AValue: WideString);
    procedure SetScreenedTheatrically(const AValue: TTMDBBoolean);
    procedure SetSortBy(const AValue: WideString);
    procedure SetTimezone(const AValue: WideString);
    procedure SetVoteAverageGTE(const AValue: Single);
    procedure SetVoteAverageLTE(const AValue: Single);
    procedure SetVoteCountGTE(const AValue: Single);
    procedure SetVoteCountLTE(const AValue: Single);
    procedure SetWatchRegion(const AValue: WideString);
    procedure SetWithCompanies(const AValue: WideString);
    procedure SetWithGenres(const AValue: WideString);
    procedure SetWithKeywords(const AValue: WideString);
    procedure SetWithNetworks(const AValue: WideString);
    procedure SetWithOriginCountry(const AValue: WideString);
    procedure SetWithOriginalLanguage(const AValue: WideString);
    procedure SetWithRuntimeGTE(const AValue: Integer);
    procedure SetWithRuntimeLTE(const AValue: Integer);
    procedure SetWithStatus(const AValue: WideString);
    procedure SetWithWatchMonetizationTypes(const AValue: WideString);
    procedure SetWithWatchProviders(const AValue: WideString);
    procedure SetWithoutCompoanies(const AValue: WideString);
    procedure SetWithoutGenres(const AValue: WideString);
    procedure SetWithoutKeywords(const AValue: WideString);
    procedure SetWithoutWatchProviders(const AValue: WideString);
    procedure SetWithType(const AValue: WideString);
  public
    constructor Create(AObj: ISuperObject);

    function GetParamStr: WideString;

    property AirDateGTE: TDateTime read GetAirDateGTE write SetAirDateGTE;
    property AirDateLTE: TDateTime read GetAirDateLTE write SetAirDateLTE;
    property FirstAirDateYear: Integer read GetFirstAirDateYear write SetFirstAirDateYear;
    property FirstAirDateGTE: TDateTime read GetFirstAirDateGTE write SetFirstAirDateGTE;
    property FirstAirDateLTE: TDAteTime read GetFirstAirDateLTE write SetFirstAirDateLTE;
    property IncludeAdult: TTMDBBoolean read GetIncludeAdult write SetIncludeAdult;
    property IncludeNullFirstAirDates: TTMDBBoolean read GetIncludeNullFirstAirDates write SetIncludeNullFirstAirDates;
    property Language: WideString read GetLanguage write SetLanguage;
    property ScreenedTheatrically: TTMDBBoolean read GetScreenedTheatrically write SetScreenedTheatrically;
    property SortBy: WideString read GetSortBy write SetSortBy;
    property Timezone: WideString read GetTimezone write SetTimezone;
    property VoteAverageGTE: Single read GetVoteAverageGTE write SetVoteAverageGTE;
    property VoteAverageLTE: Single read GetVoteAverageLTE write SetVoteAverageLTE;
    property VoteCountGTE: Single read GetVoteCountGTE write SetVoteCountGTE;
    property VoteCountLTE: Single read GetVoteCountLTE write SetVoteCountLTE;
    property WatchRegion: WideString read GetWatchRegion write SetWatchRegion;
    property WithCompanies: WideString read GetWithCompanies write SetWithCompanies;
    property WithGenres: WideString read GetWithGenres write SetWithGenres;
    property WithKeywords: WideString read GetWithKeywords write SetWithKeywords;
    property WithNetworks: WideString read GetWithNetworks write SetWithNetworks;
    property WithOriginCountry: WideString read GetWithOriginCountry write SetWithOriginCountry;
    property WithOriginalLanguage: WideString read GetWithOriginalLanguage write SetWithOriginalLanguage;
    property WithRuntimeGTE: Integer read GetWithRuntimeGTE write SetWithRuntimeGTE;
    property WithRuntimeLTE: Integer read GetWithRuntimeLTE write SetWithRuntimeLTE;
    property WithStatus: WideString read GetWithStatus write SetWithStatus;
    property WithWatchMonetizationTypes: WideString read GetWithWatchMonetizationTypes write SetWithWatchMonetizationTypes;
    property WithWatchProviders: WideString read GetWithWatchProviders write SetWithWatchProviders;
    property WithoutCompoanies: WideString read GetWithoutCompoanies write SetWithoutCompoanies;
    property WithoutGenres: WideString read GetWithoutGenres write SetWithoutGenres;
    property WithoutKeywords: WideString read GetWithoutKeywords write SetWithoutKeywords;
    property WithoutWatchProviders: WideString read GetWithoutWatchProviders write SetWithoutWatchProviders;
    property WithType: WideString read GetWithType write SetWithType;
  end;

  TTMDBAPIDiscover = class(TTMDBAPINamespace)
  public
    function GetMovie(Params: TTMDBAPIDiscoverMovieReq; const Page: Integer = 1): ISuperObject;
    function GetTV(Params: TTMDBAPIDiscoverTVReq; const Page: Integer = 1): ISuperObject;
  end;

  TTMDBAPIFind = class(TTMDBAPINamespace)
  public
    function GetFindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ISuperObject;
  end;

  TTMDBAPIGenres = class(TTMDBAPINamespace)
  public
    function GetMovieList(const Language: String = ''): ISuperArray;
    function GetTVList(const Language: String = ''): ISuperArray;
  end;

  TTMDBAPIGuestSessions = class(TTMDBAPINamespace)
  public
    function GetRatedMovies(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
    function GetRatedTV(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
    function GetRatedTVEpisodes(const GuestSessionID: String; const Language: String = '';
      const Page: Integer = 1; const SortBy: String = ''): ISuperObject;
  end;

  TTMDBAPIKeywords = class(TTMDBAPINamespace)
  public
    function GetDetails(const KeywordID: Integer): ISuperObject;
    //DEPRECATED function GetMovies(): ISuperObject;
  end;

  TTMDBAPILists = class(TTMDBAPINamespace)
  public
    function AddMovie(const ListID: Integer; const SessionID: String;
      const MediaID: Integer): ISuperObject;
    function GetCheckItemStatus(const ListID: Integer; const Language: String = '';
      const MovieID: Integer = 0): ISuperObject;
    function Clear(const ListID: Integer; const SessionID: String;
      const Confirm: Boolean = False): ISuperObject;
    function CreateList(const SessionID: String; const Name, Description, Language: String): ISuperObject;
    function Delete(const ListID: Integer; const SessionID: String): ISuperObject;
    function GetDetails(const ListID: Integer; const Language: String = ''): ISuperObject;
    function RemoveMovie(const ListID: Integer; const SessionID: String;
      const MediaID: Integer): ISuperObject;
  end;

  TTMDBAPIMovieLists = class(TTMDBAPINamespace)
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

  TTMDBAPIMovies = class(TTMDBAPINamespace)
  public
    function GetDetails(const MovieID: Integer; const AppendToResponse: String = '';
      const Language: String = ''; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAccountStates(const MovieID: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAlternativeTitles(const MovieID: Integer;
      const Country: String = ''): ISuperArray;
    function GetChanges(const MovieID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0): ISuperObject;
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
    function GetTranslations(const MovieID: Integer): ISuperObject;
    function GetVideos(const MovieID: Integer; const Language: String = ''): ISuperObject;
    function GetWatchProviders(const MovieID: Integer): ISuperObject;
    function AddRating(const MovieID: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const MovieID: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBAPINetworks = class(TTMDBAPINamespace)
  public
    function GetDetails(const NetworkID: Integer): ISuperObject;
    function GetAlternativeNames(const NetworkID: Integer): ISuperArray;
    function GetImages(const NetworkID: Integer): ISuperObject;
  end;

  TTMDBAPIPeopleLists = class(TTMDBAPINamespace)
  public
    function GetPopular(const Language: String = ''; const Page: Integer = 1): ISuperObject;
  end;

  TTMDBAPIPeople = class(TTMDBAPINamespace)
  public
    function GetDetails(const PersonID: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetChanges(const PersonID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0): ISuperObject;
    function GetCombinedCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    function GetExternalIDs(const PersonID: Integer): ISuperObject;
    function GetImages(const PersonID: Integer): ISuperObject;
    function GetLatest: ISuperObject;
    function GetMovieCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    function GetTVCredits(const PersonID: Integer; const Language: String = ''): ISuperObject;
    //DEPRECATED function GetTaggedImages(): ISuperObject;
    function GetTranslations(const PersonID: Integer): ISuperObject;
  end;

  TTMDBAPIReviews = class(TTMDBAPINamespace)
  public
    function GetDetails(const ReviewID: String): ISuperObject;
  end;

  TTMDBAPISearch = class(TTMDBAPINamespace)
  public
    function SearchCollections(const Query: String; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: String = ''; const Page: Integer = 1; const Region: String = ''): ISuperObject;
    function SearchCompanies(const Query: String; const Page: Integer = 1): ISuperObject;
    function SearchKeywords(const Query: String; const Page: Integer = 1): ISuperObject;
    function SearchMovies(const Query: String; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: String = ''; const PrimaryReleaseYear: String = '';
      const Page: Integer = 1; const Region: String = ''; const Year: String = ''): ISuperObject;
    function SearchMulti(const Query: String; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function SearchPerson(const Query: String; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function SearchTV(const Query: String; const FirstAirDateYear: String = '';
      const IncludeAdult: TTMDBBoolean = bDefault; const Language: String = '';
      const Page: Integer = 1; const Year: String = ''): ISuperObject;
  end;

  TTMDBAPITrending = class(TTMDBAPINamespace)
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

  TTMDBAPITVSeriesLists = class(TTMDBAPINamespace)
  public
    function GetAiringToday(const Language: String = ''; const Page: Integer = 1;
      const Timezone: String = ''): ISuperObject;
    function GetOnTheAir(const Language: String = ''; const Page: Integer = 1;
      const Timezone: String = ''): ISuperObject;
    function GetPopular(const Language: String = ''; const Page: Integer = 1): ISuperObject;
    function GetTopRated(const Language: String = ''; const Page: Integer = 1): ISuperObject;
  end;

  TTMDBAPITVSeries = class(TTMDBAPINamespace)
  public
    function GetDetails(const SeriesID: Integer; const AppendToResponse: String = '';
      const Language: String = ''; const SessionID: WideString = ''): ISuperObject;
    function GetAccountStates(const SeriesID: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAggregateCredits(const SeriesID: Integer; const Language: String = ''): ISuperObject;
    function GetAlternativeTitles(const SeriesID: Integer): ISuperArray;
    function GetChanges(const SeriesID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperObject;
    function GetContentRatings(const SeriesID: Integer): ISuperArray;
    function GetCredits(const SeriesID: Integer; const Language: String = ''): ISuperObject;
    function GetEpisodeGroups(const SeriesID: Integer): ISuperObject;
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
    function GetTranslations(const SeriesID: Integer): ISuperObject;
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetWatchProviders(const SeriesID: Integer): ISuperObject;
    function AddRating(const SeriesID: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const SeriesID: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBAPITVSeasons = class(TTMDBAPINamespace)
  public
    function GetDetails(const SeriesID: Integer; const SeasonNumber: Integer;
      const AppendToResponse: String = ''; const Language: String = ''): ISuperObject;
    function GetAccountStates(const SeriesID, SeasonNumber: Integer; const SessionID: String = '';
      const GuestSessionID: String = ''): ISuperObject;
    function GetAggregateCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
    function GetChanges(const SeasonID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0; const Page: Integer = 1): ISuperArray;
    function GetCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
    function GetExternalIDs(const SeriesID: Integer; const SeasonNumber: Integer): ISuperObject;
    function GetImages(const SeriesID: Integer; const SeasonNumber: Integer;
      const IncludeImageLanguage: String = ''; const Language: String = ''): ISuperObject;
    function GetTranslations(const SeriesID: Integer; const SeasonNumber: Integer): ISuperObject;
    function GetVideos(const SeriesID: Integer; const SeasonNumber: Integer;
      const IncludeVideoLanguage: String = ''; const Language: String = ''): ISuperObject;
    function GetWatchProviders(const SeriesID: Integer; const SeasonNumber: Integer;
      const Language: String = ''): ISuperObject;
  end;

  TTMDBAPITVEpisodes = class(TTMDBAPINamespace)
  public
    function GetDetails(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const AppendToResponse: String = '';
      const Language: String = ''): ISuperObject;
    function GetAccountStates(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const SessionID: String = ''; const GuestSessionID: String = ''): ISuperObject;
    function GetChanges(const EpisodeID: Integer; const StartDate: TDateTime = 0;
      const EndDate: TDateTime = 0): ISuperArray;
    function GetCredits(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const Language: String = ''): ISuperObject;
    function GetExternalIDs(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer): ISuperObject;
    function GetImages(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const IncludeImageLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function GetTranslations(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer): ISuperObject;
    function GetVideos(const SeriesID: Integer; const SeasonNumber: Integer;
      const EpisodeNumber: Integer; const IncludeVideoLanguage: String = '';
      const Language: String = ''): ISuperObject;
    function AddRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer; const Rating: Single;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
    function DeleteRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const GuestSessionID: String = ''; const SessionID: String = ''): ISuperObject;
  end;

  TTMDBAPITVEpisodeGroups = class(TTMDBAPINamespace)
  public
    function GetDetail(const TVEpisodeGroupID: String): ISuperObject;
  end;

  TTMDBAPIWatchProviders = class(TTMDBAPINamespace)
  private
    function CheckAttribution: Boolean;
  public
    function GetAvailableRegions(const Language: String = ''): ISuperArray;
    function GetMovieProviders(const Language: String = '';
      const WatchRegion: String = ''): ISuperArray;
    function GetTVProviders(const Language: String = '';
      const WatchRegion: String = ''): ISuperArray;
  end;

  TTMDBAPIImages = class(TTMDBAPINamespace)
  public
  end;

  TTMDBAPI = class(TComponent)
  private
    FHTTP: TIdHTTP;
    FSSEIO: TIdSSLIOHandlerSocketOpenSSL;
    FLastReqMsec: DWORD;
    FAPIKey: String;
    FAPIReadAccessToken: String;
    FAPIAuth: TTMDBAuthMethod;
    FAppUserAgent: String;
    FRateLimitMsec: DWORD;
    FAuthMethod: TTMDBAuthMethod;
    FAgreedToWatchProviderAttribution: Boolean;
    FRateLimiting: Boolean;

    //TMDB API Namespaces
    FConfiguration: TTMDBAPIConfiguration;
    FGenres: TTMDBAPIGenres;
    FMovies: TTMDBAPIMovies;
    FPeople: TTMDBAPIPeople;
    FNetworks: TTMDBAPINetworks;
    FSearch: TTMDBAPISearch;
    FTVSeries: TTMDBAPITVSeries;
    FTVSeasons: TTMDBAPITVSeasons;
    FWatchProviders: TTMDBAPIWatchProviders;
    FTVEpisodes: TTMDBAPITVEpisodes;
    FCompanies: TTMDBAPICompanies;
    FCertifications: TTMDBAPICertifications;
    FCollections: TTMDBAPICollections;
    FAuthentication: TTMDBAPIAuthentication;
    FChanges: TTMDBAPIChanges;
    FCredits: TTMDBAPICredits;
    FAccount: TTMDBAPIAccount;
    FTVEpisodeGroups: TTMDBAPITVEpisodeGroups;
    FDiscover: TTMDBAPIDiscover;
    FFind: TTMDBAPIFind;
    FGuestSessions: TTMDBAPIGuestSessions;
    FKeywords: TTMDBAPIKeywords;
    FLists: TTMDBAPILists;
    FMovieLists: TTMDBAPIMovieLists;
    FPeopleLists: TTMDBAPIPeopleLists;
    FTrending: TTMDBAPITrending;
    FReviews: TTMDBAPIReviews;
    FTVSeriesLists: TTMDBAPITVSeriesLists;
    FImageBaseURL: String;
    procedure SetAPIKey(const Value: String);
    procedure SetAPIReadAccessToken(const Value: String);
    procedure SetAppUserAgent(const Value: String);
    procedure PrepareJSONRequest;
    function GetURL(Req, Params: String): String;
    function GetJSON(const Req: String; const Params: String = ''): ISuperObject;
    function PostJSON(const Req: String; const Params: String = '';
      const Body: ISuperObject = nil): ISuperObject;
    function DeleteJSON(const Req: String; const Params: String = '';
      const Body: ISuperObject = nil): ISuperObject;
    function GetWatchProviders: TTMDBAPIWatchProviders;
    procedure SetAuthMethod(const Value: TTMDBAuthMethod);
    procedure SetAgreedToWatchProviderAttribution(const Value: Boolean);

    //Rate Limiting
    procedure SetRateLimitMsec(const Value: DWORD);
    procedure SetRateLimiting(const Value: Boolean);
    procedure CheckRateLimit;
    function GetRatetLimitWaitMsec: DWORD;
    procedure SetImageBaseURL(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetImageURL(const Path: WideString; const Size: WideString = 'original'): WideString;
    function GetImage(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean;
  published
    property AuthMethod: TTMDBAuthMethod read FAuthMethod write SetAuthMethod;
    property APIKey: String read FAPIKey write SetAPIKey;
    property APIReadAccessToken: String read FAPIReadAccessToken write SetAPIReadAccessToken;
    property AppUserAgent: String read FAppUserAgent write SetAppUserAgent;
    property AgreedToWatchProviderAttribution: Boolean
      read FAgreedToWatchProviderAttribution write SetAgreedToWatchProviderAttribution;
    property ImageBaseURL: String read FImageBaseURL write SetImageBaseURL;

    //Rate Limiting
    property RateLimitMsec: DWORD read FRateLimitMsec write SetRateLimitMsec;
    property RateLimiting: Boolean read FRateLimiting write SetRateLimiting;

    property Account: TTMDBAPIAccount read FAccount;
    property Authentication: TTMDBAPIAuthentication read FAuthentication;
    property Certifications: TTMDBAPICertifications read FCertifications;
    property Changes: TTMDBAPIChanges read FChanges;
    property Collections: TTMDBAPICollections read FCollections;
    property Companies: TTMDBAPICompanies read FCompanies;
    property Configuration: TTMDBAPIConfiguration read FConfiguration;
    property Credits: TTMDBAPICredits read FCredits;
    property Discover: TTMDBAPIDiscover read FDiscover;
    property Find: TTMDBAPIFind read FFind;
    property Genres: TTMDBAPIGenres read FGenres;
    property GuestSessions: TTMDBAPIGuestSessions read FGuestSessions;
    property Keywords: TTMDBAPIKeywords read FKeywords;
    property Lists: TTMDBAPILists read FLists;
    property MovieLists: TTMDBAPIMovieLists read FMovieLists;
    property Movies: TTMDBAPIMovies read FMovies;
    property Networks: TTMDBAPINetworks read FNetworks;
    property PeopleLists: TTMDBAPIPeopleLists read FPeopleLists;
    property People: TTMDBAPIPeople read FPeople;
    property Reviews: TTMDBAPIReviews read FReviews;
    property Search: TTMDBAPISearch read FSearch;
    property Trending: TTMDBAPITrending read FTrending;
    property TVSeriesLists: TTMDBAPITVSeriesLists read FTVSeriesLists;
    property TVSeries: TTMDBAPITVSeries read FTVSeries;
    property TVSeasons: TTMDBAPITVSeasons read FTVSeasons;
    property TVEpisodes: TTMDBAPITVEpisodes read FTVEpisodes;
    property TVEpisodeGroups: TTMDBAPITVEpisodeGroups read FTVEpisodeGroups;
    //NOTE: Be sure to attribute "JustWatch" if your solution uses watch providers.
    property WatchProviders: TTMDBAPIWatchProviders read GetWatchProviders;
  end;

implementation

type
  //Hack to be able to call "Delete" via "DoRequest" and provide a body.
  TIdHTTPAccess = class(TIdHTTP)
  end;

{ TTMDBAPINamespace }

procedure TTMDBAPINamespace.AddParam(var S: String; const N, V: String);
begin
  if V <> '' then
    S:= S + '&'+N+'='+V;
end;

constructor TTMDBAPINamespace.Create(AOwner: TTMDBAPI);
begin
  FOwner:= AOwner;
end;

destructor TTMDBAPINamespace.Destroy;
begin

  inherited;
end;

{ TTMDBAPIAccount }

{
function TTMDBAPIAccount.GetAccountInfo: ISuperObject;
var
  U: String;
begin
  //NOTE: This is an UNDOCUMENTED API call which appears to be the ONLY place
  //  where you can obtain your "account_id" to use in further account requests.
  //https://www.themoviedb.org/talk/5f5a5b82ec0c580035a457fd    (Bottom of page)
  U:= 'account';
  Result:= FOwner.GetJSON(U);
end;
}

function TTMDBAPIAccount.GetDetails(const AccountID: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account';
  if AccountID >= 0 then
    U:= URLCombine(U, AccountID);
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIAccount.GetDetailsBySession(
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:='account';
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIAccount.AddFavorite(const AccountID: Integer;
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
  U:= URLCombine('account', AccountID);
  U:= URLCombine(U, 'favorite');
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBAPIAccount.AddToWatchlist(const AccountID: Integer;
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
  U:= URLCombine('account', AccountID);
  U:= URLCombine(U, 'watchlist');
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.PostJSON(U, P, O);
end;

function TTMDBAPIAccount.GetFavoriteMovies(const AccountID: Integer;
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

function TTMDBAPIAccount.GetFavoriteTV(const AccountID: Integer;
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

function TTMDBAPIAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'account/'+IntToStr(AccountID)+'/lists';
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIAccount.GetRatedMovies(const AccountID: Integer;
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

function TTMDBAPIAccount.GetRatedTV(const AccountID: Integer;
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

function TTMDBAPIAccount.GetRatedTVEpisodes(const AccountID: Integer;
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

function TTMDBAPIAccount.GetWatchlistMovies(const AccountID: Integer;
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

function TTMDBAPIAccount.GetWatchlistTV(const AccountID: Integer;
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

{ TTMDBAPIAuthentication }

function TTMDBAPIAuthentication.CreateGuestSession: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication/guest_session/new');
end;

function TTMDBAPIAuthentication.CreateRequestToken: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication/token/new');
end;

function TTMDBAPIAuthentication.CreateSession(
  const RequestToken: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['request_token']:= RequestToken;
  Result:= Fowner.PostJSON('authentication/session/new', '', O);
end;

function TTMDBAPIAuthentication.CreateSessionV4(
  const AccessToken: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['access_token']:= AccessToken;
  Result:= Fowner.PostJSON('authentication/session/convert/4', '', O);
end;

function TTMDBAPIAuthentication.CreateSessionLogin(const Username, Password,
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

function TTMDBAPIAuthentication.DeleteSession(const SessionID: String): ISuperObject;
var
  O: ISuperObject;
begin
  O:= SO;
  O.S['session_id']:= SessionID;
  Result:= Fowner.DeleteJSON('authentication/session', '', O);
end;

function TTMDBAPIAuthentication.GetValidateKey: ISuperObject;
begin
  Result:= FOwner.GetJSON('authentication');
end;

{ TTMDBAPICertifications }

function TTMDBAPICertifications.GetMovieCertifications: ISuperObject;
begin
  Result:= FOwner.GetJSON('certification/movie/list');
end;

function TTMDBAPICertifications.GetTVCertifications: ISuperObject;
begin
  Result:= FOwner.GetJSON('certification/tv/list');
end;

{ TTMDBAPIChanges }

function TTMDBAPIChanges.GetMovieList(const StartDate, EndDate: TDateTime;
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

function TTMDBAPIChanges.GetPeopleList(const StartDate, EndDate: TDateTime;
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

function TTMDBAPIChanges.GetTVList(const StartDate, EndDate: TDateTime;
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

{ TTMDBAPICollections }

function TTMDBAPICollections.GetDetails(const CollectionID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'collection/'+IntToStr(CollectionID);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPICollections.GetImages(const CollectionID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'collection/'+IntToStr(CollectionID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPICollections.GetTranslations(
  const CollectionID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'collection/'+IntToStr(CollectionID)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPICompanies }

function TTMDBAPICompanies.GetDetails(const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID);
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPICompanies.GetAlternativeNames(
  const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID)+'/alternative_names';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPICompanies.GetImages(const CompanyID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'company/'+IntToStr(CompanyID)+'/images';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPIConfiguration }

function TTMDBAPIConfiguration.GetDetails: ISuperObject;
begin
  Result:= FOwner.GetJSON('configuration');
end;

function TTMDBAPIConfiguration.GetCountries: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/countries').AsArray;
end;

function TTMDBAPIConfiguration.GetJobs: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/jobs').AsArray;
end;

function TTMDBAPIConfiguration.GetLanguages: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/languages').AsArray;
end;

function TTMDBAPIConfiguration.GetPrimaryTranslations: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/primary_translations').AsArray;
end;

function TTMDBAPIConfiguration.GetTimeZones: ISuperArray;
begin
  Result:= FOwner.GetJSON('configuration/timezones').AsArray;
end;

{ TTMDBAPICredits }

function TTMDBAPICredits.GetDetails(const CreditID: WideString): ISuperObject;
var
  U: String;
begin
  U:= 'credit/'+CreditID;
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPIDiscover }

function TTMDBAPIDiscover.GetMovie(Params: TTMDBAPIDiscoverMovieReq;
  const Page: Integer): ISuperObject;
var
  P: String;
  U: String;
begin
  P:= Params.GetParamStr;
  U:= 'discover/movie';
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIDiscover.GetTV(Params: TTMDBAPIDiscoverTVReq;
  const Page: Integer): ISuperObject;
var
  P: String;
  U: String;
begin
  P:= Params.GetParamStr;
  U:= 'discover/tv';
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPIFind }

function TTMDBAPIFind.GetFindByID(const ExternalID, ExternalSource,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'find/'+ExternalID;
  AddParam(P, 'external_source', ExternalSource);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPIGenres }

function TTMDBAPIGenres.GetMovieList(const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'genre/movie/list';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['genres'];
end;

function TTMDBAPIGenres.GetTVList(const Language: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'genre/tv/list';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P).A['genres'];
end;

{ TTMDBAPIGuestSessions }

function TTMDBAPIGuestSessions.GetRatedMovies(const GuestSessionID,
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

function TTMDBAPIGuestSessions.GetRatedTV(const GuestSessionID, Language: String;
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

function TTMDBAPIGuestSessions.GetRatedTVEpisodes(const GuestSessionID,
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

{ TTMDBAPIKeywords }

function TTMDBAPIKeywords.GetDetails(const KeywordID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'keyword/'+IntToStr(KeywordID);
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPILists }

function TTMDBAPILists.AddMovie(const ListID: Integer; const SessionID: String;
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

function TTMDBAPILists.GetCheckItemStatus(const ListID: Integer;
  const Language: String; const MovieID: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID)+'/item_status';
  AddParam(P, 'language', Language);
  AddParam(P, 'movie_id', IntToStr(MovieID));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPILists.Clear(const ListID: Integer; const SessionID: String;
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

function TTMDBAPILists.CreateList(const SessionID, Name, Description,
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

function TTMDBAPILists.Delete(const ListID: Integer;
  const SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID);

  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

function TTMDBAPILists.GetDetails(const ListID: Integer; const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'list/'+IntToStr(ListID);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPILists.RemoveMovie(const ListID: Integer; const SessionID: String;
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

{ TTMDBAPIMovieLists }

function TTMDBAPIMovieLists.GetNowPlaying(const Language: String;
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

function TTMDBAPIMovieLists.GetPopular(const Language: String; const Page: Integer;
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

function TTMDBAPIMovieLists.GetTopRated(const Language: String;
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

function TTMDBAPIMovieLists.GetUpcoming(const Language: String;
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

{ TTMDBAPIMovies }

function TTMDBAPIMovies.GetDetails(const MovieID: Integer; const AppendToResponse,
  Language: String; const SessionID: String; const GuestSessionID: String): ISuperObject;
var
  U, P: String;
  S: String;
begin
  U:= 'movie/'+IntToStr(MovieID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);

  //Region test
  AddParam(P, 'region', 'US');

  Result:= FOwner.GetJSON(U, P);
  S:= Result.AsJSON(True);
end;

function TTMDBAPIMovies.GetAccountStates(const MovieID: Integer; const SessionID,
  GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetAlternativeTitles(const MovieID: Integer;
  const Country: String): ISuperArray;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/alternative_titles';
  AddParam(P, 'country', Country);
  Result:= FOwner.GetJSON(U, P).A['titles'];
end;

function TTMDBAPIMovies.GetChanges(const MovieID: Integer; const StartDate,
  EndDate: TDateTime): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetCredits(const MovieID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetExternalIDs(const MovieID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIMovies.GetImages(const MovieID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetKeywords(const MovieID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/keywords';
  Result:= FOwner.GetJSON(U, '').A['keywords'];
end;

function TTMDBAPIMovies.GetLatest: ISuperObject;
var
  U: String;
begin
  U:= 'movie/latest';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIMovies.GetLists(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/lists';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetRecommendations(const MovieID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/recommendations';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetReleaseDates(const MovieID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/release_dates';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPIMovies.GetReviews(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/reviews';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetSimilar(const MovieID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/similar';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetTranslations(const MovieID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIMovies.GetVideos(const MovieID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/videos';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIMovies.GetWatchProviders(const MovieID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIMovies.AddRating(const MovieID: Integer; const Rating: Single;
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

function TTMDBAPIMovies.DeleteRating(const MovieID: Integer; const GuestSessionID,
  SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'movie/'+IntToStr(MovieID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

{ TTMDBAPINetworks }

function TTMDBAPINetworks.GetDetails(const NetworkID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID);
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPINetworks.GetAlternativeNames(const NetworkID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID)+'/alternative_names';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPINetworks.GetImages(const NetworkID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'network/'+IntToStr(NetworkID)+'/images';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPIPeopleLists }

function TTMDBAPIPeopleLists.GetPopular(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/popular';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPIPeople }

function TTMDBAPIPeople.GetDetails(const PersonID: Integer; const AppendToResponse,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIPeople.GetChanges(const PersonID: Integer; const StartDate,
  EndDate: TDateTime): ISuperObject;
var
  S, E: String;
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIPeople.GetCombinedCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/combined_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIPeople.GetExternalIDs(const PersonID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIPeople.GetImages(const PersonID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/images';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPIPeople.GetLatest: ISuperObject;
begin
  Result:= FOwner.GetJSON('person/latest');
end;

function TTMDBAPIPeople.GetMovieCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/movie_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIPeople.GetTVCredits(const PersonID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/tv_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPIPeople.GetTranslations(const PersonID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'person/'+IntToStr(PersonID)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPIReviews }

function TTMDBAPIReviews.GetDetails(const ReviewID: String): ISuperObject;
var
  U: String;
begin
  U:= 'review/'+ReviewID;
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPISearch }

function TTMDBAPISearch.SearchCollections(const Query: String;
  const IncludeAdult: TTMDBBoolean; const Language: String; const Page: Integer;
  const Region: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/collection';
  AddParam(P, 'query', Query);
  AddParam(P, 'include_adult', TMDBBoolToStr(IncludeAdult));
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchCompanies(const Query: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/company';
  AddParam(P, 'query', Query);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchKeywords(const Query: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/keyword';
  AddParam(P, 'query', Query);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchMovies(const Query: String;
  const IncludeAdult: TTMDBBoolean; const Language, PrimaryReleaseYear: String;
  const Page: Integer; const Region, Year: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/movie';
  AddParam(P, 'query', Query);
  AddParam(P, 'include_adult', TMDBBoolToStr(IncludeAdult));
  AddParam(P, 'language', Language);
  AddParam(P, 'primary_release_year', PrimaryReleaseYear);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'region', Region);
  AddParam(P, 'year', Year);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchMulti(const Query: String;
  const IncludeAdult: TTMDBBoolean; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/multi';
  AddParam(P, 'query', Query);
  AddParam(P, 'include_adult', TMDBBoolToStr(IncludeAdult));
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchPerson(const Query: String;
  const IncludeAdult: TTMDBBoolean; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/person';
  AddParam(P, 'query', Query);
  AddParam(P, 'include_adult', TMDBBoolToStr(IncludeAdult));
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPISearch.SearchTV(const Query, FirstAirDateYear: String;
  const IncludeAdult: TTMDBBoolean; const Language: String; const Page: Integer;
  const Year: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'search/tv';
  AddParam(P, 'query', Query);
  AddParam(P, 'include_adult', TMDBBoolToStr(IncludeAdult));
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  AddParam(P, 'year', Year);
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPITrending }

function TTMDBAPITrending.GetAll(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/all/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITrending.GetMovies(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/movie/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITrending.GetPeople(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/person/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITrending.GetTV(const TimeWindow, Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'trending/tv/'+TimeWindow;
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPITVSeriesLists }

function TTMDBAPITVSeriesLists.GetAiringToday(const Language: String;
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

function TTMDBAPITVSeriesLists.GetOnTheAir(const Language: String;
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

function TTMDBAPITVSeriesLists.GetPopular(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/popular';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeriesLists.GetTopRated(const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/top_rated';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

{ TTMDBAPITVSeries }

function TTMDBAPITVSeries.GetDetails(const SeriesID: Integer;
  const AppendToResponse, Language: String; const SessionID: WideString): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  AddParam(P, 'session_id', SessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetAccountStates(const SeriesID: Integer;
  const SessionID, GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetAggregateCredits(const SeriesID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/aggregate_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetAlternativeTitles(
  const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/alternative_titles';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPITVSeries.GetChanges(const SeriesID: Integer; const StartDate,
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

function TTMDBAPITVSeries.GetContentRatings(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/content_ratings';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPITVSeries.GetCredits(const SeriesID: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetEpisodeGroups(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/episode_groups';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeries.GetExternalIDs(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeries.GetImages(const SeriesID: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetKeywords(const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/keywords';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPITVSeries.GetLatest: ISuperObject;
var
  U: String;
begin
  U:= 'tv/latest';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeries.GetLists(const SeriesID: Integer; const Language: String;
  const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/lists';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetRecommendations(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/recommendations';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetReviews(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/reviews';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetScreenedTheatrically(
  const SeriesID: Integer): ISuperArray;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/screened_theatrically';
  Result:= FOwner.GetJSON(U, '').A['results'];
end;

function TTMDBAPITVSeries.GetSimilar(const SeriesID: Integer;
  const Language: String; const Page: Integer): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/similar';
  AddParam(P, 'language', Language);
  AddParam(P, 'page', IntToStr(Page));
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetTranslations(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeries.GetVideos(const SeriesID: Integer;
  const IncludeVideoLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeries.GetWatchProviders(const SeriesID: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeries.AddRating(const SeriesID: Integer; const Rating: Single;
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

function TTMDBAPITVSeries.DeleteRating(const SeriesID: Integer;
  const GuestSessionID, SessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/rating';

  AddParam(P, 'guest_session_id', GuestSessionID);
  AddParam(P, 'session_id', SessionID);

  Result:= FOwner.DeleteJSON(U, P, nil);
end;

{ TTMDBAPITVSeasons }

function TTMDBAPITVSeasons.GetDetails(const SeriesID, SeasonNumber: Integer;
  const AppendToResponse, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber);
  AddParam(P, 'append_to_response', AppendToResponse);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetAccountStates(const SeriesID, SeasonNumber: Integer;
  const SessionID, GuestSessionID: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/account_states';
  AddParam(P, 'session_id', SessionID);
  AddParam(P, 'guest_session_id', GuestSessionID);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetAggregateCredits(const SeriesID,
  SeasonNumber: Integer; const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/aggregate_credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetChanges(const SeasonID: Integer; const StartDate,
  EndDate: TDateTime; const Page: Integer): ISuperArray;
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
  Result:= FOwner.GetJSON(U, P).A['changes'];
end;

function TTMDBAPITVSeasons.GetCredits(const SeriesID, SeasonNumber: Integer;
  const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetExternalIDs(const SeriesID,
  SeasonNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeasons.GetImages(const SeriesID, SeasonNumber: Integer;
  const IncludeImageLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/images';
  AddParam(P, 'include_image_language', IncludeImageLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetTranslations(const SeriesID,
  SeasonNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVSeasons.GetVideos(const SeriesID, SeasonNumber: Integer;
  const IncludeVideoLanguage, Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVSeasons.GetWatchProviders(const SeriesID, SeasonNumber: Integer;
  const Language: String): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/watch/providers';
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPITVEpisodes }

function TTMDBAPITVEpisodes.GetDetails(const SeriesID, SeasonNumber,
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

function TTMDBAPITVEpisodes.GetAccountStates(const SeriesID, SeasonNumber,
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

function TTMDBAPITVEpisodes.GetChanges(const EpisodeID: Integer; const StartDate,
  EndDate: TDateTime): ISuperArray;
var
  S, E: String;
  U, P: String;
begin
  U:= 'tv/episode/'+IntToStr(EpisodeID)+'/changes';
  if StartDate = 0 then S:= '' else S:= FormatDateTime('yyyy-mm-dd', StartDate);
  if EndDate = 0 then E:= '' else E:= FormatDateTime('yyyy-mm-dd', EndDate);
  AddParam(P, 'start_date', S);
  AddParam(P, 'end_date', E);
  Result:= FOwner.GetJSON(U, P).A['changes'];
end;

function TTMDBAPITVEpisodes.GetCredits(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/credits';
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVEpisodes.GetExternalIDs(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/external_ids';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVEpisodes.GetImages(const SeriesID, SeasonNumber,
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

function TTMDBAPITVEpisodes.GetTranslations(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer): ISuperObject;
var
  U: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/translations';
  Result:= FOwner.GetJSON(U, '');
end;

function TTMDBAPITVEpisodes.GetVideos(const SeriesID, SeasonNumber,
  EpisodeNumber: Integer; const IncludeVideoLanguage,
  Language: String): ISuperObject;
var
  U, P: String;
begin
  U:= 'tv/'+IntToStr(SeriesID)+'/season/'+IntToStr(SeasonNumber)+'/episode/'+
    IntToStr(EpisodeNumber)+'/videos';
  AddParam(P, 'include_video_language', IncludeVideoLanguage);
  AddParam(P, 'language', Language);
  Result:= FOwner.GetJSON(U, P);
end;

function TTMDBAPITVEpisodes.AddRating(const SeriesID, SeasonNumber,
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

function TTMDBAPITVEpisodes.DeleteRating(const SeriesID, SeasonNumber,
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

{ TTMDBAPITVEpisodeGroups }

function TTMDBAPITVEpisodeGroups.GetDetail(
  const TVEpisodeGroupID: String): ISuperObject;
var
  U: String;
begin
  U:= 'tv/episode_group/'+TVEpisodeGroupID;
  Result:= FOwner.GetJSON(U, '');
end;

{ TTMDBAPIWatchProviders }

function TTMDBAPIWatchProviders.CheckAttribution: Boolean;
begin
  Result:= FOwner.FAgreedToWatchProviderAttribution;
  if not Result then begin
    raise Exception.Create('You must first agree to attribute "JustWatch" in order to use Watch Providers.');
  end;
end;

function TTMDBAPIWatchProviders.GetAvailableRegions(
  const Language: String): ISuperArray;
var
  U, P: String;
begin
  if CheckAttribution then begin
    U:= 'watch/providers/regions';
    AddParam(P, 'language', Language);
    Result:= FOwner.GetJSON(U, P).A['results'];
  end;
end;

function TTMDBAPIWatchProviders.GetMovieProviders(const Language,
  WatchRegion: String): ISuperArray;
var
  U, P: String;
begin
  if CheckAttribution then begin
    U:= 'watch/providers/movie';
    AddParam(P, 'language', Language);
    AddParam(P, 'watch_region', WatchRegion);
    Result:= FOwner.GetJSON(U, P).A['results'];
  end;
end;

function TTMDBAPIWatchProviders.GetTVProviders(const Language,
  WatchRegion: String): ISuperArray;
var
  U, P: String;
begin
  if CheckAttribution then begin
    U:= 'watch/providers/tv';
    AddParam(P, 'language', Language);
    AddParam(P, 'watch_region', WatchRegion);
    Result:= FOwner.GetJSON(U, P).A['results'];
  end;
end;

{ TTMDBAPI }

constructor TTMDBAPI.Create(AOwner: TComponent);
begin
  inherited;
  FHTTP:= TIdHTTP.Create(nil);
  FAppUserAgent:= TMDB_API_USERAGENT;

  FRateLimitMsec:= 100;
  FLastReqMsec:= GetTickCount;
  FImageBaseURL:= 'https://image.tmdb.org/t/p/';

  FSSEIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSSEIO.SSLOptions.SSLVersions := [sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
  FSSEIO.SSLOptions.Mode := sslmClient;
  FSSEIO.SSLOptions.VerifyMode := [];
  FSSEIO.SSLOptions.VerifyDepth := 0;
  FHTTP.IOHandler := FSSEIO;

  FAccount:= TTMDBAPIAccount.Create(Self);
  FAuthentication:= TTMDBAPIAuthentication.Create(Self);
  FCertifications:= TTMDBAPICertifications.Create(Self);
  FChanges:= TTMDBAPIChanges.Create(Self);
  FCollections:= TTMDBAPICollections.Create(Self);
  FCompanies:= TTMDBAPICompanies.Create(Self);
  FConfiguration:= TTMDBAPIConfiguration.Create(Self);
  FCredits:= TTMDBAPICredits.Create(Self);
  FDiscover:= TTMDBAPIDiscover.Create(Self);
  FFind:= TTMDBAPIFind.Create(Self);
  FGenres:= TTMDBAPIGenres.Create(Self);
  FGuestSessions:= TTMDBAPIGuestSessions.Create(Self);
  FKeywords:= TTMDBAPIKeywords.Create(Self);
  FLists:= TTMDBAPILists.Create(Self);
  FMovieLists:= TTMDBAPIMovieLists.Create(Self);
  FMovies:= TTMDBAPIMovies.Create(Self);
  FNetworks:= TTMDBAPINetworks.Create(Self);
  FPeopleLists:= TTMDBAPIPeopleLists.Create(Self);
  FPeople:= TTMDBAPIPeople.Create(Self);
  FReviews:= TTMDBAPIReviews.Create(Self);
  FSearch:= TTMDBAPISearch.Create(Self);
  FTrending:= TTMDBAPITrending.Create(Self);
  FTVSeriesLists:= TTMDBAPITVSeriesLists.Create(Self);
  FTVSeries:= TTMDBAPITVSeries.Create(Self);
  FTVSeasons:= TTMDBAPITVSeasons.Create(Self);
  FTVEpisodes:= TTMDBAPITVEpisodes.Create(Self);
  FTVEpisodeGroups:= TTMDBAPITVEpisodeGroups.Create(Self);
  FWatchProviders:= TTMDBAPIWatchProviders.Create(Self);
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

  FreeAndNil(FSSEIO);
  FreeAndNil(FHTTP);
  inherited;
end;

function TTMDBAPI.GetRatetLimitWaitMsec: DWORD;
var
  Cur, Next: DWORD;
begin
  //Identify how many MSEC to wait before allowing new request...
  if FRateLimiting then begin
    Cur:= GetTickCount;
    Next:= FLastReqMsec + FRateLimitMsec;
    if Cur < Next then begin
      Result:= Next - Cur;
    end else begin
      Result:= 0;
    end;
  end else begin
    Result:= 0;
  end;
end;

procedure TTMDBAPI.CheckRateLimit;
var
  Wait: DWORD;
begin
  if FRateLimiting then begin
    Wait:= GetRatetLimitWaitMsec;
    if Wait > 0 then
      Sleep(Wait);
    FLastReqMsec:= GetTickCount;
  end;
end;

function TTMDBAPI.GetWatchProviders: TTMDBAPIWatchProviders;
begin
  Result:= FWatchProviders;
end;

procedure TTMDBAPI.PrepareJSONRequest;
begin
  CheckRateLimit;
  FHTTP.Request.Accept:= 'application/json';
  FHTTP.Request.ContentType:= 'application/json;charset=utf-8';
  FHTTP.Request.RawHeaders.Values['User-Agent']:= FAppUserAgent;
  if FAPIAuth = amAccessToken then
    FHTTP.Request.RawHeaders.Values['AAuthorization']:= 'Bearer '+FAPIReadAccessToken;
end;

function TTMDBAPI.GetURL(Req, Params: String): String;
var
  R: String;
begin
  R:= Req;
  if Copy(R, 1, 1) = '/' then
    Delete(R, 1, 1);
  if Params <> '' then
    if Copy(Params, 1, 1) <> '&' then
      Params:= '&' + Params;
  Result:= TMDB_API_ROOT + R;
  if FAPIAuth = amAPIKey then begin
    Result:= Result + '?api_key=' + FAPIKey + Params;
  end else begin
    if Params <> '' then
      Result:= Result + '?' + Params;
  end;
  Result:= TIdURI.URLEncode(Result);
end;

function TTMDBAPI.GetImageURL(const Path, Size: WideString): WideString;
begin
  Result:= FImageBaseURL;
  Result:= URLCombine(Result, Size);
  Result:= URLCombine(Result, Path);

end;

function TTMDBAPI.GetImage(var Base64: WideString; const Path,
  Size: WideString): Boolean;
var
  U: String;
  S: TStringStream;
  Enc: TBase64Encoding;
begin
  //UNTESTED
  //Base64: https://stackoverflow.com/questions/28821900/convert-bitmap-to-string-without-line-breaks/28826182#28826182
  //Result:= False;

  U:= GetImageURL(Path, Size);
  S:= TStringStream.Create;
  try
    //TODO: Setup headers...
    FHTTP.Get(U, S);
    S.Position:= 0;
    Enc:= TBase64Encoding.Create(0);
    try
      Base64:= Enc.Encode(S.DataString);
      Result:= True;
    finally
      Enc.Free;
    end;
  finally
    S.Free;
  end;
end;

function TTMDBAPI.GetJSON(const Req, Params: String): ISuperObject;
var
  U: String;
  S: String;
begin
  Result:= nil;
  PrepareJSONRequest;
  U:= GetURL(Req, Params);
  S:= FHTTP.Get(U);
  Result:= SO(S);
end;

function TTMDBAPI.PostJSON(const Req, Params: String;
  const Body: ISuperObject): ISuperObject;
var
  U: String;
  S: String;
  B: TStringStream;
begin
  Result:= nil;
  PrepareJSONRequest;
  U:= GetURL(Req, Params);
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
  U: String;
  S: String;
  B, Res: TStringStream;
begin
  Result:= nil;
  PrepareJSONRequest;
  U:= GetURL(Req, Params);
  B:= TStringStream.Create;
  Res:= TStringStream.Create;
  try
    Body.SaveTo(B, True);
    B.Position:= 0;

    //NOTE: TIdHTTP.Delete does not support request body, so we
    //  take a shortcut and directly call DoRequest to include a body...
    TIdHTTPAccess(FHTTP).DoRequest('DELETE', U, B, Res, []);
    Res.Position:= 0;
    S:= Res.DataString;

    Result:= SO(S);
  finally
    B.Free;
    Res.Free;
  end;
end;

procedure TTMDBAPI.SetAgreedToWatchProviderAttribution(const Value: Boolean);
begin
  FAgreedToWatchProviderAttribution := Value;
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

procedure TTMDBAPI.SetAuthMethod(const Value: TTMDBAuthMethod);
begin
  FAuthMethod := Value;
end;

procedure TTMDBAPI.SetImageBaseURL(const Value: String);
begin
  FImageBaseURL := Value;
end;

procedure TTMDBAPI.SetRateLimitMsec(const Value: DWORD);
begin
  FRateLimitMsec := Value;
end;

procedure TTMDBAPI.SetRateLimiting(const Value: Boolean);
begin
  FRateLimiting := Value;
end;

{ TTMDBAPIDiscoverMovieReq }

constructor TTMDBAPIDiscoverMovieReq.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  EnsureObj;
end;

procedure TTMDBAPIDiscoverMovieReq.EnsureObj;
begin
  if FObj = nil then
    FObj:= SO;
end;

function TTMDBAPIDiscoverMovieReq.GetParamStr: WideString;
var
  M: IMember;
  procedure A(const V: String); overload;
  begin
    if V <> '' then begin
      if Result <> '' then
        Result:= Result + '&';
      Result:= Result + M.Name + '=' + V;
    end;
  end;
  procedure A(const V: Integer); overload;
  begin
    if V <> 0 then
      A(IntToStr(V));
  end;
  procedure A(const V: Single); overload;
  begin
    if V <> 0 then
      A(FormatFloat('#,###,##0.####', M.AsFloat))
  end;
  procedure A(const V: TDateTime); overload;
  begin
    if V <> 0 then
      A(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', M.AsDateTime));
  end;
  function IsField(const N: String): Boolean;
  begin
    Result:= SameText(N, M.Name);
  end;
begin
  EnsureObj;
  for M in FObj do begin
    case M.DataType of
      dtNil:      ;
      dtNull:     ;
      dtObject:   ;
      dtArray:    ;
      dtString:   A(M.AsString);
      dtInteger: begin
        if IsField('include_adult') or IsField('include_video') then
        begin
          case M.AsInteger of
            0: ; //Default
            1: A('true');
            2: A('false');
          end;
        end else begin
          A(M.AsInteger);
        end;
      end;
      dtFloat:    A(M.AsFloat);
      dtBoolean:  ;
      dtDateTime: A(M.AsDateTime);
      dtDate:     A(FormatDateTime('yyyy-mm-dd', M.AsDate));
      dtTime:     A(FormatDateTime('hh:nn:ss.zzz', M.AsTime));
    end;
  end;
  //raise Exception.Create(Result);
end;

function TTMDBAPIDiscoverMovieReq.GetCertification: WideString;
begin
  EnsureObj;
  Result:= FObj.S['certification'];
end;

function TTMDBAPIDiscoverMovieReq.GetCertificationCountry: WideString;
begin
  EnsureObj;
  Result:= FObj.S['certification_country'];
end;

function TTMDBAPIDiscoverMovieReq.GetCertificationGTE: WideString;
begin
  EnsureObj;
  Result:= FObj.S['certification.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetCertificationLTE: WideString;
begin
  EnsureObj;
  Result:= FObj.S['certification.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetIncludeAdult: TTMDBBoolean;
begin
  EnsureObj;
  Result:= TTMDBBoolean(FObj.I['include_adult']);
end;

function TTMDBAPIDiscoverMovieReq.GetIncludeVideo: TTMDBBoolean;
begin
  EnsureObj;
  Result:= TTMDBBoolean(FObj.I['include_video']);
end;

function TTMDBAPIDiscoverMovieReq.GetLanguage: WideString;
begin
  EnsureObj;
  Result:= FObj.S['language'];
end;

function TTMDBAPIDiscoverMovieReq.GetPrimaryReleaseDateGTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['primary_release_date.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetPrimaryReleaseYear: Integer;
begin
  EnsureObj;
  Result:= FObj.I['primary_release_year'];
end;

function TTMDBAPIDiscoverMovieReq.GetPrimaryReleaseDateLTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['primary_release_date.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetRegion: WideString;
begin
  EnsureObj;
  Result:= FObj.S['region'];
end;

function TTMDBAPIDiscoverMovieReq.GetReleaseDateGTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['release_date.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetReleaseDateLTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['release_date.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetSortBy: WideString;
begin
  EnsureObj;
  Result:= FObj.S['sort_by'];
end;

function TTMDBAPIDiscoverMovieReq.GetVoteAverageGTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_average.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetVoteAverageLTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_average.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetVoteCountGTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_count.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetVoteCountLTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_count.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetWatchRegion: WideString;
begin
  EnsureObj;
  Result:= FObj.S['watch_region'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithCast: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_cast'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithCompanies: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_companies'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithCrew: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_crew'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithGenres: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_genres'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithKeywords: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_keywords'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithOriginalLanguage: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_original_language'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithOriginCountry: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_origin_country'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithoutCompanies: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_companies'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithoutGenres: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_genres'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithoutKeywords: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_keywords'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithoutWatchProviders: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_watch_providers'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithPeople: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_people'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithReleaseType: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_release_type'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithRuntimeGTE: Integer;
begin
  EnsureObj;
  Result:= FObj.I['with_runtime.gte'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithRuntimeLTE: Integer;
begin
  EnsureObj;
  Result:= FObj.I['with_runtime.lte'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithWatchMonetizationTypes: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_watch_monetization_types'];
end;

function TTMDBAPIDiscoverMovieReq.GetWithWatchProviders: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_watch_providers'];
end;

function TTMDBAPIDiscoverMovieReq.GetYear: Integer;
begin
  EnsureObj;
  Result:= FObj.I['year'];
end;

procedure TTMDBAPIDiscoverMovieReq.SetCertification(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['certifications']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetCertificationCountry(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['certification_country']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetCertificationGTE(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['certification.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetCertificationLTE(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['certification.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetIncludeAdult(const AValue: TTMDBBoolean);
begin
  EnsureObj;
  FObj.I['include_adult']:= Integer(AValue);
end;

procedure TTMDBAPIDiscoverMovieReq.SetIncludeVideo(const AValue: TTMDBBoolean);
begin
  EnsureObj;
  FObj.I['include_video']:= Integer(AValue);
end;

procedure TTMDBAPIDiscoverMovieReq.SetLanguage(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['language']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetPrimaryReleaseDateGTE(
  const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['primary_release_date.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetPrimaryReleaseYear(
  const AValue: Integer);
begin
  EnsureObj;
  FObj.I['primary_release_year']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetPrimaryReleaseDateLTE(
  const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['primary_release_date.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetRegion(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['region']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetReleaseDateGTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['release_date.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetReleaseDateLTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['release_date.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetSortBy(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['sort_by']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetVoteAverageGTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_average.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetVoteAverageLTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_average.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetVoteCountGTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_count.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetVoteCountLTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_count.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWatchRegion(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['watch_region']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithCast(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_cast']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithCompanies(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_companies']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithCrew(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_crew']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithGenres(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_genres']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithKeywords(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_keywords']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithOriginalLanguage(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_original_language']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithOriginCountry(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_origin_country']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithoutCompanies(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_companies']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithoutGenres(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_genres']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithoutKeywords(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_keywords']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithoutWatchProviders(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_watch_providers']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithPeople(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_people']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithReleaseType(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_release_type']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithRuntimeGTE(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['with_runtime.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithRuntimeLTE(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['with_runtime.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithWatchMonetizationTypes(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_watch_monetization_types']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetWithWatchProviders(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_watch_providers']:= AValue;
end;

procedure TTMDBAPIDiscoverMovieReq.SetYear(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['year']:= AValue;
end;

{ TTMDBAPIDiscoverTVReq }

constructor TTMDBAPIDiscoverTVReq.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  EnsureObj;
end;

procedure TTMDBAPIDiscoverTVReq.EnsureObj;
begin
  if FObj = nil then
    FObj:= SO;
end;

function TTMDBAPIDiscoverTVReq.GetParamStr: WideString;
var
  M: IMember;
  procedure A(const V: String); overload;
  begin
    if V <> '' then begin
      if Result <> '' then
        Result:= Result + '&';
      Result:= Result + M.Name + '=' + V;
    end;
  end;
  procedure A(const V: Integer); overload;
  begin
    if V <> 0 then
      A(IntToStr(V));
  end;
  procedure A(const V: Single); overload;
  begin
    if V <> 0 then
      A(FormatFloat('#,###,##0.####', M.AsFloat))
  end;
  procedure A(const V: TDateTime); overload;
  begin
    if V <> 0 then
      A(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', M.AsDateTime));
  end;
  function IsField(const N: String): Boolean;
  begin
    Result:= SameText(N, M.Name);
  end;
begin
  EnsureObj;
  for M in FObj do begin
    case M.DataType of
      dtNil:      ;
      dtNull:     ;
      dtObject:   ;
      dtArray:    ;
      dtString:   A(M.AsString);
      dtInteger: begin
        if IsField('include_adult') or IsField('include_null_first_air_dates') or
          IsField('include_screened_theatrically') then
        begin
          case M.AsInteger of
            1: A('true');
            2: A('false');
          end;
        end else begin
          A(M.AsInteger);
        end;
      end;
      dtFloat:    A(M.AsFloat);
      dtBoolean:  ;
      dtDateTime: A(M.AsDateTime);
      dtDate:     A(FormatDateTime('yyyy-mm-dd', M.AsDate));
      dtTime:     A(FormatDateTime('hh:nn:ss.zzz', M.AsTime));
    end;
  end;
end;

function TTMDBAPIDiscoverTVReq.GetAirDateGTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['air_date.gte'];
end;

function TTMDBAPIDiscoverTVReq.GetAirDateLTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['air_date.lte'];
end;

function TTMDBAPIDiscoverTVReq.GetFirstAirDateGTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['first_air_date.gte'];
end;

function TTMDBAPIDiscoverTVReq.GetFirstAirDateLTE: TDateTime;
begin
  EnsureObj;
  Result:= FObj.D['first_air_date.lte'];
end;

function TTMDBAPIDiscoverTVReq.GetFirstAirDateYear: Integer;
begin
  EnsureObj;
  Result:= FObj.I['first_air_date_year'];
end;

function TTMDBAPIDiscoverTVReq.GetIncludeAdult: TTMDBBoolean;
begin
  EnsureObj;
  Result:= TTMDBBoolean(FObj.I['include_adult']);
end;

function TTMDBAPIDiscoverTVReq.GetIncludeNullFirstAirDates: TTMDBBoolean;
begin
  EnsureObj;
  Result:= TTMDBBoolean(FObj.I['include_null_first_air_dates']);
end;

function TTMDBAPIDiscoverTVReq.GetLanguage: WideString;
begin
  EnsureObj;
  Result:= FObj.S['language'];
end;

function TTMDBAPIDiscoverTVReq.GetScreenedTheatrically: TTMDBBoolean;
begin
  EnsureObj;
  Result:= TTMDBBoolean(FObj.I['screened_theatrically']);
end;

function TTMDBAPIDiscoverTVReq.GetSortBy: WideString;
begin
  EnsureObj;
  Result:= FObj.S['sort_by'];
end;

function TTMDBAPIDiscoverTVReq.GetTimezone: WideString;
begin
  EnsureObj;
  Result:= FObj.S['timezone'];
end;

function TTMDBAPIDiscoverTVReq.GetVoteAverageGTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_average.gte'];
end;

function TTMDBAPIDiscoverTVReq.GetVoteAverageLTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_average.lte'];
end;

function TTMDBAPIDiscoverTVReq.GetVoteCountGTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_count.gte'];
end;

function TTMDBAPIDiscoverTVReq.GetVoteCountLTE: Single;
begin
  EnsureObj;
  Result:= FObj.F['vote_count.lte'];
end;

function TTMDBAPIDiscoverTVReq.GetWatchRegion: WideString;
begin
  EnsureObj;
  Result:= FObj.S['watch_region'];
end;

function TTMDBAPIDiscoverTVReq.GetWithCompanies: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_companies'];
end;

function TTMDBAPIDiscoverTVReq.GetWithGenres: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_genres'];
end;

function TTMDBAPIDiscoverTVReq.GetWithKeywords: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_keywords'];
end;

function TTMDBAPIDiscoverTVReq.GetWithNetworks: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_networks'];
end;

function TTMDBAPIDiscoverTVReq.GetWithOriginalLanguage: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_original_language'];
end;

function TTMDBAPIDiscoverTVReq.GetWithOriginCountry: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_origin_country'];
end;

function TTMDBAPIDiscoverTVReq.GetWithoutCompoanies: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_companies'];
end;

function TTMDBAPIDiscoverTVReq.GetWithoutGenres: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_genres'];
end;

function TTMDBAPIDiscoverTVReq.GetWithoutKeywords: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_keywords'];
end;

function TTMDBAPIDiscoverTVReq.GetWithoutWatchProviders: WideString;
begin
  EnsureObj;
  Result:= FObj.S['without_watch_providers'];
end;

function TTMDBAPIDiscoverTVReq.GetWithRuntimeGTE: Integer;
begin
  EnsureObj;
  Result:= FObj.I['with_runtime.gte'];
end;

function TTMDBAPIDiscoverTVReq.GetWithRuntimeLTE: Integer;
begin
  EnsureObj;
  Result:= FObj.I['with_runtime.lte'];
end;

function TTMDBAPIDiscoverTVReq.GetWithStatus: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_status'];
end;

function TTMDBAPIDiscoverTVReq.GetWithType: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_type'];
end;

function TTMDBAPIDiscoverTVReq.GetWithWatchMonetizationTypes: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_watch_monetization_types'];
end;

function TTMDBAPIDiscoverTVReq.GetWithWatchProviders: WideString;
begin
  EnsureObj;
  Result:= FObj.S['with_watch_providers'];
end;

procedure TTMDBAPIDiscoverTVReq.SetAirDateGTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['air_date.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetAirDateLTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['air_date.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetFirstAirDateGTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['first_air_date.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetFirstAirDateLTE(const AValue: TDateTime);
begin
  EnsureObj;
  FObj.D['first_air_date.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetFirstAirDateYear(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['first_air_date_year']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetIncludeAdult(const AValue: TTMDBBoolean);
begin
  EnsureObj;
  FObj.I['include_adult']:= Integer(AValue);
end;

procedure TTMDBAPIDiscoverTVReq.SetIncludeNullFirstAirDates(
  const AValue: TTMDBBoolean);
begin
  EnsureObj;
  FObj.I['include_null_first_air_dates']:= Integer(AValue);
end;

procedure TTMDBAPIDiscoverTVReq.SetLanguage(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['language']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetScreenedTheatrically(const AValue: TTMDBBoolean);
begin
  EnsureObj;
  FObj.I['screened_theatrically']:= Integer(AValue);
end;

procedure TTMDBAPIDiscoverTVReq.SetSortBy(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['sort_by']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetTimezone(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['timezone']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetVoteAverageGTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_average.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetVoteAverageLTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_average.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetVoteCountGTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_count.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetVoteCountLTE(const AValue: Single);
begin
  EnsureObj;
  FObj.F['vote_count.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWatchRegion(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['watch_region']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithCompanies(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_companies']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithGenres(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_genres']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithKeywords(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_keywords']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithNetworks(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_networks']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithOriginalLanguage(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_original_language']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithOriginCountry(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_origin_country']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithoutCompoanies(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_companies']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithoutGenres(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_genres']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithoutKeywords(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_keywords']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithoutWatchProviders(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['without_watch_providers']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithRuntimeGTE(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['with_runtime.gte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithRuntimeLTE(const AValue: Integer);
begin
  EnsureObj;
  FObj.I['with_runtime.lte']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithStatus(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_status']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithType(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_type']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithWatchMonetizationTypes(
  const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_watch_monetization_types']:= AValue;
end;

procedure TTMDBAPIDiscoverTVReq.SetWithWatchProviders(const AValue: WideString);
begin
  EnsureObj;
  FObj.S['with_watch_providers']:= AValue;
end;

end.
