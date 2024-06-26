unit JD.TMDB.Impl;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  ----------------------------------------------------------------------------
  TMDB Interfaced Object Implementation
  ----------------------------------------------------------------------------

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.TMDB.API, JD.TMDB.Intf,
  XSuperObject,
  XSuperJSON,
  JD.TMDB.Common;

type

{$REGION 'Forward Definitions'}
  TTMDBItem = class;
  TTMDBItems = class;
  TTMDBPage = class;
  TTMDBDetail = class;
  TTMDBMedium = class;
  TTMDBMedia = class;
  TTMDBMediaPage = class;
  TTMDBAlternativeTitle = class;
  TTMDBAlternativeTitles = class;
  TTMDBAccountDetail = class;
  TTMDBAccountAddFavoriteResult = class;
  TTMDBAccountAddWatchlistResult = class;
  TTMDBAccountStates = class;
  TTMDBAuthGuestSessionResult = class;
  TTMDBAuthRequestTokenResult = class;
  TTMDBAuthSessionResult = class;
  TTMDBAuthSessionResultLogin = class;
  TTMDBAuthDeleteSessionResult = class;
  TTMDBAuthValidateKeyResult = class;
  TTMDBCertification = class;
  TTMDBCertificationCountry = class;
  TTMDBCertificationCountries = class;
  TTMDBReleaseDate = class;
  TTMDBReleaseDateCountry = class;
  TTMDBReleaseDateCountries = class;
  //TTMDBChangeValue = class;
  //TTMDBChangeRecord = class;
  TTMDBChange = class;
  TTMDBChanges = class;
  TTMDBChangePage = class;
  //TTMDBChangeDetail = class;
  TTMDBTranslationData = class;
  TTMDBMovieTranslationData = class;
  TTMDBCollectionTranslationData = class;
  TTMDBPersonTranslationData = class;
  TTMDBTVSeriesTranslationData = class;
  TTMDBTVSeasonTranslationData = class;
  TTMDBTVEpisodeTranslationData = class;
  TTMDBTranslation = class;
  TTMDBTranslations = class;
  TTMDBCollection = class;
  TTMDBCollections = class;
  TTMDBCollectionPage = class;
  TTMDBCollectionPart = class;
  TTMDBCollectionDetail = class;
  TTMDBCompany = class;
  TTMDBCompanies = class;
  TTMDBCompanyPage = class;
  TTMDBCompanyDetail = class;
  TTMDBConfigurationImages = class;
  TTMDBConfiguration = class;
  TTMDBCountry = class;
  TTMDBCountries = class;
  TTMDBJobDepartment = class;
  TTMDBJobDepartments = class;
  TTMDBLanguage = class;
  TTMDBLanguages = class;
  TTMDBTimezone = class;
  TTMDBTimezones = class;
  TTMDBGenre = class;
  TTMDBGenres = class;
  TTMDBKeyword = class;
  TTMDBKeywords = class;
  TTMDBKeywordPage = class;
  TTMDBKeywordDetail = class;
  TTMDBMediaImage = class;
  TTMDBMediaImages = class;
  TTMDBMediaImageGroup = class;
  TTMDBVideo = class;
  TTMDBVideos = class;
  TTMDBPerson = class;
  TTMDBPeople = class;
  TTMDBPersonPage = class;
  //TTMDBPersonDetail = class;
  TTMDBCastPerson = class;
  TTMDBCastPeople = class;
  TTMDBCrewPerson = class;
  TTMDBCrewPeople = class;
  TTMDBCredits = class;
  TTMDBMovie = class;
  TTMDBMovies = class;
  TTMDBMoviePage = class;
  TTMDBRatedMovie = class;
  TTMDBRatedMovies = class;
  TTMDBRatedMoviePage = class;
  TTMDBMovieCollectionRef = class;
  TTMDBMovieDetail = class;
  TTMDBDateRange = class;
  TTMDBDatedMoviePage = class;
  TTMDBTVNetwork = class;
  TTMDBTVNetworks = class;
  TTMDBTVNetworkDetail = class;
  //TTMDBContentRating = class;
  //TTMDBContentRatings = class;
  TTMDBTVSerie = class;
  TTMDBTVSeries = class;
  TTMDBTVSeriesPage = class;
  TTMDBRatedTVSerie = class;
  TTMDBRatedTVSeries = class;
  TTMDBRatedTVSeriesPage = class;
  TTMDBTVSerieDetail = class;
  //TTMDBTVSeason = class;
  //TTMDBTVSeasons = class;
  //TTMDBTVSeasonPage = class;
  //TTMDBTVSeasonDetail = class;
  TTMDBTVEpisode = class;
  TTMDBTVEpisodes = class;
  TTMDBTVEpisodePage = class;
  TTMDBRatedTVEpisode = class;
  TTMDBRatedTVEpisodes = class;
  TTMDBTVEpisodeDetail = class;
  TTMDBTVEpisodeGroup = class;
  TTMDBTVEpisodeGroups = class;
  TTMDBList = class;
  TTMDBLists = class;
  TTMDBListPage = class;
  TTMDBListDetail = class;
  //TTMDBDiscoverMoviesParams = class;
  //TTMDBDiscoverTVParams = class;
  //TTMDBDiscoverMovie = class;
  //TTMDBDiscoverMovies = class;
  //TTMDBDiscoverMoviePage = class;
  //TTMDBDiscoverTVSerie = class;
  //TTMDBDiscoverTVSeries = class;
  //TTMDBDiscoverTVSeriesPage = class;
  //TTMDBFindResults = class;
  TTMDBWatchProviderPriority = class;
  TTMDBWatchProviderPriorities = class;
  TTMDBWatchProvider = class;
  TTMDBWatchProviders = class;
  TTMDBService = class;
  TTMDBServiceAccount = class;
  TTMDBServiceAuthentication = class;
  TTMDBServiceCertifications = class;
  TTMDBServiceChanges = class;
  TTMDBServiceCollections = class;
  TTMDBServiceCompanies = class;
  TTMDBServiceConfiguration = class;
  TTMDBServiceCredits = class;
  TTMDBServiceDiscover = class;
  TTMDBServiceFind = class;
  TTMDBServiceGenres = class;
  TTMDBServiceGuestSessions = class;
  TTMDBServiceKeywords = class;
  TTMDBServiceLists = class;
  TTMDBServiceMovieLists = class;
  TTMDBServiceMovies = class;
  TTMDBServiceNetworks = class;
  TTMDBServicePeopleLists = class;
  TTMDBServicePeople = class;
  TTMDBServiceReviews = class;
  TTMDBServiceSearch = class;
  TTMDBServiceTrending = class;
  TTMDBServiceTVSeriesLists = class;
  TTMDBServiceTVSeries = class;
  TTMDBServiceTVSeasons = class;
  TTMDBServiceTVEpisodes = class;
  TTMDBServiceTVEpisodeGroups = class;
  TTMDBServiceWatchProviders = class;
  TTMDBServiceImages = class;
  TTMDBCache = class;
  TTMDBLoginState = class;
  TTMDBClient = class;

{$ENDREGION}



{$REGION 'Common'}

  TTMDBItemClass = class of TTMDBItem;

  TTMDBItemsClass = class of TTMDBItems;

  TTMDBItem = class(TInterfacedObject, ITMDBItem)
  private
    FTMDB: ITMDBClient;
    FObj: ISuperObject;
    FOwner: ITMDBItems;
    FIndex: Integer;
  protected
    function GetOwner: ITMDBItems; stdcall;
    function GetIndex: Integer; stdcall;
  public
    constructor Create(AOwner: ITMDBItems; AObj: ISuperObject;
      const AIndex: Integer; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property Owner: ITMDBItems read GetOwner;
    property Index: Integer read GetIndex;
  end;

  TTMDBItems = class(TInterfacedObject, ITMDBItems)
  private
    FTMDB: ITMDBClient;
    FObj: ISuperArray;
    FList: TInterfaceList;
    FItemClass: TTMDBItemClass;
    procedure PopulateItems; virtual;
    procedure ClearItems; virtual;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; ATMDB: ITMDBClient;
      AItemClass: TTMDBItemClass); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBItem read GetItem; default;
  end;

  TTMDBPage = class(TInterfacedObject, ITMDBPage)
  private
    FObj: ISuperObject;
    FItems: ITMDBItems;
  protected
    function GetPage: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItems: ITMDBItems;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient;
      AItemClass: TTMDBItemClass; AItemsClass: TTMDBItemsClass); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items: ITMDBItems read GetItems;
  end;

  TTMDBDetail = class(TInterfacedObject, ITMDBDetail)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
  protected
    function GetID: Integer; stdcall; //NOTE: Some use string for "id"
    function GetTitle: WideString; stdcall; //NOTE: Shared between "name" and "title"
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
  end;

{$ENDREGION}



{$REGION 'Media Base Related'}

  TTMDBMedium = class(TTMDBItem, ITMDBMedium)
  protected
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetAdult: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetPopularity: Single; stdcall;
  public
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

  TTMDBMedia = class(TTMDBItems, ITMDBMedia)
  private
    procedure PopulateItems; override;
  protected
    function GetItem(const Index: Integer): ITMDBMedium; stdcall;
  public
    property Items[const Index: Integer]: ITMDBMedium read GetItem; default;
  end;

  TTMDBMediaPage = class(TTMDBPage, ITMDBMediaPage)
  protected
    function GetItems: ITMDBMedia; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient;
      AItemClass: TTMDBItemClass; AItemsClass: TTMDBItemsClass); override;
    destructor Destroy; override;

    property Items: ITMDBMedia read GetItems;
  end;

{$ENDREGION}



{$REGION 'Account Related'}

  TTMDBAccountDetail = class(TTMDBDetail, ITMDBAccountDetail)
  protected
    function GetUserName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);

    property UserName: WideString read GetUserName;
    property IncludeAdult: Boolean read GetIncludeAdult;
    property CountryCode: WideString read GetCountryCode;
    property LanguageCode: WideString read GetLanguageCode;
    property GravatarHash: WideString read GetGravatarHash;
    property TMDBAvatarPath: WideString read GetTMDBAvatarPath;
  end;

  TTMDBAccountAddFavoriteResult = class(TInterfacedObject, ITMDBAccountAddFavoriteResult)
  private
    FObj: ISuperObject;
  protected
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  TTMDBAccountAddWatchlistResult = class(TInterfacedObject, ITMDBAccountAddWatchlistResult)
  private
    FObj: ISuperObject;
  protected
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  TTMDBAccountStates = class(TInterfacedObject, ITMDBAccountStates)
  private
    FObj: ISuperObject;
  protected
    function GetFavorite: Boolean; stdcall;
    function GetRatedValue: Single; stdcall;
    function GetWatchlist: Boolean; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Favorite: Boolean read GetFAvorite;
    property RatedValue: Single read GetRatedValue;
    property Watchlist: Boolean read GetWatchlist;
  end;

{$ENDREGION}



{$REGION 'Authentication Related'}

  TTMDBAuthGuestSessionResult = class(TInterfacedObject, ITMDBAuthGuestSessionResult)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetGuestSessionID: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property GuestSessionID: WideString read GetGuestSessionID;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  TTMDBAuthRequestTokenResult = class(TInterfacedObject, ITMDBAuthRequestTokenResult)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property RequestToken: WideString read GetRequestToken;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  TTMDBAuthSessionResult = class(TInterfacedObject, ITMDBAuthSessionResult)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property SessionID: WideString read GetSessionID;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  TTMDBAuthSessionResultLogin = class(TInterfacedObject, ITMDBAuthSessionResultLogin)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetExpiresAt: TDateTime; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property ExpiresAt: TDateTime read GetExpiresAt;
    property RequestToken: WideString read GetRequestToken;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  TTMDBAuthDeleteSessionResult = class(TInterfacedObject, ITMDBAuthDeleteSessionResult)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  TTMDBAuthValidateKeyResult = class(TInterfacedObject, ITMDBAuthValidateKeyResult)
  private
    FObj: ISuperObject;
  protected
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

{$ENDREGION}



{$REGION 'Alternative Title Related'}

  TTMDBAlternativeTitle = class(TTMDBItem, ITMDBAlternativeTitle)
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetType: WideString; stdcall;
  public
    property ISO3166_1: WideString read GetISO3166_1;
    property Title: WideString read GetTitle;
    property &Type: WideString read GetType;
  end;

  TTMDBAlternativeTitles = class(TTMDBItems, ITMDBAlternativeTitles)
  protected
    function GetItem(const Index: Integer): ITMDBAlternativeTitle; stdcall;
  public
    property Items[const Index: Integer]: ITMDBAlternativeTitle read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Certification Related'}

  TTMDBCertification = class(TInterfacedObject, ITMDBCertification)
  private
    FObj: ISuperObject;
    FOwner: ITMDBCertificationCountry;
  protected
    function GetCertification: WideString; stdcall;
    function GetMeaning: WideString; stdcall;
    function GetOrder: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject; AOwner: ITMDBCertificationCountry); virtual;
    destructor Destroy; override;

    property Certification: WideString read GetCertification;
    property Meaning: WideString read GetMeaning;
    property Order: Integer read GetOrder;
  end;

  TTMDBCertificationCountry = class(TInterfacedObject, ITMDBCertificationCountry)
  private
    FObj: ISuperArray;
    FOwner: ITMDBCertificationCountries;
    FItems: TInterfaceList;
    FCountryCode: WideString;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertification; stdcall;
  public
    constructor Create(AObj: ISuperArray; AOwner: ITMDBCertificationCountries;
      const CountryCode: WideString); virtual;
    destructor Destroy; override;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertification read GetItem;
  end;

  TTMDBCertificationCountries = class(TInterfacedObject, ITMDBCertificationCountries)
  private
    FObj: ISuperObject;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertificationCountry; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationCountry read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Release Date Related'}

  TTMDBReleaseDate = class(TInterfacedObject, ITMDBReleaseDate)
  private
    FObj: ISuperObject;
    FOwner: TTMDBReleaseDateCountry;
  protected
    function GetCertification: WideString; stdcall;
    function GetDescriptors: TTMDBStrArray; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetNote: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetType: TTMDBReleaseType; stdcall;
  public
    constructor Create(AObj: ISuperObject; AOwner: TTMDBReleaseDateCountry); virtual;
    destructor Destroy; override;

    property Certification: WideString read GetCertification;
    property Descriptors: TTMDBStrArray read GetDescriptors;
    property ISO639_1: WideString read GetISO639_1;
    property Note: WideString read GetNote;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property ReleaseType: TTMDBReleaseType read GetType;
  end;

  TTMDBReleaseDateCountry = class(TInterfacedObject, ITMDBReleaseDateCountry)
  private
    FObj: ISuperArray;
    FOwner: TTMDBReleaseDateCountries;
    FItems: TInterfaceList;
    FCountryCode: WideString;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDate; stdcall;
  public
    constructor Create(AObj: ISuperArray; AOwner: TTMDBReleaseDateCountries;
      const CountryCode: WideString); virtual;
    destructor Destroy; override;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDate read GetItem;
  end;

  TTMDBReleaseDateCountries = class(TInterfacedObject, ITMDBReleaseDateCountries)
  private
    FObj: ISuperArray;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDateCountry; stdcall;
  public
    constructor Create(AObj: ISuperArray); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDateCountry read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Change Related'}

  TTMDBChange = class(TTMDBItem, ITMDBChange)
  protected
    function GetKey: WideString; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;
  public
    constructor Create(AOwner: ITMDBItems; AObj: ISuperObject;
      const AIndex: Integer; ATMDB: ITMDBClient); override;
    destructor Destroy; override;
  end;

  TTMDBChanges = class(TTMDBItems, ITMDBChanges)
  protected
    function GetItem(const Index: Integer): ITMDBChange; stdcall;
  public
    property Items[const Index: Integer]: ITMDBChange read GetItem; default;
  end;

  TTMDBChangePage = class(TTMDBPage, ITMDBChangePage)
  protected
    function GetItems: ITMDBChanges; stdcall;
  public
    property Items: ITMDBChanges read GetItems;
  end;

{$ENDREGION}



{$REGION 'Company Related'}

  TTMDBCompany = class(TTMDBItem, ITMDBCompany)
  protected
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
  public
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  TTMDBCompanies = class(TTMDBItems, ITMDBCompanies)
  protected
    function GetItem(const Index: Integer): ITMDBCompany; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCompany read GetItem; default;
  end;

  TTMDBCompanyPage = class(TTMDBPage, ITMDBCompanyPage)
  protected
    function GetItems: ITMDBCompanies; stdcall;
  public
    property Items: ITMDBCompanies read GetItems;
  end;

  TTMDBCompanyDetail = class(TInterfacedObject, ITMDBCompanyDetail)
  private
    FObj: ISuperObject;
  protected
    function GetDescription: WideString; stdcall;
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
    function GetParentCompany: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

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

  TTMDBConfigurationImages = class(TInterfacedObject, ITMDBConfigurationImages)
  private
    FOwner: ITMDBConfiguration;
    FObj: ISuperObject;
  protected
    function GetBaseURL: WideString; stdcall;
    function GetSecureBaseURL: WideString; stdcall;
    function GetBackdropSizes: TTMDBStrArray; stdcall;
    function GetLogoSizes: TTMDBStrArray; stdcall;
    function GetPosterSizes: TTMDBStrArray; stdcall;
    function GetProfileSizes: TTMDBStrArray; stdcall;
    function GetStillSizes: TTMDBStrArray; stdcall;
  public
    constructor Create(AOwner: ITMDBConfiguration; AObj: ISuperObject);

    property BaseURL: WideString read GetBaseURL;
    property SecureBaseURL: WideString read GetSecureBaseURL;
    property BackdropSizes: TTMDBStrArray read GetBackdropSizes;
    property LogoSizes: TTMDBStrArray read GetLogoSizes;
    property PosterSizes: TTMDBStrArray read GetPosterSizes;
    property ProfileSizes: TTMDBStrArray read GetProfileSizes;
    property StillSizes: TTMDBStrArray read GetStillSizes;
  end;

  TTMDBConfiguration = class(TInterfacedObject, ITMDBConfiguration)
  private
    FObj: ISuperObject;
    FImages: ITMDBConfigurationImages;
  protected
    function GetImages: ITMDBConfigurationImages; stdcall;
    function GetChangeKeys: TTMDBStrArray; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;
    property Images: ITMDBConfigurationImages read GetImages;
    property ChangeKeys: TTMDBStrArray read GetChangeKeys;
  end;

{$ENDREGION}



{$REGION 'Country Related'}

  TTMDBCountry = class(TTMDBItem, ITMDBCountry)
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetNativeName: WideString; stdcall;
  public
    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;

  TTMDBCountries = class(TTMDBItems, ITMDBCountries)
  protected
    function GetItem(const Index: Integer): ITMDBCountry; stdcall;
  public
    function GetByCode(const Code: WideString): ITMDBCountry; stdcall;

    property Items[const Index: Integer]: ITMDBCountry read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Genre Related'}

  TTMDBGenre = class(TTMDBItem, ITMDBGenre)
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  TTMDBGenres = class(TTMDBItems, ITMDBGenres)
  private
    FMediaType: TTMDBMediaType;
  protected
    function GetItem(const Index: Integer): ITMDBGenre; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
  public
    constructor Create(AObj: ISuperArray; ATMDB: ITMDBClient;
      AMediaType: TTMDBMediaType); reintroduce;

    property Items[const Index: Integer]: ITMDBGenre read GetItem;
    property MediaType: TTMDBMediaType read GetMediaType;
  end;

{$ENDREGION}



