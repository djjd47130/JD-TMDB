unit JD.TMDB.Intf;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  ----------------------------------------------------------------------------
  TMDB Object Interface Definitions
  ----------------------------------------------------------------------------

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils,
  Winapi.Windows,
  XSuperObject,
  JD.TMDB.Common,
  JD.TMDB.API;



type

{$REGION 'Forward Definitions'}
  ITMDBItem = interface;
  ITMDBItems = interface;
  ITMDBPage = interface;
  ITMDBDetail = interface;
  ITMDBMedium = interface;
  ITMDBMedia = interface;
  ITMDBMediaPage = interface;
  ITMDBAccountDetail = interface;
  ITMDBAccountAddFavoriteResult = interface;
  ITMDBAccountAddWatchlistResult = interface;
  ITMDBAccountStates = interface;
  ITMDBAuthGuestSessionResult = interface;
  ITMDBAuthRequestTokenResult = interface;
  ITMDBAuthSessionResult = interface;
  ITMDBAuthSessionResultLogin = interface;
  ITMDBAuthDeleteSessionResult = interface;
  ITMDBAuthValidateKeyResult = interface;
  ITMDBAlternativeTitle = interface;
  ITMDBAlternativeTitles = interface;
  ITMDBCertification = interface;
  ITMDBCertificationCountry = interface;
  ITMDBCertificationCountries = interface;
  ITMDBChangeValue = interface;
  ITMDBChangeRecord = interface;
  ITMDBChange = interface;
  ITMDBChanges = interface;
  ITMDBChangeRef = interface;
  ITMDBChangeRefs = interface;
  ITMDBChangeRefPage = interface;
  ITMDBCompany = interface;
  ITMDBCompanies = interface;
  ITMDBCompanyPage = interface;
  ITMDBCompanyDetail = interface;
  ITMDBConfigurationImages = interface;
  ITMDBConfiguration = interface;
  ITMDBContentRating = interface;
  ITMDBContentRatings = interface;
  ITMDBCountry = interface;
  ITMDBCountries = interface;
  ITMDBExternalIDs = interface;
  ITMDBGenre = interface;
  ITMDBGenres = interface;
  ITMDBMediaImage = interface;
  ITMDBMediaImages = interface;
  ITMDBMediaImageGroup = interface;
  ITMDBJobDepartment = interface;
  ITMDBJobDepartments = interface;
  ITMDBKeyword = interface;
  ITMDBKeywords = interface;
  ITMDBKeywordPage = interface;
  ITMDBKeywordDetail = interface;
  ITMDBLanguage = interface;
  ITMDBLanguages = interface;
  ITMDBTVNetwork = interface;
  ITMDBTVNetworks = interface;
  ITMDBTVNetworkDetail = interface;
  ITMDBTimezone = interface;
  ITMDBTimezones = interface;
  ITMDBReleaseDate = interface;
  ITMDBReleaseDateCountry = interface;
  ITMDBReleaseDateCountries = interface;
  ITMDBTranslationData = interface;
  ITMDBMovieTranslationData = interface;
  ITMDBCollectionTranslationData = interface;
  ITMDBPersonTranslationData = interface;
  ITMDBTVSeriesTranslationData = interface;
  ITMDBTVSeasonTranslationData = interface;
  ITMDBTVEpisodeTranslationData = interface;
  ITMDBTranslation = interface;
  ITMDBTranslations = interface;
  ITMDBVideo = interface;
  ITMDBVideos = interface;
  ITMDBCollection = interface;
  ITMDBCollections = interface;
  ITMDBCollectionPage = interface;
  ITMDBCollectionDetail = interface;
  ITMDBDiscoverMoviesParams = interface;
  ITMDBDiscoverTVParams = interface;
  ITMDBFindResults = interface;
  ITMDBPerson = interface;
  ITMDBPeople = interface;
  ITMDBPersonPage = interface;
  ITMDBPersonDetail = interface;
  ITMDBCastPerson = interface;
  ITMDBCastPeople = interface;
  ITMDBCrewPerson = interface;
  ITMDBCrewPeople = interface;
  ITMDBCredits = interface;
  ITMDBCombinedCredits = interface;
  ITMDBCreditDetail = interface;
  ITMDBList = interface;
  ITMDBLists = interface;
  ITMDBListPage = interface;
  ITMDBListDetail = interface;
  ITMDBReviewAuthor = interface;
  ITMDBReview = interface;
  ITMDBReviews = interface;
  ITMDBReviewPage = interface;
  ITMDBReviewDetail = interface;
  ITMDBMovie = interface;
  ITMDBMovies = interface;
  ITMDBMoviePage = interface;
  ITMDBRatedMovie = interface;
  ITMDBRatedMovies = interface;
  ITMDBRatedMoviePage = interface;
  ITMDBMovieCollectionRef = interface;
  ITMDBMovieDetail = interface;
  ITMDBDateRange = interface;
  ITMDBDatedMoviePage = interface;
  ITMDBTVSerie = interface;
  ITMDBTVSeries = interface;
  ITMDBTVSeriesPage = interface;
  ITMDBRatedTVSerie = interface;
  ITMDBRatedTVSeries = interface;
  ITMDBRatedTVSeriesPage = interface;
  ITMDBTVSerieDetail = interface;
  ITMDBTVSeason = interface;
  ITMDBTVSeasons = interface;
  ITMDBTVSeasonPage = interface;
  ITMDBTVSeasonDetail = interface;
  //ITMDBTVSeasonEpisode = interface;
  //ITMDBTVSeasonEpisodes = interface;
  ITMDBTVEpisode = interface;
  ITMDBTVEpisodes = interface;
  ITMDBTVEpisodePage = interface;
  ITMDBRatedTVEpisode = interface;
  ITMDBRatedTVEpisodes = interface;
  ITMDBTVEpisodeDetail = interface;
  ITMDBTVEpisodeGroup = interface;
  ITMDBTVEpisodeGroups = interface;
  ITMDBWatchProviderPriority = interface;
  ITMDBWatchProviderPriorities = interface;
  ITMDBWatchProvider = interface;
  ITMDBWatchProviders = interface;
  ITMDBNamespace = interface;
  ITMDBNamespaceAccount = interface;
  ITMDBNamespaceAuthentication = interface;
  ITMDBNamespaceCertifications = interface;
  ITMDBNamespaceChanges = interface;
  ITMDBNamespaceCollections = interface;
  ITMDBNamespaceCompanies = interface;
  ITMDBNamespaceConfiguration = interface;
  ITMDBNamespaceCredits = interface;
  ITMDBNamespaceDiscover = interface;
  ITMDBNamespaceFind = interface;
  ITMDBNamespaceGenres = interface;
  ITMDBNamespaceGuestSessions = interface;
  ITMDBNamespaceKeywords = interface;
  ITMDBNamespaceLists = interface;
  ITMDBNamespaceMovieLists = interface;
  ITMDBNamespaceMovies = interface;
  ITMDBNamespaceNetworks = interface;
  ITMDBNamespacePeopleLists = interface;
  ITMDBNamespacePeople = interface;
  ITMDBNamespaceReviews = interface;
  ITMDBNamespaceSearch = interface;
  ITMDBNamespaceTrending = interface;
  ITMDBNamespaceTVSeriesLists = interface;
  ITMDBNamespaceTVSeries = interface;
  ITMDBNamespaceTVSeasons = interface;
  ITMDBNamespaceTVEpisodes = interface;
  ITMDBNamespaceTVEpisodeGroups = interface;
  ITMDBNamespaceWatchProviders = interface;
  ITMDBCache = interface;
  ITMDBLoginState = interface;
  ITMDBClient = interface;

{$ENDREGION}



