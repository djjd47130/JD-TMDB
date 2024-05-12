unit JD.TMDB.Intf;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  TMDB Object Interface Definitions

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils;

type

  { Common }

  /// <summary>
  /// Array of String, as used across TMDB library.
  /// </summary>
  TTMDBStrArray = TArray<WideString>;

  /// <summary>
  /// Array of Integer, as used across TMDB library.
  /// </summary>
  TTMDBIntArray = TArray<Integer>;

  /// <summary>
  /// Application / API Authentication Method
  /// </summary>
  TTMDBAuthMethod = (amAPIKey, amAccessToken);

  /// <summary>
  /// TMDB user Account Authentication
  /// </summary>
  TTMDBUserAuth = (uaUnauthorized, uaGuest, uaNormal, uaCredentials);

  /// <summary>
  /// Type of media found in TMDB
  /// </summary>
  TTMDBMediaType = (mtMovie, mtTV, mtPerson);

  /// <summary>
  ///
  /// </summary>
  TTMDBReleaseType = (rtUnknown = 0, rtPremiere = 1, rtTheatricalLimited = 2,
    rtTheatrical = 3, rtDigital = 4, rtPhysical = 5, rtTV = 6);

  { Pagination Related }

  ITMDBPageItem = interface;

  /// <summary>
  /// A single page of results, following TMDB's pagination standards.
  /// </summary>
  ITMDBPage = interface
    ['{F95555BF-1E0C-4E95-AE81-93A09EFA4EA3}']
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
  end;

  /// <summary>
  /// A single item found on a page of results, following TMDB's pagination standards.
  /// </summary>
  ITMDBPageItem = interface
    ['{9909E734-78DB-4CBB-B84D-A8E16315DA4E}']
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;

  { Account Related }

  /// <summary>
  /// The details of a given user account.
  /// </summary>
  ITMDBAccountDetail = interface
    ['{DE0E4519-BED8-4218-BE84-A4C0AC5C6DBD}']
    function GetID: Integer; stdcall;
    function GetUserName: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;

    property ID: Integer read GetID;
    property UserName: WideString read GetUserName;
    property Name: WideString read GetName;
    property IncludeAdult: Boolean read GetIncludeAdult;
    property CountryCode: WideString read GetCountryCode;
    property LanguageCode: WideString read GetLanguageCode;
    property GravatarHash: WideString read GetGravatarHash;
    property TMDBAvatarPath: WideString read GetTMDBAvatarPath;
  end;

  { Authentication Related }

  /// <summary>
  /// The result of creating a new guest session.
  /// </summary>
  ITMDBAuthGuestSessionResult = interface
    ['{4C790F86-60C7-4C4E-ACF0-D6C2FB5E3534}']
    function GetSuccess: Boolean;
    function GetGuestSessionID: WideString;
    function GetExpiresAt: TDateTime;
  end;

  /// <summary>
  /// The result of creating a new request token.
  /// </summary>
  ITMDBAuthRequestTokenResult = interface
    ['{84A78372-DE91-4D30-89AD-8DCA3B3A2871}']
    function GetSuccess: Boolean;
    function GetRequestToken: WideString;
    function GetExpiresAt: TDateTime;
  end;

  /// <summary>
  /// The result of creating a new user session.
  /// </summary>
  ITMDBAuthSessionResult = interface
    ['{5671A7BD-6B4E-49AB-8AA9-237C7FC42E02}']
    function GetSuccess: Boolean;
    function SessionID: WideString;
    function GetStatusCode: Integer;
    function GetStatusMessage: WideString;
  end;

  /// <summary>
  /// The result of creating a new user session using user credentials.
  /// </summary>
  ITMDBAuthSessionResultLogin = interface
    ['{7744853D-5EC2-4B0B-9207-9008BAC2D12E}']
    function GetSuccess: Boolean;
    function GetExpiresAt: TDateTime;
    function GetRequestToken: WideString;
    function GetStatusCode: Integer;
    function GetStatusMessage: WideString;
  end;

  /// <summary>
  /// The result of deleting a user session (or "logging out").
  /// </summary>
  ITMDBAuthDeleteSessionResult = interface
    ['{7857764E-1768-4755-B794-D71411E38A7A}']
    function GetSuccess: Boolean;
    function GetStatusCode: Integer;
    function GetStatusMessage: WideString;
  end;

  /// <summary>
  /// The result of validating the API Key / Application authentication
  /// </summary>
  ITMDBAuthValidateKeyResult = interface
    ['{5EF18F33-1051-4A4A-A779-2D63FEA70F30}']
    function GetSuccess: Boolean;
    function GetStatusCode: Integer;
    function GetStatusMessage: WideString;
  end;

  { Certifications Related }

  ITMDBCertificationItem = interface;
  ITMDBCertificationCountry = interface;

  ITMDBCertificationItem = interface
    ['{02B6525F-7A01-4FDC-B39F-2F276D999827}']
    function GetCertification: WideString;
    function GetMeaning: WideString;
    function GetOrder: Integer;

    property Certification: WideString read GetCertification;
    property Meaning: WideString read GetMeaning;
    property Order: Integer read GetOrder;
  end;

  ITMDBCertificationCountry = interface
    ['{4BE1C674-3BFE-464D-8595-67567687A7E3}']
    function GetCountryCode: WideString;
    function GetCountryName: WideString;
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBCertificationItem;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationItem read GetItem; default;
  end;

  ITMDBCertificationCountries = interface
    ['{F907A3E0-B9A4-45B8-A7BC-B10FEC984CEF}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBCertificationCountry;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationCountry read GetItem; default;
  end;

  { Configuration Related }

  /// <summary>
  /// The "Images" section of system configuration.
  /// </summary>
  ITMDBConfigurationImages = interface
    ['{E258E153-9527-4993-B9B9-4E8A1513D84D}']
    function GetBaseURL: WideString;
    function GetSecureBaseURL: WideString;
    function GetBackdropSizes: TTMDBStrArray;
    function GetLogoSizes: TTMDBStrArray;
    function GetPosterSizes: TTMDBStrArray;
    function GetProfileSizes: TTMDBStrArray;
    function GetStillSizes: TTMDBStrArray;

    property BaseURL: WideString read GetBaseURL;
    property SecureBaseURL: WideString read GetSecureBaseURL;
    property BackdropSizes: TTMDBStrArray read GetBackdropSizes;
    property LogoSizes: TTMDBStrArray read GetLogoSizes;
    property PosterSizes: TTMDBStrArray read GetPosterSizes;
    property ProfileSizes: TTMDBStrArray read GetProfileSizes;
    property StillSizes: TTMDBStrArray read GetStillSizes;
  end;

  /// <summary>
  /// The result of base system configuration.
  /// </summary>
  ITMDBConfiguration = interface
    ['{F8527F61-7BE9-47D7-997D-C8FDCF54CEE0}']
    function GetImages: ITMDBConfigurationImages;
    function GetChangeKeys: TTMDBStrArray;

    property Images: ITMDBConfigurationImages read GetImages;
    property ChangeKeys: TTMDBStrArray read GetChangeKeys;
  end;

  { Countries Related }

  ITMDBCountryItem = interface;

  /// <summary>
  /// A list containing all possible countries supported by TMDB.
  /// </summary>
  ITMDBCountryList = interface
    ['{A1081041-E5B2-46C4-9905-EF7984C45FCA}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBCountryItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCountryItem read GetItem; default;
  end;

  /// <summary>
  /// A single country record within ITMDBCountryList.
  /// </summary>
  ITMDBCountryItem = interface
    ['{8E894D16-379C-431B-9F27-6FBB80F761B0}']
    function GetISO3166_1: WideString;
    function GetEnglishName: WideString;
    function GetNativeName: WideString;

    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;

  { Jobs / Departments Related }

  ITMDBJobDepartmentItem = interface;

  /// <summary>
  ///
  /// </summary>
  ITMDBJobDepartmentList = interface
    ['{2B9A1DF6-2CA9-48E2-886C-179F7F92383C}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBJobDepartmentItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBJobDepartmentItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBJobDepartmentItem = interface
    ['{847352D6-4054-4E62-897C-258305FBEDE2}']
    function GetDepartment: WideString;
    function GetJobs: TTMDBStrArray;

    property Department: WideString read GetDepartment;
    property Jobs: TTMDBStrArray read GetJobs;
  end;

  { Languages Related }

  ITMDBLanguageItem = interface;

  /// <summary>
  ///
  /// </summary>
  ITMDBLanguageList = interface
    ['{B08908B7-3C02-4BF9-8B94-AECF0EEC8D49}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBLanguageItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBLanguageItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBLanguageItem = interface
    ['{CBEECBBE-5CBE-4592-9C65-B82F1D07CCF7}']
    function GetISO639_1: WideString;
    function GetEnglishName: WideString;
    function GetName: WideString;

    property ISO639_1: WideString read GetISO639_1;
    property EnglishName: WideString read GetEnglishName;
    property Name: WideString read GetName;
  end;

  { Timezones Related }

  ITMDBTimezoneItem = interface;

  /// <summary>
  ///
  /// </summary>
  ITMDBTimezoneList = interface
    ['{E120B06B-06AC-4591-9469-1173DA85C199}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBTimezoneItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTimezoneItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBTimezoneItem = interface
    ['{58364B5B-DC6E-4A66-B3A5-7D812382C720}']
    function GetISO3166_1: WideString;
    function GetZones: TTMDBStrArray;

    property ISO3166_1: WideString read GetISO3166_1;
    property Zones: TTMDBStrArray read GetZones;
  end;

  { Genres Related }

  ITMDBGenreItem = interface;

  /// <summary>
  ///
  /// </summary>
  ITMDBGenreList = interface
    ['{8C26B769-0488-47B8-BFBA-DA1D8DAA05E4}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBGenreItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBGenreItem = interface
    ['{6C6A1423-D7D9-473D-86C7-07A7FAB64AE7}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  { Movies Related }

  ITMDBMovieItem = interface;

  /// <summary>
  ///
  /// </summary>
  ITMDBMoviePage = interface(ITMDBPage)
    ['{D35DC3E6-D4BB-416D-9A43-348C0FCAABB1}']
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;

  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBMovieItem = interface(ITMDBPageItem)
    ['{00EB49F1-F0EA-4E7A-859E-38632667BA87}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetID: Integer; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBMovieCollectionRef = interface
    ['{7BA3E60C-FE29-4C8E-ADC4-4F8F8900E7C8}']
    function GetBelongsToCollection: Boolean;
    function GetID: Integer;
    function GetName: WideString;
    function GetPosterPath: WideString;
    function GetBackdropPath: WideString;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBMovieDetail = interface
    ['{9F2CC08D-6D65-4C6E-AEB0-8CEF4748B501}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCollection: ITMDBMovieCollectionRef; stdcall;
    function GetBudget: Currency; stdcall;
    function GetGenreIDs: TTMDBIntArray; stdcall;
    function GetGenreNames: TTMDBStrArray; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetOriginalCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    //TODO: GetProductionCompanies
    function GetReleaseDate: TDateTime; stdcall;
    function GetRevenue: Currency; stdcall;
    function GetRuntime: Integer; stdcall;
    //TODO: GetSpokenLanguages
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
  end;



type

  { Forward Definitions }

  ITMDB = interface;

  { API Services }

  /// <summary>
  /// Base interface for each possible TMDB service category.
  /// </summary>
  ITMDBService = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']

  end;

  ITMDBServiceAccount = interface(ITMDBService)
    ['{E690DF1A-6680-4040-BBC6-ABE0D4CC6916}']
    function GetDetails(AAccountID: Integer;
      ASessionID: WideString = ''): ITMDBAccountDetail; stdcall;
    function SetFavorite(const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Favorite: Boolean): Integer; stdcall;
    function SetWatchlist(const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Watchlist: Boolean): Integer; stdcall;
    function GetFavoriteMovies(const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    //GetFavoriteTV
    //GetLists
    //GetRatedMovies
    //GetRatedTV
    //GetRatedTVEpisodes
    //GetWatchlistMovies
    //GetWatchlistTV
  end;

  ITMDBServiceAuthentication = interface(ITMDBService)
    ['{2144056B-54A4-49C4-AE3E-E0701B10E218}']
    function CreateGuestSession: ITMDBAuthGuestSessionResult;
    function CreateRequestToken: ITMDBAuthRequestTokenResult;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin;
    //DeleteSession
    //ValidateKey
  end;

  ITMDBServiceCertifications = interface(ITMDBService)
    ['{C6FCB00E-CDCA-46EA-B44B-A3CA2570774B}']
    function GetMovieCertifications: ITMDBCertificationCountries;
    function GetTVCertifications: ITMDBCertificationCountries;
  end;

  ITMDBServiceChanges = interface(ITMDBService)
    ['{944AE998-E4B0-49DA-924E-2272AEF9F8A0}']

  end;

  ITMDBServiceCollections = interface(ITMDBService)
    ['{C0040473-5A07-493B-9771-2EAF58CD5DB0}']

  end;

  ITMDBServiceCompanies = interface(ITMDBService)
    ['{13F92C49-85D1-4C7F-BBA6-8B815B23EDDE}']

  end;

  ITMDBServiceConfiguration = interface(ITMDBService)
    ['{A459EFE0-D167-4247-8EAD-319021284D10}']
    function GetDetails: ITMDBConfiguration;
    function GetCountries: ITMDBCountryList;
    function GetJobs: ITMDBJobDepartmentList;
    function GetLanguages: ITMDBLanguageList;
    function GetPrimaryTranslations: TTMDBStrArray;
    function GetTimezones: ITMDBTimezoneList;
  end;

  ITMDBServiceCredits = interface(ITMDBService)
    ['{B5BDB2EC-A303-474B-B71F-C329100CC378}']

  end;

  ITMDBServiceDiscover = interface(ITMDBService)
    ['{F3D713B4-04D6-48D8-A4C9-6505CD361694}']

  end;

  ITMDBServiceFind = interface(ITMDBService)
    ['{82DB20C9-8E71-4151-9E76-B173CA5F1B97}']

  end;

  ITMDBServiceGenres = interface(ITMDBService)
    ['{E21E59C6-5416-4D9A-B6EB-33E004A5622D}']

  end;

  ITMDBServiceGuestSessions = interface(ITMDBService)
    ['{FDF85071-F2F4-49A6-BAAD-6ECD96BE3CBD}']

  end;

  ITMDBServiceKeywords = interface(ITMDBService)
    ['{8FE0FEB6-511B-4704-A71A-BA8B5C8E912C}']

  end;

  ITMDBServiceLists = interface(ITMDBService)
    ['{9516AD42-A8CC-47E8-9CDB-4E2C8C48E028}']

  end;

  ITMDBServiceMovieLists = interface(ITMDBService)
    ['{FAFB9948-B099-47AD-8C0F-74FE3A1B2E0E}']

  end;

  ITMDBServiceMovies = interface(ITMDBService)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']
    function GetDetails(const MovieID: Integer; const AppendToResponse: WideString = '';
      const Language: WideString = ''): ITMDBMovieDetail; stdcall;

  end;

  ITMDBServiceNetworks = interface(ITMDBService)
    ['{766C690C-DD9A-4E3B-A611-F93B1CFE1DF6}']

  end;

  ITMDBServicePeopleLists = interface(ITMDBService)
    ['{24DB64CB-1303-4CF5-86D9-F007E773C869}']

  end;

  ITMDBServicePeople = interface(ITMDBService)
    ['{7A209CC2-3BB0-4AC7-AD28-9466ACC666EA}']

  end;

  ITMDBServiceReviews = interface(ITMDBService)
    ['{FD2277E9-2A59-413D-B67B-B210D32F1133}']

  end;

  ITMDBServiceSearch = interface(ITMDBService)
    ['{D7E9618F-ED5C-4D9A-93FF-CF109294DA0F}']

    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;

  end;

  ITMDBServiceTrending = interface(ITMDBService)
    ['{54784907-ACC7-40D1-81D5-109FB413F18A}']

  end;

  ITMDBServiceTVSeriesLists = interface(ITMDBService)
    ['{7CFA63BE-1377-446E-AE16-D6EB8FF74074}']

  end;

  ITMDBServiceTVSeries = interface(ITMDBService)
    ['{A72F79E7-A3C2-4105-B0F0-3D53B59352B2}']

  end;

  ITMDBServiceTVSeasons = interface(ITMDBService)
    ['{89A1F3C8-F032-4B36-8481-DFE5291EBDA3}']

  end;

  ITMDBServiceTVEpisodes = interface(ITMDBService)
    ['{CD87A380-130A-46CD-9661-6CE1CE30CD82}']

  end;

  ITMDBServiceTVEpisodeGroups = interface(ITMDBService)
    ['{B55FFFC4-7C29-4BA1-89C5-0CF1A8D88943}']

  end;

  ITMDBServiceWatchProviders = interface(ITMDBService)
    ['{FDB079FA-C25C-4337-BDD7-C4E4A9186A36}']

  end;





  { Core Access }

  ITMDB = interface
    ['{FB7CAA70-63BE-4BAC-9BE8-4E0E0225A9C3}']
    function GetAPIKey: WideString; stdcall;
    procedure SetAPIKey(const Value: WideString); stdcall;
    function GetAccessToken: WideString; stdcall;
    procedure SetAccessToken(const Value: WideString); stdcall;
    function GetAuthMethod: TTMDBAuthMethod; stdcall;
    procedure SetAuthMethod(const Value: TTMDBAuthMethod); stdcall;
    function GetUserAuth: TTMDBUserAuth; stdcall;
    procedure SetUserAuth(const Value: TTMDBUserAuth); stdcall;

    { Services }

    function Account: ITMDBServiceAccount; stdcall;
    function Authentication: ITMDBServiceAuthentication; stdcall;
    //function Certifications: ITMDBServiceCertifications; stdcall;
    //function Changes: ITMDBServiceChanges; stdcall;
    //function Collections: ITMDBServiceCollections; stdcall;
    //function Companies: ITMDBServiceCompanies; stdcall;
    function Configuration: ITMDBServiceConfiguration; stdcall;
    //function Credits: ITMDBServiceCredits; stdcall;
    //function Discover: ITMDBServiceDiscover; stdcall;
    //function Find: ITMDBServiceFind; stdcall;
    //function Genres: ITMDBServiceGenres; stdcall;
    //function GuestSessions: ITMDBServiceGuestSessions; stdcall;
    //function Keywords: ITMDBServiceKeywords; stdcall;
    //function Lists: ITMDBServiceLists; stdcall;
    //function MovieLists: ITMDBServiceMovieLists; stdcall;
    //function Movies: ITMDBServiceMovies; stdcall;
    //function Networks: ITMDBServiceNetworks; stdcall;
    //function PeopleLists: ITMDBServicePeopleLists; stdcall;
    //function People: ITMDBServicePeople; stdcall;
    //function Reviews: ITMDBServiceReviews; stdcall;
    //function Search: ITMDBServiceSearch; stdcall;
    //function Trending: ITMDBServiceTrending; stdcall;
    //function TVSeriesLists: ITMDBServiceTVSeriesLists; stdcall;
    //function TVSeries: ITMDBServiceTVSeries; stdcall;
    //function TVSeasons: ITMDBServiceTVSeasons; stdcall;
    //function TVEpisodes: ITMDBServiceTVEpisodes; stdcall;
    //function TVEpisodeGroups: ITMDBServiceTVEpisodeGroups; stdcall;
    //function WatchProviders: ITMDBServiceWatchProviders; stdcall;

    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;

  end;

implementation

end.