{$REGION 'Images Related'}

  TTMDBMediaImage = class(TTMDBItem, ITMDBMediaImage)
  protected
    function GetAspectRatio: Single; stdcall;
    function GetHeight: Integer; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetFilePath: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetWidth: Integer; stdcall;
  public
    property AspectRatio: Single read GetAspectRatio;
    property Height: Integer read GetHeight;
    property ISO639_1: WideString read GetISO639_1;
    property FilePath: WideString read GetFilePath;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property Width: Integer read GetWidth;
  end;

  TTMDBMediaImages = class(TTMDBItems, ITMDBMediaImages)
  protected
    function GetItem(const Index: Integer): ITMDBMediaImage; stdcall;
  public
    property Items[const Index: Integer]: ITMDBMediaImage read GetItem; default;
  end;

  TTMDBMediaImageGroup = class(TInterfacedObject, ITMDBMediaImageGroup)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FBackdrops: ITMDBMediaImages;
    FLogos: ITMDBMediaImages;
    FPosters: ITMDBMediaImages;
  protected
    function GetBackdrops: ITMDBMediaImages; stdcall;
    function GetLogos: ITMDBMediaImages; stdcall;
    function GetPosters: ITMDBMediaImages; stdcall;
    function GetID: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property Backdrops: ITMDBMediaImages read GetBackdrops;
    property Logos: ITMDBMediaImages read GetLogos;
    property Posters: ITMDBMediaImages read GetPosters;
    property ID: Integer read GetID;
  end;

{$ENDREGION}



{$REGION 'Job / Department Related'}

  TTMDBJobDepartment = class(TTMDBItem, ITMDBJobDepartment)
  protected
    function GetDepartment: WideString; stdcall;
    function GetJobs: TTMDBStrArray; stdcall;
  public
    property Department: WideString read GetDepartment;
    property Jobs: TTMDBStrArray read GetJobs;
  end;

  TTMDBJobDepartments = class(TTMDBItems, ITMDBJobDepartments)
  protected
    function GetItem(const Index: Integer): ITMDBJobDepartment; stdcall;
  public
    property Items[const Index: Integer]: ITMDBJobDepartment read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Keyword Related'}

  TTMDBKeyword = class(TTMDBItem, ITMDBKeyword)
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  TTMDBKeywords = class(TTMDBItems, ITMDBKeywords)
  protected
    function GetItem(const Index: Integer): ITMDBKeyword; stdcall;
  public
    property Items[const Index: Integer]: ITMDBKeyword read GetItem; default;
  end;

  TTMDBKeywordPage = class(TTMDBPage, ITMDBKeywordPage)
  protected
    function GetItems: ITMDBKeywords; stdcall;
  public
    property Items: ITMDBKeywords read GetItems;
  end;

  TTMDBKeywordDetail = class(TInterfacedObject, ITMDBKeywordDetail)
  private
    FObj: ISuperObject;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

{$ENDREGION}



{$REGION 'Language Related'}

  TTMDBLanguage = class(TTMDBItem, ITMDBLanguage)
  protected
    function GetISO639_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetName: WideString; stdcall;
  public
    property ISO639_1: WideString read GetISO639_1;
    property EnglishName: WideString read GetEnglishName;
    property Name: WideString read GetName;
  end;

  TTMDBLanguages = class(TTMDBItems, ITMDBLanguages)
  protected
    function GetItem(const Index: Integer): ITMDBLanguage; stdcall;
  public
    function GetByCode(const Code: WideString): ITMDBLanguage; stdcall;

    property Items[const Index: Integer]: ITMDBLanguage read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Timezone Related'}

  TTMDBTimezone = class(TTMDBItem, ITMDBTimezone)
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetZones: TTMDBStrArray; stdcall;
  public
    property ISO3166_1: WideString read GetISO3166_1;
    property Zones: TTMDBStrArray read GetZones;
  end;

  TTMDBTimezones = class(TTMDBItems, ITMDBTimezones)
  protected
    function GetItem(const Index: Integer): ITMDBTimezone; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTimezone read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Translation Related'}

  TTMDBTranslationData = class(TInterfacedObject, ITMDBTranslationData)
  private
    FObj: ISuperObject;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;
  end;

  TTMDBMovieTranslationData = class(TTMDBTranslationData, ITMDBMovieTranslationData)
  protected
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetRuntime: Integer; stdcall;
  public
    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
    property Runtime: Integer read GetRuntime;
  end;

  TTMDBCollectionTranslationData = class(TTMDBTranslationData, ITMDBCollectionTranslationData)
  protected
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
  public
    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
  end;

  TTMDBPersonTranslationData = class(TTMDBTranslationData, ITMDBPersonTranslationData)
  protected
    function GetBiography: WideString; stdcall;
  public
    property Biography: WideString read GetBiography;
  end;

  TTMDBTVSeriesTranslationData = class(TTMDBTranslationData, ITMDBTVSeriesTranslationData)
  protected
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;
  public
    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
  end;

  TTMDBTVSeasonTranslationData = class(TTMDBTranslationData, ITMDBTVSeasonTranslationData)
  protected
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
  public
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  TTMDBTVEpisodeTranslationData = class(TTMDBTranslationData, ITMDBTVEpisodeTranslationData)
  protected
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
  public
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  TTMDBTranslation = class(TInterfacedObject, ITMDBTranslation)
  private
    FObj: ISuperObject;
    FData: ITMDBTranslationData;
    FDataType: TTMDBTranslationType;
  protected
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
  public
    constructor Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
    destructor Destroy; override;

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

  TTMDBTranslations = class(TInterfacedObject, ITMDBTranslations)
  private
    FObj: ISuperObject;
    FItems: TInterfaceList;
    FDataType: TTMDBTranslationType;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTranslation; stdcall;
  public
    constructor Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTranslation read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Video Related'}

  TTMDBVideo = class(TTMDBItem, ITMDBVideo)
  protected
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
  public
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

  TTMDBVideos = class(TTMDBItems, ITMDBVideos)
  protected
    function GetItem(const Index: Integer): ITMDBVideo; stdcall;
  public
    property Items[const Index: Integer]: ITMDBVideo read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Discover Related'}

  TTMDBDateRange = class(TInterfacedObject, ITMDBDateRange)
  private
    FObj: ISuperObject;
  protected
    function GetMinimum: TDateTime; stdcall;
    function GetMaximum: TDateTime; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Minimum: TDateTime read GetMinimum;
    property Maximum: TDateTime read GetMaximum;
  end;

  //TTMDBDiscoverMoviesParams

  //TTMDBDiscoverTVParams

{$ENDREGION}



{$REGION 'Person Related'}

  TTMDBPerson = class(TTMDBMedium, ITMDBPerson)
  private
    FKnownFor: ITMDBMedia;
  protected
    function GetGender: TTMDBGender; stdcall;
    function GetKnownFor: ITMDBMedia; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetProfilePath: WideString; stdcall;
  public
    constructor Create(AOwner: ITMDBItems; AObj: ISuperObject;
      const AIndex: Integer; ATMDB: ITMDBClient); override;
    destructor Destroy; override;

    property Gender: TTMDBGender read GetGender;
    property KnownFor: ITMDBMedia read GetKnownFor;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property ProfilePath: WideString read GetProfilePath;
  end;

  TTMDBPeople = class(TTMDBMedia, ITMDBPeople)
  protected
    function GetItem(const Index: Integer): ITMDBPerson; stdcall;
  public
    property Items[const Index: Integer]: ITMDBPerson read GetItem; default;
  end;

  TTMDBPersonPage = class(TTMDBMediaPage, ITMDBPersonPage)
  protected
    function GetItems: ITMDBPeople; stdcall;
  public
    property Items: ITMDBPeople read GetItems;
  end;

{$ENDREGION}



{$REGION 'Credits Related'}

  TTMDBCastPerson = class(TTMDBPerson, ITMDBCastPerson)
  protected
    function GetCastID: Integer; stdcall;
    function GetCharacter: WideString; stdcall;
    function GetCreditID: WideString; stdcall;
    function GetOrder: Integer; stdcall;
  public
    property CastID: Integer read GetCastID;
    property Character: WideString read GetCharacter;
    property CreditID: WideString read GetCreditID;
    property Order: Integer read GetOrder;
  end;

  TTMDBCastPeople = class(TTMDBPeople, ITMDBCastPeople)
  private
    procedure PopulateItems; override;
  protected
    function GetItem(const Index: Integer): ITMDBCastPerson; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCastPerson read GetItem; default;
  end;

  TTMDBCrewPerson = class(TTMDBPerson, ITMDBCrewPerson)
  protected
    function GetCreditID: WideString; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetJob: WideString; stdcall;
  public
    property CreditID: WideString read GetCreditID;
    property Department: WideString read GetDepartment;
    property Job: WideString read GetJob;
  end;

  TTMDBCrewPeople = class(TTMDBPeople, ITMDBCrewPeople)
  private
    procedure PopulateItems; override;
  protected
    function GetItem(const Index: Integer): ITMDBCrewPerson; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCrewPerson read GetItem; default;
  end;

  TTMDBCredits = class(TInterfacedObject, ITMDBCredits)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FCast: ITMDBCastPeople;
    FCrew: ITMDBCrewPeople;
  protected
    function GetCast: ITMDBCastPeople; stdcall;
    function GetCrew: ITMDBCrewPeople; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property Cast: ITMDBCastPeople read GetCast;
    property Crew: ITMDBCrewPeople read GetCrew;
  end;

{$ENDREGION}



{$REGION 'Network Related'}

  TTMDBTVNetwork = class(TTMDBItem, ITMDBTVNetwork)
  protected
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
  public
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  TTMDBTVNetworks = class(TTMDBItems, ITMDBTVNetworks)
  protected
    function GetItem(const Index: Integer): ITMDBTVNetwork; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVNetwork read GetItem; default;
  end;

  TTMDBTVNetworkDetail = class(TInterfacedObject, ITMDBTVNetworkDetail)
  private
    FObj: ISuperObject;
  protected
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property Headquarters: WideString read GetHeadquarters;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

{$ENDREGION}



{$REGION 'Collection Related'}

  TTMDBCollection = class(TTMDBItem, ITMDBCollection)
  protected
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
  public
    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
  end;

  TTMDBCollections = class(TTMDBItems, ITMDBCollections)
  protected
    function GetItem(const Index: Integer): ITMDBCollection; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCollection read GetItem; default;
  end;

  TTMDBCollectionPage = class(TTMDBPage, ITMDBCollectionPage)
  protected
    function GetItems: ITMDBCollections; stdcall;
  public
    property Items: ITMDBCollections read GetItems;
  end;

  TTMDBCollectionPart = class(TInterfacedObject, ITMDBCollectionPart)
  private
    FObj: ISuperObject;
    FGenres: ITMDBGenres;
    FTMDB: ITMDBClient;
  protected
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetGenres: ITMDBGenres; stdcall;
    function GetPopularity: Single; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property MediaType: TTMDBMediaType read GetMediaType;
    property Genres: ITMDBGenres read GetGenres;
    property Popularity: Single read GetPopularity;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  TTMDBCollectionDetail = class(TInterfacedObject, ITMDBCollectionDetail)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FParts: TInterfaceList;
    procedure PopulateParts;
    procedure ClearParts;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetPartCount: Integer; stdcall;
    function GetPart(const Index: Integer): ITMDBCollectionPart; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

    function GetImages(const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations: ITMDBTranslations; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
    property PartCount: Integer read GetPartCount;
    property Parts[const Index: Integer]: ITMDBCollectionPart read GetPart; default;
  end;

{$ENDREGION}



{$REGION 'Movie Related'}

  TTMDBMovie = class(TTMDBMedium, ITMDBMovie)
  private
    FGenres: ITMDBGenres;
  protected
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
  public
    function GetDetails: ITMDBMovieDetail; stdcall;
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

  TTMDBMovies = class(TTMDBMedia, ITMDBMovies)
  protected
    function GetItem(const Index: Integer): ITMDBMovie; stdcall;
  public
    property Items[const Index: Integer]: ITMDBMovie read GetItem; default;
  end;

  TTMDBMoviePage = class(TTMDBMediaPage, ITMDBMoviePage)
  protected
    function GetItems: ITMDBMovies; stdcall;
  public
    property Items: ITMDBMovies read GetItems;
  end;

  TTMDBRatedMovie = class(TTMDBMovie, ITMDBRatedMovie)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;

  TTMDBRatedMovies = class(TTMDBMovies, ITMDBRatedMovies)
  protected
    function GetItem(const Index: Integer): ITMDBRatedMovie; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedMovie read GetItem; default;
  end;

  TTMDBRatedMoviePage = class(TTMDBMoviePage, ITMDBRatedMoviePage)
  protected
    function GetItems: ITMDBRatedMovies; stdcall;
  public
    property Items: ITMDBRatedMovies read GetItems;
  end;

  TTMDBDatedMoviePage = class(TTMDBMoviePage, ITMDBDatedMoviePage)
  private
    FDates: ITMDBDateRange;
  protected
    function GetDates: ITMDBDateRange; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); reintroduce;
    destructor Destroy; override;

    property Dates: ITMDBDateRange read GetDates;
  end;

  TTMDBMovieCollectionRef = class(TInterfacedObject, ITMDBMovieCollectionRef)
  private
    FObj: ISuperObject;
  protected
    function GetBelongsToCollection: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property BelongsToCollection: Boolean read GetBelongsToCollection;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
  end;

  TTMDBMovieDetail = class(TInterfacedObject, ITMDBMovieDetail)
  private
    FTMDB: ITMDBClient;
    FObj: ISuperObject;
    FCollection: ITMDBMovieCollectionRef;
    FGenres: ITMDBGenres;
    FProductionCompanies: ITMDBCompanies;
    FProductionCountries: ITMDBCountries;
    FSpokenLanguages: ITMDBLanguages;
  protected
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
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    //Append to Response Data
    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAlternativeTitles: ITMDBAlternativeTitles; stdcall;
    function AppendedChanges: ITMDBChangePage; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    //function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImageGroup; stdcall;
    function AppendedKeywords: ITMDBKeywords; stdcall;
    //function AppendedLists: ITMDB; stdcall;
    //function AppendedRecommendations: ITMDB; stdcall;
    function AppendedReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function AppendedReviews: ITMDB; stdcall;
    function AppendedSimilar: ITMDBMoviePage; stdcall;
    function AppendedTranslations: ITMDBTranslations; stdcall;
    function AppendedVideos: ITMDBVideos; stdcall;

    //User Media Rating Shortcuts
    function AddToFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function RemoveFromFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function AddToWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    function RemoveFromWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    //function AddRating(const Rating: Single): ITMDB...
    //function RemoveRating: ITMDB...

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



{$REGION 'TV Series Related'}

  TTMDBTVSerie = class(TTMDBMedium, ITMDBTVSerie)
  private
    FGenres: ITMDBGenres;
  protected
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
  public
    constructor Create(AOwner: ITMDBItems; AObj: ISuperObject;
      const AIndex: Integer; ATMDB: ITMDBClient); override;
    destructor Destroy; override;

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

  TTMDBTVSeries = class(TTMDBMedia, ITMDBTVSeries)
  protected
    function GetItem(const Index: Integer): ITMDBTVSerie; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVSerie read GetItem; default;
  end;

  TTMDBTVSeriesPage = class(TTMDBMediaPage, ITMDBTVSeriesPage)
  protected
    function GetItems: ITMDBTVSeries; stdcall;
  public
    property Items: ITMDBTVSeries read GetItems;
  end;



  TTMDBRatedTVSerie = class(TTMDBTVSerie, ITMDBRatedTVSerie)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;

  TTMDBRatedTVSeries = class(TTMDBTVSeries, ITMDBRatedTVSeries)
  protected
    function GetItem(const Index: Integer): ITMDBRatedTVSerie; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedTVSerie read GetItem;
  end;

  TTMDBRatedTVSeriesPage = class(TTMDBTVSeriesPage, ITMDBRatedTVSeriesPage)
  protected
    function GetItems: ITMDBTVSeries; stdcall;
  public
    property Items: ITMDBTVSeries read GetItems;
  end;



  TTMDBTVSerieDetail = class(TTMDBDetail, ITMDBTVSerieDetail)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
  protected
    function GetAdult: Boolean;
    function GetBackdropPath: WideString;
    function GetCreatedBy: ITMDBPeople;
    function GetEpisodeRunTime: TTMDBIntArray;
    function GetFirstAirDate: TDateTime;
    function GetGenres: ITMDBGenres;
    function GetHomepage: WideString;
    function GetInProduction: Boolean;
    function GetLanguages: TTMDBStrArray;
    function GetLastAirDate: TDateTime;
    function GetLastEpisodeToAir: ITMDBTVEpisode;
    function GetNextEpisodeToAir: ITMDBTVEpisode;
    function GetNetworks: ITMDBTVNetworks;
    function GetNumberOfEpisodes: Integer;
    function GetNumberOfSeasons: Integer;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString;
    function GetOriginalName: WideString;
    function GetOverview: WideString;
    function GetPopularity: Single;
    function GetPosterPath: WideString;
    function GetProductionCompanies: ITMDBCompanies;
    function GetProductionCountries: ITMDBCountries;
    //function GetSeasons: ITMDBTVSeasons;
    function GetSpokenLanguages: ITMDBLanguages;
    function GetStatus: WideString;
    function GetTagline: WideString;
    function GetType: WideString;
    function GetVoteAverage: Single;
    function GetVoteCount: Integer;

  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

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
    //TODO: Seasons
    property SpokenLanguages: ITMDBLanguages read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property SeriesType: WideString read GetType;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



{$REGION 'TV Season Related'}

{$ENDREGION}



{$REGION 'TV Episode Related'}

  TTMDBTVEpisode = class(TTMDBMedium, ITMDBTVEpisode)
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
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
  public
    property ID: Integer read GetID;
    property Name: WideString read GetName;
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

  TTMDBTVEpisodes = class(TTMDBMedia, ITMDBTVEpisodes)
  protected
    function GetItem(const Index: Integer): ITMDBTVEpisode; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVEpisode read GetItem; default;
  end;

  TTMDBTVEpisodePage = class(TTMDBMediaPage, ITMDBTVEpisodePage)
  protected
    function GetItems: ITMDBTVEpisodes; stdcall;
  public
    property Items: ITMDBTVEpisodes read GetItems;
  end;



  TTMDBRatedTVEpisode = class(TTMDBTVEpisode, ITMDBRatedTVEpisode)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;

  TTMDBRatedTVEpisodes = class(TTMDBTVEpisodes, ITMDBRatedTVEpisodes)
  protected
    function GetItem(const Index: Integer): ITMDBRatedTVEpisode; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedTVEpisode read GetItem; default;
  end;

  TTMDBRatedTVEpisodePage = class(TTMDBTVEpisodePage, ITMDBRatedTVEpisodePage)
  protected
    function GetItems: ITMDBRatedTVEpisodes; stdcall;
  public
    property Items: ITMDBRatedTVEpisodes read GetItems;
  end;

  TTMDBTVEpisodeDetail = class(TTMDBDetail, ITMDBTVEpisodeDetail)
  protected
    //TODO
  end;

{$ENDREGION}



{$REGION 'TV Episode Group Related'}

  TTMDBTVEpisodeGroups = class(TInterfacedObject, ITMDBTVEpisodeGroups)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FItems: TInterfaceList;
    FNetwork: ITMDBTVNetwork;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetDescription: WideString; stdcall;
    function GetEpisodeCount: Integer; stdcall;
    function GetGroupCount: Integer; stdcall;
    function GetGroup(const Index: Integer): ITMDBTVEpisodeGroup; stdcall;
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetNetwork: ITMDBTVNetwork; stdcall;
    function GetType: TTMDBTVEpisodeGroupType; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

    property Description: WideString read GetDescription;
    property EpisodeCount: Integer read GetEpisodeCount;
    property GroupCount: Integer read GetGroupCount;
    property Groups[const Index: Integer]: ITMDBTVEpisodeGroup read GetGroup; default;
    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Network: ITMDBTVNetwork read GetNetwork;
    property GroupType: TTMDBTVEpisodeGroupType read GetType;
  end;

  TTMDBTVEpisodeGroup = class(TInterfacedObject, ITMDBTVEpisodeGroup)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOrder: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetEpisode(const Index: Integer): ITMDBTVEpisode; stdcall;
    function GetLocked: Boolean; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Order: Integer read GetOrder;
    property Count: Integer read GetCount;
    property Episodes[const Index: Integer]: ITMDBTVEpisode read GetEpisode; default;
    property Locked: Boolean read GetLocked;
  end;