{$REGION 'Common'}

  /// <summary>
  /// A single abstract item found in any given possible item list across TMDB.
  /// </summary>
  ITMDBItem = interface
    ['{9909E734-78DB-4CBB-B84D-A8E16315DA4E}']
    function GetOwner: ITMDBItems; stdcall;
    function GetIndex: Integer; stdcall;

    property Owner: ITMDBItems read GetOwner;
    property Index: Integer read GetIndex;
  end;

  /// <summary>
  /// Base for each possible list of items
  /// </summary>
  ITMDBItems = interface
    ['{3159DDC3-F510-4353-B24A-ACFD459948C9}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBItem read GetItem; default;
  end;

  /// <summary>
  /// A single abstract page of results, following TMDB's pagination standards.
  /// Supports a variety of page-related functions, such as page count,
  /// total result count, etc.
  /// </summary>
  ITMDBPage = interface
    ['{F95555BF-1E0C-4E95-AE81-93A09EFA4EA3}']
    function GetPage: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItems: ITMDBItems;

    property Page: Integer read GetPage;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items: ITMDBItems read GetItems;
  end;

  /// <summary>
  /// Base type for any details of a given entity within TMDB.
  /// For example, ITMDBMovieDetail, ITMDBPersonDetail, ITMDBNetworkDetail, etc.
  /// </summary>
  ITMDBDetail = interface
    ['{45ECEE84-E982-4699-AF1C-BD2A2AE7BF62}']
    function GetID: Integer; stdcall; //NOTE: Some use string for "id"
    function GetTitle: WideString; stdcall; //NOTE: Shared between "name" and "title"

    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
  end;

{$ENDREGION}



{$REGION 'Media Base Related'}

  /// <summary>
  /// Base type for any of the "media type" items which may be combined in a single list.
  /// This includes "media_type" values of "movie", "tv", and "person".
  /// </summary>
  ITMDBMedium = interface(ITMDBItem)
    ['{48B983F9-A07F-404D-9A5C-4FB7206D1407}']
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetAdult: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetPopularity: Single; stdcall;

    function AsMovie: ITMDBMovie; stdcall;
    function AsPerson: ITMDBPerson; stdcall;
    function AsTVSeries: ITMDBTVSerie; stdcall;
    function AsTVEpisode: ITMDBTVEpisode; stdcall;

    property MediaType: TTMDBMediaType read GetMediaType;
    property Adult: Boolean read GetAdult;
    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
    property Popularity: Single read GetPopularity;
  end;

  /// <summary>
  /// A list of ITMDBMedium objects. Can contain a mix of any media type,
  /// or all one specific media type.
  /// </summary>
  ITMDBMedia = interface(ITMDBItems)
    ['{3B5A5855-C20A-4F15-8AD0-A83D587C7623}']
    function GetItem(const Index: Integer): ITMDBMedium; stdcall;

    property Items[const Index: Integer]: ITMDBMedium read GetItem; default;
  end;

  /// <summary>
  /// A page of ITMDBMedium objects. Much like ITMDBMedia, but paginated.
  /// </summary>
  ITMDBMediaPage = interface(ITMDBPage)
    ['{31FFE854-7CAB-45A5-9ADC-6FB82F1AA8AF}']
    function GetItems: ITMDBMedia; stdcall;

    property Items: ITMDBMedia read GetItems;
  end;

{$ENDREGION}



{$REGION 'Account Related'}

  /// <summary>
  /// The details of a given user account.
  /// </summary>
  ITMDBAccountDetail = interface
    ['{DE0E4519-BED8-4218-BE84-A4C0AC5C6DBD}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetUserName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property UserName: WideString read GetUserName;
    property IncludeAdult: Boolean read GetIncludeAdult;
    property CountryCode: WideString read GetCountryCode;
    property LanguageCode: WideString read GetLanguageCode;
    property GravatarHash: WideString read GetGravatarHash;
    property TMDBAvatarPath: WideString read GetTMDBAvatarPath;
  end;

  /// <summary>
  /// The result of adding (or removing) a favorite.
  /// </summary>
  ITMDBAccountAddFavoriteResult = interface
    ['{03377611-F4BC-4FF1-A446-0AEE7A8878BA}']
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of adding (or removing) a watchlist.
  /// </summary>
  ITMDBAccountAddWatchlistResult = interface
    ['{03DDF702-8AE6-48A6-AB10-75468CC9CE51}']
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// A summary of an item as found on account's favorites, watchlist, and ratings.
  /// </summary>
  ITMDBAccountStates = interface
    ['{A83C88DC-B507-4825-8338-8DD67B545059}']
    function GetFavorite: Boolean; stdcall;
    function GetRatedValue: Single; stdcall;
    function GetWatchlist: Boolean; stdcall;

    property Favorite: Boolean read GetFAvorite;
    property RatedValue: Single read GetRatedValue;
    property Watchlist: Boolean read GetWatchlist;
  end;

{$ENDREGION}



{$REGION 'Authentication Related'}

  /// <summary>
  /// The result of creating a new guest session.
  /// </summary>
  ITMDBAuthGuestSessionResult = interface
    ['{4C790F86-60C7-4C4E-ACF0-D6C2FB5E3534}']
    function GetSuccess: Boolean; stdcall;
    function GetGuestSessionID: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;

    property Success: Boolean read GetSuccess;
    property GuestSessionID: WideString read GetGuestSessionID;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  /// <summary>
  /// The result of creating a new request token.
  /// </summary>
  ITMDBAuthRequestTokenResult = interface
    ['{84A78372-DE91-4D30-89AD-8DCA3B3A2871}']
    function GetSuccess: Boolean; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;

    property Success: Boolean read GetSuccess;
    property RequestToken: WideString read GetRequestToken;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  /// <summary>
  /// The result of creating a new user session.
  /// </summary>
  ITMDBAuthSessionResult = interface
    ['{5671A7BD-6B4E-49AB-8AA9-237C7FC42E02}']
    function GetSuccess: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property SessionID: WideString read GetSessionID;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of creating a new user session using user credentials.
  /// </summary>
  ITMDBAuthSessionResultLogin = interface
    ['{7744853D-5EC2-4B0B-9207-9008BAC2D12E}']
    function GetSuccess: Boolean; stdcall;
    function GetExpiresAt: TDateTime; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property ExpiresAt: TDateTime read GetExpiresAt;
    property RequestToken: WideString read GetRequestToken;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of deleting a user session (or "logging out").
  /// </summary>
  ITMDBAuthDeleteSessionResult = interface
    ['{7857764E-1768-4755-B794-D71411E38A7A}']
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of validating the API Key / Application authentication
  /// </summary>
  ITMDBAuthValidateKeyResult = interface
    ['{5EF18F33-1051-4A4A-A779-2D63FEA70F30}']
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

{$ENDREGION}



{$REGION 'Alternative Title Related'}

  /// <summary>
  /// A single alternative title (or name) as found in TMDB for an item.
  /// </summary>
  ITMDBAlternativeTitle = interface(ITMDBItem)
    ['{AEB8181D-8409-4834-8515-29EB7651FA7A}']
    function GetISO3166_1: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetType: WideString; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property Title: WideString read GetTitle;
    property &Type: WideString read GetType;
  end;

  /// <summary>
  /// A list of alternative titles (or names) as found in TMDB for an item.
  /// </summary>
  ITMDBAlternativeTitles = interface(ITMDBItems)
    ['{C8AD733E-B9C2-4C41-948E-D9B3F9DE81D4}']
    function GetItem(const Index: Integer): ITMDBAlternativeTitle; stdcall;

    property Items[const Index: Integer]: ITMDBAlternativeTitle read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Certification Related'}

  /// <summary>
  /// A single certification as found in TMDB.
  /// </summary>
  ITMDBCertification = interface
    ['{02B6525F-7A01-4FDC-B39F-2F276D999827}']
    function GetCertification: WideString; stdcall;
    function GetMeaning: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property Certification: WideString read GetCertification;
    property Meaning: WideString read GetMeaning;
    property Order: Integer read GetOrder;
  end;

  /// <summary>
  /// A single country and its certifications as found in TMDB.
  /// </summary>
  ITMDBCertificationCountry = interface
    ['{4BE1C674-3BFE-464D-8595-67567687A7E3}']
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertification; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertification read GetItem; default;
  end;

  /// <summary>
  /// A list of countries and their certifications as found in TMDB.
  /// </summary>
  ITMDBCertificationCountries = interface
    ['{F907A3E0-B9A4-45B8-A7BC-B10FEC984CEF}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertificationCountry; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationCountry read GetItem; default;
  end;

{$ENDREGION}



//TODO
{$REGION 'Change Related'}

  //TODO: This is quite a complex structure, because the data types dynamically differ
  //  depending on the type of change...
  //https://developer.themoviedb.org/docs/tracking-content-changes

  /// <summary>
  /// The actual value which has been changed in TMDB.
  /// </summary>
  ITMDBChangeValue = interface
    ['{D44D0AA2-5EB9-458F-A0CD-FFCE923C571A}']
    function GetS: WideString; stdcall;
    function GetI: Integer; stdcall;
    function GetB: Boolean; stdcall;
    function GetF: Double; stdcall;
    function GetD: TDateTime; stdcall;
    function GetO: ISuperObject; stdcall;
    function GetA: ISuperArray; stdcall;

    property S: WideString read GetS;
    property I: Integer read GetI;
    property B: Boolean read GetB;
    property F: Double read GetF;
    property D: TDateTime read GetD;
    property O: ISuperObject read GetO;
    property A: ISuperArray read GetA;
  end;

  /// <summary>
  /// A reference to an action made on an item in TMDB triggering a change.
  /// </summary>
  ITMDBChangeRecord = interface
    ['{27B8CA5E-D72C-4298-92D9-012A58450CAA}']
    function GetID: WideString; stdcall;
    function GetAction: WideString; stdcall; //TODO: Change to enum...
    function GetTime: TDateTime; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetISO3166_1: WideString; stdcall;
    function GetValue: ITMDBChangeValue; stdcall;
    function GetOriginalValue: ITMDBChangeValue; stdcall;

    property ID: WideString read GetID;
    property Action: WideString read GetAction; //TODO
    property Time: TDateTime read GetTime;
    property ISO639_1: WideString read GetISO639_1;
    property ISO3166_1: WideString read GetISO3166_1;
    property Value: ITMDBChangeValue read GetValue;
    property OriginalValue: ITMDBChangeValue read GetOriginalValue;
  end;

  /// <summary>
  /// A single change which has been made to an item in TMDB.
  /// </summary>
  ITMDBChange = interface(ITMDBItem)
    ['{04186AE5-0DFE-4E30-99A8-8B8CBC98E17F}']
    function GetKey: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;

    property Key: WideString read GetKey;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBChangeRecord read GetItem; default;
  end;

  /// <summary>
  /// A list of changes which have been made to an item in TMDB.
  /// </summary>
  ITMDBChanges = interface(ITMDBItems)
    ['{67851829-A928-4C8E-9DED-694E0CE8139B}']
    function GetItem(const Index: Integer): ITMDBChange; stdcall;

    property Items[const Index: Integer]: ITMDBChange read GetItem; default;
  end;



  /// <summary>
  /// A reference to a change that was made in TMDB.
  /// </summary>
  ITMDBChangeRef = interface(ITMDBItem)
    ['{A99B9531-F7D4-4130-BC26-33AB3E9B6A17}']
    function GetID: Integer; stdcall;
    function GetAdult: Boolean; stdcall;

    property ID: Integer read GetID;
    property Adult: Boolean read GetAdult;
  end;

  /// <summary>
  /// A list of references to changes that were made in TMDB.
  /// </summary>
  ITMDBChangeRefs = interface(ITMDBItems)
    ['{7D64BAA8-37A0-4B05-BEC7-922190611F92}']
    function GetItem(const Index: Integer): ITMDBChangeRef; stdcall;

    property Items[const Index: Integer]: ITMDBChangeRef read GetItem; default;
  end;

  /// <summary>
  /// A page of references to changes that were made in TMDB.
  /// </summary>
  ITMDBChangeRefPage = interface(ITMDBPage)
    ['{AB96A172-0202-4E26-8627-1059D48F3130}']
    function GetItems: ITMDBChangeRefs; stdcall;

    property Items: ITMDBChangeRefs read GetItems;
  end;

{$ENDREGION}



{$REGION 'Company Related'}

  /// <summary>
  /// A single company as found in TMDB.
  /// </summary>
  ITMDBCompany = interface(ITMDBItem)
    ['{491A255A-0E29-43B3-8AAC-5F727D74DD98}']
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  /// <summary>
  /// A list of companies as found in TMDB.
  /// </summary>
  ITMDBCompanies = interface(ITMDBItems)
    ['{BF6B6EC5-C0E1-4D7B-B987-8F2BE6AD4211}']
    function GetItem(const Index: Integer): ITMDBCompany; stdcall;

    property Items[const Index: Integer]: ITMDBCompany read GetItem; default;
  end;

  /// <summary>
  /// A list of companies following TMDB's pagination standards.
  /// </summary>
  ITMDBCompanyPage = interface(ITMDBPage)
    ['{F3D62122-D304-4CA3-BE0C-72B1219E0DD1}']
    function GetItems: ITMDBCompanies; stdcall;

    property Items: ITMDBCompanies read GetItems;
  end;

  /// <summary>
  /// The details of a specific company as found in TMDB.
  /// </summary>
  ITMDBCompanyDetail = interface
    ['{B5A7E62D-03AA-481A-BA02-DD4EAB7F6AC3}']
    function GetDescription: WideString; stdcall;
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
    function GetParentCompany: WideString; stdcall;

    property Description: WideString read GetDescription;
    property Headquarters: WideString read GetHeadquarters;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
    property ParentCompany: WideString read GetParentCompany;
  end;

{$ENDREGION}



{$REGION 'Configuration Related'}

  /// <summary>
  /// The "Images" section of system configuration.
  /// </summary>
  ITMDBConfigurationImages = interface
    ['{E258E153-9527-4993-B9B9-4E8A1513D84D}']
    function GetBaseURL: WideString; stdcall;
    function GetSecureBaseURL: WideString; stdcall;
    function GetBackdropSizes: TTMDBStrArray; stdcall;
    function GetLogoSizes: TTMDBStrArray; stdcall;
    function GetPosterSizes: TTMDBStrArray; stdcall;
    function GetProfileSizes: TTMDBStrArray; stdcall;
    function GetStillSizes: TTMDBStrArray; stdcall;

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
    function GetImages: ITMDBConfigurationImages; stdcall;
    function GetChangeKeys: TTMDBStrArray; stdcall;

    property Images: ITMDBConfigurationImages read GetImages;
    property ChangeKeys: TTMDBStrArray read GetChangeKeys;
  end;

{$ENDREGION}



{$REGION 'Content Rating Related'}

  /// <summary>
  /// A specific content rating associated with an item in TMDB.
  /// </summary>
  ITMDBContentRating = interface(ITMDBItem)
    ['{D6DDA578-E421-4CB9-8436-A24EADEC8D06}']
    function GetDescriptors: TTMDBStrArray; stdcall;
    function GetISO3166_1: WideString; stdcall;
    function GetRating: WideString; stdcall;

    property Descriptors: TTMDBStrArray read GetDescriptors;
    property ISO3166_1: WideString read GetISO3166_1;
    property Rating: WideString read GetRating;
  end;

  /// <summary>
  /// A list of content ratings associated with an item in TMDB.
  /// </summary>
  ITMDBContentRatings = interface(ITMDBItems)
    ['{DBCEC84C-C2A6-4243-90B8-114BEA06A6A3}']
    function GetItem(const Index: Integer): ITMDBContentRating; stdcall;

    property Items[const Index: Integer]: ITMDBContentRating read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Country Related'}

  /// <summary>
  /// A single country record.
  /// </summary>
  ITMDBCountry = interface(ITMDBItem)
    ['{8E894D16-379C-431B-9F27-6FBB80F761B0}']
    function GetISO3166_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetNativeName: WideString; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;

  /// <summary>
  /// A list containing all possible countries supported by TMDB.
  /// </summary>
  ITMDBCountries = interface(ITMDBItems)
    ['{A1081041-E5B2-46C4-9905-EF7984C45FCA}']
    function GetItem(const Index: Integer): ITMDBCountry; stdcall;

    function GetByCode(const Code: WideString): ITMDBCountry; stdcall;

    property Items[const Index: Integer]: ITMDBCountry read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'External ID Related'}

  ITMDBExternalIDs = interface
    ['{6EEFD491-0A1A-49DD-8CA3-6516B2CC9621}']
    function GetID: Integer;
    function GetIMDBID: WideString;
    function GetWikiDataID: WideString;
    function GetFacebookID: WideString;
    function GetInstagramID: WideString;
    function GetTwitterID: WideString;

    property ID: Integer read GetID;
    property IMDBID: WideString read GetIMDBID;
    property WikiDataID: WideString read GetWikiDataID;
    property FacebookID: WideString read GetFacebookID;
    property InstagramID: WideString read GetInstagramID;
    property TwitterID: WideString read GetTwitterID;
  end;

{$ENDREGION}



{$REGION 'Genre Related'}

  /// <summary>
  /// A specific genre within a genre list.
  /// </summary>
  ITMDBGenre = interface(ITMDBItem)
    ['{6C6A1423-D7D9-473D-86C7-07A7FAB64AE7}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  /// <summary>
  /// A list of genres.
  /// </summary>
  ITMDBGenres = interface(ITMDBItems)
    ['{8C26B769-0488-47B8-BFBA-DA1D8DAA05E4}']
    function GetItem(const Index: Integer): ITMDBGenre; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;

    property Items[const Index: Integer]: ITMDBGenre read GetItem; default;
    property MediaType: TTMDBMediaType read GetMediaType;
  end;

{$ENDREGION}



{$REGION 'Image Related'}

  /// <summary>
  /// A single reference to an image as found in TMDB.
  /// </summary>
  ITMDBMediaImage = interface(ITMDBItem)
    ['{5E421D4C-DD05-4F49-84C7-0FC5A3A9BCE6}']
    function GetAspectRatio: Single; stdcall;
    function GetHeight: Integer; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetFilePath: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetWidth: Integer; stdcall;

    function GetImage(var Base64: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;

    property AspectRatio: Single read GetAspectRatio;
    property Height: Integer read GetHeight;
    property ISO639_1: WideString read GetISO639_1;
    property FilePath: WideString read GetFilePath;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property Width: Integer read GetWidth;
  end;

  /// <summary>
  /// A list of image references as found in TMDB.
  /// </summary>
  ITMDBMediaImages = interface(ITMDBItems)
    ['{124D54B5-7433-4C5B-8907-C5D5700D970E}']
    function GetItem(const Index: Integer): ITMDBMediaImage; stdcall;

    property Items[const Index: Integer]: ITMDBMediaImage read GetItem; default;
  end;

  /// <summary>
  /// A group of various image lists associated with a given item in TMDB.
  /// </summary>
  ITMDBMediaImageGroup = interface
    ['{FD622861-6E8C-49DE-8151-3E072AF39299}']
    function GetBackdrops: ITMDBMediaImages; stdcall;
    function GetLogos: ITMDBMediaImages; stdcall;
    function GetPosters: ITMDBMediaImages; stdcall;
    function GetProfiles: ITMDBMediaImages; stdcall;
    function GetStills: ITMDBMediaImages; stdcall;
    function GetID: Integer; stdcall;

    property Backdrops: ITMDBMediaImages read GetBackdrops;
    property Logos: ITMDBMediaImages read GetLogos;
    property Posters: ITMDBMediaImages read GetPosters;
    property Profiles: ITMDBMediaImages read GetProfiles;
    property Stills: ITMDBMediaImages read GetStills;
    property ID: Integer read GetID;
  end;

{$ENDREGION}



{$REGION 'Job / Department Related'}

  /// <summary>
  /// A single department and all related jobs as found in TMDB.
  /// </summary>
  ITMDBJobDepartment = interface(ITMDBItem)
    ['{847352D6-4054-4E62-897C-258305FBEDE2}']
    function GetDepartment: WideString; stdcall;
    function GetJobs: TTMDBStrArray; stdcall;

    property Department: WideString read GetDepartment;
    property Jobs: TTMDBStrArray read GetJobs;
  end;

  /// <summary>
  /// A list of departments and their jobs as found in TMDB.
  /// </summary>
  ITMDBJobDepartments = interface(ITMDBItems)
    ['{2B9A1DF6-2CA9-48E2-886C-179F7F92383C}']
    function GetItem(const Index: Integer): ITMDBJobDepartment; stdcall;

    property Items[const Index: Integer]: ITMDBJobDepartment read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Keyword Related'}

  /// <summary>
  /// A single keyword as found in TMDB.
  /// </summary>
  ITMDBKeyword = interface(ITMDBItem)
    ['{98460089-3E55-4022-A8AC-863EDBB8567A}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  /// <summary>
  /// A list of keywords as found in TMDB.
  /// </summary>
  ITMDBKeywords = interface(ITMDBItems)
    ['{3E3016F7-4459-4C65-87E8-DCE6B023EBDF}']
    function GetItem(const Index: Integer): ITMDBKeyword; stdcall;

    property Items[const Index: Integer]: ITMDBKeyword read GetItem; default;
  end;

  /// <summary>
  /// A list of keywords following TMDB's patination standards.
  /// </summary>
  ITMDBKeywordPage = interface(ITMDBPage)
    ['{DC679E95-D35E-4361-AF65-D1F10C52B881}']
    function GetItems: ITMDBKeywords; stdcall;

    property Items: ITMDBKeywords read GetItems;
  end;

  /// <summary>
  /// The details of a specific keyword as found in TMDB.
  /// </summary>
  ITMDBKeywordDetail = interface
    ['{FEF48832-CA59-4AEF-83D9-8167C136DC4B}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

{$ENDREGION}



{$REGION 'Language Related'}

  /// <summary>
  /// A single language as found in TMDB.
  /// </summary>
  ITMDBLanguage = interface(ITMDBItem)
    ['{CBEECBBE-5CBE-4592-9C65-B82F1D07CCF7}']
    function GetISO639_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetName: WideString; stdcall;

    property ISO639_1: WideString read GetISO639_1;
    property EnglishName: WideString read GetEnglishName;
    property Name: WideString read GetName;
  end;

  /// <summary>
  /// A list of languages as found in TMDB.
  /// </summary>
  ITMDBLanguages = interface(ITMDBItems)
    ['{B08908B7-3C02-4BF9-8B94-AECF0EEC8D49}']
    function GetItem(const Index: Integer): ITMDBLanguage; stdcall;

    function GetByCode(const Code: WideString): ITMDBLanguage; stdcall;

    property Items[const Index: Integer]: ITMDBLanguage read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Network Related'}

  /// <summary>
  /// A single TV network as found in TMDB.
  /// </summary>
  ITMDBTVNetwork = interface(ITMDBItem)
    ['{BCC9E4A7-07DD-416E-9F04-54CDC2A50DA3}']
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  /// <summary>
  /// A list of TV networks as found in TMDB.
  /// </summary>
  ITMDBTVNetworks = interface(ITMDBItems)
    ['{2569A653-F292-4E48-8FE1-DBBCCE289102}']
    function GetItem(const Index: Integer): ITMDBTVNetwork; stdcall;

    property Items[const Index: Integer]: ITMDBTVNetwork read GetItem; default;
  end;

  /// <summary>
  /// The details of a specific network as found in TMDB.
  /// </summary>
  ITMDBTVNetworkDetail = interface
    ['{B3293FC5-F238-4B3D-B3F2-CF4C894BD0EE}']
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property Headquarters: WideString read GetHeadquarters;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

{$ENDREGION}



{$REGION 'Timezone Related'}

  /// <summary>
  /// A single timezone as found in TMDB.
  /// </summary>
  ITMDBTimezone = interface(ITMDBItem)
    ['{58364B5B-DC6E-4A66-B3A5-7D812382C720}']
    function GetISO3166_1: WideString; stdcall;
    function GetZones: TTMDBStrArray; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property Zones: TTMDBStrArray read GetZones;
  end;

  /// <summary>
  /// A list of timezones as found in TMDB.
  /// </summary>
  ITMDBTimezones = interface(ITMDBItems)
    ['{E120B06B-06AC-4591-9469-1173DA85C199}']
    function GetItem(const Index: Integer): ITMDBTimezone; stdcall;

    property Items[const Index: Integer]: ITMDBTimezone read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Release Date Related'}

  /// <summary>
  /// A single release date associated with a given item in TMDB.
  /// </summary>
  ITMDBReleaseDate = interface
    ['{78E9A30C-DCDE-4DF5-A8A7-9BF08C210F90}']
    function GetCertification: WideString; stdcall;
    function GetDescriptors: TTMDBStrArray; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetNote: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetType: TTMDBReleaseType; stdcall;

    property Certification: WideString read GetCertification;
    property Descriptors: TTMDBStrArray read GetDescriptors;
    property ISO639_1: WideString read GetISO639_1;
    property Note: WideString read GetNote;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property ReleaseType: TTMDBReleaseType read GetType;
  end;

  /// <summary>
  /// A single country containing release dates as found in TMDB.
  /// </summary>
  ITMDBReleaseDateCountry = interface
    ['{E466037A-7C13-4D5C-BE6E-42A49E6C2F8C}']
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDate; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDate read GetItem; default;
  end;

  /// <summary>
  /// A list of countries containing release dates as found in TMDB.
  /// </summary>
  ITMDBReleaseDateCountries = interface
    ['{F93CE7EB-EE02-4107-A412-F6161832333F}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDateCountry; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDateCountry read GetItem; default;
  end;

{$ENDREGION}



//TODO
{$REGION 'Translation Related'}

  /// <summary>
  /// The base of translation data for any given TMDB media type.
  /// </summary>
  ITMDBTranslationData = interface
    ['{7AD55E8C-BF41-45D1-AEF4-F17E797A4BBD}']

  end;

  /// <summary>
  /// Translation data for a movie.
  /// </summary>
  ITMDBMovieTranslationData = interface(ITMDBTranslationData)
    ['{09C095D9-4F9A-4E8C-8FA8-F71BA339DCEB}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetRuntime: Integer; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
    property Runtime: Integer read GetRuntime;
  end;

  /// <summary>
  /// Translation data for a collection.
  /// </summary>
  ITMDBCollectionTranslationData = interface(ITMDBTranslationData)
    ['{AE77BCCF-6AD8-425D-9FF6-EE387DC5FD34}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
  end;

  /// <summary>
  /// Translation data for a person.
  /// </summary>
  ITMDBPersonTranslationData = interface(ITMDBTranslationData)
    ['{BB5C94AD-1FC5-4B2E-9002-8927F803B3A9}']
    function GetBiography: WideString; stdcall;

    property Biography: WideString read GetBiography;
  end;

  /// <summary>
  /// Translation data for a TV Series.
  /// </summary>
  ITMDBTVSeriesTranslationData = interface(ITMDBTranslationData)
    ['{E5FC1F22-200A-4952-BE12-A891F08381CA}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
  end;

  /// <summary>
  /// Translation data for a TV Season.
  /// </summary>
  ITMDBTVSeasonTranslationData = interface(ITMDBTranslationData)
    ['{3EDACBDD-D5E1-4E88-B46F-3BB871E53A64}']
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;

    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  /// <summary>
  /// Translation data for a TV Episode.
  /// </summary>
  ITMDBTVEpisodeTranslationData = interface(ITMDBTranslationData)
    ['{8D3E5163-C0D7-4102-9DD1-450267F442B5}']
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;

    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  //TODO: Inherit from item base...
  /// <summary>
  /// A single translation for a given item in TMDB.
  /// </summary>
  ITMDBTranslation = interface
    ['{15A88780-ABF6-4EEA-AFFC-BC63A22A26BE}']
    function GetISO3166_1: WideString; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetMovieData: ITMDBMovieTranslationData; stdcall;
    function GetCollectionData: ITMDBCollectionTranslationData; stdcall;
    function GetPersonData: ITMDBPersonTranslationData; stdcall;
    function GetTVSeriesData: ITMDBTVSeriesTranslationData; stdcall;
    function GetTVSeasonData: ITMDBTVSeasonTranslationData; stdcall;
    function GetTVEpisodeData: ITMDBTVEpisodeTranslationData; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property ISO639_1: WideString read GetISO639_1;
    property Name: WideString read GetName;
    property EnglishName: WideString read GetEnglishName;
    property MovieData: ITMDBMovieTranslationData read GetMovieData;
    property CollectionData: ITMDBCollectionTranslationData read GetCollectionData;
    property PersonData: ITMDBPersonTranslationData read GetPersonData;
    property TVSeriesData: ITMDBTVSeriesTranslationData read GetTVSeriesData;
    property TVSeasonData: ITMDBTVSeasonTranslationData read GetTVSeasonData;
    property TVEpisodeData: ITMDBTVEpisodeTranslationData read GetTVEpisodeData;
  end;

  //TODO: Inherit from list base...
  /// <summary>
  /// A list of translations for a given item in TMDB.
  /// </summary>
  ITMDBTranslations = interface
    ['{7E5FB55A-B061-43A3-A6F9-DFB7AF75823D}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTranslation; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTranslation read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Video Related'}

  /// <summary>
  /// A single reference to a video associated with an item in TMDB.
  /// </summary>
  ITMDBVideo = interface(ITMDBItem)
    ['{EC411DD6-C212-4DA8-9421-688E099079B3}']
    function GetISO639_1: WideString; stdcall;
    function GetISO3166_1: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetKey: WideString; stdcall;
    function GetSite: WideString; stdcall;
    function GetSize: Integer; stdcall;
    function GetType: WideString; stdcall;
    function GetOfficial: Boolean; stdcall;
    function GetPublishedAt: TDateTime; stdcall;
    function GetID: WideString; stdcall;

    property ISO639_1: WideString read GetISO639_1;
    property ISO3166_1: WideString read GetISO3166_1;
    property Name: WideString read GetName;
    property Key: WideString read GetKey;
    property Site: WideString read GetSite;
    property Size: Integer read GetSize;
    property VideoType: WideString read GetType;
    property Official: Boolean read GetOfficial;
    property PublishedAt: TDateTime read GetPublishedAt;
    property ID: WideString read GetID;
  end;

  /// <summary>
  /// A list of video references associated with an item in TMDB.
  /// </summary>
  ITMDBVideos = interface(ITMDBItems)
    ['{1346CC9D-5897-4BBB-B140-5FEB6A892552}']
    function GetItem(const Index: Integer): ITMDBVideo; stdcall;

    property Items[const Index: Integer]: ITMDBVideo read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Collection Related'}

  /// <summary>
  /// A single collection as found in TMDB.
  /// </summary>
  ITMDBCollection = interface(ITMDBItem)
    ['{C0911ACB-C909-438A-8DC3-5A67E5F4CB4F}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
  end;

  /// <summary>
  /// A list of collections as found in TMDB.
  /// </summary>
  ITMDBCollections = interface(ITMDBItems)
    ['{DF22CFAD-33BC-4EF4-AB99-1848AB11E191}']
    function GetItem(const Index: Integer): ITMDBCollection; stdcall;

    property Items[const Index: Integer]: ITMDBCollection read GetItem; default;
  end;

  /// <summary>
  /// A page of collections as found in TMDB.
  /// </summary>
  ITMDBCollectionPage = interface(ITMDBPage)
    ['{7A7ADCD0-8062-4CF3-8D07-903DCCDA42E8}']
    function GetItems: ITMDBCollections; stdcall;

    property Items: ITMDBCollections read GetItems;
  end;

  /// <summary>
  /// The details of a specific collection as found in TMDB.
  /// </summary>
  ITMDBCollectionDetail = interface
    ['{78E5B1AC-0FF3-4472-886E-4A7696BE1E0E}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetParts: ITMDBMovies; stdcall;

    //Shortcut Functions
    function GetImages(const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations: ITMDBTranslations; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
    property Parts: ITMDBMovies read GetParts;
  end;

{$ENDREGION}



{$REGION 'Rating Related'}

  ITMDBRatingResult = interface
    ['{CEC0D889-C652-4A74-8111-723F8F785851}']
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

{$ENDREGION}



//TODO
{$REGION 'Person Related'}

  /// <summary>
  /// A single person as found in TMDB
  /// </summary>
  ITMDBPerson = interface(ITMDBMedium)
    ['{28C68CE8-358F-4C6E-B4D1-E859D8CCBD65}']
    function GetGender: TTMDBGender; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetProfilePath: WideString; stdcall;
    function GetKnownFor: ITMDBMedia; stdcall;

    property Gender: TTMDBGender read GetGender;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property ProfilePath: WideString read GetProfilePath;
    property KnownFor: ITMDBMedia read GetKnownFor;
  end;

  /// <summary>
  /// A list of people as found in TMDB
  /// </summary>
  ITMDBPeople = interface(ITMDBMedia)
    ['{80B66DAA-C18D-427B-9A0C-B0F070725B83}']
    function GetItem(const Index: Integer): ITMDBPerson; stdcall;

    property Items[const Index: Integer]: ITMDBPerson read GetItem; default;
  end;

  /// <summary>
  /// A paginated list of people as found in TMDB.
  /// </summary>
  ITMDBPersonPage = interface(ITMDBMediaPage)
    ['{88C5FCB1-50A7-4D3A-AB69-95B542D77FD5}']
    function GetItems: ITMDBPeople; stdcall;

    property Items: ITMDBPeople read GetItems;
  end;

  /// <summary>
  /// The details of a specific person as found in TMDB.
  /// </summary>
  ITMDBPersonDetail = interface(ITMDBDetail)
    ['{2C4F4272-71FB-47EA-926A-FB26C5DFFA18}']
    function GetAdult: Boolean; stdcall;
    function GetAlsoKnownAs: TTMDBStrArray; stdcall;
    function GetBiography: WideString; stdcall;
    function GetBirthday: TDateTime; stdcall;
    function GetDeathday: TDateTime; stdcall;
    function GetGender: TTMDBGender; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetPlaceOfBirth: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetProfilePath: WideString; stdcall;

    //TODO: Appended data...
    function AppendedChanges: ITMDBChanges; stdcall;
    function AppendedCombinedCredits: ITMDBCombinedCredits; stdcall;
    function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedMovieCredits: ITMDBCombinedCredits; stdcall;
    function AppendedTVCredits: ITMDBCombinedCredits; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;

    //TODO: Shortcut functions...
    //function GetChanges(): ITMDBChanges; stdcall;
    //function GetCombinedCredits(): ITMDBCombinedCredits; stdcall;
    //function GetExternalIDs(): ITMDBCombinedCredits; stdcall;
    //function GetImages(): ITMDBMediaImageGroup; stdcall;
    //function GetMovieCredits
    //function GetTVCredits
    //function GetTranslations(): ITMDBTranslations; stdcall;

    property Adult: Boolean read GetAdult;
    property AlsoKnownAs: TTMDBStrArray read GetAlsoKnownAs;
    property Biography: WideString read GetBiography;
    property Birthday: TDateTime read GetBirthday;
    property Deathday: TDateTime read GetDeathday;
    property Gender: TTMDBGender read GetGender;
    property Homepage: WideString read GetHomepage;
    property IMDBID: WideString read GetIMDBID;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property PlaceOfBirth: WideString read GetPlaceOfBirth;
    property Popularity: Single read GetPopularity;
    property ProfilePath: WideString read GetProfilePath;
  end;

{$ENDREGION}



//TODO
{$REGION 'Credit Related'}

  /// <summary>
  /// A single person in the cast of credits.
  /// </summary>
  ITMDBCastPerson = interface(ITMDBPerson)
    ['{9CCB9511-A5A5-4BE2-9991-D8A388F7439C}']
    function GetCastID: Integer; stdcall;
    function GetCharacter: WideString; stdcall;
    function GetCreditID: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property CastID: Integer read GetCastID;
    property Character: WideString read GetCharacter;
    property CreditID: WideString read GetCreditID;
    property Order: Integer read GetOrder;
  end;

  /// <summary>
  /// A list of people in the cast of credits.
  /// </summary>
  ITMDBCastPeople = interface(ITMDBPeople)
    ['{EE41CD2D-6271-48D8-8A5F-646646C44F30}']
    function GetItem(const Index: Integer): ITMDBCastPerson; stdcall;

    property Items[const Index: Integer]: ITMDBCastPerson read GetItem; default;
  end;

  /// <summary>
  /// A single person in the crew of credits.
  /// </summary>
  ITMDBCrewPerson = interface(ITMDBPerson)
    ['{51AE4CAA-1698-4AF6-B05C-D55E45BAE4ED}']
    function GetCreditID: WideString; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetJob: WideString; stdcall;

    property CreditID: WideString read GetCreditID;
    property Department: WideString read GetDepartment;
    property Job: WideString read GetJob;
  end;

  /// <summary>
  /// A list of people in the crew of credits.
  /// </summary>
  ITMDBCrewPeople = interface(ITMDBPeople)
    ['{1FF0C1A1-EB42-4EF9-8C1B-DEA3AFBD6777}']
    function GetItem(const Index: Integer): ITMDBCrewPerson; stdcall;

    property Items[const Index: Integer]: ITMDBCrewPerson read GetItem; default;
  end;

  /// <summary>
  /// A combination of Cast and Crew people related to a medium.
  /// </summary>
  ITMDBCredits = interface
    ['{6A1470C6-79DA-4EE8-B43E-F76EEA9015B9}']
    function GetCast: ITMDBCastPeople; stdcall;
    function GetCrew: ITMDBCrewPeople; stdcall;

    property Cast: ITMDBCastPeople read GetCast;
    property Crew: ITMDBCrewPeople read GetCrew;
  end;



  ITMDBCreditDetail = interface
    ['{33B43E23-2425-4B33-BB13-CC1FD11ADDFD}']
    function GetCreditType: TTMDBCreditType; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetJob: WideString; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetMedia: ITMDBMedium; stdcall;
    function GetID: WideString; stdcall;
    function GetPerson: ITMDBPerson; stdcall;

    property CreditType: TTMDBCreditType read GetCreditType;
    property Department: WideString read GetDepartment;
    property Job: WideString read GetJob;
    property MediaType: TTMDBMediaType read GetMediaType;
    property Media: ITMDBMedium read GetMedia;
    property ID: WideString read GetID;
    property Person: ITMDBPerson read GetPerson;
  end;



  //Aggregate Credits...

  ITMDBCreditRole = interface(ITMDBItem)
    ['{F712EFBD-731C-47B8-B666-35049D2B5686}']
    function GetCreditID: WideString; stdcall;
    function GetCharacter: WideString; stdcall;
    function GetEpisodeCount: Integer; stdcall;

    function GetDetail: ITMDBCreditDetail; stdcall;

    property CreditID: WideString read GetCreditID;
    property Character: WideString read GetCharacter;
    property EpisodeCount: Integer read GetEpisodeCount;
  end;

  ITMDBCreditRoles = interface(ITMDBItems)
    ['{4A12338E-9E81-4CC9-A34F-EEBAE84C06C3}']
    function GetItem(const Index: Integer): ITMDBCreditRole; stdcall;

    property Items[const Index: Integer]: ITMDBCreditRole read GetItem; default;
  end;

  ITMDBCreditJob = interface(ITMDBItem)
    ['{9F43A09E-FF26-4D8B-AEF8-577FE5CC31F1}']
    function GetCreditID: WideString; stdcall;
    function GetJob: WideString; stdcall;
    function GetEpisodeCount: Integer; stdcall;

    function GetDetail: ITMDBCreditDetail; stdcall;

    property CreditID: WideString read GetCreditID;
    property Job: WideString read GetJob;
    property EpisodeCount: Integer read GetEpisodeCount;
  end;

  ITMDBCreditJobs = interface(ITMDBItems)
    ['{CBA9313A-4592-429C-932E-FE5E6986C09A}']
    function GetItem(const Index: Integer): ITMDBCreditJob; stdcall;

    property Items[const Index: Integer]: ITMDBCreditJob read GetItem; default;
  end;

  ITMDBAggregateCastPerson = interface(ITMDBCastPerson)
    ['{C83EF72F-CE39-4D57-BC4D-7F14831DA13D}']
    function GetRoles: ITMDBCreditRoles; stdcall;
    function GetTotalEpisodeCount: Integer; stdcall;

    property Roles: ITMDBCreditRoles read GetRoles;
    property TotalEpisodeCount: Integer read GetTotalEpisodeCount;
  end;

  ITMDBAggregateCastPeople = interface(ITMDBCastPeople)
    ['{C41A4DE0-DA03-42BD-8C48-A89DAE5B3969}']
    function GetItem(const Index: Integer): ITMDBAggregateCastPerson; stdcall;

    property Items[const Index: Integer]: ITMDBAggregateCastPerson read GetItem; default;
  end;

  ITMDBAggregateCrewPerson = interface(ITMDBCrewPerson)
    ['{2615B60D-2B40-4CE9-8B3F-4B4F414B3B2B}']
    function GetJobs: ITMDBCreditJobs; stdcall;
    function GetTotalEpisodeCount: Integer; stdcall;
    function GetDepartment: WideString; stdcall;

    property Jobs: ITMDBCreditJobs read GetJobs;
    property TotalEpisodeCount: Integer read GetTotalEpisodeCount;
    property Department: WideString read GetDepartment;
  end;

  ITMDBAggregateCrewPeople = interface(ITMDBCrewPeople)
    ['{D625BC19-CF1F-4900-AAB5-B80C49761298}']
    function GetItem(const Index: Integer): ITMDBAggregateCrewPerson; stdcall;

    property Items[const Index: Integer]: ITMDBAggregateCrewPerson read GetItem; default;
  end;

  ITMDBAggregateCredits = interface
    ['{AE1F164B-1CB6-4937-9E53-F4764B2C213D}']
    function GetCast: ITMDBAggregateCastPeople; stdcall;
    function GetCrew: ITMDBAggregateCrewPeople; stdcall;

    property Cast: ITMDBAggregateCastPeople read GetCast;
    property Crew: ITMDBAggregateCrewPeople read GetCrew;
  end;



  //Combined Credits...

  ITMDBCombinedCastCredit = interface(ITMDBMedium)
    ['{5616E161-EB0A-446A-A483-16CA42A84997}']
    function GetCharacter: WideString; stdcall;
    function GetCreditID: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property Character: WideString read GetCharacter;
    property CreditID: WideString read GetCreditID;
    property Order: Integer read GetOrder;
  end;

  ITMDBCombinedCastCredits = interface(ITMDBMedia)
    ['{DBF41BA7-0738-47ED-8CB2-966D8237C12F}']
    function GetItem(const Index: Integer): ITMDBCombinedCastCredit; stdcall;

    property Items[const Index: Integer]: ITMDBCombinedCastCredit read GetItem; default;
  end;

  ITMDBCombinedCrewCredit = interface(ITMDBMedium)
    ['{A90D0B22-4DDE-4DBC-A102-DACEA92DE66F}']
    function GetJob: WideString; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetCreditID: WideString; stdcall;

    property Job: WideString read GetJob;
    property Department: WideString read GetDepartment;
    property CreditID: WideString read GetCreditID;
  end;

  ITMDBCombinedCrewCredits = interface(ITMDBMedia)
    ['{9694CCF1-FD74-42C4-BB26-F2C8861D6553}']
    function GetItem(const Index: Integer): ITMDBCombinedCrewCredit; stdcall;

    property Items[const Index: Integer]: ITMDBCombinedCrewCredit read GetItem; default;
  end;

  ITMDBCombinedCredits = interface
    ['{3A536F7E-7FC9-4C98-AE42-2281277C44B9}']
    function GetCast: ITMDBCombinedCastCredits; stdcall;
    function GetCrew: ITMDBCombinedCrewCredits; stdcall;

    property Cast: ITMDBCombinedCastCredits read GetCast;
    property Crew: ITMDBCombinedCrewCredits read GetCrew;
  end;

{$ENDREGION}



{$REGION 'Review Related'}

  ITMDBReviewAuthor = interface
    ['{CD8089C5-AD0A-4B2C-81CC-6148862AA2FA}']
    function GetName: WideString; stdcall;
    function GetUsername: WideString; stdcall;
    function GetAvatarPath: WideString; stdcall;
    function GetRating: Single; stdcall;

    property Name: WideString read GetName;
    property Username: WideString read GetUsername;
    property AvatarPath: WideString read GetAvatarPath;
    property Rating: Single read GetRating;
  end;

  ITMDBReview = interface(ITMDBItem)
    ['{6355DA86-5D53-4643-A158-4CF2CEFCCA6E}']
    function GetAuthor: WideString; stdcall;
    function GetAuthorDetail: ITMDBReviewAuthor; stdcall;
    function GetContent: WideString; stdcall;
    function GetCreatedAt: TDateTime; stdcall;
    function GetID: WideString; stdcall;
    function GetUpdatedAt: TDateTime; stdcall;
    function GetURL: WideString; stdcall;

    property Author: WideString read GetAuthor;
    property AuthorDetail: ITMDBReviewAuthor read GetAuthorDetail;
    property Content: WideString read GetContent;
    property CreatedAt: TDateTime read GetCreatedAt;
    property ID: WideString read GetID;
    property UpdatedAt: TDateTime read GetUpdatedAt;
    property URL: WideString read GetURL;
  end;

  ITMDBReviews = interface(ITMDBItems)
    ['{3CBF33BB-5A7C-4121-901F-133C3E254A9A}']
    function GetItem(const Index: Integer): ITMDBReview; stdcall;

    property Items[const Index: Integer]: ITMDBReview read GetItem; default;
  end;

  ITMDBReviewPage = interface(ITMDBPage)
    ['{672B8014-9334-4021-A547-5DB54D8DD289}']
    function GetItems: ITMDBReviews; stdcall;

    property Items: ITMDBReviews read GetItems;
  end;

  ITMDBReviewDetail = interface
    ['{47EDD6CB-AF3C-4762-B10B-4C976DEB23AB}']
    function GetAuthor: WideString; stdcall;
    function GetAuthorDetail: ITMDBReviewAuthor; stdcall;
    function GetContent: WideString; stdcall;
    function GetCreatedAt: TDateTime; stdcall;
    function GetID: WideString; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetMediaID: Integer; stdcall;
    function GetMediaTitle: WideString; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetUpdatedAt: TDateTime; stdcall;
    function GetURL: WideString; stdcall;

    property Author: WideString read GetAuthor;
    property AuthorDetail: ITMDBReviewAuthor read GetAuthorDetail;
    property Content: WideString read GetContent;
    property CreatedAt: TDateTime read GetCreatedAt;
    property ID: WideString read GetID;
    property ISO639_1: WideString read GetISO639_1;
    property MediaID: Integer read GetMediaID;
    property MediaTitle: WideString read GetMediaTitle;
    property MediaType: TTMDBMediaType read GetMediaType;
    property UpdatedAt: TDateTime read GetUpdatedAt;
    property URL: WideString read GetURL;
  end;

{$ENDREGION}



//TODO
{$REGION 'Movie Related'}

  /// <summary>
  /// A single movie item as found in TMDB.
  /// </summary>
  ITMDBMovie = interface(ITMDBMedium)
    ['{00EB49F1-F0EA-4E7A-859E-38632667BA87}']
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenres; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    function GetDetails(const AppendToResponse: TTMDBMovieRequests = [];
      const Language: WideString = ''; const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBMovieDetail; stdcall;
    //function GetAccountStates: ITMDBAccountStates; stdcall;
    //function GetAlternativeTitles(const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    //function GetChanges(const StartDate, EndDate: TDateTime;
    //  const Page: Integer = 1): ITMDBChangePage; stdcall;
    //function GetCredits: ITMDBCredits; stdcall;
    //function GetExternalIDs: ITMDBExternalIDs; stdcall;
    //function GetImages(): ITMDBMediaImages; stdcall;
    //function GetKeywords: ITMDBKeywordList; stdcall;
    //function GetLists(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBListPage; stdcall;
    //function GetRecommendations(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function GetReviews(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBReviewList; stdcall;
    //function GetSimilar(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetTranslations: ITMDBTranslationList; stdcall;
    //function GetVideos(const Language: WideString): ITMDBVideoList; stdcall;

    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenres read GetGenres;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// <summary>
  /// A list of movies
  /// </summary>
  ITMDBMovies = interface(ITMDBMedia)
    ['{AC2F3E06-A3C5-4B7B-B83C-23258F6E2FEF}']
    function GetItem(const Index: Integer): ITMDBMovie; stdcall;

    property Items[const Index: Integer]: ITMDBMovie read GetItem; default;
  end;

  /// <summary>
  /// A paginated list containing movie results.
  /// </summary>
  ITMDBMoviePage = interface(ITMDBMediaPage)
    ['{D35DC3E6-D4BB-416D-9A43-348C0FCAABB1}']
    function GetItems: ITMDBMovies; stdcall;

    property Items: ITMDBMovies read GetItems;
  end;




  /// <summary>
  /// A single movie with an associated rating.
  /// </summary>
  ITMDBRatedMovie = interface(ITMDBMovie)
    ['{8C67545E-20BB-4A32-8FB7-136C642F73A9}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// <summary>
  /// A list of movies with associated ratings.
  /// </summary>
  ITMDBRatedMovies = interface(ITMDBMovies)
    ['{F76B28E0-0F0E-45EB-B808-9821549BC755}']
    function GetItem(const Index: Integer): ITMDBRatedMovie; stdcall;

    property Items[const Index: Integer]: ITMDBRatedMovie read GetItem; default;
  end;

  /// <summary>
  /// A page of movies with associated ratings.
  /// </summary>
  ITMDBRatedMoviePage = interface(ITMDBMoviePage)
    ['{5E267356-3F72-4C5B-87B6-B1D596FDD037}']
    function GetItems: ITMDBRatedMovies; stdcall;

    property Items: ITMDBRatedMovies read GetItems;
  end;



  /// <summary>
  /// Reference to a collection which a movie belongs to.
  /// </summary>
  ITMDBMovieCollectionRef = interface
    ['{7BA3E60C-FE29-4C8E-ADC4-4F8F8900E7C8}']
    function GetBelongsToCollection: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;

    property BelongsToCollection: Boolean read GetBelongsToCollection;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
  end;

  /// <summary>
  /// Details of a specific movie.
  /// </summary>
  ITMDBMovieDetail = interface
    ['{9F2CC08D-6D65-4C6E-AEB0-8CEF4748B501}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCollection: ITMDBMovieCollectionRef; stdcall;
    function GetBudget: Currency; stdcall;
    function GetGenres: ITMDBGenres; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetOriginalCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetProductionCompanies: ITMDBCompanies; stdcall;
    function GetProductionCountries: ITMDBCountries; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetRevenue: Currency; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSpokenLanguages: ITMDBLanguages; stdcall;
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAlternativeTitles: ITMDBAlternativeTitles; stdcall;
    function AppendedChanges: ITMDBChanges; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedKeywords: ITMDBKeywords; stdcall;
    function AppendedLists: ITMDBListPage; stdcall;
    function AppendedRecommendations: ITMDBMediaPage; stdcall;
    function AppendedReleaseDates: ITMDBReleaseDateCountries; stdcall;
    function AppendedReviews: ITMDBReviewPage; stdcall;
    function AppendedSimilar: ITMDBMoviePage; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;
    function AppendedVideos: ITMDBVideos; stdcall;

    function AddToFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function RemoveFromFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function AddToWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    function RemoveFromWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    //function AddRating(const Rating: Single): ITMDB...
    //function RemoveRating: ITMDB...

    //TODO: Should I share these with "Appended" data?
    //  For example, if (Has Appended Data) then (Use Appended Data) else (Fetch Data)
    function GetAccountStates(const SessionID: WideString;
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetAlternativeTitles(const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    function GetChanges(const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetCredits(const Language: WideString = ''): ITMDBCredits; stdcall;
    function GetExternalIDs: ITMDBExternalIDs; stdcall;
    function GetImages(const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetKeywords: ITMDBKeywords; stdcall;
    function GetLists(const Language: WideString = '';
      const Page: Integer = 1): ITMDBListPage; stdcall;
    function GetRecommendations(const Language: WideString = '';
      const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function GetReleaseDates: ITMDBReleaseDateCountries; stdcall;
    function GetReviews(const Language: WideString = '';
      const Page: Integer = 1): ITMDBReviewPage; stdcall;
    function GetSimilar(const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetTranslations: ITMDBTranslations; stdcall;
    function GetVideos(const Language: WideString): ITMDBVideos; stdcall;
    //function GetWatchProviders: ITMDBMediaWatchProviders; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Collection: ITMDBMovieCollectionRef read GetCollection;
    property Budget: Currency read GetBudget;
    property Genres: ITMDBGenres read GetGenres;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property ITMDBID: WideString read GetIMDBID;
    property OriginalCountry: TTMDBStrArray read GetOriginalCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanies read GetProductionCompanies;
    property ProductionCountries: ITMDBCountries read GetProductionCountries;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Revenue: Currency read GetRevenue;
    property Runtime: Integer read GetRuntime;
    property SpokenLanguages: ITMDBLanguages read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property Title: WideString read GetTitle;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



{$REGION 'Movie List Related'}

  /// <summary>
  /// A range of dates (Min/Max).
  /// </summary>
  ITMDBDateRange = interface
    ['{CB7698C0-AB5A-4C5D-9043-02E049BAB915}']
    function GetMinimum: TDateTime; stdcall;
    function GetMaximum: TDateTime; stdcall;

    property Minimum: TDateTime read GetMinimum;
    property Maximum: TDateTime read GetMaximum;
  end;

  /// <summary>
  /// A paginated list of movies along with a given date range.
  /// </summary>
  ITMDBDatedMoviePage = interface(ITMDBMoviePage)
    ['{E1E4F07E-30EE-4D36-946B-621D98F1EBCB}']
    function GetDates: ITMDBDateRange; stdcall;

    property Dates: ITMDBDateRange read GetDates;
  end;

{$ENDREGION}



{$REGION 'Screened Theatrically Related'}

  ITMDBScreenedTheatricallyRef = interface(ITMDBItem)
    ['{97CF218D-B80D-4F40-BD52-C8BF37B09CBD}']
    function GetID: Integer; stdcall;
    function GetEpisodeNumber: Integer; stdcall;
    function GetSeasonNumber: Integer; stdcall;

    function GetDetail: ITMDBTVEpisodeDetail; stdcall;

    property ID: Integer read GetID;
    property EpisodeNumber: Integer read GetEpisodeNumber;
    property SeasonNumber: Integer read GetSeasonNumber;
  end;

  ITMDBScreenedTheatrically = interface(ITMDBItems)
    ['{FFAD63E2-311F-40DF-AD59-0AC13A669F77}']
    function GetItem(const Index: Integer): ITMDBScreenedTheatricallyRef; stdcall;

    property Items[const Index: Integer]: ITMDBScreenedTheatricallyRef read GetItem; default;
  end;

{$ENDREGION}



//TODO
{$REGION 'TV Series Related'}

  /// <summary>
  /// A single TV Series as found in TMDB.
  /// </summary>
  ITMDBTVSerie = interface(ITMDBMedium)
    ['{7907FF27-E02F-4270-9AAB-322E6C31516D}']
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenres; stdcall;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetFirstAirDate: TDateTime; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    //TODO: Shortcut Functions...
    //function GetDetail(const AppendToResponse: TTMDBTVSeriesRequests = [];
    //  const Language: WideString = ''): ITMDBTVSerieDetail; stdcall;
    //function GetAccountStates(const SessionID: WideString = '';
    //  const GuestSessionID: WideString = '': ITMDBAccountStates; stdcall;
    //function GetAggregateCredits(const Language: WideString = ''): ITMDBAggregateCredits; stdcall;
    //function GetAlternativeTitles: ITMDBAlternativeTitles; stdcall;
    //function GetChanges(const StartDate, EndDate: TDateTime): ITMDBChanges; s tdcall;
    //function GetContentRatings: ITMDBContentRatings; stdcall;
    //function GetCredits(const Language: WideString = ''): ITMDBCredits; stdcall;
    //function GetEpisodeGroups: ITMDBEpisodeGroups; stdcall;
    //function GetExternalIDs: ITMDBExternalIDs; stdcall;
    //function GetImages(const IncludeImageLanguage: WideString = '';
    //  const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    //function GetKeywords: ITMDBKeywords; stdcall;
    //function GetLists(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBLists; stdcall;
    //function GetRecommendations(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMediaPage;
    //function GetReviews(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBReviewPage;
    //function GetScreenedTheatrically: ???
    //function GetSimilar(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    //function GetTranslations: ITMDTTranslations; stdcall;
    //function GetVideos(const IncludeVideoLanguage: WideString = '';
    //  const Language: WideString = ''): ITMDBVideos; stdcall;
    //function GetWatchProviders: ITMDBMediaWatchProviders; stdcall;

    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenres read GetGenres;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// <summary>
  /// A list of TV series as found in TMDB.
  /// </summary>
  ITMDBTVSeries = interface(ITMDBMedia)
    ['{13D059E8-BC04-423B-AA5B-8590DFA6E97F}']
    function GetItem(const Index: Integer): ITMDBTVSerie; stdcall;

    property Items[const Index: Integer]: ITMDBTVSerie read GetItem; default;
  end;

  /// <summary>
  /// A paginated list containing TV Series results.
  /// </summary>
  ITMDBTVSeriesPage = interface(ITMDBMediaPage)
    ['{05742B99-FDCC-47E5-B34F-987ECA5DEBA2}']
    function GetItems: ITMDBTVSeries; stdcall;

    property Items: ITMDBTVSeries read GetItems;
  end;



  /// <summary>
  /// A TV Series which has been rated.
  /// </summary>
  ITMDBRatedTVSerie = interface(ITMDBTVSerie)
    ['{D48E190F-3095-452A-AE5C-75E70DB7C709}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// <summary>
  /// A list of TV Series which have been rated.
  /// </summary>
  ITMDBRatedTVSeries = interface(ITMDBTVSeries)
    ['{C7614607-9784-4D6A-99C2-66CB135A0736}']
    function GetItem(const Index: Integer): ITMDBRatedTVSerie; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVSerie read GetItem;
  end;

  /// <summary>
  /// A paginated list of TV Series which have been rated.
  /// </summary>
  ITMDBRatedTVSeriesPage = interface(ITMDBTVSeriesPage)
    ['{AD5E62E1-41CE-4564-8407-DCEE9F2F0756}']
    function GetItems: ITMDBTVSeries; stdcall;

    property Items: ITMDBTVSeries read GetItems;
  end;



  /// <summary>
  /// The details of a specific TV Series.
  /// </summary>
  ITMDBTVSerieDetail = interface(ITMDBDetail)
    ['{21659C51-7E37-4353-A47E-B1D5C31B456D}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCreatedBy: ITMDBPeople; stdcall;
    function GetEpisodeRunTime: TTMDBIntArray; stdcall;
    function GetFirstAirDate: TDateTime; stdcall;
    function GetGenres: ITMDBGenres; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetInProduction: Boolean; stdcall;
    function GetLanguages: TTMDBStrArray; stdcall;
    function GetLastAirDate: TDateTime; stdcall;
    function GetLastEpisodeToAir: ITMDBTVEpisode; stdcall;
    function GetNextEpisodeToAir: ITMDBTVEpisode; stdcall;
    function GetNetworks: ITMDBTVNetworks; stdcall;
    function GetNumberOfEpisodes: Integer; stdcall;
    function GetNumberOfSeasons: Integer; stdcall;
    function GetOriginCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetProductionCompanies: ITMDBCompanies; stdcall;
    function GetProductionCountries: ITMDBCountries; stdcall;
    function GetSeasons: ITMDBTVSeasons; stdcall;
    function GetSpokenLanguages: ITMDBLanguages; stdcall;
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetType: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    //TODO: Appended Data...
    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAggregateCredits: ITMDBAggregateCredits; stdcall;
    function AppendedAlternativeTitles: ITMDBAlternativeTitles; stdcall;
    function AppendedChanges: ITMDBChanges; stdcall;
    function AppendedContentRatings: ITMDBContentRatings; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    function AppendedEpisodeGroups: ITMDBTVEpisodeGroups; stdcall;
    function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedKeywords: ITMDBKeywords; stdcall;
    function AppendedLists: ITMDBListPage; stdcall;
    function AppendedRecommendations: ITMDBMediaPage;
    function AppendedReviews: ITMDBReviewPage;
    function AppendedScreenedTheatrically: ITMDBScreenedTheatrically; stdcall;
    function AppendedSimilar: ITMDBTVSeriesPage; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;
    function AppendedVideos: ITMDBVideos; stdcall;

    //TODO: Shortcut Functions...
    //function GetAccountStates(const SessionID: WideString = '';
    //  const GuestSessionID: WideString = '': ITMDBAccountStates; stdcall;
    //function GetAggregateCredits(const Language: WideString = ''): ITMDBAggregateCredits; stdcall;
    //function GetAlternativeTitles: ITMDBAlternativeTitles; stdcall;
    //function GetChanges(const StartDate, EndDate: TDateTime): ITMDBChanges; s tdcall;
    //function GetContentRatings: ITMDBContentRatings; stdcall;
    //function GetCredits(const Language: WideString = ''): ITMDBCredits; stdcall;
    //function GetEpisodeGroups: ITMDBEpisodeGroups; stdcall;
    //function GetExternalIDs: ITMDBExternalIDs; stdcall;
    //function GetImages(const IncludeImageLanguage: WideString = '';
    //  const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    //function GetKeywords: ITMDBKeywords; stdcall;
    //function GetLists(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBLists; stdcall;
    //function GetRecommendations(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMediaPage;
    //function GetReviews(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBReviewPage;
    //function GetScreenedTheatrically: ???
    //function GetSimilar(cosnt Language: WideString = '';
    //  const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    //function GetTranslations: ITMDTTranslations; stdcall;
    //function GetVideos(const IncludeVideoLanguage: WideString = '';
    //  const Language: WideString = ''): ITMDBVideos; stdcall;
    //function GetWatchProviders: ITMDBMediaWatchProviders; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property CreatedBy: ITMDBPeople read GetCreatedBy;
    property EpisodeRunTime: TTMDBIntArray read GetEpisodeRunTime;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property Genres: ITMDBGenres read GetGenres;
    property Homepage: WideString read GetHomepage;
    property InProduction: Boolean read GetInProduction;
    property Languages: TTMDBStrArray read GetLanguages;
    property LastAirDate: TDateTime read GetLastAirDate;
    property LastEpisodeToAir: ITMDBTVEpisode read GetLastEpisodeToAir;
    property NextEpisodeToAir: ITMDBTVEpisode read GetNextEpisodeToAir;
    property Networks: ITMDBTVNetworks read GetNetworks;
    property NumberOfEpisodes: Integer read GetNumberOfEpisodes;
    property NumberOfSeasons: Integer read GetNumberOfSeasons;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanies read GetProductionCompanies;
    property ProductionCountries: ITMDBCountries read GetProductionCountries;
    property Seasons: ITMDBTVSeasons read GetSeasons;
    property SpokenLanguages: ITMDBLanguages read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property SeriesType: WideString read GetType;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



//TODO
{$REGION 'TV Episode Related'}

  /// <summary>
  /// A single TV episode as found in TMDB.
  /// </summary>
  ITMDBTVEpisode = interface(ITMDBMedium)
    ['{2B2377B6-CEB0-47E0-9B64-D259600DECB4}']
    function GetOverview: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetAirDate: TDateTime; stdcall;
    function GetEpisodeNumber: Integer; stdcall;
    function GetProductionCode: WideString; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSeasonNumber: Integer; stdcall;
    function GetShowID: Integer; stdcall;
    function GetStillPath: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    //TODO: Shortcut Functions...

    property Overview: WideString read GetOverview;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property AirDate: TDateTime read GetAirDate;
    property EpisodeNumber: Integer read GetEpisodeNumber;
    property ProductionCode: WideString read GetProductionCode;
    property Runtime: Integer read GetRuntime;
    property SeasonNumber: Integer read GetSeasonNumber;
    property ShowID: Integer read GetShowID;
    property StillPath: WideString read GetStillPath;
    property Order: Integer read GetOrder;
  end;

  /// <summary>
  /// A list of TV episodes as found in TMDB.
  /// </summary>
  ITMDBTVEpisodes = interface(ITMDBMedia)
    ['{C574FEB8-2F01-408A-95B5-6B80E218EECD}']
    function GetItem(const Index: Integer): ITMDBTVEpisode; stdcall;

    property Items[const Index: Integer]: ITMDBTVEpisode read GetItem; default;
  end;

  /// <summary>
  /// A page of TV episodes as found in TMDB.
  /// </summary>
  ITMDBTVEpisodePage = interface(ITMDBMediaPage)
    ['{BB238B34-1BA9-411C-92AF-B43C6DD6702A}']
    function GetItems: ITMDBTVEpisodes; stdcall;

    property Items: ITMDBTVEpisodes read GetItems;
  end;



  /// <summary>
  /// A TV Episode which has been rated.
  /// </summary>
  ITMDBRatedTVEpisode = interface(ITMDBTVEpisode)
    ['{0FDB3732-0EB1-43FF-A006-4E6EFC411C54}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// <summary>
  /// A list of TV Episodes which have been rated.
  /// </summary>
  ITMDBRatedTVEpisodes = interface(ITMDBTVEpisodes)
    ['{B9718FA3-4D61-4E43-BE53-58E28E787CF4}']
    function GetItem(const Index: Integer): ITMDBRatedTVEpisode; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVEpisode read GetItem; default;
  end;

  /// <summary>
  /// A page of TV Episodes which have been rated.
  /// </summary>
  ITMDBRatedTVEpisodePage = interface(ITMDBTVEpisodePage)
    ['{DDC4B9FA-AC4B-4EAC-B9B8-78464034BC68}']
    function GetItems: ITMDBRatedTVEpisodes; stdcall;

    property Items: ITMDBRatedTVEpisodes read GetItems;
  end;



  /// <summary>
  /// The details of a specific TV Episode.
  /// </summary>
  ITMDBTVEpisodeDetail = interface(ITMDBDetail)
    ['{54B42FE7-72A4-4D20-B249-F9F987285053}']
    function GetAirDate: TDateTime; stdcall;
    function GetEpisodeNumber: Integer; stdcall;
    function GetCrew: ITMDBCrewPeople; stdcall;
    function GetGuestStars: ITMDBCastPeople; stdcall;
    function GetOverview: WideString; stdcall;
    function GetProductionCode: WideString; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSeasonNumber: Integer; stdcall;
    function GetStillPath: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    //TODO: Appended Data...
    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedChanges: ITMDBChanges; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;
    function AppendedVideos: ITMDBVideos; stdcall;

    //TODO: Shortcut Functions...

    property AirDate: TDateTime read GetAirDate;
    property EpisodeNumber: Integer read GetEpisodeNumber;
    property Crew: ITMDBCrewPeople read GetCrew;
    property GuestStars: ITMDBCastPeople read GetGuestStars;
    property Overview: WideString read GetOverview;
    property ProductionCode: WideString read GetProductionCode;
    property Runtime: Integer read GetRuntime;
    property SeasonNumber: Integer read GetSeasonNumber;
    property StillPath: WideString read GetStillPath;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



//TODO
{$REGION 'TV Season Related'}

  /// <summary>
  /// A single TV season as found in TMDB
  /// </summary>
  ITMDBTVSeason = interface(ITMDBMedium)
    ['{A3291740-EB50-467E-8B82-ED5F3463A882}']
    function GetAirDate: TDateTime; stdcall;
    function GetEpisodeCount: Integer; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetSeasonNumber: Integer; stdcall;
    function GetVoteAverage: Single; stdcall;

    property AirDate: TDateTime read GetAirDate;
    property EpisodeCount: Integer read GetEpisodeCount;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property SeasonNumber: Integer read GetSeasonNumber;
    property VoteAverage: Single read GetVoteAverage;
  end;

  /// <summary>
  /// A list of TV seasons as found in TMDB
  /// </summary>
  ITMDBTVSeasons = interface(ITMDBMedia)
    ['{BA1F02CD-9D5F-4AC7-B849-7B524C3B25F1}']
    function GetItem(const Index: Integer): ITMDBTVSeason; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeason read GetItem; default;
  end;

  /// <summary>
  /// A page of TV seasons as found in TMDB
  /// </summary>
  ITMDBTVSeasonPage = interface(ITMDBMediaPage)
    ['{697CDF42-1FE5-49C3-92C5-87BE730AD427}']
    function GetItems: ITMDBTVSeasons; stdcall;

    property Items: ITMDBTVSeasons read GetItems;
  end;



  /// <summary>
  /// A TV Episode as found within a TV Season.
  /// </summary>
  ITMDBTVSeasonEpisode = interface(ITMDBTVEpisode)
    ['{87C960B0-FECC-4DB3-B4CC-822674CC88A2}']
    function GetCrew: ITMDBCrewPeople; stdcall;
    function GetGuestStars: ITMDBCastPeople; stdcall;

    property Crew: ITMDBCrewPeople read GetCrew;
    property GuestStarts: ITMDBCastPeople read GetGuestStars;
  end;

  /// <summary>
  /// A list of TV Episodes as found within a TV Season
  /// </summary>
  ITMDBTVSeasonEpisodes = interface(ITMDBTVEpisodes)
    ['{CF11A522-263C-492E-AEF7-A871133994B7}']
    function GetItem(const Index: Integer): ITMDBTVSeasonEpisode; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeasonEpisode read GetItem; default;
  end;



  /// <summary>
  /// The details of a single TV season as found in TMDB
  /// </summary>
  ITMDBTVSeasonDetail = interface
    ['{8E456798-FF9E-483E-B3DA-3CC5EDA54C98}']
    function Get_ID: WideString; stdcall;
    function GetAirDate: TDateTime; stdcall;
    function GetEpisodes: ITMDBTVSeasonEpisodes; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetSeasonNumber: Integer; stdcall;
    function GetVoteAverage: Single; stdcall;

    //TODO: Appended Data...
    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAggregateCredits: ITMDBAggregateCredits; stdcall;
    function AppendedChanges: ITMDBChanges; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;
    function AppendedVideos: ITMDBVideos; stdcall;


    //TODO: Shortcut Functions...

    property _ID: WideString read Get_ID;
    property AirDate: TDateTime read GetAirDate;
    property Episodes: ITMDBTVSeasonEpisodes read GetEpisodes;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property ID: Integer read GetID;
    property PosterPath: WideString read GetPosterPath;
    property SeasonNumber: Integer read GetSeasonNumber;
    property VoteAverage: Single read GetVoteAverage;
  end;

{$ENDREGION}



//TODO
{$REGION 'TV Episode Group Related'}

  /// <summary>
  /// A list of episode groups as found in TMDB.
  /// </summary>
  ITMDBTVEpisodeGroups = interface
    ['{14C7DEAF-20B9-4541-BBF8-D9A9A8E8205E}']
    function GetDescription: WideString; stdcall;
    function GetEpisodeCount: Integer; stdcall;
    function GetGroupCount: Integer; stdcall;
    function GetGroup(const Index: Integer): ITMDBTVEpisodeGroup; stdcall;
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetNetwork: ITMDBTVNetwork; stdcall;
    function GetType: TTMDBTVEpisodeGroupType; stdcall;

    property Description: WideString read GetDescription;
    property EpisodeCount: Integer read GetEpisodeCount;
    property GroupCount: Integer read GetGroupCount;
    property Groups[const Index: Integer]: ITMDBTVEpisodeGroup read GetGroup; default;
    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Network: ITMDBTVNetwork read GetNetwork;
    property GroupType: TTMDBTVEpisodeGroupType read GetType;
  end;

  /// <summary>
  /// A single episode group as found in TMDB.
  /// </summary>
  ITMDBTVEpisodeGroup = interface
    ['{EBECFB23-6043-4830-8497-EAE3A6AD5E6B}']
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOrder: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetEpisode(const Index: Integer): ITMDBTVEpisode; stdcall;
    function GetLocked: Boolean; stdcall;

    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Order: Integer read GetOrder;
    property Count: Integer read GetCount;
    property Episodes[const Index: Integer]: ITMDBTVEpisode read GetEpisode; default;
    property Locked: Boolean read GetLocked;
  end;

{$ENDREGION}



//TODO
{$REGION 'List Related'}

  /// <summary>
  ///
  /// </summary>
  ITMDBList = interface(ITMDBItem)
    ['{7B153F3B-E562-45AC-8708-6C1F3E6EE6B2}']
    function GetDescription: WideString;
    function GetFavoriteCount: Integer;
    function GetID: Integer;
    function GetISO639_1: WideString;
    function GetListType: TTMDBListType;
    function GetName: WideString;
    function GetPosterPath: WideString;

    property Description: WideString read GetDescription;
    property FavoriteCount: Integer read GetFavoriteCount;
    property ID: Integer read GetID;
    property ISO639_1: WideString read GetISO639_1;
    property ListType: TTMDBListType read GetListType;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBLists = interface(ITMDBItems)
    ['{3E59EB7F-7ACA-4C60-87CF-14D8D57DDA17}']
    function GetItem(const Index: Integer): ITMDBList; stdcall;

    property Items[const Index: Integer]: ITMDBList read GetItem; default;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBListPage = interface(ITMDBPage)
    ['{6B0E3282-73BC-4DF8-9097-089F41BEE53B}']
    function GetItems: ITMDBLists; stdcall;

    property Items: ITMDBLists read GetItems;
  end;

  /// <summary>
  ///
  /// </summary>
  ITMDBListDetail = interface
    ['{23EA408A-0752-455E-B9CA-0BB1C5BB02A1}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetParts: ITMDBMedia; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
    property Parts: ITMDBMedia read GetParts;
  end;

{$ENDREGION}



//TODO
{$REGION 'Discover Related'}

  ITMDBDiscoverMoviesParams = interface
    ['{700EDC98-83A5-41FB-AB34-4326179EE37B}']
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

    function GetRec: TTMDBAPIDiscoverMovieReq; stdcall;

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

  ITMDBDiscoverTVParams = interface
    ['{C2E7A309-1E14-4D62-BC23-505525F3D9D4}']
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
    procedure SetFirstAirDateLTE(const AValue: TDAteTime);
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

    function GetRec: TTMDBAPIDiscoverTVReq; stdcall;

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


{$ENDREGION}



{$REGION 'Find Related'}

  /// <summary>
  /// The resposne of calling Find By ID containing several lists of results.
  /// </summary>
  ITMDBFindResults = interface
    ['{4A7BEA80-3F67-4CF2-8A79-31CA9E19EB0D}']
    function GetMovieResults: ITMDBMovies;
    function GetPersonResults: ITMDBPeople;
    function GetTVResults: ITMDBTVSeries;
    function GetTVEpisodeResults: ITMDBTVEpisodes;
    function GetTVSeasonResults: ITMDBTVSeasons;

    property MovieResults: ITMDBMovies read GetMovieResults;
    property PersonResults: ITMDBPeople read GetPersonResults;
    property TVResults: ITMDBTVSeries read GetTVResults;
    property TVEpisodeResults: ITMDBTVEpisodes read GetTVEpisodeResults;
    property TVSeasonResults: ITMDBTVSeasons read GetTVSeasonResults;
  end;

{$ENDREGION}



{$REGION 'Watch Provider Related'}

  /// <summary>
  /// A single country and its priority for a given watch provider.
  /// </summary>
  ITMDBWatchProviderPriority = interface
    ['{9C41902E-4F0B-452E-8B80-40A3B139061B}']
    function GetCountryCode: WideString; stdcall;
    function GetPriority: Integer; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property Priority: Integer read GetPriority;
  end;

  /// <summary>
  /// A list of countries and their priority for a given watch provider.
  /// </summary>
  ITMDBWatchProviderPriorities = interface
    ['{256F86BF-7470-40AE-B5C6-128960948240}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderPriority; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderPriority read GetItem; default;
  end;

  /// <summary>
  /// A single watch provider as found in TMDB.
  /// </summary>
  ITMDBWatchProvider = interface(ITMDBItem)
    ['{D94AA552-F436-494D-881B-7FEEBC429068}']
    function GetDisplayPriorities: ITMDBWatchProviderPriorities; stdcall;
    function GetDisplayPriority: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetProviderName: WideString; stdcall;
    function GetProviderID: Integer; stdcall;

    property DisplayPriorities: ITMDBWatchProviderPriorities read GetDisplayPriorities;
    property DisplayPriority: Integer read GetDisplayPriority;
    property LogoPath: WideString read GetLogoPath;
    property ProviderName: WideString read GetProviderName;
    property ProviderID: Integer read GetProviderID;
  end;

  /// <summary>
  /// A list of watch providers as found in TMDB.
  /// </summary>
  ITMDBWatchProviders = interface(ITMDBItems)
    ['{59B51A31-211F-48CD-BED4-B61E9EAA3EB1}']
    function GetItem(const Index: Integer): ITMDBWatchProvider; stdcall;

    property Items[const Index: Integer]: ITMDBWatchProvider read GetItem; default;
  end;



  ITMDBMediaWatchProvider = interface(ITMDBItem)
    ['{DF1CF54E-5E56-4BB7-8EB6-C385B7845289}']
    function GetLogoPath: WideString; stdcall;
    function GetProviderID: Integer; stdcall;
    function GetProviderName: WideString; stdcall;
    function GetDisplayPriority: Integer; stdcall;

    property LogoPath: WideString read GetLogoPath;
    property ProviderID: Integer read GetProviderID;
    property ProviderName: WideString read GetProviderName;
    property DisplayPriority: Integer read GetDisplayPriority;
  end;

  ITMDBMediaWatchProviders = interface(ITMDBItems)
    ['{9B0CA949-7FAC-4F35-97AD-89847AAD501B}']
    function GetItem(const Index: Integer): ITMDBMediaWatchProvider; stdcall;

    property Items[const Index: Integer]: ITMDBMediaWatchProvider read GetItem; default;
  end;

  ITMDBMediaWatchProviderCountry = interface
    ['{705496C5-CCDE-40C0-B660-920B44518A9A}']
    function GetLink: WideString; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetBuy: ITMDBMediaWatchProviders; stdcall;
    function GetRent: ITMDBMediaWatchProviders; stdcall;
    function GetFlatrate: ITMDBMediaWatchProviders; stdcall;

    property Link: WideString read GetLink;
    property CountryCode: WideString read GetCountryCode;
    property Buy: ITMDBMediaWatchProviders read GetBuy;
    property Rent: ITMDBMediaWatchProviders read GetRent;
    property Flatrate: ITMDBMediaWatchProviders read GetFlatrate;
  end;

  ITMDBMediaWatchProviderCountries = interface
    ['{FCB23E8C-5FA7-4C27-B6BC-1EEF522A2ED2}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBMediaWatchProviderCountry; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBMediaWatchProviderCountry read GetItem; default;
  end;

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'API Namespace Related'}

  /// <summary>
  /// Base interface for each possible TMDB Namespace category.
  /// </summary>
  ITMDBNamespace = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']
    function GetOwner: ITMDBClient;

    property Owner: ITMDBClient read GetOwner;
  end;

  ITMDBNamespaceAccount = interface(ITMDBNamespace)
    ['{E690DF1A-6680-4040-BBC6-ABE0D4CC6916}']
    function GetDetails(AAccountID: Integer;
      ASessionID: WideString = ''): ITMDBAccountDetail; stdcall;
    function GetDetailsBySession(const ASessionID: WideString): ITMDBAccountDetail; stdcall;
    function SetFavorite(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult; stdcall;
    function SetWatchlist(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult; stdcall;
    function GetFavoriteMovies(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetFavoriteTV(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBTVSeriesPage; stdcall;
    function GetLists(const AccountID: Integer; const Page: Integer = 1;
      const SessionID: WideString = ''): ITMDBListPage; stdcall;
    function GetRatedMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedMoviePage; stdcall;
    function GetRatedTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVSeriesPage; stdcall;
    function GetRatedTVEpisodes(AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVEpisodePage; stdcall;
    function GetWatchlistMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetWatchlistTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBNamespaceAuthentication = interface(ITMDBNamespace)
    ['{2144056B-54A4-49C4-AE3E-E0701B10E218}']
    function CreateGuestSession: ITMDBAuthGuestSessionResult; stdcall;
    function CreateRequestToken: ITMDBAuthRequestTokenResult; stdcall;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin; stdcall;
    function DeleteSession(const SessionID: WideString): ITMDBAuthDeleteSessionResult; stdcall;
    function ValidateKey: ITMDBAuthValidateKeyResult; stdcall;
  end;

  ITMDBNamespaceCertifications = interface(ITMDBNamespace)
    ['{C6FCB00E-CDCA-46EA-B44B-A3CA2570774B}']
    function GetMovieCertifications: ITMDBCertificationCountries; stdcall;
    function GetTVCertifications: ITMDBCertificationCountries; stdcall;
  end;

  ITMDBNamespaceChanges = interface(ITMDBNamespace)
    ['{944AE998-E4B0-49DA-924E-2272AEF9F8A0}']
    function MovieList(const StartDate, EndDate: TDateTime;
      const Page: Integer = 1): ITMDBChangeRefPage; stdcall;
    function PeopleList(const StartDate, EndDate: TDateTime;
      const Page: Integer = 1): ITMDBChangeRefPage; stdcall;
    function TVList(const StartDate, EndDate: TDateTime;
      const Page: Integer = 1): ITMDBChangeRefPage; stdcall;
  end;

  ITMDBNamespaceCollections = interface(ITMDBNamespace)
    ['{C0040473-5A07-493B-9771-2EAF58CD5DB0}']
    function GetDetails(const CollectionID: Integer;
      const Language: WideString = ''): ITMDBCollectionDetail; stdcall;
    function GetImages(const CollectionID: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations(const CollectionID: Integer): ITMDBTranslations; stdcall;
  end;

  ITMDBNamespaceCompanies = interface(ITMDBNamespace)
    ['{13F92C49-85D1-4C7F-BBA6-8B815B23EDDE}']
    function GetDetails(const CompanyID: Integer): ITMDBCompanyDetail; stdcall;
    function GetAlternativeNames(const CompanyID: Integer): ITMDBAlternativeTitles; stdcall;
    function GetImages(const CompanyID: Integer): ITMDBMediaImageGroup; stdcall;
  end;

  ITMDBNamespaceConfiguration = interface(ITMDBNamespace)
    ['{A459EFE0-D167-4247-8EAD-319021284D10}']
    function GetDetails: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountries; stdcall;
    function GetJobs: ITMDBJobDepartments; stdcall;
    function GetLanguages: ITMDBLanguages; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezones; stdcall;
  end;

  ITMDBNamespaceCredits = interface(ITMDBNamespace)
    ['{B5BDB2EC-A303-474B-B71F-C329100CC378}']
    function GetDetails(const CreditID: WideString): ITMDBCreditDetail; stdcall;
  end;

  ITMDBNamespaceDiscover = interface(ITMDBNamespace)
    ['{F3D713B4-04D6-48D8-A4C9-6505CD361694}']
    function NewMovieParams: ITMDBDiscoverMoviesParams; stdcall;
    function NewTVParams: ITMDBDiscoverTVParams; stdcall;

    function DiscoverMovies(Params: ITMDBDiscoverMoviesParams;
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function DiscoverTV(Params: ITMDBDiscoverTVParams;
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBNamespaceFind = interface(ITMDBNamespace)
    ['{82DB20C9-8E71-4151-9E76-B173CA5F1B97}']
    function FindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ITMDBFindResults; stdcall;
  end;

  ITMDBNamespaceGenres = interface(ITMDBNamespace)
    ['{E21E59C6-5416-4D9A-B6EB-33E004A5622D}']
    function GetMovieList(const Language: WideString = ''): ITMDBGenres; stdcall;
    function GetTVList(const Language: WideString = ''): ITMDBGenres; stdcall;
  end;

  ITMDBNamespaceGuestSessions = interface(ITMDBNamespace)
    ['{FDF85071-F2F4-49A6-BAAD-6ECD96BE3CBD}']
    function GetRatedMovies(const GuestSessionID: WideString;
      const Language: WideString = ''; const SortBy: WideString = '';
      const Page: Integer = 1): ITMDBRatedMoviePage;
    function GetRatedTV(const GuestSessionID: WideString;
      const Language: WideString = ''; const SortBy: WideString = '';
      const Page: Integer = 1): ITMDBRatedTVSeriesPage;
    function GetRatedTVEpisodes(const GuestSessionID: WideString;
      const Language: WideString = ''; const SortBy: WideString = '';
      const Page: Integer = 1): ITMDBRatedTVEpisodePage;
  end;

  ITMDBNamespaceKeywords = interface(ITMDBNamespace)
    ['{8FE0FEB6-511B-4704-A71A-BA8B5C8E912C}']
    function GetDetails(const KeywordID: Integer): ITMDBKeywordDetail; stdcall;
  end;

  ITMDBNamespaceLists = interface(ITMDBNamespace)
    ['{9516AD42-A8CC-47E8-9CDB-4E2C8C48E028}']
    //function AddMovie
    //function CheckItemStatus(const ListID: Integer; const MovieID: Integer;
    //  const Language: WideString = ''): ITMDBListItemStatus; stdcall;
    //function Clear
    //function Create
    //function Delete
    function GetDetails(const ListID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBListDetail; stdcall;
    //function RemoveMovie
  end;

  ITMDBNamespaceMovieLists = interface(ITMDBNamespace)
    ['{FAFB9948-B099-47AD-8C0F-74FE3A1B2E0E}']
    function GetNowPlaying(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
    function GetPopular(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetTopRated(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetUpcoming(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
  end;

  ITMDBNamespaceMovies = interface(ITMDBNamespace)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
      const Language: WideString = ''; const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBMovieDetail; stdcall;
    function GetAccountStates(const MovieID: Integer; const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetAlternativeTitles(const MovieID: Integer;
      const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    function GetChanges(const MovieID: Integer; const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetCredits(const MovieID: Integer; const Language: String = ''): ITMDBCredits; stdcall;
    function GetExternalIDs(const MovieID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const MovieID: Integer; const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetKeywords(const MovieID: Integer): ITMDBKeywords; stdcall;
    function GetLatest: ITMDBMovieDetail;
    function GetLists(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBListPage; stdcall;
    function GetRecommendations(const MovieID: Integer;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function GetReleaseDates(const MovieID: Integer): ITMDBReleaseDateCountries; stdcall;
    function GetReviews(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBReviewPage; stdcall;
    function GetSimilar(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetTranslations(const MovieID: Integer): ITMDBTranslations; stdcall;
    function GetVideos(const MovieID: Integer; const Language: WideString = ''): ITMDBVideos; stdcall;
    function GetWatchProviders(const MovieID: Integer): ITMDBMediaWatchProviderCountries; stdcall;
    function AddRating(const MovieID: Integer; const Rating: Single;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
    function DeleteRating(const MovieID: Integer;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
  end;

  ITMDBNamespaceNetworks = interface(ITMDBNamespace)
    ['{766C690C-DD9A-4E3B-A611-F93B1CFE1DF6}']
    function GetDetails(const NetworkID: Integer): ITMDBTVNetworkDetail; stdcall;
    function GetAlternativeNames(const NetworkID: Integer): ITMDBAlternativeTitles; stdcall;
    function GetImages(const NetworkID: Integer): ITMDBMediaImageGroup; stdcall;
  end;

  ITMDBNamespacePeopleLists = interface(ITMDBNamespace)
    ['{24DB64CB-1303-4CF5-86D9-F007E773C869}']
    function GetPopular(const Language: WideString = '';
      const Page: Integer = 1): ITMDBPersonPage; stdcall;
  end;

  ITMDBNamespacePeople = interface(ITMDBNamespace)
    ['{7A209CC2-3BB0-4AC7-AD28-9466ACC666EA}']
    function GetDetails(const PersonID: Integer; const AppendToResult: TTMDBPersonRequests = [];
      const Language: WideString = ''): ITMDBPersonDetail; stdcall;
    function GetChanges(const PersonID: Integer;
      const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetCombinedCredits(const PersonID: Integer;
      const Language: WideString = ''): ITMDBCombinedCredits; stdcall;
    function GetExternalIDs(const PersonID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const PersonID: Integer): ITMDBMediaImageGroup; stdcall;
    function GetLatest: ITMDBPersonDetail; stdcall;
    function GetMovieCredits(const PersonID: Integer;
      const Language: WideString = ''): ITMDBCombinedCredits; stdcall;
    function GetTVCredits(const PersonID: Integer;
      const Language: WideString = ''): ITMDBCombinedCredits; stdcall;
    function GetTranslations(const PersonID: Integer): ITMDBTranslations; stdcall;
  end;

  ITMDBNamespaceReviews = interface(ITMDBNamespace)
    ['{FD2277E9-2A59-413D-B67B-B210D32F1133}']
    function GetDetail(const ReviewID: WideString): ITMDBReviewDetail; stdcall;
  end;

  ITMDBNamespaceSearch = interface(ITMDBNamespace)
    ['{D7E9618F-ED5C-4D9A-93FF-CF109294DA0F}']
    function SearchCollections(const Query: WideString; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: WideString = ''; const Region: WideString = '';
      const Page: Integer = 1): ITMDBCollectionPage; stdcall;
    function SearchCompanies(const Query: WideString; const Page: Integer = 1): ITMDBCompanyPage; stdcall;
    function SearchKeywords(const Query: WideString;
      const Page: Integer = 1): ITMDBKeywordPage; stdcall;
    function SearchMovies(const Query: WideString; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function SearchMulti(const Query: WideString; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function SearchPeople(const Query: WideString; const IncludeAdult: TTMDBBoolean = bDefault;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBPersonPage; stdcall;
    function SearchTV(const Query: String; const FirstAirDateYear: Integer = 0;
      const IncludeAdult: TTMDBBoolean = bDefault; const Language: WideString = '';
      const Year: Integer = 0; const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBNamespaceTrending = interface(ITMDBNamespace)
    ['{54784907-ACC7-40D1-81D5-109FB413F18A}']
    function GetAll(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function GetMovies(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetPeople(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBPersonPage; stdcall;
    function GetTV(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBNamespaceTVSeriesLists = interface(ITMDBNamespace)
    ['{7CFA63BE-1377-446E-AE16-D6EB8FF74074}']
    function GetAiringToday(const Language: WideString = ''; const Timezone: WideString  = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    function GetOnTheAir(const Language: WideString = ''; const Timezone: WideString  = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    function GetPopular(const Language: WideString = ''; const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    function GetTopRated(const Language: WideString = ''; const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBNamespaceTVSeries = interface(ITMDBNamespace)
    ['{A72F79E7-A3C2-4105-B0F0-3D53B59352B2}']
    function GetDetails(const SeriesID: Integer; const AppendToResponse: TTMDBTVSeriesRequests = [];
      const Language: WideString = ''; const SessionID: WideString = ''): ITMDBTVSerieDetail; stdcall;
    function GetAccountStates(const SeriesID: Integer): ITMDBAccountStates; stdcall;
    function GetAggregateCredits(const SeriesID: Integer;
      const Language: WideString = ''): ITMDBAggregateCredits; stdcall;
    function GetAlternativeTitles(const SeriesID: Integer): ITMDBAlternativeTitles; stdcall;
    function GetChanges(const SeriesID: Integer; const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetContentRatings(const SeriesID: Integer): ITMDBContentRatings; stdcall;
    function GetCredits(const SeriesID: Integer; const Language: WideString = ''): ITMDBCredits; stdcall;
    function GetEpisodeGroups(const SeriesID: Integer): ITMDBTVEpisodeGroups; stdcall;
    function GetExternalIDs(const SeriesID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const SeriesID: Integer; const IncludeImageLanguage: WideString ='';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetKeywords(const SeriesID: Integer): ITMDBKeywords; stdcall;
    function GetLatest: ITMDBTVSerieDetail; stdcall;
    function GetLists(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBListPage; stdcall;
    function GetRecommendations(const SeriesID: Integer;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function GetReviews(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBReviewPage; stdcall;
    function GetScreenedTheatrically(const SeriesID: Integer): ITMDBScreenedTheatrically; stdcall;
    function GetSimilar(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    function GetTranslations(const SeriesID: Integer): ITMDBTranslations; stdcall;
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideos; stdcall;
    function GetWatchProviders(const SeriesID: Integer): ITMDBMediaWatchProviderCountries; stdcall;
    function AddRating(const SeriesID: Integer; const Rating: Single;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
    function DeleteRating(const SeriesID: Integer;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
  end;

  ITMDBNamespaceTVSeasons = interface(ITMDBNamespace)
    ['{89A1F3C8-F032-4B36-8481-DFE5291EBDA3}']
    function GetDetails(const SeriesID, SeasonNumber: Integer;
      const AppendToResponse: TTMDBTVSeasonRequests = [];
      const Language: WideString = ''): ITMDBTVSeasonDetail; stdcall;
    function GetAccountStates(const SeriesID, SeasonNumber: Integer;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetAggregateCredits(const SeriesID, SeasonNumber: Integer;
      const Language: WideString = ''): ITMDBAggregateCredits; stdcall;
    function GetChanges(const SeasonID: Integer; const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetCredits(const SeriesID, SeasonNumber: Integer;
      const Language: WideString = ''): ITMDBCredits; stdcall;
    function GetExternalIDs(const SeriesID, SeasonNumber: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const SeriesID, SeasonNumber: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations(const SeriesID, SeasonNumber: Integer): ITMDBTranslations; stdcall;
    function GetVideos(const SeriesID, SeasonNumber: Integer;
      const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideos; stdcall;
    function GetWatchProviders(const SeriesID, SeasonNumber: Integer;
      const Language: WideString = ''): ITMDBMediaWatchProviderCountries; stdcall;
  end;

  ITMDBNamespaceTVEpisodes = interface(ITMDBNamespace)
    ['{CD87A380-130A-46CD-9661-6CE1CE30CD82}']
    function GetDetails(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const AppendToResponse: TTMDBTVEpisodeRequests;
      const Language: WideString = ''): ITMDBTVEpisodeDetail; stdcall;
    function GetAccountStates(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetChanges(const EpisodeID: Integer;
      const StartDate, EndDate: TDateTime): ITMDBChanges; stdcall;
    function GetCredits(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const Language: WideString = ''): ITMDBCredits; stdcall;
    function GetExternalIDs(const SeriesID, SeasonNumber, EpisodeNumber: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations(const SeriesID, SeasonNumber, EpisodeNumber: Integer): ITMDBTranslations; stdcall;
    function GetVideos(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideos; stdcall;
    function AddRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer; const Rating: Single;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
    function DeleteRating(const SeriesID, SeasonNumber, EpisodeNumber: Integer;
      const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBRatingResult; stdcall;
  end;

  ITMDBNamespaceTVEpisodeGroups = interface(ITMDBNamespace)
    ['{B55FFFC4-7C29-4BA1-89C5-0CF1A8D88943}']
    function GetDetails(const TVEpisodeGroupID: String): ITMDBTVEpisodeGroups; stdcall;
  end;

  ITMDBNamespaceWatchProviders = interface(ITMDBNamespace)
    ['{FDB079FA-C25C-4337-BDD7-C4E4A9186A36}']
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountries; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviders; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviders; stdcall;
  end;


{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'TMDB Client'}

  /// <summary>
  ///
  /// </summary>
  ITMDBCache = interface
    ['{7D0D9646-6136-48D8-8FC1-03A6950B670F}']
    function GetConfig: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountries; stdcall;
    function GetJobDepartments: ITMDBJobDepartments; stdcall;
    function GetLanguages: ITMDBLanguages; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezones; stdcall;
    function GetMovieCerts: ITMDBCertificationCountries; stdcall;
    function GetTVCerts: ITMDBCertificationCountries; stdcall;
    function GetMovieGenres: ITMDBGenres; stdcall;
    function GetTVGenres: ITMDBGenres; stdcall;

    procedure RefreshAll; stdcall;
    function MovieGenre(const ID: Integer): WideString; stdcall;
    function TVGenre(const ID: Integer): WideString; stdcall;

    property Config: ITMDBConfiguration read GetConfig;
    property Countries: ITMDBCountries read GetCountries;
    //property Jobs: ITMDBJobList read GetJobs;
    property Languages: ITMDBLanguages read GetLanguages;
    property PrimaryTranslations: TTMDBStrArray read GetPrimaryTranslations;
    property Timezones: ITMDBTimezones read GetTimezones;
    property MovieCerts: ITMDBCertificationCountries read GetMovieCerts;
    property TVCerts: ITMDBCertificationCountries read GetTVCerts;
    property MovieGenres: ITMDBGenres read GetMovieGenres;
    property TVGenres: ITMDBGenres read GetTVGenres;
  end;



  /// <summary>
  /// Encapsulates a TMDB user authentication and account info.
  /// </summary>
  ITMDBLoginState = interface
    ['{FCFBEAC1-3256-4574-9F6F-C5ACF0721BB3}']
    function GetOwner: ITMDBClient;
    function GetAuthMethod: TTMDBUserAuth; stdcall;
    procedure SetAuthMethod(const Value: TTMDBUserAuth); stdcall;
    function GetIsAuthenticated: Boolean; stdcall;
    function GetIsGuest: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetAccountID: Integer; stdcall;
    function GetAccountDetail: ITMDBAccountDetail; stdcall;

    function LoginAsGuest: ITMDBAuthGuestSessionResult; stdcall;
    function LoginAsUser: ITMDBAuthSessionResult; stdcall;
    function LoginAsCreds(const Username, Password: WideString): ITMDBAuthSessionResult; stdcall;
    function Logout: Boolean; stdcall;

    function RestoreSession(const SessionID: WideString): Boolean; stdcall;

    property AuthMethod: TTMDBUserAuth read GetAuthMethod write SetAuthMethod;
    property IsAuthenticated: Boolean read GetIsAuthenticated;
    property IsGuest: Boolean read GetIsGuest;
    property SessionID: WideString read GetSessionID;
    property AccountID: Integer read GetAccountID;
    property AccountDetail: ITMDBAccountDetail read GetAccountDetail;
  end;



  /// <summary>
  /// The core interface-based implementation of the TMDB API wrapper.
  /// </summary>
  ITMDBClient = interface
    ['{FB7CAA70-63BE-4BAC-9BE8-4E0E0225A9C3}']

    { Authentication }

    function GetAppUserAgent: WideString; stdcall;
    procedure SetAppUserAgent(const Value: WideString); stdcall;
    function GetAPIKey: WideString; stdcall;
    procedure SetAPIKey(const Value: WideString); stdcall;
    function GetAccessToken: WideString; stdcall;
    procedure SetAccessToken(const Value: WideString); stdcall;
    function GetAuthMethod: TTMDBAuthMethod; stdcall;
    procedure SetAuthMethod(const Value: TTMDBAuthMethod); stdcall;
    function GetUserAuth: TTMDBUserAuth; stdcall;
    procedure SetUserAuth(const Value: TTMDBUserAuth); stdcall;
    function GetCache: ITMDBCache; stdcall;
    function GetLoginState: ITMDBLoginState; stdcall;
    function GetOnUserAuthRequest: TTMDBUserAuthRequestEvent; stdcall;
    procedure SetOnUserAuthRequest(const Value: TTMDBUserAuthRequestEvent); stdcall;
    function GetRateLimiting: Boolean; stdcall;
    procedure SetRateLimiting(const Value: Boolean); stdcall;
    function GetRateLimitMsec: DWORD; stdcall;
    procedure SetRateLimitMsec(const Value: DWORD); stdcall;
    function GetAgreedToWatchProviderAttribution: Boolean; stdcall;
    procedure SetAgreedToWatchProviderAttribution(const Value: Boolean); stdcall;

    { Namespaces }

    function Account: ITMDBNamespaceAccount; stdcall;
    function Authentication: ITMDBNamespaceAuthentication; stdcall;
    function Certifications: ITMDBNamespaceCertifications; stdcall;
    function Changes: ITMDBNamespaceChanges; stdcall;
    function Collections: ITMDBNamespaceCollections; stdcall;
    function Companies: ITMDBNamespaceCompanies; stdcall;
    function Configuration: ITMDBNamespaceConfiguration; stdcall;
    function Credits: ITMDBNamespaceCredits; stdcall;
    function Discover: ITMDBNamespaceDiscover; stdcall;
    function Find: ITMDBNamespaceFind; stdcall;
    function Genres: ITMDBNamespaceGenres; stdcall;
    function GuestSessions: ITMDBNamespaceGuestSessions; stdcall;
    function Keywords: ITMDBNamespaceKeywords; stdcall;
    function Lists: ITMDBNamespaceLists; stdcall;
    function MovieLists: ITMDBNamespaceMovieLists; stdcall;
    function Movies: ITMDBNamespaceMovies; stdcall;
    function Networks: ITMDBNamespaceNetworks; stdcall;
    function PeopleLists: ITMDBNamespacePeopleLists; stdcall;
    function People: ITMDBNamespacePeople; stdcall;
    function Reviews: ITMDBNamespaceReviews; stdcall;
    function Search: ITMDBNamespaceSearch; stdcall;
    function Trending: ITMDBNamespaceTrending; stdcall;
    function TVSeriesLists: ITMDBNamespaceTVSeriesLists; stdcall;
    function TVSeries: ITMDBNamespaceTVSeries; stdcall;
    function TVSeasons: ITMDBNamespaceTVSeasons; stdcall;
    function TVEpisodes: ITMDBNamespaceTVEpisodes; stdcall;
    function TVEpisodeGroups: ITMDBNamespaceTVEpisodeGroups; stdcall;
    function WatchProviders: ITMDBNamespaceWatchProviders; stdcall;

    property AppUserAgent: WideString read GetAppUserAgent write SetAppUserAgent;
    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;
    property Cache: ITMDBCache read GetCache;
    property LoginState: ITMDBLoginState read GetLoginState;
    property RateLimiting: Boolean read GetRateLimiting write SetRateLimiting;
    property RateLimitMsec: DWORD read GetRateLimitMsec write SetRateLimitMsec;
    property AgreedToWatchProviderAttribution: Boolean
      read GetAgreedToWatchProviderAttribution write SetAgreedToWatchProviderAttribution;

    function GetImage(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;

    property OnUserAuthRequest: TTMDBUserAuthRequestEvent
      read GetOnUserAuthRequest write SetOnUserAuthRequest;
  end;

{$ENDREGION}



implementation

end.