{$ENDREGION}



{$REGION 'Lists Related'}

  TTMDBList = class(TTMDBItem, ITMDBList)
  protected
    function GetDescription: WideString;
    function GetFavoriteCount: Integer;
    function GetID: Integer;
    function GetISO639_1: WideString;
    function GetListType: TTMDBListType;
    function GetName: WideString;
    function GetPosterPath: WideString;
  public
    property Description: WideString read GetDescription;
    property FavoriteCount: Integer read GetFavoriteCount;
    property ID: Integer read GetID;
    property ISO639_1: WideString read GetISO639_1;
    property ListType: TTMDBListType read GetListType;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
  end;

  TTMDBLists = class(TTMDBItems, ITMDBLists)
  protected
    function GetItem(const Index: Integer): ITMDBList; stdcall;
  public
    property Items[const Index: Integer]: ITMDBList read GetItem; default;
  end;

  TTMDBListPage = class(TTMDBPage, ITMDBListPage)
  protected
    function GetItems: ITMDBLists; stdcall;
  public
    property Items: ITMDBLists read GetItems;
  end;

  TTMDBListDetail = class(TInterfacedObject, ITMDBListDetail)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FParts: ITMDBMedia;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetParts: ITMDBMedia; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
    property Parts: ITMDBMedia read GetParts;
  end;

{$ENDREGION}



{$REGION 'Watch Provider Related'}

  TTMDBWatchProviderPriority = class(TInterfacedObject, ITMDBWatchProviderPriority)
  private
    FCountryCode: WideString;
    FPriority: Integer;
  protected
    function GetCountryCode: WideString; stdcall;
    function GetPriority: Integer; stdcall;
  public
    constructor Create(const ACountryCode: WideString; const APriority: Integer);

    property CountryCode: WideString read GetCountryCode;
    property Priority: Integer read GetPriority;
  end;

  TTMDBWatchProviderPriorities = class(TInterfacedObject, ITMDBWatchProviderPriorities)
  private
    FObj: ISuperObject;
    FItems: TInterfaceList;
    FTMDB: ITMDBClient;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderPriority; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderPriority read GetItem; default;
  end;

  TTMDBWatchProvider = class(TTMDBItem, ITMDBWatchProvider)
  private
    FDisplayPriorities: ITMDBWatchProviderPriorities;
  protected
    function GetDisplayPriorities: ITMDBWatchProviderPriorities; stdcall;
    function GetDisplayPriority: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetProviderName: WideString; stdcall;
    function GetProviderID: Integer; stdcall;
  public
    constructor Create(AOwner: ITMDBItems; AObj: ISuperObject;
      const AIndex: Integer; ATMDB: ITMDBClient); override;
    destructor Destroy; override;

    property DisplayPriorities: ITMDBWatchProviderPriorities read GetDisplayPriorities;
    property DisplayPriority: Integer read GetDisplayPriority;
    property LogoPath: WideString read GetLogoPath;
    property ProviderName: WideString read GetProviderName;
    property ProviderID: Integer read GetProviderID;
  end;

  TTMDBWatchProviders = class(TTMDBItems, ITMDBWatchProviders)
  protected
    function GetItem(const Index: Integer): ITMDBWatchProvider; stdcall;
  public
    property Items[const Index: Integer]: ITMDBWatchProvider read GetItem; default;
  end;

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'API Service Related'}

  TTMDBService = class(TInterfacedObject, ITMDBService)
  private
    FOwner: TTMDBClient;
  protected
    function GetOwner: ITMDBClient;
    property Owner: ITMDBClient read GetOwner;
  public
    constructor Create(AOwner: TTMDBClient);
    destructor Destroy; override;
  end;

  TTMDBServiceAccount = class(TTMDBService, ITMDBServiceAccount)
  protected
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

  TTMDBServiceAuthentication = class(TTMDBService, ITMDBServiceAuthentication)
  protected
    function CreateGuestSession: ITMDBAuthGuestSessionResult; stdcall;
    function CreateRequestToken: ITMDBAuthRequestTokenResult; stdcall;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin; stdcall;
    function DeleteSession(const SessionID: WideString): ITMDBAuthDeleteSessionResult; stdcall;
    function ValidateKey: ITMDBAuthValidateKeyResult; stdcall;
  end;

  TTMDBServiceCertifications = class(TTMDBService, ITMDBServiceCertifications)
  protected
    function GetMovieCertifications: ITMDBCertificationCountries; stdcall;
    function GetTVCertifications: ITMDBCertificationCountries; stdcall;
  end;

  TTMDBServiceChanges = class(TTMDBService, ITMDBServiceChanges)
  protected
    //MovieList
    //PeopleList
    //TVList
  end;

  TTMDBServiceCollections = class(TTMDBService, ITMDBServiceCollections)
  protected
    function GetDetails(const CollectionID: Integer;
      const Language: WideString = ''): ITMDBCollectionDetail; stdcall;
    function GetImages(const CollectionID: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetTranslations(const CollectionID: Integer): ITMDBTranslations; stdcall;
  end;

  TTMDBServiceCompanies = class(TTMDBService, ITMDBServiceCompanies)
  protected
    function GetDetails(const CompanyID: Integer): ITMDBCompanyDetail; stdcall;
    function GetAlternativeNames(const CompanyID: Integer): ITMDBAlternativeTitles; stdcall;
    function GetImages(const CompanyID: Integer): ITMDBMediaImageGroup; stdcall;
  end;

  TTMDBServiceConfiguration = class(TTMDBService, ITMDBServiceConfiguration)
  protected
    function GetDetails: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountries; stdcall;
    function GetJobs: ITMDBJobDepartments; stdcall;
    function GetLanguages: ITMDBLanguages; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezones; stdcall;
  end;

  TTMDBServiceCredits = class(TTMDBService, ITMDBServiceCredits)
  protected
    //GetDetails
  end;

  TTMDBServiceDiscover = class(TTMDBService, ITMDBServiceDiscover)
  protected
    //TODO: HUGE CONCEPT - Need to visit later...
    //GetMovies
    //GetTV
  end;

  TTMDBServiceFind = class(TTMDBService, ITMDBServiceFind)
  protected
    function FindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ITMDBFindResults; stdcall;
  end;

  TTMDBServiceGenres = class(TTMDBService, ITMDBServiceGenres)
  protected
    function GetMovieList(const Language: WideString = ''): ITMDBGenres; stdcall;
    function GetTVList(const Language: WideString = ''): ITMDBGenres; stdcall;
  end;

  TTMDBServiceGuestSessions = class(TTMDBService, ITMDBServiceGuestSessions)
  protected
    //GetRatedMovies
    //GetRatedTV
    //GetRatedTVEpisodes
  end;

  TTMDBServiceKeywords = class(TTMDBService, ITMDBServiceKeywords)
  protected
    function GetDetails(const KeywordID: Integer): ITMDBKeywordDetail; stdcall;
    //Movies (DEPRECATED)
  end;

  TTMDBServiceLists = class(TTMDBService, ITMDBServiceLists)
  protected
    //AddMovie
    //CheckItemStatus
    //Clear
    //Create
    //Delete
    //GetDetails
    //RemoveMovie
  end;

  TTMDBServiceMovieLists = class(TTMDBService, ITMDBServiceMovieLists)
  protected
    function GetNowPlaying(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
    function GetPopular(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetTopRated(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetUpcoming(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
  end;

  TTMDBServiceMovies = class(TTMDBService, ITMDBServiceMovies)
  protected
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
      const Language: WideString = ''; const SessionID: String = ''): ITMDBMovieDetail; stdcall;
    function GetAccountStates(const MovieID: Integer; const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetAlternativeTitles(const MovieID: Integer;
      const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    //function GetChanges(): ITMDBChangePage; stdcall;
    function GetCredits(const MovieID: Integer; const Language: String = ''): ITMDBCredits; stdcall;
    //function GetExternalIDs(const MovieID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const MovieID: Integer; const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetKeywords(const MovieID: Integer): ITMDBKeywords; stdcall;
    function GetLatest: ITMDBMovieDetail;
    //function GetLists
    //function GetRecommendations
    function GetReleaseDates(const MovieID: Integer): ITMDBReleaseDateCountries; stdcall;
    //function GetReviews
    function GetSimilar(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetTranslations(const MovieID: Integer): ITMDBTranslations; stdcall;
    function GetVideos(const MovieID: Integer; const Language: WideString = ''): ITMDBVideos; stdcall;
    //function GetWatchProviders
    //function AddRating
    //function DeleteRating
  end;

  TTMDBServiceNetworks = class(TTMDBService, ITMDBServiceNetworks)
  protected
    function GetDetails(const NetworkID: Integer): ITMDBTVNetworkDetail; stdcall;
    function GetAlternativeNames(const NetworkID: Integer): ITMDBAlternativeTitles; stdcall;
    function GetImages(const NetworkID: Integer): ITMDBMediaImageGroup; stdcall;
  end;

  TTMDBServicePeopleLists = class(TTMDBService, ITMDBServicePeopleLists)
  protected
    //GetPopular
  end;

  TTMDBServicePeople = class(TTMDBService, ITMDBServicePeople)
  protected
    //GetDetails
    //GetChanges
    //GetCombinedCredits
    //GetExternalIDs
    //GetImages
    //GetLatest
    //GetMovieCredits
    //GetTVCredits
    //GetTaggedImages [DEPRECATED]
    //GetTranslations
  end;

  TTMDBServiceReviews = class(TTMDBService, ITMDBServiceReviews)
  protected
    //function GetDetail(const ReviewID: WideString): ITMDBReviewDetail; stdcall;
  end;

  TTMDBServiceSearch = class(TTMDBService, ITMDBServiceSearch)
  protected
    function SearchCollections(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const Page: Integer = 1): ITMDBCollectionPage; stdcall;
    function SearchCompanies(const Query: WideString; const Page: Integer = 1): ITMDBCompanyPage; stdcall;
    function SearchKeywords(const Query: WideString;
      const Page: Integer = 1): ITMDBKeywordPage; stdcall;
    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function SearchMulti(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function SearchPeople(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBPersonPage; stdcall;
    function SearchTV(const Query: String; const FirstAirDateYear: Integer = 0;
      const IncludeAdult: Boolean = False; const Language: WideString = '';
      const Year: Integer = 0; const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  TTMDBServiceTrending = class(TTMDBService, ITMDBServiceTrending)
  protected
    //All
    function GetMovies(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //People
    function GetTV(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  TTMDBServiceTVSeriesLists = class(TTMDBService, ITMDBServiceTVSeriesLists)
  protected
    //GetAiringToday
    //GetOnTheAir
    //GetPopular
    //GetTopRated
  end;

  TTMDBServiceTVSeries = class(TTMDBService, ITMDBServiceTVSeries)
  protected
    function GetDetails(const SeriesID: Integer; const AppendToResponse: TTMDBTVSeriesRequests = [];
      const Language: WideString = ''): ITMDBTVSerieDetail; stdcall;
    function GetAccountStates(const SeriesID: Integer): ITMDBAccountStates; stdcall;
    //GetAggregateCredits
    function GetAlternativeTitles(const SeriesID: Integer): ITMDBAlternativeTitles; stdcall;
    //GetChanges
    //GetContentRatings
    function GetCredits(const SeriesID: Integer; const Language: WideString = ''): ITMDBCredits; stdcall;
    //GetEpisodeGroups
    //GetExternalIDs
    function GetImages(const SeriesID: Integer; const IncludeImageLanguage: WideString ='';
      const Language: WideString = ''): ITMDBMediaImageGroup; stdcall;
    function GetKeywords(const SeriesID: Integer): ITMDBKeywords; stdcall;
    function GetLatest: ITMDBTVSerieDetail; stdcall;
    //GetLists
    //GetRecommendations
    //GetReviews
    //GetScreenedTheatrically
    function GetSimilar(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    //GetTranslations
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideos; stdcall;
    //GetWatchProviders
    //AddRating
    //DeleteRating
  end;

  TTMDBServiceTVSeasons = class(TTMDBService, ITMDBServiceTVSeasons)
  protected
    //GetDetails
    //GetAccountStates
    //GetAggregateCredits
    //GetChanges
    //GetCredits
    //GetExternalIDs
    //GetImages
    //GetTranslations
    //GetVideos
    //GetWatchProviders
  end;

  TTMDBServiceTVEpisodes = class(TTMDBService, ITMDBServiceTVEpisodes)
  protected
    //GetDetails
    //GetAccountStates
    //GetChanges
    //GetCredits
    //GetExternalIDs
    //GetImages
    //GetTranslations
    //GetVideos
    //AddRating
    //DeleteRating
  end;

  TTMDBServiceTVEpisodeGroups = class(TTMDBService, ITMDBServiceTVEpisodeGroups)
  protected
    function GetDetails(const TVEpisodeGroupID: String): ITMDBTVEpisodeGroups; stdcall;
  end;

  TTMDBServiceWatchProviders = class(TTMDBService, ITMDBServiceWatchProviders)
  protected
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountries; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviders; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviders; stdcall;
  end;

  TTMDBServiceImages = class(TTMDBService, ITMDBServiceImages)
  private
    function GetImage(var Base64: WideString; const Path: WideString;
      const Size: WideString): Boolean;
  protected
    function GetBackdrop(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetLogo(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetPoster(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetProfile(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetStill(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
  end;

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'TMDB Client'}

  TTMDBCache = class(TInterfacedObject, ITMDBCache)
  private
    FOwner: TTMDBClient;
    FConfig: ITMDBConfiguration;
    FCountries: ITMDBCountries;
    FJobDepartments: ITMDBJobDepartments;
    FLanguages: ITMDBLanguages;
    FPrimaryTranslations: TTMDBStrArray;
    FTimezones: ITMDBTimezones;
    FMovieCerts: ITMDBCertificationCountries;
    FTVCerts: ITMDBCertificationCountries;
    FMovieGenres: ITMDBGenres;
    FTVGenres: ITMDBGenres;
  protected
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
  public
    constructor Create(AOwner: TTMDBClient);
    destructor Destroy; override;

    procedure RefreshAll; stdcall;
    function MovieGenre(const ID: Integer): WideString; stdcall;
    function TVGenre(const ID: Integer): WideString; stdcall;

    property Config: ITMDBConfiguration read GetConfig;
    property Countries: ITMDBCountries read GetCountries;
    property JobDepartments: ITMDBJobDepartments read GetJobDepartments;
    property Languages: ITMDBLanguages read GetLanguages;
    property PrimaryTranslations: TTMDBStrArray read GetPrimaryTranslations;
    property Timezones: ITMDBTimezones read GetTimezones;
    property MovieCerts: ITMDBCertificationCountries read GetMovieCerts;
    property TVCerts: ITMDBCertificationCountries read GetTVCerts;
    property MovieGenres: ITMDBGenres read GetMovieGenres;
    property TVGenres: ITMDBGenres read GetTVGenres;
  end;

  TTMDBLoginState = class(TInterfacedObject, ITMDBLoginState)
  private
    FOwner: TTMDBClient;
    FAuthMethod: TTMDBUserAuth;
    FIsAuthenticated: Boolean;
    FIsGuest: Boolean;
    FSessionID: WideString;
    FAccountDetail: ITMDBAccountDetail;
  protected
    function GetOwner: ITMDBClient;
    function GetAuthMethod: TTMDBUserAuth; stdcall;
    procedure SetAuthMethod(const Value: TTMDBUserAuth); stdcall;
    function GetIsAuthenticated: Boolean; stdcall;
    function GetIsGuest: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetAccountID: Integer; stdcall;
    function GetAccountDetail: ITMDBAccountDetail; stdcall;
  public
    constructor Create(AOwner: TTMDBClient);
    destructor Destroy; override;

    function LoginAsGuest: ITMDBAuthGuestSessionResult; stdcall;
    //TODO: Trigger event to open a link in a browser for user authentication
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

  TTMDBClient = class(TInterfacedObject, ITMDBClient)
  private
    FAPI: TTMDBAPI;
    FUserAuth: TTMDBUserAuth;
    FCache: ITMDBCache;
    FLoginState: ITMDBLoginState;

    FAccount: ITMDBServiceAccount;
    FAuthentication: ITMDBServiceAuthentication;
    FCertifications: ITMDBServiceCertifications;
    FChanges: ITMDBServiceChanges;
    FCollections: ITMDBServiceCollections;
    FCompanies: ITMDBServiceCompanies;
    FConfiguration: ITMDBServiceConfiguration;
    FCredits: ITMDBServiceCredits;
    FDiscover: ITMDBServiceDiscover;
    FFind: ITMDBServiceFind;
    FGenres: ITMDBServiceGenres;
    FGuestSessions: ITMDBServiceGuestSessions;
    FKeywords: ITMDBServiceKeywords;
    FLists: ITMDBServiceLists;
    FMovieLists: ITMDBServiceMovieLists;
    FMovies: ITMDBServiceMovies;
    FNetworks: ITMDBServiceNetworks;
    FPeopleLists: ITMDBServicePeopleLists;
    FPeople: ITMDBServicePeople;
    FReviews: ITMDBServiceReviews;
    FSearch: ITMDBServiceSearch;
    FTrending: ITMDBServiceTrending;
    FTVSeriesLists: ITMDBServiceTVSeriesLists;
    FTVSeries: ITMDBServiceTVSeries;
    FTVSeasons: ITMDBServiceTVSeasons;
    FTVEpisodes: ITMDBServiceTVEpisodes;
    FTVEpisodeGroups: ITMDBServiceTVEpisodeGroups;
    FWatchProviders: ITMDBServiceWatchProviders;
    FImages: ITMDBServiceImages;
    FOnUserAuthRequest: TTMDBUserAuthRequestEvent;
  protected
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

    procedure DoUserAuthRequest(const RequestToken: WideString; var Result: Boolean); virtual;
  public
    constructor Create;
    destructor Destroy; override;

    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;
    property Cache: ITMDBCache read GetCache;
    property LoginState: ITMDBLoginState read GetLoginState;

    function Account: ITMDBServiceAccount; stdcall;
    function Authentication: ITMDBServiceAuthentication; stdcall;
    function Certifications: ITMDBServiceCertifications; stdcall;
    function Changes: ITMDBServiceChanges; stdcall;
    function Collections: ITMDBServiceCollections; stdcall;
    function Companies: ITMDBServiceCompanies; stdcall;
    function Configuration: ITMDBServiceConfiguration; stdcall;
    function Credits: ITMDBServiceCredits; stdcall;
    function Discover: ITMDBServiceDiscover; stdcall;
    function Find: ITMDBServiceFind; stdcall;
    function Genres: ITMDBServiceGenres; stdcall;
    function GuestSessions: ITMDBServiceGuestSessions; stdcall;
    function Keywords: ITMDBServiceKeywords; stdcall;
    function Lists: ITMDBServiceLists; stdcall;
    function MovieLists: ITMDBServiceMovieLists; stdcall;
    function Movies: ITMDBServiceMovies; stdcall;
    function Networks: ITMDBServiceNetworks; stdcall;
    function PeopleLists: ITMDBServicePeopleLists; stdcall;
    function People: ITMDBServicePeople; stdcall;
    function Reviews: ITMDBServiceReviews; stdcall;
    function Search: ITMDBServiceSearch; stdcall;
    function Trending: ITMDBServiceTrending; stdcall;
    function TVSeriesLists: ITMDBServiceTVSeriesLists; stdcall;
    function TVSeries: ITMDBServiceTVSeries; stdcall;
    function TVSeasons: ITMDBServiceTVSeasons; stdcall;
    function TVEpisodes: ITMDBServiceTVEpisodes; stdcall;
    function TVEpisodeGroups: ITMDBServiceTVEpisodeGroups; stdcall;
    function WatchProviders: ITMDBServiceWatchProviders; stdcall;
    function Images: ITMDBServiceImages; stdcall;

    property OnUserAuthRequest: TTMDBUserAuthRequestEvent
      read GetOnUserAuthRequest write SetOnUserAuthRequest;
  end;

{$ENDREGION}



implementation

{ TTMDBItem }

constructor TTMDBItem.Create(AOwner: ITMDBItems; AObj: ISuperObject;
  const AIndex: Integer; ATMDB: ITMDBClient);
begin
  FOwner:= AOwner;
  FObj:= AObj;
  FIndex:= AIndex;
  FTMDB:= ATMDB;
end;

destructor TTMDBItem.Destroy;
begin
  FOwner:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBItem.GetIndex: Integer;
begin
  Result:= FIndex;
end;

function TTMDBItem.GetOwner: ITMDBItems;
begin
  Result:= FOwner;
end;





{ TTMDBPage }

constructor TTMDBPage.Create(AObj: ISuperObject; ATMDB: ITMDBClient;
  AItemClass: TTMDBItemClass; AItemsClass: TTMDBItemsClass);
var
  A: ISuperArray;
begin
  FObj:= AObj;
  A:= AObj.A['results'];
  FItems:= AItemsClass.Create(A, ATMDB, AItemClass);
end;

destructor TTMDBPage.Destroy;
begin
  FItems:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBPage.GetItems: ITMDBItems;
begin
  Result:= FItems;
end;

function TTMDBPage.GetPage: Integer;
begin
  Result:= FObj.I['page'];
end;

function TTMDBPage.GetTotalPages: Integer;
begin
  Result:= FObj.I['total_pages'];
end;

function TTMDBPage.GetTotalResults: Integer;
begin
  Result:= FObj.I['total_results'];
end;





{ TTMDBAlternativeTitle }

function TTMDBAlternativeTitle.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBAlternativeTitle.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

function TTMDBAlternativeTitle.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

{ TTMDBAlternativeTitles }

function TTMDBAlternativeTitles.GetItem(
  const Index: Integer): ITMDBAlternativeTitle;
begin
  Result:= (inherited GetItem(Index)) as ITMDBAlternativeTitle;
end;

{ TTMDBAccountDetail }

constructor TTMDBAccountDetail.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  inherited Create(AObj, ATMDB);

end;

function TTMDBAccountDetail.GetCountryCode: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBAccountDetail.GetGravatarHash: WideString;
begin
  Result:= FObj.O['avatar'].O['gravatar'].S['hash'];
end;

function TTMDBAccountDetail.GetIncludeAdult: Boolean;
begin
  Result:= FObj.B['include_adult'];
end;

function TTMDBAccountDetail.GetLanguageCode: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBAccountDetail.GetTMDBAvatarPath: WideString;
begin
  Result:= FObj.O['avatar'].O['tmdb'].S['avatar_path'];
end;

function TTMDBAccountDetail.GetUserName: WideString;
begin
  Result:= FObj.S['username'];
end;

{ TTMDBAccountAddFavoriteResult }

constructor TTMDBAccountAddFavoriteResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAccountAddFavoriteResult.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAccountAddFavoriteResult.GetStatusMessage: WideString;
begin
  Result:= Fobj.S['status_message'];
end;

{ TTMDBAccountAddWatchlistResult }

constructor TTMDBAccountAddWatchlistResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAccountAddWatchlistResult.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAccountAddWatchlistResult.GetStatusMessage: WideString;
begin
  Result:= Fobj.S['status_message'];
end;

{ TTMDBAuthGuestSessionResult }

constructor TTMDBAuthGuestSessionResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthGuestSessionResult.GetExpiresAt: TDateTime;
var
  S: String;
begin
  S:= FObj.S['expires_at'];
  Result:= ConvertDate(S); //TODO: Ensure this accounts for time...
end;

function TTMDBAuthGuestSessionResult.GetGuestSessionID: WideString;
begin
  Result:= FObj.S['session_id'];
end;

function TTMDBAuthGuestSessionResult.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBAuthRequestTokenResult }

constructor TTMDBAuthRequestTokenResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthRequestTokenResult.GetExpiresAt: TDateTime;
var
  S: String;
begin
  S:= FObj.S['expires_at'];
  Result:= ConvertDate(S); //TODO: Ensure this accounts for time...

end;

function TTMDBAuthRequestTokenResult.GetRequestToken: WideString;
begin
  Result:= FObj.S['request_token'];
end;

function TTMDBAuthRequestTokenResult.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBAuthSessionResult }

constructor TTMDBAuthSessionResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthSessionResult.GetSessionID: WideString;
begin
  Result:= FObj.S['session_id'];
end;

function TTMDBAuthSessionResult.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAuthSessionResult.GetStatusMessage: WideString;
begin
  Result:= FObj.S['status_message'];
end;

function TTMDBAuthSessionResult.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBAuthSessionResultLogin }

constructor TTMDBAuthSessionResultLogin.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthSessionResultLogin.GetExpiresAt: TDateTime;
var
  S: String;
begin
  S:= FObj.S['expires_at'];
  Result:= StrToDateTimeDef(S, 0);
  //TODO: This will probably fail and return 0 due to extra text in string...

end;

function TTMDBAuthSessionResultLogin.GetRequestToken: WideString;
begin
  Result:= FObj.S['request_token'];
end;

function TTMDBAuthSessionResultLogin.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAuthSessionResultLogin.GetStatusMessage: WideString;
begin
  Result:= FObj.S['status_message'];
end;

function TTMDBAuthSessionResultLogin.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBAuthDeleteSessionResult }

constructor TTMDBAuthDeleteSessionResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthDeleteSessionResult.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAuthDeleteSessionResult.GetStatusMessage: WideString;
begin
  Result:= FObj.S['status_message'];
end;

function TTMDBAuthDeleteSessionResult.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBAuthValidateKeyResult }

constructor TTMDBAuthValidateKeyResult.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAuthValidateKeyResult.GetStatusCode: Integer;
begin
  Result:= FObj.I['status_code'];
end;

function TTMDBAuthValidateKeyResult.GetStatusMessage: WideString;
begin
  Result:= FObj.S['status_message'];
end;

function TTMDBAuthValidateKeyResult.GetSuccess: Boolean;
begin
  Result:= FObj.B['success'];
end;

{ TTMDBCertificationItem }

constructor TTMDBCertification.Create(AObj: ISuperObject; AOwner: ITMDBCertificationCountry);
begin
  FObj:= AObj;
  FOwner:= AOwner;
end;

destructor TTMDBCertification.Destroy;
begin
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBCertification.GetCertification: WideString;
begin
  Result:= FObj.S['certification'];
end;

function TTMDBCertification.GetMeaning: WideString;
begin
  Result:= FObj.S['meaning'];
end;

function TTMDBCertification.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

{ TTMDBCertificationCountries }

procedure TTMDBCertificationCountries.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBCertificationCountry(FItems[X])._Release;
  end;
  FItems.Clear;
end;

constructor TTMDBCertificationCountries.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  //FItems:= TList<ITMDBCertificationCountry>.Create;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBCertificationCountries.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  FObj:= nil;
  inherited;
end;

function TTMDBCertificationCountries.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBCertificationCountries.GetItem(
  const Index: Integer): ITMDBCertificationCountry;
begin
  Result:= (FItems[Index]) as ITMDBCertificationCountry;
end;

procedure TTMDBCertificationCountries.PopulateItems;
var
  M: IMember;
  C: ISuperArray;
  I: ITMDBCertificationCountry;
begin
  Clear;
  for M in FObj['certifications'].AsObject do begin
    C:= M.AsArray;
    I:= TTMDBCertificationCountry.Create(C, Self, M.Name);
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBCertificationCountry }

constructor TTMDBCertificationCountry.Create(AObj: ISuperArray; AOwner: ITMDBCertificationCountries;
  const CountryCode: WideString);
begin
  FObj:= AObj;
  FOwner:= AOwner;
  FItems:= TInterfaceList.Create;
  FCountryCode:= CountryCode;
  PopulateItems;
end;

destructor TTMDBCertificationCountry.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

procedure TTMDBCertificationCountry.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBCertification(FItems[X])._Release;
  end;
  FItems.Clear;
end;

function TTMDBCertificationCountry.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBCertificationCountry.GetCountryCode: WideString;
begin
  Result:= FCountryCode;
end;

function TTMDBCertificationCountry.GetCountryName: WideString;
begin
  //TODO: Lookup country name based on code...

end;

function TTMDBCertificationCountry.GetItem(
  const Index: Integer): ITMDBCertification;
begin
  Result:= (FItems[Index]) as ITMDBCertification;
end;

procedure TTMDBCertificationCountry.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCertification;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCertification.Create(O, Self);
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBChangeItem }

constructor TTMDBChange.Create(AOwner: ITMDBItems; AObj: ISuperObject;
  const AIndex: Integer; ATMDB: ITMDBClient);
begin
  inherited;

end;

destructor TTMDBChange.Destroy;
begin

  inherited;
end;

function TTMDBChange.GetItem(const Index: Integer): ITMDBChangeRecord;
begin
  //Result:= (inherited GetItem(Index)) as ITMDBChangeRecord; //TODO
end;

function TTMDBChange.GetKey: WideString;
begin
  Result:= FObj.S['key'];
end;

{ TTMDBJobDepartmentList }

function TTMDBJobDepartments.GetItem(
  const Index: Integer): ITMDBJobDepartment;
begin
  Result:= (inherited GetItem(Index)) as ITMDBJobDepartment;
end;

{ TTMDBJobDepartmentItem }

function TTMDBJobDepartment.GetDepartment: WideString;
begin
  Result:= FObj.S['department'];
end;

function TTMDBJobDepartment.GetJobs: TTMDBStrArray;
var
  A: ISuperArray;
  X: Integer;
begin
  A:= FObj.A['jobs'];
  SetLength(Result, A.Length);
  for X := 0 to A.Length-1 do begin
    Result[X]:= A.S[X];
  end;
end;

{ TTMDBGenreList }

constructor TTMDBGenres.Create(AObj: ISuperArray; ATMDB: ITMDBClient;
  AMediaType: TTMDBMediaType);
begin
  inherited Create(AObj, ATMDB, TTMDBGenre);
  FMediaType:= AMediaType;
end;

function TTMDBGenres.GetItem(const Index: Integer): ITMDBGenre;
begin
  Result:= inherited GetItem(Index) as ITMDBGenre;
end;

function TTMDBGenres.GetMediaType: TTMDBMediaType;
begin
  Result:= FMediaType;
end;

{ TTMDBGenreItem }

function TTMDBGenre.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBGenre.GetName: WideString;
var
  L: ITMDBGenres;
begin
  if FObj.Null['name'] = jAssigned then
    Result:= FObj.S['name']
  else begin
    //If "name" doesn't exist, then lookup its "id" in cached genre list.
    L:= Owner as ITMDBGenres;
    case L.MediaType of
      TTMDBMediaType.mtMovie: begin
        Result:= FTMDB.Cache.MovieGenre(GetID);
      end;
      TTMDBMediaType.mtTV: begin
        Result:= FTMDB.Cache.TVGenre(GetID);
      end;
    end;
  end;
end;

{ TTMDBConfigurationImages }

constructor TTMDBConfigurationImages.Create(AOwner: ITMDBConfiguration; AObj: ISuperObject);
begin
  FOwner:= AOwner;
  FObj:= AObj;

end;

function TTMDBConfigurationImages.GetBackdropSizes: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['backdrop_sizes']);
end;

function TTMDBConfigurationImages.GetBaseURL: WideString;
begin
  Result:= FObj.S['base_url'];
end;

function TTMDBConfigurationImages.GetLogoSizes: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['logo_sizes']);
end;

function TTMDBConfigurationImages.GetPosterSizes: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['poster_sizes']);
end;

function TTMDBConfigurationImages.GetProfileSizes: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['profile_sizes']);
end;

function TTMDBConfigurationImages.GetSecureBaseURL: WideString;
begin
  Result:= FObj.S['secure_base_url'];
end;

function TTMDBConfigurationImages.GetStillSizes: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['still_sizes']);
end;

{ TTMDBConfiguration }

constructor TTMDBConfiguration.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FImages:= TTMDBConfigurationImages.Create(Self, FObj.O['images']);
end;

destructor TTMDBConfiguration.Destroy;
begin

  inherited;
end;

function TTMDBConfiguration.GetChangeKeys: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['change_keys']);
end;

function TTMDBConfiguration.GetImages: ITMDBConfigurationImages;
begin
  Result:= FImages;
end;

{ TTMDBCountryList }

function TTMDBCountries.GetByCode(const Code: WideString): ITMDBCountry;
var
  X: Integer;
begin
  Result:= nil;
  for X := 0 to Count-1 do begin
    if SameText(GetItem(X).ISO3166_1, Code) then begin
      Result:= GetItem(X);
      Break;
    end;
  end;
end;

function TTMDBCountries.GetItem(const Index: Integer): ITMDBCountry;
begin
  Result:= inherited GetItem(Index) as ITMDBCountry;
end;

{ TTMDBCountryItem }

function TTMDBCountry.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBCountry.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBCountry.GetNativeName: WideString;
begin
  Result:= FObj.S['native_name'];
end;

{ TTMDBLanguageList }

function TTMDBLanguages.GetByCode(const Code: WideString): ITMDBLanguage;
var
  X: Integer;
begin
  Result:= nil;
  for X := 0 to Count-1 do begin
    if SameText(GetItem(X).ISO639_1, Code) then begin
      Result:= GetItem(X);
      Break;
    end;
  end;
end;

function TTMDBLanguages.GetItem(const Index: Integer): ITMDBLanguage;
begin
  Result:= (inherited GetItem(Index)) as ITMDBLanguage;
end;

{ TTMDBLanguageItem }

function TTMDBLanguage.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBLanguage.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBLanguage.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBTimezoneList }

function TTMDBTimezones.GetItem(const Index: Integer): ITMDBTimezone;
begin
  Result:= (inherited GetItem(Index)) as ITMDBTimezone;
end;

{ TTMDBTimezoneItem }

function TTMDBTimezone.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBTimezone.GetZones: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['zones']);
end;

{ TTMDBMovieItem }

function TTMDBMovie.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBMovie.GetDetails: ITMDBMovieDetail;
begin
  //TODO: Keep track of ownership so this can be executed...
  //Result:= FOwner.FTMDB.Movies.GetDetails(ID);
end;

function TTMDBMovie.GetGenres: ITMDBGenres;
var
  A, A2: ISuperArray;
  O: ISuperObject;
  X: Integer;
begin
  //One-time lookup and cache...
  if FGenres = nil then begin
    A:= FObj.A['genre_ids'];
    A2:= SA([]);
    for X := 0 to A.Length-1 do begin
      O:= SO;
      O.I['id']:= A.I[X];
      A2.Add(O);
    end;
    FGenres:= TTMDBGenres.Create(A2, FTMDB, TTMDBMediaType.mtMovie);
  end;
  Result:= FGenres;
end;

function TTMDBMovie.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBMovie.GetOriginalTitle: WideString;
begin
  Result:= FObj.S['original_title'];
end;

function TTMDBMovie.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBMovie.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBMovie.GetReleaseDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['release_date']);
end;

function TTMDBMovie.GetVideo: Boolean;
begin
  Result:= FObj.B['video'];
end;

function TTMDBMovie.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBMovie.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBRatedMoviePage }

function TTMDBRatedMoviePage.GetItems: ITMDBRatedMovies;
begin
  Result:= (inherited GetItems) as ITMDBRatedMovies;
end;

{ TTMDBRatedMovieItem }

function TTMDBRatedMovie.GetRating: Single;
begin
  Result:= FObj.F['rating'];
end;

{ TTMDBMovieDetail }

constructor TTMDBMovieDetail.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
end;

destructor TTMDBMovieDetail.Destroy;
begin
  FGenres:= nil;
  FCollection:= nil;
  FProductionCompanies:= nil;
  FProductionCountries:= nil;
  FSpokenLanguages:= nil;
  inherited;
end;

function TTMDBMovieDetail.AddToFavorites: ITMDBAccountAddFavoriteResult;
begin
  Result:= FTMDB.Account.SetFavorite(FTMDB.LoginState.AccountID, TTMDBMediaType.mtMovie,
    ID, True, FTMDB.LoginState.SessionID);
end;

function TTMDBMovieDetail.AddToWatchlist: ITMDBAccountAddWatchlistResult;
begin
  Result:= FTMDB.Account.SetWatchlist(FTMDB.LoginState.AccountID, TTMDBMediaType.mtMovie,
    ID, True, FTMDB.LoginState.SessionID);
end;

function TTMDBMovieDetail.RemoveFromFavorites: ITMDBAccountAddFavoriteResult;
begin
  Result:= FTMDB.Account.SetFavorite(FTMDB.LoginState.AccountID, TTMDBMediaType.mtMovie,
    ID, False, FTMDB.LoginState.SessionID);
end;

function TTMDBMovieDetail.RemoveFromWatchlist: ITMDBAccountAddWatchlistResult;
begin
  Result:= FTMDB.Account.SetWatchlist(FTMDB.LoginState.AccountID, TTMDBMediaType.mtMovie,
    ID, False, FTMDB.LoginState.SessionID);
end;

function TTMDBMovieDetail.AppendedAccountStates: ITMDBAccountStates;
var
  O: ISuperObject;
  S: String;
begin
  Result:= nil;
  O:= FObj.O['account_states'];
  if O <> nil then begin
    S:= O.AsJSON(True);
    Result:= TTMDBAccountStates.Create(O);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedAlternativeTitles: ITMDBAlternativeTitles;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['alternative_titles'];
  if O <> nil then begin
    Result:= TTMDBAlternativeTitles.Create(O.A['titles'], FTMDB, TTMDBAlternativeTitle);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedChanges: ITMDBChangePage;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['changes'];
  if O <> nil then begin
    Result:= TTMDBChangePage.Create(O, FTMDB, TTMDBChange, TTMDBChanges);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedCredits: ITMDBCredits;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['credits'];
  if O <> nil then begin
    Result:= TTMDBCredits.Create(O, FTMDB);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedImages: ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['images'];
  if O <> nil then begin
    Result:= TTMDBMediaImageGroup.Create(O, FTMDB);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedKeywords: ITMDBKeywords;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['keywords'];
  if O <> nil then begin
    Result:= TTMDBKeywords.Create(O.A['keywords'], FTMDB, TTMDBKeyword);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedReleaseDates: ITMDBReleaseDateCountries;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['release_dates'];
  if O <> nil then begin
    Result:= TTMDBReleaseDateCountries.Create(O.A['results']);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedSimilar: ITMDBMoviePage;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['similar'];
  if O <> nil then begin
    Result:= TTMDBMoviePage.Create(O, FTMDB, TTMDBMovie, TTMDBMovies);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedTranslations: ITMDBTranslations;
var
  O: ISuperObject;
begin
  O:= FObj.O['translations'];
  if O <> nil then begin
    Result:= TTMDBTranslations.Create(O, ttMovie);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedVideos: ITMDBVideos;
var
  O: ISuperObject;
begin
  O:= FObj.O['videos'];
  if O <> nil then begin
    Result:= TTMDBVideos.Create(O.A['results'], FTMDB, TTMDBVideo);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBMovieDetail.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBMovieDetail.GetBudget: Currency;
begin
  Result:= FObj.F['budget'];
end;

function TTMDBMovieDetail.GetCollection: ITMDBMovieCollectionRef;
var
  O: ISuperObject;
begin
  if FCollection = nil then begin
    O:= FObj.O['belongs_to_collection'];
    if O <> nil then begin
      FCollection:= TTMDBMovieCollectionRef.Create(O);
    end;
  end;
  Result:= FCollection;
end;

function TTMDBMovieDetail.GetGenres: ITMDBGenres;
begin
  if FGenres = nil then begin
    FGenres:= TTMDBGenres.Create(FObj.A['genres'], FTMDB, mtMovie);
  end;
  Result:= FGenres;
end;

function TTMDBMovieDetail.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBMovieDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMovieDetail.GetIMDBID: WideString;
begin
  Result:= FObj.S['imdb_id'];
end;

function TTMDBMovieDetail.GetOriginalCountry: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['origin_country']);
end;

function TTMDBMovieDetail.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBMovieDetail.GetOriginalTitle: WideString;
begin
  Result:= FObj.S['original_title'];
end;

function TTMDBMovieDetail.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBMovieDetail.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBMovieDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBMovieDetail.GetProductionCompanies: ITMDBCompanies;
begin
  if FProductionCompanies = nil then begin
    FProductionCompanies:= TTMDBCompanies.Create(FObj.A['production_companies'],
      FTMDB, TTMDBCompany);
  end;
  Result:= FProductionCompanies;
end;

function TTMDBMovieDetail.GetProductionCountries: ITMDBCountries;
begin
  //TODO: The structure is different than ITMDBCountryList...
  if FProductionCountries = nil then begin
    FProductionCountries:= TTMDBCountries.Create(FObj.A['production_countries'],
      FTMDB, TTMDBCountry);
  end;
  Result:= FProductionCountries;
end;

function TTMDBMovieDetail.GetReleaseDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['release_date']);
end;

function TTMDBMovieDetail.GetRevenue: Currency;
begin
  Result:= FObj.F['revenue'];
end;

function TTMDBMovieDetail.GetRuntime: Integer;
begin
  Result:= FObj.I['runtime'];
end;

function TTMDBMovieDetail.GetSpokenLanguages: ITMDBLanguages;
begin
  if FSpokenLanguages = nil then begin
    FSpokenLanguages:= TTMDBLanguages.Create(FObj.A['spoken_languages'],
      FTMDB, TTMDBLanguage);
  end;
  Result:= FSpokenLanguages;
end;

function TTMDBMovieDetail.GetStatus: WideString;
begin
  Result:= FObj.S['status'];
end;

function TTMDBMovieDetail.GetTagline: WideString;
begin
  Result:= FObj.S['tagline'];
end;

function TTMDBMovieDetail.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

function TTMDBMovieDetail.GetVideo: Boolean;
begin
  Result:= FObj.B['video'];
end;

function TTMDBMovieDetail.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBMovieDetail.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBTVSeriesPage }

function TTMDBTVSeriesPage.GetItems: ITMDBTVSeries;
begin
  Result:= (inherited GetItems) as ITMDBTVSeries;
end;

{ TTMDBTVSeriesItem }

constructor TTMDBTVSerie.Create(AOwner: ITMDBItems; AObj: ISuperObject;
  const AIndex: Integer; ATMDB: ITMDBClient);
begin
  inherited;
  FGenres:= nil;
end;

destructor TTMDBTVSerie.Destroy;
begin

  FGenres:= nil;
  inherited;
end;

function TTMDBTVSerie.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBTVSerie.GetFirstAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['first_air_date']);
end;

function TTMDBTVSerie.GetGenres: ITMDBGenres;
var
  A, A2: ISuperArray;
  O: ISuperObject;
  X: Integer;
begin
  //One-time lookup and cache...
  if FGenres = nil then begin
    A:= FObj.A['genre_ids'];
    A2:= SA([]);
    for X := 0 to A.Length-1 do begin
      O:= SO;
      O.I['id']:= A.I[X];
      A2.Add(O);
    end;
    FGenres:= TTMDBGenres.Create(A2, FTMDB, TTMDBMediaType.mtTV);
  end;
  Result:= FGenres;
end;

function TTMDBTVSerie.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBTVSerie.GetOriginalName: WideString;
begin
  Result:= FObj.S['original_name'];
end;

function TTMDBTVSerie.GetOriginCountry: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['origin_country']);
end;

function TTMDBTVSerie.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVSerie.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBTVSerie.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVSerie.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBRatedTVSeriesItem }

function TTMDBRatedTVSerie.GetRating: Single;
begin
  Result:= FObj.F['rating'];
end;

{ TTMDBListItem }

function TTMDBList.GetDescription: WideString;
begin
  Result:= FObj.S['description'];
end;

function TTMDBList.GetFavoriteCount: Integer;
begin
  Result:= FObj.I['favorite_count'];
end;

function TTMDBList.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBList.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBList.GetListType: TTMDBListType;
begin
  Result:= TMDBStrToListType(FObj.S['media_type']);
end;

function TTMDBList.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBList.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBWatchProviderPriority }

constructor TTMDBWatchProviderPriority.Create(const ACountryCode: WideString;
  const APriority: Integer);
begin
  FCountryCode:= ACountryCode;
  FPriority:= APriority;
end;

function TTMDBWatchProviderPriority.GetCountryCode: WideString;
begin
  Result:= FCountryCode;
end;

function TTMDBWatchProviderPriority.GetPriority: Integer;
begin
  Result:= FPriority;
end;

{ TTMDBWatchProviderPriorities }

constructor TTMDBWatchProviderPriorities.Create(AObj: ISuperObject;
  ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBWatchProviderPriorities.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBWatchProviderPriorities.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

procedure TTMDBWatchProviderPriorities.ClearItems;
begin
  FItems.Clear;
end;

function TTMDBWatchProviderPriorities.GetItem(
  const Index: Integer): ITMDBWatchProviderPriority;
begin
  Result:= FItems[Index] as ITMDBWatchProviderPriority;
end;

{ TTMDBWatchProviderItem }

constructor TTMDBWatchProvider.Create(AOwner: ITMDBItems; AObj: ISuperObject;
  const AIndex: Integer; ATMDB: ITMDBClient);
begin
  inherited Create(AOwner, AObj, AIndex, ATMDB);
  FDisplayPriorities:= TTMDBWatchProviderPriorities.Create(FObj.O['display_priorities'],
    ATMDB);

end;

destructor TTMDBWatchProvider.Destroy;
begin

  FDisplayPriorities:= nil;
  inherited;
end;

function TTMDBWatchProvider.GetDisplayPriorities: ITMDBWatchProviderPriorities;
begin
  Result:= FDisplayPriorities;
end;

function TTMDBWatchProvider.GetDisplayPriority: Integer;
begin
  Result:= FObj.I['display_priority'];
end;

function TTMDBWatchProvider.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBWatchProvider.GetProviderID: Integer;
begin
  Result:= FObj.I['provider_id'];
end;

function TTMDBWatchProvider.GetProviderName: WideString;
begin
  Result:= FObj.S['provider_name'];
end;

{ TTMDBWatchProviderList }

function TTMDBWatchProviders.GetItem(
  const Index: Integer): ITMDBWatchProvider;
begin
  Result:= (inherited GetItem(Index)) as ITMDBWatchProvider;
end;

procedure TTMDBWatchProviderPriorities.PopulateItems;
var
  M: IMember;
  X: Integer;
  I: ITMDBWatchProviderPriority;
begin
  ClearItems;
  X:= 0;
  for M in FObj do begin
    I:= TTMDBWatchProviderPriority.Create(M.Name, M.AsInteger);
    Inc(X);
  end;

end;

























{ TTMDBAccountStates }

constructor TTMDBAccountStates.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBAccountStates.Destroy;
begin

  inherited;
end;

function TTMDBAccountStates.GetFavorite: Boolean;
begin
  Result:= FObj.B['favorite'];
end;

function TTMDBAccountStates.GetRatedValue: Single;
var
  O: ISuperObject;
  T: TVarType;
begin
  Result:= 0;
  try
    T:= FObj.GetType('rated');
    if T = varObject then begin
      if FObj.Null['rated'] <> jUnAssigned then begin
        O:= FObj.O['rated'];
        if O <> nil then
          Result:= O.F['value'];
      end;
    end;
  except
    on E: Exception do begin
      //TODO
    end;
  end;
end;

function TTMDBAccountStates.GetWatchlist: Boolean;
begin
  Result:= FObj.B['watchlist'];
end;

{ TTMDBCredits }

constructor TTMDBCredits.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FCast:= TTMDBCastPeople.Create(FObj.A['cast'], FTMDB, TTMDBCastPerson);
  FCrew:= TTMDBCrewPeople.Create(FObj.A['crew'], FTMDB, TTMDBCrewPerson);
end;

destructor TTMDBCredits.Destroy;
begin
  FCrew:= nil;
  FCast:= nil;
  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBCredits.GetCast: ITMDBCastPeople;
begin
  Result:= FCast;
end;

function TTMDBCredits.GetCrew: ITMDBCrewPeople;
begin
  Result:= FCrew;
end;

{ TTMDBPersonItem }

constructor TTMDBPerson.Create(AOwner: ITMDBItems; AObj: ISuperObject;
  const AIndex: Integer; ATMDB: ITMDBClient);
begin
  inherited Create(AOwner, AObj, AIndex, ATMDB);
  FKnownFor:= nil;

end;

destructor TTMDBPerson.Destroy;
begin

  FKnownFor:= nil;
  inherited;
end;

function TTMDBPerson.GetGender: TTMDBGender;
begin
  Result:= TTMDBGender(FObj.I['gender']);
end;

function TTMDBPerson.GetKnownFor: ITMDBMedia;
begin
  if FKnownFor = nil then begin
    FKnownFor:= TTMDBMedia.Create(FObj.A['known_for'], FTMDB, TTMDBMedium);
  end;
  Result:= FKnownFor;
end;

function TTMDBPerson.GetKnownForDepartment: WideString;
begin
  Result:= FObj.S['known_for_department'];
end;

function TTMDBPerson.GetProfilePath: WideString;
begin
  Result:= FObj.S['profile_path'];
end;

{ TTMDBPersonList }

function TTMDBPeople.GetItem(const Index: Integer): ITMDBPerson;
begin
  Result:= inherited GetItem(Index) as ITMDBPerson;
end;

{ TTMDBItems }

constructor TTMDBItems.Create(AObj: ISuperArray; ATMDB: ITMDBClient;
  AItemClass: TTMDBItemClass);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FItemClass:= AItemClass;
  FList:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBItems.Destroy;
begin
  ClearItems;
  FObj:= nil;
  FTMDB:= nil;
  FreeAndNil(FList);
  inherited;
end;

function TTMDBItems.GetCount: Integer;
begin
  Result:= FList.Count;
end;

function TTMDBItems.GetItem(const Index: Integer): ITMDBItem;
begin
  Result:= (FList[Index]) as ITMDBItem;
end;

procedure TTMDBItems.ClearItems;
var
  X: Integer;
begin
  for X := 0 to FList.Count-1 do begin
    ITMDBItem(FList[X])._Release;
  end;
  FList.Clear;
end;

procedure TTMDBItems.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= FItemClass.Create(Self, O, X, FTMDB);
    I._AddRef;
    FList.Add(I);
  end;
end;

{ TTMDBCastItem }

function TTMDBCastPerson.GetCastID: Integer;
begin
  Result:= FObj.I['cast_id'];
end;

function TTMDBCastPerson.GetCharacter: WideString;
begin
  Result:= FObj.S['character'];
end;

function TTMDBCastPerson.GetCreditID: WideString;
begin
  Result:= FObj.S['credit_id'];
end;

function TTMDBCastPerson.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

{ TTMDBCastList }

function TTMDBCastPeople.GetItem(const Index: Integer): ITMDBCastPerson;
begin
  Result:= (inherited GetItem(Index)) as ITMDBCastPerson;
end;

procedure TTMDBCastPeople.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCastPerson;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCastPerson.Create(nil, O, X, FTMDB);
    FList.Add(I);
  end;
end;

{ TTMDBCrewItem }

function TTMDBCrewPerson.GetCreditID: WideString;
begin
  Result:= FObj.S['credit_id'];
end;

function TTMDBCrewPerson.GetDepartment: WideString;
begin
  Result:= FObj.S['department'];
end;

function TTMDBCrewPerson.GetJob: WideString;
begin
  Result:= Fobj.S['job'];
end;

{ TTMDBCrewList }

function TTMDBCrewPeople.GetItem(const Index: Integer): ITMDBCrewPerson;
begin
  Result:= (inherited GetItem(Index)) as ITMDBCrewPerson;
end;

procedure TTMDBCrewPeople.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCrewPerson;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCrewPerson.Create(nil, O, X, FTMDB);
    FList.Add(I);
  end;
end;

{ TTMDBMediaImage }

function TTMDBMediaImage.GetAspectRatio: Single;
begin
  Result:= FObj.F['aspect_ratio'];
end;

function TTMDBMediaImage.GetFilePath: WideString;
begin
  Result:= FObj.S['file_path'];
end;

function TTMDBMediaImage.GetHeight: Integer;
begin
  Result:= FObj.I['height'];
end;

function TTMDBMediaImage.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBMediaImage.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBMediaImage.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

function TTMDBMediaImage.GetWidth: Integer;
begin
  Result:= FObj.I['width'];
end;

{ TTMDBMediaImageList }

function TTMDBMediaImages.GetItem(const Index: Integer): ITMDBMediaImage;
begin
  Result:= (inherited GetItem(Index)) as ITMDBMediaImage;
end;

{ TTMDBMediaImages }

constructor TTMDBMediaImageGroup.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FBackdrops:= TTMDBMediaImages.Create(FObj.A['backdrops'], FTMDB, TTMDBMediaImage);
  FLogos:= TTMDBMediaImages.Create(FObj.A['logos'], FTMDB, TTMDBMediaImage);
  FPosters:= TTMDBMediaImages.Create(FObj.A['posters'], FTMDB, TTMDBMediaImage);
end;

destructor TTMDBMediaImageGroup.Destroy;
begin

  inherited;
end;

function TTMDBMediaImageGroup.GetBackdrops: ITMDBMediaImages;
begin
  Result:= FBackdrops;
end;

function TTMDBMediaImageGroup.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMediaImageGroup.GetLogos: ITMDBMediaImages;
begin
  Result:= FLogos;
end;

function TTMDBMediaImageGroup.GetPosters: ITMDBMediaImages;
begin
  Result:= FPosters;
end;

{ TTMDBDateRange }

constructor TTMDBDateRange.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBDateRange.Destroy;
begin

  inherited;
end;

function TTMDBDateRange.GetMaximum: TDateTime;
begin
  Result:= StrToDateTimeDef(FObj.S['maximum'], 0);
end;

function TTMDBDateRange.GetMinimum: TDateTime;
begin
  Result:= StrToDateTimeDef(FObj.S['minimum'], 0);
end;

{ TTMDBDatedMoviePage }

constructor TTMDBDatedMoviePage.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  inherited Create(AObj, ATMDB, TTMDBMovie, TTMDBMovies);
  FDates:= TTMDBDateRange.Create(FObj.O['dates']);
end;

destructor TTMDBDatedMoviePage.Destroy;
begin

  inherited;
end;

function TTMDBDatedMoviePage.GetDates: ITMDBDateRange;
begin
  Result:= FDates;
end;

{ TTMDBCache }

constructor TTMDBCache.Create(AOwner: TTMDBClient);
begin
  FOwner:= AOwner;
end;

destructor TTMDBCache.Destroy;
begin
  FConfig:= nil;
  FCountries:= nil;
  FJobDepartments:= nil;
  FLanguages:= nil;
  SetLength(FPrimaryTranslations, 0);
  FTimezones:= nil;
  FMovieCerts:= nil;
  FTVCerts:= nil;
  FMovieGenres:= nil;
  FTVGenres:= nil;

  inherited;
end;

procedure TTMDBCache.RefreshAll;
begin
  FConfig:= FOwner.Configuration.GetDetails;
  FCountries:= FOwner.Configuration.GetCountries;
  FJobDepartments:= FOwner.Configuration.GetJobs;
  FLanguages:= FOwner.Configuration.GetLanguages;
  FPrimaryTranslations:= FOwner.Configuration.GetPrimaryTranslations;
  FTimezones:= FOwner.Configuration.GetTimezones;
  FMovieCerts:= FOwner.Certifications.GetMovieCertifications;
  FTVCerts:= FOwner.Certifications.GetTVCertifications;
  FMovieGenres:= FOwner.FGenres.GetMovieList;
  FTVGenres:= FOwner.FGenres.GetTVList;
end;

function TTMDBCache.GetConfig: ITMDBConfiguration;
begin
  if FConfig = nil then
    FConfig:= FOwner.Configuration.GetDetails;
  Result:= FConfig;
end;

function TTMDBCache.GetCountries: ITMDBCountries;
begin
  if FCountries = nil then begin
    FCountries:= FOwner.Configuration.GetCountries;
  end;
  Result:= FCountries;
end;

function TTMDBCache.GetJobDepartments: ITMDBJobDepartments;
begin
  if FJobDepartments = nil then
    FJobDepartments:= FOwner.Configuration.GetJobs;
  Result:= FJobDepartments;
end;

function TTMDBCache.GetLanguages: ITMDBLanguages;
begin
  if FLanguages = nil then
    FLanguages:= FOwner.Configuration.GetLanguages;
  Result:= FLanguages;
end;

function TTMDBCache.GetMovieCerts: ITMDBCertificationCountries;
begin
  if FMovieCerts = nil then
    FMovieCerts:= FOwner.Certifications.GetMovieCertifications;
  Result:= FMovieCerts;
end;

function TTMDBCache.GetMovieGenres: ITMDBGenres;
begin
  if FMovieGenres = nil then
    FMovieGenres:= FOwner.Genres.GetMovieList;
  Result:= FMovieGenres;
end;

function TTMDBCache.GetPrimaryTranslations: TTMDBStrArray;
begin
  if Length(FPrimaryTranslations) = 0 then
    FPrimaryTranslations:= FOwner.Configuration.GetPrimaryTranslations;
  Result:= FPrimaryTranslations;
end;

function TTMDBCache.GetTimezones: ITMDBTimezones;
begin
  if FTimezones = nil then
    FTimezones:= FOwner.Configuration.GetTimezones;
  Result:= FTimezones;
end;

function TTMDBCache.GetTVCerts: ITMDBCertificationCountries;
begin
  if FTVCerts = nil then
    FTVCerts:= FOwner.Certifications.GetTVCertifications;
  Result:= FTVCerts;
end;

function TTMDBCache.GetTVGenres: ITMDBGenres;
begin
  if FTVGenres = nil then
    FTVGenres:= FOwner.Genres.GetTVList;
  Result:= FTVGenres;
end;

function TTMDBCache.MovieGenre(const ID: Integer): WideString;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to MovieGenres.Count-1 do begin
    if MovieGenres[X].ID = ID then begin
      Result:= FMovieGenres[X].Name;
      Break;
    end;
  end;
end;

function TTMDBCache.TVGenre(const ID: Integer): WideString;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to TVGenres.Count-1 do begin
    if TVGenres[X].ID = ID then begin
      Result:= FTVGenres[X].Name;
      Break;
    end;
  end;
end;

{ TTMDBKeywordItem }

function TTMDBKeyword.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBKeyword.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBKeywordList }

function TTMDBKeywords.GetItem(const Index: Integer): ITMDBKeyword;
begin
  Result:= inherited GetItem(Index) as ITMDBKeyword;
end;

{ TTMDBLoginState }

constructor TTMDBLoginState.Create(AOwner: TTMDBClient);
begin
  FOwner:= AOwner;
end;

destructor TTMDBLoginState.Destroy;
begin
  FAccountDetail:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBLoginState.GetAccountDetail: ITMDBAccountDetail;
begin
  Result:= FAccountDetail;
end;

function TTMDBLoginState.GetAccountID: Integer;
begin
  if FAccountDetail <> nil then
    Result:= FAccountDetail.ID
  else
    Result:= 0;
end;

function TTMDBLoginState.GetAuthMethod: TTMDBUserAuth;
begin
  Result:= FAuthMethod;
end;

function TTMDBLoginState.GetIsAuthenticated: Boolean;
begin
  Result:= FIsAuthenticated;
end;

function TTMDBLoginState.GetIsGuest: Boolean;
begin
  Result:= FIsGuest;
end;

function TTMDBLoginState.GetOwner: ITMDBClient;
begin
  Result:= FOwner;
end;

function TTMDBLoginState.GetSessionID: WideString;
begin
  Result:= FSessionID;
end;

function TTMDBLoginState.LoginAsCreds(const Username,
  Password: WideString): ITMDBAuthSessionResult;
var
  RT: ITMDBAuthRequestTokenResult;
  LS: ITMDBAuthSessionResultLogin;
begin
  RT:= FOwner.Authentication.CreateRequestToken;
  if RT.Success then begin
    LS:= FOwner.Authentication.CreateSessionLogin(Username, Password, RT.RequestToken);
    if LS.Success then begin
      Result:= FOwner.Authentication.CreateSession(RT.RequestToken);
      if Result.Success then begin
        FSessionID:= Result.SessionID;
        FIsGuest:= False;
        FIsAuthenticated:= True;
        FAccountDetail:= FOwner.Account.GetDetails(0, FSessionID);
      end;
    end;
  end;
end;

function TTMDBLoginState.LoginAsGuest: ITMDBAuthGuestSessionResult;
begin
  Result:= FOwner.Authentication.CreateGuestSession;
  if Result.Success then begin
    FSessionID:= Result.GuestSessionID;
    FIsAuthenticated:= True;
    FIsGuest:= True;
    FAccountDetail:= nil;
  end;
end;

function TTMDBLoginState.LoginAsUser: ITMDBAuthSessionResult;
var
  RT: ITMDBAuthRequestTokenResult;
  Res: Boolean;
  O: ISuperObject;
begin
  RT:= FOwner.Authentication.CreateRequestToken;
  if RT.Success then begin
    Res:= False;

    //Trigger event to open browser of choice to URL...
    FOwner.DoUserAuthRequest(RT.RequestToken, Res);

    if Res then begin
      Result:= FOwner.Authentication.CreateSession(RT.RequestToken);
      if Result.Success then begin
        FSessionID:= Result.SessionID;
        FIsAuthenticated:= True;
        FIsGuest:= False;
        FAccountDetail:= FOwner.Account.GetDetails(0, FSessionID);
      end;
    end else begin
      O:= SO;
      O.B['success']:= False;
      O.B['failure']:= True;
      O.I['status_code']:= 17;
      O.S['status_message']:= 'Session denied.';
      Result:= TTMDBAuthSessionResult.Create(O);
    end;

  end;
end;

function TTMDBLoginState.Logout: Boolean;
begin
  FIsGuest:= False;
  FIsAuthenticated:= False;
  if (FSessionID <> '') and (not FIsGuest) then
    FOwner.Authentication.DeleteSession(FSessionID);
  FSessionID:= '';
  FAccountDetail:= nil;
  Result:= True;
end;

function TTMDBLoginState.RestoreSession(const SessionID: WideString): Boolean;
var
  A: ITMDBAccountDetail;
begin
  Result:= False;
  A:= FOwner.Account.GetDetails(0, SessionID);
  if A <> nil then begin
    Result:= A.ID > 0;
    if Result then begin
      FIsAuthenticated:= True;
      FIsGuest:= False;
      FSessionID:= SessionID;
      FAccountDetail:= A;
    end;
  end;
end;

procedure TTMDBLoginState.SetAuthMethod(const Value: TTMDBUserAuth);
begin
  if IsAuthenticated then
    raise Exception.Create('Cannot change auth method while logged in.');
  FAuthMethod:= Value;
end;

{ TTMDBReleaseDateItem }

constructor TTMDBReleaseDate.Create(AObj: ISuperObject;
  AOwner: TTMDBReleaseDateCountry);
begin
  FObj:= AObj;
  FOwner:= AOwner;
end;

destructor TTMDBReleaseDate.Destroy;
begin
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBReleaseDate.GetCertification: WideString;
begin
  Result:= FObj.S['certification'];
end;

function TTMDBReleaseDate.GetDescriptors: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['descriptors']);
end;

function TTMDBReleaseDate.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBReleaseDate.GetNote: WideString;
begin
  Result:= FObj.S['note'];
end;

function TTMDBReleaseDate.GetReleaseDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['release_date']);
end;

function TTMDBReleaseDate.GetType: TTMDBReleaseType;
begin
  Result:= TTMDBReleaseType(FObj.I['type']);
end;

{ TTMDBReleaseDateCountry }

procedure TTMDBReleaseDateCountry.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBReleaseDate(FItems[X])._Release;
  end;
  FItems.Clear;
end;

constructor TTMDBReleaseDateCountry.Create(AObj: ISuperArray;
  AOwner: TTMDBReleaseDateCountries; const CountryCode: WideString);
begin
  FItems:= TInterfaceList.Create;
  FObj:= AObj;
  FOwner:= AOwner;
  FCountryCode:= CountryCode;
  PopulateItems;
end;

destructor TTMDBReleaseDateCountry.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBReleaseDateCountry.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBReleaseDateCountry.GetCountryCode: WideString;
begin
  Result:= FCountryCode;
end;

function TTMDBReleaseDateCountry.GetCountryName: WideString;
begin
  //TODO

end;

function TTMDBReleaseDateCountry.GetItem(
  const Index: Integer): ITMDBReleaseDate;
begin
  Result:= (FItems[Index]) as ITMDBReleaseDate;
end;

procedure TTMDBReleaseDateCountry.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBReleaseDate;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBReleaseDate.Create(O, Self);
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBReleaseDateCountries }

procedure TTMDBReleaseDateCountries.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBReleaseDateCountry(FItems[X])._Release;
  end;
  FItems.Clear;
end;

constructor TTMDBReleaseDateCountries.Create(AObj: ISuperArray);
begin
  FItems:= TInterfaceList.Create;
  FObj:= AObj;
  PopulateItems;
end;

destructor TTMDBReleaseDateCountries.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  FObj:= nil;
  inherited;
end;

function TTMDBReleaseDateCountries.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBReleaseDateCountries.GetItem(
  const Index: Integer): ITMDBReleaseDateCountry;
begin
  Result:= (FItems[Index]) as ITMDBReleaseDateCountry;
end;

procedure TTMDBReleaseDateCountries.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBReleaseDateCountry;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBReleaseDateCountry.Create(O.A['release_dates'], Self, O.S['iso_3166_1']);
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBCollectionItem }

function TTMDBCollection.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBCollection.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBCollection.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCollection.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCollection.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBCollection.GetOriginalName: WideString;
begin
  Result:= Fobj.S['original_name'];
end;

function TTMDBCollection.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBCollection.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBCompanyItem }

function TTMDBCompany.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCompany.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBCompany.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCompany.GetOriginCountry: WideString;
begin
  Result:= FObj.S['origin_country'];
end;

{ TTMDBCompanyList }

function TTMDBCompanies.GetItem(const Index: Integer): ITMDBCompany;
begin
  Result:= inherited GetItem(Index) as ITMDBCompany;
end;

{ TTMDBCollectionPart }

constructor TTMDBCollectionPart.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FGenres:= nil;
  FTMDB:= ATMDB;
end;

destructor TTMDBCollectionPart.Destroy;
begin
  FObj:= nil;
  FGenres:= nil;
  FTMDB:= nil;
  inherited;
end;

function TTMDBCollectionPart.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBCollectionPart.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBCollectionPart.GetGenres: ITMDBGenres;
var
  A, A2: ISuperArray;
  O: ISuperObject;
  X: Integer;
begin
  //One-time lookup and cache...
  if FGenres = nil then begin
    A:= FObj.A['genre_ids'];
    A2:= SA([]);
    for X := 0 to A.Length-1 do begin
      O:= SO;
      O.I['id']:= A.I[X];
      A2.Add(O);
    end;
    FGenres:= TTMDBGenres.Create(A2, FTMDB, MediaType);
  end;
  Result:= FGenres;
end;

function TTMDBCollectionPart.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCollectionPart.GetMediaType: TTMDBMediaType;
begin
  Result:= TMDBStrToMediaType(FObj.S['media_type']);
end;

function TTMDBCollectionPart.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBCollectionPart.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBCollectionPart.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBCollectionPart.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBCollectionPart.GetReleaseDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['release_date']);
end;

function TTMDBCollectionPart.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

function TTMDBCollectionPart.GetVideo: Boolean;
begin
  Result:= FObj.B['video'];
end;

function TTMDBCollectionPart.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBCollectionPart.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBCollectionDetail }

procedure TTMDBCollectionDetail.ClearParts;
var
  X: Integer;
begin
  for X := 0 to FParts.Count-1 do begin
    ITMDBCollectionPart(FParts[X])._Release;
  end;
  FParts.Clear;
end;

constructor TTMDBCollectionDetail.Create(AObj: ISuperObject;
  ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FParts:= TInterfaceList.Create;
  PopulateParts;
end;

destructor TTMDBCollectionDetail.Destroy;
begin
  ClearParts;
  FreeAndNil(FParts);
  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBCollectionDetail.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBCollectionDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCollectionDetail.GetImages(const IncludeImageLanguage,
  Language: WideString): ITMDBMediaImageGroup;
begin
  Result:= FTMDB.Collections.GetImages(ID, IncludeImageLanguage, Language);
end;

function TTMDBCollectionDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCollectionDetail.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBCollectionDetail.GetPart(
  const Index: Integer): ITMDBCollectionPart;
begin
  Result:= (FParts[Index]) as ITMDBCollectionPart;
end;

function TTMDBCollectionDetail.GetPartCount: Integer;
begin
  Result:= FParts.Count;
end;

function TTMDBCollectionDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBCollectionDetail.GetTranslations: ITMDBTranslations;
begin
  Result:= FTMDB.Collections.GetTranslations(ID);
end;

procedure TTMDBCollectionDetail.PopulateParts;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCollectionPart;
begin
  ClearParts;
  for X := 0 to FObj.A['parts'].Length-1 do begin
    O:= FObj.A['parts'].O[X];
    I:= TTMDBCollectionPart.Create(O, FTMDB);
    I._AddRef;
    FParts.Add(I);
  end;
end;

{ TTMDBMovieCollectionRef }

constructor TTMDBMovieCollectionRef.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  if FObj <> nil then
    if FObj.DataType in [dtNil,dtNull] then
      FObj:= nil;

end;

destructor TTMDBMovieCollectionRef.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBMovieCollectionRef.GetBackdropPath: WideString;
begin
  if FObj = nil then
    Result:= ''
  else
    Result:= FObj.S['backdrop_path'];
end;

function TTMDBMovieCollectionRef.GetBelongsToCollection: Boolean;
begin
  Result:= FObj <> nil;
end;

function TTMDBMovieCollectionRef.GetID: Integer;
begin
  if FObj = nil then
    Result:= 0
  else
    Result:= FObj.I['id'];
end;

function TTMDBMovieCollectionRef.GetName: WideString;
begin
  if FObj = nil then
    Result:= ''
  else
    Result:= FObj.S['name'];
end;

function TTMDBMovieCollectionRef.GetPosterPath: WideString;
begin
  if FObj = nil then
    Result:= ''
  else
    Result:= FObj.S['poster_path'];
end;

{ TTMDBTranslationItem }

constructor TTMDBTranslation.Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
var
  D: ISuperObject;
begin
  FObj:= AObj;
  FDataType:= ADataType;
  D:= FObj.O['data'];
  case ADataType of
    ttMovie:      FData:= TTMDBMovieTranslationData.Create(D);
    ttCollection: FData:= TTMDBCollectionTranslationData.Create(D);
    ttPerson:     FData:= TTMDBPersonTranslationData.Create(D);
    ttTVSeries:   FData:= TTMDBTVSeriesTranslationData.Create(D);
    ttTVSeason:   FData:= TTMDBTVSeasonTranslationData.Create(D);
    ttTVEpisode:  FData:= TTMDBTVEpisodeTranslationData.Create(D);
  end;
end;

destructor TTMDBTranslation.Destroy;
begin
  FData:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBTranslation.GetMovieData: ITMDBMovieTranslationData;
begin
  Result:= (FData) as ITMDBMovieTranslationData;
end;

function TTMDBTranslation.GetCollectionData: ITMDBCollectionTranslationData;
begin
  Result:= (FData) as ITMDBCollectionTranslationData;
end;

function TTMDBTranslation.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBTranslation.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBTranslation.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBTranslation.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTranslation.GetPersonData: ITMDBPersonTranslationData;
begin
  Result:= (FData) as ITMDBPersonTranslationData;
end;

function TTMDBTranslation.GetTVEpisodeData: ITMDBTVEpisodeTranslationData;
begin
  Result:= (FData) as ITMDBTVEpisodeTranslationData;
end;

function TTMDBTranslation.GetTVSeasonData: ITMDBTVSeasonTranslationData;
begin
  Result:= (FData) as ITMDBTVSeasonTranslationData;
end;

function TTMDBTranslation.GetTVSeriesData: ITMDBTVSeriesTranslationData;
begin
  Result:= (FData) as ITMDBTVSeriesTranslationData;
end;

{ TTMDBTranslationList }

procedure TTMDBTranslations.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTranslations.Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
begin
  FObj:= AObj;
  FDataType:= ADataType;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBTranslations.Destroy;
begin
  ClearItems;
  FObj:= nil;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBTranslations.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBTranslations.GetItem(
  const Index: Integer): ITMDBTranslation;
begin
  Result:= (FItems[Index]) as ITMDBTranslation;
end;

procedure TTMDBTranslations.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTranslation;
begin
  ClearItems;
  for X := 0 to FObj.A['translations'].Length-1 do begin
    O:= FObj.A['translations'].O[X];
    I:= TTMDBTranslation.Create(O, FDataType);
    FItems.Add(I);
  end;
end;

{ TTMDBTranslationData }

constructor TTMDBTranslationData.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBTranslationData.Destroy;
begin
  FObj:= nil;
  inherited;
end;

{ TTMDBMovieTranslationData }

function TTMDBMovieTranslationData.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBMovieTranslationData.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBMovieTranslationData.GetRuntime: Integer;
begin
  Result:= FObj.I['runtime'];
end;

function TTMDBMovieTranslationData.GetTagline: WideString;
begin
  Result:= FObj.S['tagline'];
end;

function TTMDBMovieTranslationData.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

{ TTMDBCollectionTranslationData }

function TTMDBCollectionTranslationData.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBCollectionTranslationData.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBCollectionTranslationData.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

{ TTMDBPersonTranslationData }

function TTMDBPersonTranslationData.GetBiography: WideString;
begin
  Result:= FObj.S['biography'];
end;

{ TTMDBTVSeriesTranslationData }

function TTMDBTVSeriesTranslationData.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBTVSeriesTranslationData.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVSeriesTranslationData.GetTagline: WideString;
begin
  Result:= FObj.S['tagline'];
end;

function TTMDBTVSeriesTranslationData.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

{ TTMDBTVSeasonTranslationData }

function TTMDBTVSeasonTranslationData.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVSeasonTranslationData.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

{ TTMDBTVEpisodeTranslationData }

function TTMDBTVEpisodeTranslationData.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVEpisodeTranslationData.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

{ TTMDBVideoItem }

function TTMDBVideo.GetID: WideString;
begin
  Result:= FObj.S['id'];
end;

function TTMDBVideo.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBVideo.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBVideo.GetKey: WideString;
begin
  Result:= FObj.S['key'];
end;

function TTMDBVideo.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBVideo.GetOfficial: Boolean;
begin
  Result:= FObj.B['official'];
end;

function TTMDBVideo.GetPublishedAt: TDateTime;
begin
  Result:= ConvertDate(FObj.S['published_at']);
end;

function TTMDBVideo.GetSite: WideString;
begin
  Result:= FObj.S['site'];
end;

function TTMDBVideo.GetSize: Integer;
begin
  Result:= FObj.I['size'];
end;

function TTMDBVideo.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

{ TTMDBVideoList }

function TTMDBVideos.GetItem(const Index: Integer): ITMDBVideo;
begin
  Result:= (inherited GetItem(Index)) as ITMDBVideo;
end;

{ TTMDBTVSeriesDetail }

constructor TTMDBTVSerieDetail.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;

end;

destructor TTMDBTVSerieDetail.Destroy;
begin

  FObj:= nil;
  FTMDB:= nil;
  inherited;
end;

function TTMDBTVSerieDetail.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBTVSerieDetail.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBTVSerieDetail.GetCreatedBy: ITMDBPeople;
begin
  //TODO
end;

function TTMDBTVSerieDetail.GetEpisodeRunTime: TTMDBIntArray;
begin
  Result:= JSONToIntArray(FObj.A['episode_run_time']);
end;

function TTMDBTVSerieDetail.GetFirstAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['first_air_date']);
end;

function TTMDBTVSerieDetail.GetGenres: ITMDBGenres;
begin
  Result:= TTMDBGenres.Create(FObj.A['genres'], FTMDB, mtTV);
end;

function TTMDBTVSerieDetail.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBTVSerieDetail.GetInProduction: Boolean;
begin
  Result:= FObj.B['in_production'];
end;

function TTMDBTVSerieDetail.GetLanguages: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['languages']);
end;

function TTMDBTVSerieDetail.GetLastAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['last_air_date']);
end;

function TTMDBTVSerieDetail.GetLastEpisodeToAir: ITMDBTVEpisode;
begin
  Result:= TTMDBTVEpisode.Create(nil, FObj.O['last_episode_to_air'], 0, FTMDB);
end;

function TTMDBTVSerieDetail.GetNetworks: ITMDBTVNetworks;
begin
  //TODO
end;

function TTMDBTVSerieDetail.GetNextEpisodeToAir: ITMDBTVEpisode;
begin
  Result:= TTMDBTVEpisode.Create(nil, FObj.O['next_episode_to_air'], 0, FTMDB);
end;

function TTMDBTVSerieDetail.GetNumberOfEpisodes: Integer;
begin
  Result:= FObj.I['number_of_episodes'];
end;

function TTMDBTVSerieDetail.GetNumberOfSeasons: Integer;
begin
  Result:= FObj.I['number_of_seasons'];
end;

function TTMDBTVSerieDetail.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBTVSerieDetail.GetOriginalName: WideString;
begin
  Result:= FObj.S['original_name'];
end;

function TTMDBTVSerieDetail.GetOriginCountry: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['origin_country']);
end;

function TTMDBTVSerieDetail.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVSerieDetail.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBTVSerieDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBTVSerieDetail.GetProductionCompanies: ITMDBCompanies;
begin
  Result:= TTMDBCompanies.Create(FObj.A['production_companies'], FTMDB, TTMDBCompany);
end;

function TTMDBTVSerieDetail.GetProductionCountries: ITMDBCountries;
begin
  Result:= TTMDBCountries.Create(FObj.A['production_countries'], FTMDB, TTMDBCountry);
end;

function TTMDBTVSerieDetail.GetSpokenLanguages: ITMDBLanguages;
begin
  Result:= TTMDBLanguages.Create(FObj.A['spoken_languages'], FTMDB, TTMDBLanguage);
end;

function TTMDBTVSerieDetail.GetStatus: WideString;
begin
  Result:= FObj.S['status'];
end;

function TTMDBTVSerieDetail.GetTagline: WideString;
begin
  Result:= FObj.S['tagline'];
end;

function TTMDBTVSerieDetail.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

function TTMDBTVSerieDetail.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVSerieDetail.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBTVSeriesList }

function TTMDBTVSeries.GetItem(const Index: Integer): ITMDBTVSerie;
begin
  Result:= (inherited Items[Index]) as ITMDBTVSerie;
end;

{ TTMDBTVEpisodeItem }

function TTMDBTVEpisode.GetAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['air_date']);
end;

function TTMDBTVEpisode.GetEpisodeNumber: Integer;
begin
  Result:= FObj.I['episode_number'];
end;

function TTMDBTVEpisode.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVEpisode.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVEpisode.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

function TTMDBTVEpisode.GetOverview: WideString;
begin
  Result:= Fobj.S['overview'];
end;

function TTMDBTVEpisode.GetProductionCode: WideString;
begin
  Result:= FObj.S['production_code'];
end;

function TTMDBTVEpisode.GetRuntime: Integer;
begin
  Result:= FObj.I['runtime'];
end;

function TTMDBTVEpisode.GetSeasonNumber: Integer;
begin
  Result:= FObj.I['season_number'];
end;

function TTMDBTVEpisode.GetShowID: Integer;
begin
  Result:= FObj.I['show_id'];
end;

function TTMDBTVEpisode.GetStillPath: WideString;
begin
  Result:= FObj.S['still_path'];
end;

function TTMDBTVEpisode.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVEpisode.GetVoteCount: Integer;
begin
  Result:= Fobj.I['vote_count'];
end;

{ TTMDBTVEpisodeList }

function TTMDBTVEpisodes.GetItem(const Index: Integer): ITMDBTVEpisode;
begin
  Result:= (inherited Items[Index]) as ITMDBTVEpisode;
end;

{ TTMDBTVNetworkList }

function TTMDBTVNetworks.GetItem(const Index: Integer): ITMDBTVNetwork;
begin
  Result:= inherited GetItem(Index) as ITMDBTVNetwork;
end;

{ TTMDBTVNetworkItem }

function TTMDBTVNetwork.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVNetwork.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBTVNetwork.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVNetwork.GetOriginCountry: WideString;
begin
  Result:= FObj.S['origin_country'];
end;

{ TTMDBTVNetworkDetail }

constructor TTMDBTVNetworkDetail.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBTVNetworkDetail.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBTVNetworkDetail.GetHeadquarters: WideString;
begin
  Result:= FObj.S['headquarters'];
end;

function TTMDBTVNetworkDetail.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBTVNetworkDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVNetworkDetail.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBTVNetworkDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVNetworkDetail.GetOriginCountry: WideString;
begin
  Result:= FObj.S['origin_country'];
end;

{ TTMDBMedium }

function TTMDBMedium.AsMovie: ITMDBMovie;
begin
  Result:= Self as ITMDBMovie;
end;

function TTMDBMedium.AsPerson: ITMDBPerson;
begin
  Result:= Self as ITMDBPerson;
end;

function TTMDBMedium.AsTVEpisode: ITMDBTVEpisode;
begin
  Result:= Self as ITMDBTVEpisode;
end;

function TTMDBMedium.AsTVSeries: ITMDBTVSerie;
begin
  Result:= Self as ITMDBTVSerie;
end;

function TTMDBMedium.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBMedium.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMedium.GetMediaType: TTMDBMediaType;
begin
  Result:= TMDBStrToMediaType(FObj.S['media_type']);
end;

function TTMDBMedium.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBMedium.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
  if Result = '' then
    Result:= FObj.S['name'];
end;

{ TTMDBMedia }

function TTMDBMedia.GetItem(const Index: Integer): ITMDBMedium;
begin
  Result:= inherited GetItem(Index) as ITMDBMedium;
end;

procedure TTMDBMedia.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBMedium;
  MT: TTMDBMediaType;
  T: TTMDBItemClass;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    MT:= TMDBStrToMediaType(O.S['media_type']);
    case MT of
      mtMovie:  T:= TTMDBMovie;
      mtTV:     T:= TTMDBTVSerie;
      mtPerson: T:= TTMDBPerson;
      else begin
        T:= FItemClass;
      end;
    end;
    I:= T.Create(Self, O, X, FTMDB) as ITMDBMedium;
    FList.Add(I);
  end;
end;

{ TTMDBMovieList }

function TTMDBMovies.GetItem(const Index: Integer): ITMDBMovie;
begin
  Result:= (inherited GetItem(Index)) as ITMDBMovie;
end;

{ TTMDBMediaPage }

constructor TTMDBMediaPage.Create(AObj: ISuperObject; ATMDB: ITMDBClient;
  AItemClass: TTMDBItemClass; AItemsClass: TTMDBItemsClass);
begin
  inherited Create(AObj, ATMDB, AItemClass, AItemsClass);

end;

destructor TTMDBMediaPage.Destroy;
begin

  inherited;
end;

function TTMDBMediaPage.GetItems: ITMDBMedia;
begin
  Result:= (inherited GetItems) as ITMDBMedia;
end;

{ TTMDBKeywordDetail }

constructor TTMDBKeywordDetail.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBKeywordDetail.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBKeywordDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBKeywordDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBTVEpisodeGroupResponse }

procedure TTMDBTVEpisodeGroups.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTVEpisodeGroups.Create(AObj: ISuperObject;
  ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FItems:= TInterfaceList.Create;
  FNetwork:= nil;
  PopulateItems;
end;

destructor TTMDBTVEpisodeGroups.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  FNetwork:= nil;
  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBTVEpisodeGroups.GetDescription: WideString;
begin
  Result:= FObj.S['description'];
end;

function TTMDBTVEpisodeGroups.GetEpisodeCount: Integer;
begin
  Result:= FObj.I['episode_count'];
end;

function TTMDBTVEpisodeGroups.GetGroup(
  const Index: Integer): ITMDBTVEpisodeGroup;
begin
  Result:= (FItems[Index]) as ITMDBTVEpisodeGroup;
end;

function TTMDBTVEpisodeGroups.GetGroupCount: Integer;
begin
  Result:= FObj.I['group_count'];
end;

function TTMDBTVEpisodeGroups.GetID: WideString;
begin
  Result:= FObj.S['id'];
end;

function TTMDBTVEpisodeGroups.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVEpisodeGroups.GetNetwork: ITMDBTVNetwork;
begin
  if FNetwork = nil then begin
    FNetwork:= TTMDBTVNetwork.Create(nil, FObj.O['network'], -1, FTMDB);
  end;
  Result:= FNetwork;
end;

function TTMDBTVEpisodeGroups.GetType: TTMDBTVEpisodeGroupType;
begin
  Result:= TTMDBTVEpisodeGroupType(FObj.I['type']);
end;

procedure TTMDBTVEpisodeGroups.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTVEpisodeGroup;
begin
  ClearItems;
  for X := 0 to FObj.A['groups'].Length-1 do  begin
    O:= FObj.A['groups'].O[X];
    I:= TTMDBTVEpisodeGroup.Create(O, FTMDB);
    FItems.Add(I);
  end;
end;

{ TTMDBTVEpisodeGroup }

procedure TTMDBTVEpisodeGroup.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTVEpisodeGroup.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBTVEpisodeGroup.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  FObj:= nil;
  FTMDB:= nil;
  inherited;
end;

function TTMDBTVEpisodeGroup.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBTVEpisodeGroup.GetEpisode(
  const Index: Integer): ITMDBTVEpisode;
begin
  Result:= (FItems[Index]) as ITMDBTVEpisode;
end;

function TTMDBTVEpisodeGroup.GetID: WideString;
begin
  Result:= FObj.S['id'];
end;

function TTMDBTVEpisodeGroup.GetLocked: Boolean;
begin
  Result:= FObj.B['locked'];
end;

function TTMDBTVEpisodeGroup.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVEpisodeGroup.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

procedure TTMDBTVEpisodeGroup.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTVEpisode;
begin
  ClearItems;
  for X := 0 to FObj.A['episodes'].Length-1 do begin
    O:= FObj.A['episodes'].O[X];
    I:= TTMDBTVEpisode.Create(nil, O, X, FTMDB);
    FItems.Add(I);
  end;
end;

{ TTMDBRatedTVEpisodeItem }

function TTMDBRatedTVEpisode.GetRating: Single;
begin
  Result:= FObj.F['rating']; //TODO: Integer???
end;

{ TTMDBCompanyDetail }

constructor TTMDBCompanyDetail.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBCompanyDetail.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBCompanyDetail.GetDescription: WideString;
begin
  Result:= FObj.S['description'];
end;

function TTMDBCompanyDetail.GetHeadquarters: WideString;
begin
  Result:= FObj.S['headquarters'];
end;

function TTMDBCompanyDetail.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBCompanyDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCompanyDetail.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBCompanyDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCompanyDetail.GetOriginCountry: WideString;
begin
  Result:= FObj.S['origin_country'];
end;

function TTMDBCompanyDetail.GetParentCompany: WideString;
begin
  Result:= FObj.S['parent_company'];
  //TODO: Apparently this could be "null"...

end;

{ TTMDBRatedMovieList }

function TTMDBRatedMovies.GetItem(const Index: Integer): ITMDBRatedMovie;
begin
  Result:= (inherited GetItem(Index)) as ITMDBRatedMovie;
end;

{ TTMDBChangeList }

function TTMDBChanges.GetItem(const Index: Integer): ITMDBChange;
begin
  Result:= (inherited GetItem(Index)) as ITMDBChange;
end;

{ TTMDBChangePage }

function TTMDBChangePage.GetItems: ITMDBChanges;
begin
  Result:= (inherited GetItems) as ITMDBChanges;
end;

{ TTMDBCompanyPage }

function TTMDBCompanyPage.GetItems: ITMDBCompanies;
begin
  Result:= (inherited GetItems) as ITMDBCompanies;
end;

{ TTMDBKeywordPage }

function TTMDBKeywordPage.GetItems: ITMDBKeywords;
begin
  Result:= (inherited GetItems) as ITMDBKeywords;
end;

{ TTMDBPersonPage }

function TTMDBPersonPage.GetItems: ITMDBPeople;
begin
  Result:= (inherited GetItems) as ITMDBPeople;
end;

{ TTMDBCollectionList }

function TTMDBCollections.GetItem(const Index: Integer): ITMDBCollection;
begin
  Result:= (inherited GetItem(Index)) as ITMDBCollection;
end;

{ TTMDBCollectionPage }

function TTMDBCollectionPage.GetItems: ITMDBCollections;
begin
  Result:= (inherited GetItems) as ITMDBCollections;
end;

{ TTMDBTVEpisodePage }

function TTMDBTVEpisodePage.GetItems: ITMDBTVEpisodes;
begin
  Result:= (inherited GetItems) as ITMDBTVEpisodes;
end;

{ TTMDBRatedTVEpisodePage }

function TTMDBRatedTVEpisodePage.GetItems: ITMDBRatedTVEpisodes;
begin
  Result:= (inherited GetItems) as ITMDBRatedTVEpisodes;
end;

{ TTMDBRatedTVSeriesPage }

function TTMDBRatedTVSeriesPage.GetItems: ITMDBTVSeries;
begin
  Result:= (inherited GetItems) as ITMDBTVSeries;
end;

{ TTMDBLists }

function TTMDBLists.GetItem(const Index: Integer): ITMDBList;
begin
  Result:= (inherited GetItem(Index)) as ITMDBList;
end;

{ TTMDBListPage }

function TTMDBListPage.GetItems: ITMDBLists;
begin
  Result:= (inherited GetItems) as ITMDBLists;
end;

{ TTMDBRatedTVSeriesList }

function TTMDBRatedTVSeries.GetItem(
  const Index: Integer): ITMDBRatedTVSerie;
begin
  Result:= (inherited GetItem(Index)) as ITMDBRatedTVSerie;
end;

{ TTMDBRatedTVEpisodeList }

function TTMDBRatedTVEpisodes.GetItem(
  const Index: Integer): ITMDBRatedTVEpisode;
begin
  Result:= (inherited GetItem(Index)) as ITMDBRatedTVEpisode;
end;

{ TTMDBMoviePage }

function TTMDBMoviePage.GetItems: ITMDBMovies;
begin
  Result:= (inherited GetItems) as ITMDBMovies;
end;

{ TTMDBListDetail }

constructor TTMDBListDetail.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FParts:= nil;
end;

destructor TTMDBListDetail.Destroy;
begin
  FObj:= nil;
  FParts:= nil;
  inherited;
end;

function TTMDBListDetail.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBListDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBListDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBListDetail.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBListDetail.GetParts: ITMDBMedia;
begin
  if FParts = nil then begin
    FParts:= TTMDBMedia.Create(FObj.A['parts'], FTMDB, TTMDBMedium);
  end;
  Result:= FParts;
end;

function TTMDBListDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBDetail }

constructor TTMDBDetail.Create(AObj: ISuperObject; ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;

end;

destructor TTMDBDetail.Destroy;
begin

  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBDetail.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
  if Result = '' then
    Result:= FObj.S['name'];
end;





































{ TTMDBService }

constructor TTMDBService.Create(AOwner: TTMDBClient);
begin
  FOwner:= AOwner;
end;

destructor TTMDBService.Destroy;
begin

  inherited;
end;

function TTMDBService.GetOwner: ITMDBClient;
begin
  Result:= FOwner;
end;

{ TTMDBServiceAccount }

function TTMDBServiceAccount.GetDetails(AAccountID: Integer;
  ASessionID: WideString): ITMDBAccountDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetDetails(AAccountID, ASessionID);
  Result:= TTMDBAccountDetail.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetDetailsBySession(
  const ASessionID: WideString): ITMDBAccountDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetDetailsBySession(ASessionID);
  Result:= TTMDBAccountDetail.Create(O, FOwner);
end;

function TTMDBServiceAccount.SetFavorite(const AccountID: Integer;
  const MediaType: TTMDBMediaType; const MediaID: Integer;
  const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.AddFavorite(AccountID, TMDBMediaTypeToStr(MediaType), MediaID, Favorite, SessionID);
  Result:= TTMDBAccountAddFavoriteResult.Create(O);
end;

function TTMDBServiceAccount.SetWatchlist(const AccountID: Integer;
  const MediaType: TTMDBMediaType; const MediaID: Integer;
  const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.AddToWatchlist(AccountID, TMDBMediaTypeToStr(MediaType), MediaID, Watchlist, SessionID);
  Result:= TTMDBAccountAddWatchlistResult.Create(O);
end;

function TTMDBServiceAccount.GetFavoriteMovies(const AccountID: Integer; const Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetFavoriteMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceAccount.GetFavoriteTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetFavoriteTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSerie, TTMDBTVSeries);
end;

function TTMDBServiceAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: WideString): ITMDBListPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetLists(AccountID, Page, SessionID);
  Result:= TTMDBListPage.Create(O, FOwner, TTMDBList, TTMDBLists);
end;

function TTMDBServiceAccount.GetRatedMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedMoviePage.Create(O, FOwner, TTMDBRatedMovie, TTMDBRatedMovies);
end;

function TTMDBServiceAccount.GetRatedTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedTVSeriesPage.Create(O, FOwner, TTMDBRatedTVSerie, TTMDBRatedTVSeries);
end;

function TTMDBServiceAccount.GetRatedTVEpisodes(AccountID: Integer;
  const Page: Integer; const Language, SessionID,
  SortBy: WideString): ITMDBRatedTVEpisodePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedTVEpisodes(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedTVEpisodePage.Create(O, FOwner, TTMDBRatedTVEpisode, TTMDBRatedTVEpisodes);
end;

function TTMDBServiceAccount.GetWatchlistMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetWatchlistMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceAccount.GetWatchlistTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetWatchlistTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSerie, TTMDBTVSeries);
end;

{ TTMDBServiceAuthentication }

function TTMDBServiceAuthentication.CreateGuestSession: ITMDBAuthGuestSessionResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.CreateGuestSession;
  Result:= TTMDBAuthGuestSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateRequestToken: ITMDBAuthRequestTokenResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.CreateRequestToken;
  Result:= TTMDBAuthRequestTokenResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateSession(
  const ARequestToken: WideString): ITMDBAuthSessionResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.CreateSession(ARequestToken);
  Result:= TTMDBAuthSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateSessionLogin(const AUsername,
  APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.CreateSessionLogin(AUsername, APassword, ARequestToken);
  Result:= TTMDBAuthSessionResultLogin.Create(O);
end;

function TTMDBServiceAuthentication.CreateSessionV4(
  const AAccessToken: WideString): ITMDBAuthSessionResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.CreateSessionV4(AAccessToken);
  Result:= TTMDBAuthSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.DeleteSession(
  const SessionID: WideString): ITMDBAuthDeleteSessionResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.DeleteSession(SessionID);
  Result:= TTMDBAuthDeleteSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.ValidateKey: ITMDBAuthValidateKeyResult;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Authentication.GetValidateKey;
  Result:= TTMDBAuthValidateKeyResult.Create(O);
end;

{ TTMDBServiceCertifications }

function TTMDBServiceCertifications.GetMovieCertifications: ITMDBCertificationCountries;
var
  Res: ISuperObject;
begin
  Res:= FOwner.FAPI.Certifications.GetMovieCertifications;
  Result:= TTMDBCertificationCountries.Create(Res);
end;

function TTMDBServiceCertifications.GetTVCertifications: ITMDBCertificationCountries;
var
  Res: ISuperObject;
begin
  Res:= FOwner.FAPI.Certifications.GetTVCertifications;
  Result:= TTMDBCertificationCountries.Create(Res);
end;

{ TTMDBServiceCompanies }

function TTMDBServiceCompanies.GetAlternativeNames(
  const CompanyID: Integer): ITMDBAlternativeTitles;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Companies.GetAlternativeNames(CompanyID);
  Result:= TTMDBAlternativeTitles.Create(O.A['results'], FOwner, TTMDBAlternativeTitle);
end;

function TTMDBServiceCompanies.GetDetails(
  const CompanyID: Integer): ITMDBCompanyDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Companies.GetDetails(CompanyID);
  Result:= TTMDBCompanyDetail.Create(O);
end;

function TTMDBServiceCompanies.GetImages(
  const CompanyID: Integer): ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Companies.GetImages(CompanyID);
  Result:= TTMDBMediaImageGroup.Create(O, FOwner);
end;

{ TTMDBServiceConfiguration }

function TTMDBServiceConfiguration.GetDetails: ITMDBConfiguration;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Configuration.GetDetails;
  Result:= TTMDBConfiguration.Create(O);
end;

function TTMDBServiceConfiguration.GetCountries: ITMDBCountries;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetCountries;
  Result:= TTMDBCountries.Create(A, FOwner, TTMDBCountry);
end;

function TTMDBServiceConfiguration.GetJobs: ITMDBJobDepartments;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetJobs;
  Result:= TTMDBJobDepartments.Create(A, FOwner, TTMDBJobDepartment);
end;

function TTMDBServiceConfiguration.GetLanguages: ITMDBLanguages;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetLanguages;
  Result:= TTMDBLanguages.Create(A, FOwner, TTMDBLanguage);
end;

function TTMDBServiceConfiguration.GetPrimaryTranslations: TTMDBStrArray;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetPrimaryTranslations;
  Result:= JSONToStrArray(A);
end;

function TTMDBServiceConfiguration.GetTimezones: ITMDBTimezones;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetTimeZones;
  Result:= TTMDBTimezones.Create(A, FOwner, TTMDBTimezone);
end;

{ TTMDBServiceFind }

function TTMDBServiceFind.FindByID(const ExternalID, ExternalSource,
  Language: String): ITMDBFindResults;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Find.GetFindByID(ExternalID, ExternalSource, Language);
  //Result:= TTMDBFindResults.Create(O);
end;

{ TTMDBServiceGenres }

function TTMDBServiceGenres.GetMovieList(
  const Language: WideString): ITMDBGenres;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Genres.GetMovieList(Language);
  Result:= TTMDBGenres.Create(A, FOwner, TTMDBMediaType.mtMovie);
end;

function TTMDBServiceGenres.GetTVList(
  const Language: WideString): ITMDBGenres;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Genres.GetTVList(Language);
  Result:= TTMDBGenres.Create(A, FOwner, TTMDBMediaType.mtTV);
end;

{ TTMDBServiceKeywords }

function TTMDBServiceKeywords.GetDetails(
  const KeywordID: Integer): ITMDBKeywordDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Keywords.GetDetails(KeywordID);
  Result:= TTMDBKeywordDetail.Create(O);
end;

{ TTMDBServiceMovieLists }

function TTMDBServiceMovieLists.GetNowPlaying(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBDatedMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetNowPlaying(Language, Page, Region);
  Result:= TTMDBDatedMoviePage.Create(O, FOwner);
end;

function TTMDBServiceMovieLists.GetPopular(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetPopular(Language, Page, Region);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceMovieLists.GetTopRated(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetTopRated(Language, Page, Region);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceMovieLists.GetUpcoming(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBDatedMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetUpcoming(Language, Page, Region);
  Result:= TTMDBDatedMoviePage.Create(O, FOwner);
end;

{ TTMDBServiceMovies }

function TTMDBServiceMovies.GetAccountStates(const MovieID: Integer;
  const SessionID, GuestSessionID: WideString): ITMDBAccountStates;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetAccountStates(MovieID, SessionID, GuestSessionID);
  Result:= TTMDBAccountStates.Create(O);
end;

function TTMDBServiceMovies.GetAlternativeTitles(const MovieID: Integer;
  const Country: WideString): ITMDBAlternativeTitles;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Movies.GetAlternativeTitles(MovieID, Country);
  Result:= TTMDBAlternativeTitles.Create(O, FOwner, TTMDBAlternativeTitle);
end;

function TTMDBServiceMovies.GetCredits(const MovieID: Integer;
  const Language: String): ITMDBCredits;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetCredits(MovieID, Language);
  Result:= TTMDBCredits.Create(O, Owner);
end;

function TTMDBServiceMovies.GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
  const Language: WideString = ''; const SessionID: String = ''): ITMDBMovieDetail;
var
  O: ISuperObject;
  ATR: String;
begin
  ATR:= TMDBMovieRequestsToStr(AppendToResponse);
  O:= FOwner.FAPI.Movies.GetDetails(MovieID, ATR, Language, SessionID);
  Result:= TTMDBMovieDetail.Create(O, FOwner);
end;

function TTMDBServiceMovies.GetImages(const MovieID: Integer;
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetImages(MovieID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImageGroup.Create(O, FOwner);
end;

function TTMDBServiceMovies.GetKeywords(
  const MovieID: Integer): ITMDBKeywords;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Movies.GetKeywords(MovieID);
  Result:= TTMDBKeywords.Create(O, FOwner, TTMDBKeyword);
end;

function TTMDBServiceMovies.GetLatest: ITMDBMovieDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetLatest;
  Result:= TTMDBMovieDetail.Create(O, FOwner);
end;

function TTMDBServiceMovies.GetReleaseDates(
  const MovieID: Integer): ITMDBReleaseDateCountries;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Movies.GetReleaseDates(MovieID);
  Result:= TTMDBReleaseDateCountries.Create(O);
end;

function TTMDBServiceMovies.GetSimilar(const MovieID: Integer;
  const Language: WideString; const Page: Integer): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetSimilar(MovieID, Language, Page);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceMovies.GetTranslations(
  const MovieID: Integer): ITMDBTranslations;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetTranslations(MovieID);
  Result:= TTMDBTranslations.Create(O, ttMovie);
end;

function TTMDBServiceMovies.GetVideos(const MovieID: Integer;
  const Language: WideString): ITMDBVideos;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetVideos(MovieID, Language);
  Result:= TTMDBVideos.Create(O.A['results'], FOwner, TTMDBVideo);
end;

{ TTMDBServiceNetworks }

function TTMDBServiceNetworks.GetAlternativeNames(
  const NetworkID: Integer): ITMDBAlternativeTitles;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Networks.GetAlternativeNames(NetworkID);
  Result:= TTMDBAlternativeTitles.Create(O, FOwner, TTMDBAlternativeTitle);
end;

function TTMDBServiceNetworks.GetDetails(
  const NetworkID: Integer): ITMDBTVNetworkDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Networks.GetDetails(NetworkID);
  Result:= TTMDBTVNetworkDetail.Create(O);
end;

function TTMDBServiceNetworks.GetImages(
  const NetworkID: Integer): ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Networks.GetImages(NetworkID);
  Result:= TTMDBMediaImageGroup.Create(O, FOwner);
end;

{ TTMDBServiceSearch }

function TTMDBServiceSearch.SearchCollections(const Query: WideString;
  const IncludeAdult: Boolean; const Language, Region: WideString;
  const Page: Integer): ITMDBCollectionPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchCollections(Query, IncludeAdult, Language,
    Page, Region);
  Result:= TTMDBCollectionPage.Create(O, FOwner, TTMDBCollection, TTMDBCollections);
end;

function TTMDBServiceSearch.SearchCompanies(const Query: WideString;
  const Page: Integer): ITMDBCompanyPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchCompanies(Query, Page);
  Result:= TTMDBCompanyPage.Create(O, FOwner, TTMDBCompany, TTMDBCompanies);
end;

function TTMDBServiceSearch.SearchKeywords(const Query: WideString;
  const Page: Integer): ITMDBKeywordPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchKeywords(Query, Page);
  Result:= TTMDBKeywordPage.Create(O, FOwner, TTMDBKeyword, TTMDBKeywords);
end;

function TTMDBServiceSearch.SearchMovies(const Query: WideString;
  const IncludeAdult: Boolean; const Language, Region, PrimaryReleaseYear,
  Year: WideString; const Page: Integer): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchMovies(Query, IncludeAdult, Language, PrimaryReleaseYear,
    Page, Region, Year);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceSearch.SearchMulti(const Query: WideString;
  const IncludeAdult: Boolean; const Language: WideString;
  const Page: Integer): ITMDBMediaPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchMulti(Query, IncludeAdult, Language, Page);
  Result:= TTMDBMediaPage.Create(O, FOwner, TTMDBMedium, TTMDBMedia);
end;

function TTMDBServiceSearch.SearchPeople(const Query: WideString;
  const IncludeAdult: Boolean; const Language: WideString;
  const Page: Integer): ITMDBPersonPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchPerson(Query, IncludeAdult, Language, Page);
  Result:= TTMDBPersonPage.Create(O, FOwner, TTMDBPerson, TTMDBPeople);
end;

function TTMDBServiceSearch.SearchTV(const Query: String;
  const FirstAirDateYear: Integer; const IncludeAdult: Boolean;
  const Language: WideString; const Year, Page: Integer): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchTV(Query, IntToStr(FirstAirDateYear),
    IncludeAdult, Language, Page, IntToStr(Year));
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSerie, TTMDBTVSeries);
end;

{ TTMDBServiceCollections }

function TTMDBServiceCollections.GetDetails(const CollectionID: Integer;
  const Language: WideString): ITMDBCollectionDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Collections.GetDetails(CollectionID, Language);
  Result:= TTMDBCollectionDetail.Create(O, FOwner);
end;

function TTMDBServiceCollections.GetImages(const CollectionID: Integer;
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Collections.GetImages(CollectionID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImageGroup.Create(O, FOwner);
end;

function TTMDBServiceCollections.GetTranslations(
  const CollectionID: Integer): ITMDBTranslations;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Collections.GetTranslations(CollectionID);
  Result:= TTMDBTranslations.Create(O, ttCollection);
end;

{ TTMDBServiceTrending }

function TTMDBServiceTrending.GetMovies(const TimeWindow: TTMDBTimeWindow;
  const Language: WideString; const Page: Integer): ITMDBMoviePage;
var
  O: ISuperObject;
  TW: String;
begin
  case TimeWindow of
    twDay:  TW:= 'day';
    twWeek: TW:= 'week';
  end;
  O:= FOwner.FAPI.Trending.GetMovies(TW, Language, Page);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovie, TTMDBMovies);
end;

function TTMDBServiceTrending.GetTV(const TimeWindow: TTMDBTimeWindow;
  const Language: WideString; const Page: Integer): ITMDBTVSeriesPage;
var
  O: ISuperObject;
  TW: String;
begin
  case TimeWindow of
    twDay:  TW:= 'day';
    twWeek: TW:= 'week';
  end;
  O:= FOwner.FAPI.Trending.GetTV(TW, Language, Page);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSerie, TTMDBTVSeries);
end;

{ TTMDBServiceTVSeries }

function TTMDBServiceTVSeries.GetAccountStates(
  const SeriesID: Integer): ITMDBAccountStates;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetAccountStates(SeriesID, FOwner.LoginState.SessionID);
  Result:= TTMDBAccountStates.Create(O);
end;

function TTMDBServiceTVSeries.GetAlternativeTitles(
  const SeriesID: Integer): ITMDBAlternativeTitles;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.TVSeries.GetAlternativeTitles(SeriesID);
  Result:= TTMDBAlternativeTitles.Create(O, FOwner, TTMDBAlternativeTitle);
end;

function TTMDBServiceTVSeries.GetDetails(const SeriesID: Integer;
  const AppendToResponse: TTMDBTVSeriesRequests;
  const Language: WideString): ITMDBTVSerieDetail;
var
  ATR: String;
  O: ISuperObject;
begin
  ATR:= TMDBTVSeriesRequestsToStr(AppendToResponse);
  O:= FOwner.FAPI.TVSeries.GetDetails(SeriesID, ATR, Language);
  Result:= TTMDBTVSerieDetail.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetCredits(const SeriesID: Integer;
  const Language: WideString): ITMDBCredits;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetCredits(SeriesID, Language);
  Result:= TTMDBCredits.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetImages(const SeriesID: Integer;
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImageGroup;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetImages(SeriesID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImageGroup.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetKeywords(
  const SeriesID: Integer): ITMDBKeywords;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.TVSeries.GetKeywords(SeriesID);
  Result:= TTMDBKeywords.Create(O, FOwner, TTMDBKeyword);
end;

function TTMDBServiceTVSeries.GetLatest: ITMDBTVSerieDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetLatest;
  Result:= TTMDBTVSerieDetail.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetSimilar(const SeriesID: Integer;
  const Language: WideString; const Page: Integer): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetSimilar(SeriesID, Language, Page);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSerie, TTMDBTVSeries);
end;

function TTMDBServiceTVSeries.GetVideos(const SeriesID: Integer;
  const IncludeVideoLanguage, Language: WideString): ITMDBVideos;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetVideos(SeriesID, IncludeVideoLanguage, Language);
  Result:= TTMDBVideos.Create(O.A['results'], FOwner, TTMDBVideo);
end;

{ TTMDBServiceTVEpisodeGroups }

function TTMDBServiceTVEpisodeGroups.GetDetails(
  const TVEpisodeGroupID: String): ITMDBTVEpisodeGroups;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVEpisodeGroups.GetDetail(TVEpisodeGroupID);
  Result:= TTMDBTVEpisodeGroups.Create(O, FOwner);
end;

{ TTMDBServiceWatchProviders }

function TTMDBServiceWatchProviders.GetAvailableRegions(
  const Language: WideString): ITMDBCountries;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetAvailableRegions(Language);
  Result:= TTMDBCountries.Create(A, FOwner, TTMDBCountry);
end;

function TTMDBServiceWatchProviders.GetMovieProviders(const Language,
  WatchRegion: WideString): ITMDBWatchProviders;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetMovieProviders(Language, WatchRegion);
  Result:= TTMDBWatchProviders.Create(A, FOwner, TTMDBWatchProvider);
end;

function TTMDBServiceWatchProviders.GetTVProviders(const Language,
  WatchRegion: WideString): ITMDBWatchProviders;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetTVProviders(Language, WatchRegion);
  Result:= TTMDBWatchProviders.Create(A, FOwner, TTMDBWatchProvider);
end;

{ TTMDBServiceImages }

function TTMDBServiceImages.GetImage(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= FOwner.FAPI.Images.GetImage(Base64, Path, Size);
end;

function TTMDBServiceImages.GetBackdrop(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= GetImage(Base64, Path, Size);
end;

function TTMDBServiceImages.GetLogo(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= GetImage(Base64, Path, Size);
end;

function TTMDBServiceImages.GetPoster(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= GetImage(Base64, Path, Size);
end;

function TTMDBServiceImages.GetProfile(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= GetImage(Base64, Path, Size);
end;

function TTMDBServiceImages.GetStill(var Base64: WideString; const Path,
  Size: WideString): Boolean;
begin
  Result:= GetImage(Base64, Path, Size);
end;

{ TTMDBClient }

constructor TTMDBClient.Create;
begin
  FAPI:= TTMDBAPI.Create(nil);
  FLoginState:= TTMDBLoginState.Create(Self);

  { Create Services }

  FAccount:= TTMDBServiceAccount.Create(Self);
  FAuthentication:= TTMDBServiceAuthentication.Create(Self);
  FCertifications:= TTMDBServiceCertifications.Create(Self);
  FChanges:= TTMDBServiceChanges.Create(Self);
  FCollections:= TTMDBServiceCollections.Create(Self);
  FCompanies:= TTMDBServiceCompanies.Create(Self);
  FConfiguration:= TTMDBServiceConfiguration.Create(Self);
  FCredits:= TTMDBServiceCredits.Create(Self);
  FDiscover:= TTMDBServiceDiscover.Create(Self);
  FFind:= TTMDBServiceFind.Create(Self);
  FGenres:= TTMDBServiceGenres.Create(Self);
  FGuestSessions:= TTMDBServiceGuestSessions.Create(Self);
  FKeywords:= TTMDBServiceKeywords.Create(Self);
  FLists:= TTMDBServiceLists.Create(Self);
  FMovieLists:= TTMDBServiceMovieLists.Create(Self);
  FMovies:= TTMDBServiceMovies.Create(Self);
  FNetworks:= TTMDBServiceNetworks.Create(Self);
  FPeopleLists:= TTMDBServicePeopleLists.Create(Self);
  FPeople:= TTMDBServicePeople.Create(Self);
  FReviews:= TTMDBServiceReviews.Create(Self);
  FSearch:= TTMDBServiceSearch.Create(Self);
  FTrending:= TTMDBServiceTrending.Create(Self);
  FTVSeriesLists:= TTMDBServiceTVSeriesLists.Create(Self);
  FTVSeries:= TTMDBServiceTVSeries.Create(Self);
  FTVSeasons:= TTMDBServiceTVSeasons.Create(Self);
  FTVEpisodes:= TTMDBServiceTVEpisodes.Create(Self);
  FTVEpisodeGroups:= TTMDBServiceTVEpisodeGroups.Create(Self);
  FWatchProviders:= TTMDBServiceWatchProviders.Create(Self);
  FImages:= TTMDBServiceImages.Create(Self);
end;

destructor TTMDBClient.Destroy;
begin
  FAccount:= nil;
  FAuthentication:= nil;
  FCertifications:= nil;
  FChanges:= nil;
  FCollections:= nil;
  FCredits:= nil;
  FDiscover:= nil;
  FFind:= nil;
  FGenres:= nil;
  FGuestSessions:= nil;
  FKeywords:= nil;
  FLists:= nil;
  FMovieLists:= nil;
  FMovies:= nil;
  FNetworks:= nil;
  FPeopleLists:= nil;
  FPeople:= nil;
  FReviews:= nil;
  FSearch:= nil;
  FTrending:= nil;
  FTVSeriesLists:= nil;
  FTVSeries:= nil;
  FTVSeasons:= nil;
  FTVEpisodes:= nil;
  FTVEpisodeGroups:= nil;
  FWatchProviders:= nil;
  FImages:= nil;

  FLoginState:= nil;
  FCache:= nil;

  FreeAndNil(FAPI);
  inherited;
end;

function TTMDBClient.GetAccessToken: WideString;
begin
  Result:= FAPI.APIReadAccessToken;
end;

function TTMDBClient.GetAPIKey: WideString;
begin
  Result:= FAPI.APIKey;
end;

function TTMDBClient.GetAuthMethod: TTMDBAuthMethod;
begin
  Result:= FAPI.AuthMethod;
end;

function TTMDBClient.GetCache: ITMDBCache;
begin
  if FCache = nil then begin
    FCache:= TTMDBCache.Create(Self);
  end;
  Result:= FCache;
end;

function TTMDBClient.GetLoginState: ITMDBLoginState;
begin
  Result:= FLoginState;
end;

function TTMDBClient.GetOnUserAuthRequest: TTMDBUserAuthRequestEvent;
begin
  Result:= Self.FOnUserAuthRequest;
end;

function TTMDBClient.GetUserAuth: TTMDBUserAuth;
begin
  Result:= FUserAuth;
end;

procedure TTMDBClient.SetAccessToken(const Value: WideString);
begin
  FAPI.APIReadAccessToken:= Value;
end;

procedure TTMDBClient.SetAPIKey(const Value: WideString);
begin
  FAPI.APIKey:= Value;
end;

procedure TTMDBClient.SetAuthMethod(const Value: TTMDBAuthMethod);
begin
  FAPI.AuthMethod:= Value;
end;

procedure TTMDBClient.SetOnUserAuthRequest(
  const Value: TTMDBUserAuthRequestEvent);
begin
  Self.FOnUserAuthRequest:= Value;
end;

procedure TTMDBClient.SetUserAuth(const Value: TTMDBUserAuth);
begin
  FUserAuth:= Value;
end;

function TTMDBClient.Account: ITMDBServiceAccount;
begin
  Result:= FAccount;
end;

function TTMDBClient.Authentication: ITMDBServiceAuthentication;
begin
  Result:= FAuthentication;
end;

function TTMDBClient.Certifications: ITMDBServiceCertifications;
begin
  Result:= FCertifications;
end;

function TTMDBClient.Changes: ITMDBServiceChanges;
begin
  Result:= FChanges;
end;

function TTMDBClient.Collections: ITMDBServiceCollections;
begin
  Result:= FCollections;
end;

function TTMDBClient.Companies: ITMDBServiceCompanies;
begin
  Result:= FCompanies;
end;

function TTMDBClient.Configuration: ITMDBServiceConfiguration;
begin
  Result:= FConfiguration;
end;

function TTMDBClient.Credits: ITMDBServiceCredits;
begin
  Result:= FCredits;
end;

function TTMDBClient.Discover: ITMDBServiceDiscover;
begin
  Result:= FDiscover;
end;

procedure TTMDBClient.DoUserAuthRequest(const RequestToken: WideString;
  var Result: Boolean);
var
  U: String;
begin
  if Assigned(FOnUserAuthRequest) then begin
    U:= 'https://www.themoviedb.org/authenticate/'+RequestToken;
    FOnUserAuthRequest(Self, U, Result);
  end;
end;

function TTMDBClient.Find: ITMDBServiceFind;
begin
  Result:= FFind;
end;

function TTMDBClient.Genres: ITMDBServiceGenres;
begin
  Result:= FGenres;
end;

function TTMDBClient.GuestSessions: ITMDBServiceGuestSessions;
begin
  Result:= FGuestSessions;
end;

function TTMDBClient.Images: ITMDBServiceImages;
begin
  Result:= FImages;
end;

function TTMDBClient.Keywords: ITMDBServiceKeywords;
begin
  Result:= FKeywords;
end;

function TTMDBClient.Lists: ITMDBServiceLists;
begin
  Result:= FLists;
end;

function TTMDBClient.MovieLists: ITMDBServiceMovieLists;
begin
  Result:= FMovieLists;
end;

function TTMDBClient.Movies: ITMDBServiceMovies;
begin
  Result:= FMovies;
end;

function TTMDBClient.Networks: ITMDBServiceNetworks;
begin
  Result:= FNetworks;
end;

function TTMDBClient.People: ITMDBServicePeople;
begin
  Result:= FPeople;
end;

function TTMDBClient.PeopleLists: ITMDBServicePeopleLists;
begin
  Result:= FPeopleLists;
end;

function TTMDBClient.Reviews: ITMDBServiceReviews;
begin
  Result:= FReviews;
end;

function TTMDBClient.Search: ITMDBServiceSearch;
begin
  Result:= FSearch;
end;

function TTMDBClient.Trending: ITMDBServiceTrending;
begin
  Result:= FTrending;
end;

function TTMDBClient.TVEpisodeGroups: ITMDBServiceTVEpisodeGroups;
begin
  Result:= FTVEpisodeGroups;
end;

function TTMDBClient.TVEpisodes: ITMDBServiceTVEpisodes;
begin
  Result:= FTVEpisodes;
end;

function TTMDBClient.TVSeasons: ITMDBServiceTVSeasons;
begin
  Result:= FTVSeasons;
end;

function TTMDBClient.TVSeries: ITMDBServiceTVSeries;
begin
  Result:= FTVSeries;
end;

function TTMDBClient.TVSeriesLists: ITMDBServiceTVSeriesLists;
begin
  Result:= FTVSeriesLists;
end;

function TTMDBClient.WatchProviders: ITMDBServiceWatchProviders;
begin
  Result:= FWatchProviders;
end;

end.
