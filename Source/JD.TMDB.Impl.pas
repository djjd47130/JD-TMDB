unit JD.TMDB.Impl;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  TMDB Object Interface Implementation

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.TMDB.API, JD.TMDB.Intf,
  XSuperObject;

type

  { Pagination Related }

  TTMDBPageItem = class;

  //[DONE]
  TTMDBPage = class(TInterfacedObject, ITMDBPage)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBPageItem>;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem;
  end;

  //[DONE]
  TTMDBPageItem = class(TInterfacedObject, ITMDBPageItem)
  private
    FOwner: ITMDBPage;
    FObj: ISuperObject;
    FIndex: Integer;
  protected
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;
  public
    constructor Create(AOwner: ITMDBPage; AObj: ISuperObject;
      const AIndex: Integer); virtual;
    destructor Destroy; override;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;



  { Account Related }

  //[DONE]
  TTMDBAccountDetail = class(TInterfacedObject, ITMDBAccountDetail)
  private
    FObj: ISuperObject;
  protected
    function GetID: Integer; stdcall;
    function GetUserName: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);

    property ID: Integer read GetID;
    property UserName: WideString read GetUserName;
    property Name: WideString read GetName;
    property IncludeAdult: Boolean read GetIncludeAdult;
    property CountryCode: WideString read GetCountryCode;
    property LanguageCode: WideString read GetLanguageCode;
    property GravatarHash: WideString read GetGravatarHash;
    property TMDBAvatarPath: WideString read GetTMDBAvatarPath;
  end;

  //[DONE]
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

  //[DONE]
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



  { Authentication Related }

  //[DONE]
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

  //[DONE]
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

  //[DONE]
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

  //[DONE]
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

  //[DONE]
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

  //[DONE]
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



  { Certification Related }

  //[DONE]
  TTMDBCertificationItem = class(TInterfacedObject, ITMDBCertificationItem)
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

  //[DONE]
  TTMDBCertificationCountry = class(TInterfacedObject, ITMDBCertificationCountry)
  private
    FObj: ISuperArray;
    FOwner: ITMDBCertificationCountries;
    FItems: TList<ITMDBCertificationItem>;
    FCountryCode: WideString;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertificationItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; AOwner: ITMDBCertificationCountries;
      const CountryCode: WideString); virtual;
    destructor Destroy; override;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationItem read GetItem;
  end;

  //[DONE]
  TTMDBCertificationCountries = class(TInterfacedObject, ITMDBCertificationCountries)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBCertificationCountry>;
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



  { Changes Related }



  { Collections Related}



  { Companies Related }



  { Configuration Related }

  //[DONE]
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

  //[DONE]
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



  { Countries Related }

  //[DONE]
  TTMDBCountryList = class(TInterfacedObject, ITMDBCountryList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBCountryItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCountryItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCountryItem read GetItem; default;
  end;

  //[DONE]
  TTMDBCountryItem = class(TInterfacedObject, ITMDBCountryItem)
  private
    FObj: ISuperObject;
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetNativeName: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;



  { Jobs / Departments Related }

  //[DONE]
  TTMDBJobDepartmentList = class(TInterfacedObject, ITMDBJobDepartmentList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBJobDepartmentItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBJobDepartmentItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBJobDepartmentItem read GetItem; default;
  end;

  //[DONE]
  TTMDBJobDepartmentItem = class(TInterfacedObject, ITMDBJobDepartmentItem)
  private
    FObj: ISuperObject;
  protected
    function GetDepartment: WideString; stdcall;
    function GetJobs: TTMDBStrArray; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property Department: WideString read GetDepartment;
    property Jobs: TTMDBStrArray read GetJobs;
  end;



  { Languages Related }

  //[DONE]
  TTMDBLanguageList = class(TInterfacedObject, ITMDBLanguageList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBLanguageItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBLanguageItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBLanguageItem read GetItem; default;
  end;

  //[DONE]
  TTMDBLanguageItem = class(TInterfacedObject, ITMDBLanguageItem)
  private
    FObj: ISuperObject;
  protected
    function GetISO639_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ISO639_1: WideString read GetISO639_1;
    property EnglishName: WideString read GetEnglishName;
    property Name: WideString read GetName;
  end;



  { Timezones Related }

  //[DONE]
  TTMDBTimezoneList = class(TInterfacedObject, ITMDBTimezoneList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBTimezoneItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTimezoneItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTimezoneItem read GetItem; default;
  end;

  //[DONE]
  TTMDBTimezoneItem = class(TInterfacedObject, ITMDBTimezoneItem)
  private
    FObj: ISuperObject;
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetZones: TTMDBStrArray; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ISO3166_1: WideString read GetISO3166_1;
    property Zones: TTMDBStrArray read GetZones;
  end;



  { Genres Related }

  //[DONE]
  TTMDBGenreList = class(TInterfacedObject, ITMDBGenreList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBGenreItem>;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBGenreItem; stdcall;
  public
    constructor Create(AObj: ISuperArray); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem;
  end;

  //[DONE]
  TTMDBGenreItem = class(TInterfacedObject, ITMDBGenreItem)
  private
    FObj: ISuperObject;
    FOwner: ITMDBGenreList;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(AOwner: TTMDBGenreList; AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;



  { Movie Related }

  //[DONE]
  TTMDBMoviePage = class(TTMDBPage, ITMDBMoviePage)
  protected
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBMovieItem read GetItem; default;
  end;

  //[DONE]
  TTMDBMovieItem = class(TTMDBPageItem, ITMDBMovieItem)
  private
    FGenres: ITMDBGenreList;
  protected
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
  public
    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property ID: Integer read GetID;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Title: WideString read GetTitle;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  //[DONE]
  TTMDBRatedMoviePage = class(TTMDBMoviePage, ITMDBRatedMoviePage)
  protected
    function GetItem(const Index: Integer): ITMDBRatedMovieItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedMovieItem read GetItem; default;
  end;

  //[DONE]
  TTMDBRatedMovieItem = class(TTMDBMovieItem, ITMDBRatedMovieItem)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;



  { TV Related }

  TTMDBTVItem = class;

  //[DONE]
  TTMDBTVPage = class(TTMDBPage, ITMDBTVPage)
  protected
    function GetItem(const Index: Integer): ITMDBTVItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVItem read GetItem; default;
  end;

  //[DONE]
  TTMDBTVItem = class(TTMDBPageItem, ITMDBTVItem)
  protected
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetID: Integer; stdcall;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetFirstAirDate: TDateTime; stdcall;
    function GetName: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
  public
    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property ID: Integer read GetID;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property Name: WideString read GetName;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  //[DONE]
  TTMDBRatedTVPage = class(TTMDBTVPage, ITMDBRatedTVPage)
  protected
    function GetItem(const Index: Integer): ITMDBRatedTVItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedTVItem read GetItem; default;
  end;

  //[DONE]
  TTMDBRatedTVItem = class(TTMDBTVItem, ITMDBRatedTVItem)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;



  { Pagination Related }

  //[DONE]
  TTMDBListPage = class(TTMDBPage, ITMDBListPage)
  protected
    function GetItem(const Index: Integer): ITMDBListPageItem;
  public
    property Items[const Index: Integer]: ITMDBListPageItem read GetItem; default;
  end;

  //[DONE]
  TTMDBListPageItem = class(TTMDBPageItem, ITMDBListPageItem)
  protected
    function GetDescription: WideString;
    function GetFavoriteCount: Integer;
    function GetID: Integer;
    function GetItemCount: Integer;
    function GetISO639_1: WideString;
    function GetListType: TTMDBListType;
    function GetName: WideString;
    function GetPosterPath: WideString;
  public
    property Description: WideString read GetDescription;
    property FavoriteCount: Integer read GetFavoriteCount;
    property ID: Integer read GetID;
    property ItemCount: Integer read GetItemCount;
    property ISO639_1: WideString read GetISO639_1;
    property ListType: TTMDBListType read GetListType;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
  end;




////////////////////////////////////////////////////////////////////////////////



type
  TTMDB = class;

  { API Services }

  TTMDBService = class(TInterfacedObject, ITMDBService)
  private
    FOwner: TTMDB;
  protected
    property Owner: TTMDB read FOwner;
  public
    constructor Create(AOwner: TTMDB);
    destructor Destroy; override;
  end;

  TTMDBServiceAccount = class(TTMDBService, ITMDBServiceAccount)
  protected
    function GetDetails(AAccountID: Integer;
      ASessionID: WideString = ''): ITMDBAccountDetail; stdcall;
    function SetFavorite(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult; stdcall;
    function SetWatchlist(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult; stdcall;
    function GetFavoriteMovies(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetFavoriteTV(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBTVPage; stdcall;
    function GetLists(const AccountID: Integer; const Page: Integer = 1;
      const SessionID: WideString = ''): ITMDBListPage; stdcall;
    function GetRatedMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedMoviePage; stdcall;
    function GetRatedTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVPage; stdcall;
    //GetRatedTVEpisodes
    //GetWatchlistMovies
    //GetWatchlistTV
  end;

  TTMDBServiceAuthentication = class(TTMDBService, ITMDBServiceAuthentication)
  protected
    function CreateGuestSession: ITMDBAuthGuestSessionResult;
    function CreateRequestToken: ITMDBAuthRequestTokenResult;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin;
    function DeleteSession(const SessionID: WideString): ITMDBAuthDeleteSessionResult;
    function ValidateKey: ITMDBAuthValidateKeyResult;
  end;

  TTMDBServiceCertifications = class(TTMDBService, ITMDBServiceCertifications)
  protected
    function GetMovieCertifications: ITMDBCertificationCountries;
    function GetTVCertifications: ITMDBCertificationCountries;
  end;

  TTMDBServiceChanges = class(TTMDBService, ITMDBServiceChanges)
  protected

  end;

  TTMDBServiceCollections = class(TTMDBService, ITMDBServiceCollections)
  protected

  end;

  TTMDBServiceCompanies = class(TTMDBService, ITMDBServiceCompanies)
  protected

  end;

  TTMDBServiceConfiguration = class(TTMDBService, ITMDBServiceConfiguration)
  protected
    function GetDetails: ITMDBConfiguration;
    function GetCountries: ITMDBCountryList;
    function GetJobs: ITMDBJobDepartmentList;
    function GetLanguages: ITMDBLanguageList;
    function GetPrimaryTranslations: TTMDBStrArray;
    function GetTimezones: ITMDBTimezoneList;
  end;

  TTMDBServiceCredits = class(TTMDBService, ITMDBServiceCredits)
  protected

  end;

  TTMDBServiceDiscover = class(TTMDBService, ITMDBServiceDiscover)
  protected
    //HUGE CONCEPT - Need to visit later...
  end;

  TTMDBServiceFind = class(TTMDBService, ITMDBServiceFind)
  protected

  end;

  TTMDBServiceGenres = class(TTMDBService, ITMDBServiceGenres)
  protected
    function GetMovieList(const Language: WideString = ''): ITMDBGenreList; stdcall;
    function GetTVList(const Language: WideString = ''): ITMDBGenreList; stdcall;
  end;

  TTMDBServiceGuestSessions = class(TTMDBService, ITMDBServiceGuestSessions)
  protected

  end;

  TTMDBServiceKeywords = class(TTMDBService, ITMDBServiceKeywords)
  protected

  end;

  TTMDBServiceLists = class(TTMDBService, ITMDBServiceLists)
  protected

  end;

  TTMDBServiceMovieLists = class(TTMDBService, ITMDBServiceMovieLists)
  protected

  end;

  TTMDBServiceMovies = class(TTMDBService, ITMDBServiceMovies)
  protected
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieDetails = [];
      const Language: WideString = ''): ITMDBMovieDetail; stdcall;

  end;

  TTMDBServiceNetworks = class(TTMDBService, ITMDBServiceNetworks)
  protected

  end;

  TTMDBServicePeopleLists = class(TTMDBService, ITMDBServicePeopleLists)
  protected

  end;

  TTMDBServicePeople = class(TTMDBService, ITMDBServicePeople)
  protected

  end;

  TTMDBServiceReviews = class(TTMDBService, ITMDBServiceReviews)
  protected

  end;

  TTMDBServiceSearch = class(TTMDBService, ITMDBServiceSearch)
  protected
    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;


  end;

  TTMDBServiceTrending = class(TTMDBService, ITMDBServiceTrending)
  protected

  end;

  TTMDBServiceTVSeriesLists = class(TTMDBService, ITMDBServiceTVSeriesLists)
  protected

  end;

  TTMDBServiceTVSeries = class(TTMDBService, ITMDBServiceTVSeries)
  protected

  end;

  TTMDBServiceTVSeasons = class(TTMDBService, ITMDBServiceTVSeasons)
  protected

  end;

  TTMDBServiceTVEpisodes = class(TTMDBService, ITMDBServiceTVEpisodes)
  protected

  end;

  TTMDBServiceTVEpisodeGroups = class(TTMDBService, ITMDBServiceTVEpisodeGroups)
  protected

  end;

  TTMDBServiceWatchProviders = class(TTMDBService, ITMDBServiceWatchProviders)
  protected

  end;




////////////////////////////////////////////////////////////////////////////////





  TTMDB = class(TInterfacedObject, ITMDB)
  private
    FAPI: TTMDBAPI;
    FAPIAuth: TTMDBAuthMethod;
    FUserAuth: TTMDBUserAuth;

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
  protected
    function GetAPIKey: WideString; stdcall;
    procedure SetAPIKey(const Value: WideString); stdcall;
    function GetAccessToken: WideString; stdcall;
    procedure SetAccessToken(const Value: WideString); stdcall;
    function GetAuthMethod: TTMDBAuthMethod; stdcall;
    procedure SetAuthMethod(const Value: TTMDBAuthMethod); stdcall;
    function GetUserAuth: TTMDBUserAuth; stdcall;
    procedure SetUserAuth(const Value: TTMDBUserAuth); stdcall;

  public
    constructor Create;
    destructor Destroy; override;

    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;

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
  end;


implementation

{ TTMDBPage }

constructor TTMDBPage.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBPageItem>.Create;
  PopulateItems;
end;

destructor TTMDBPage.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBPage.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBPage.GetItem(const Index: Integer): ITMDBPageItem;
begin
  Result:= FItems[Index];
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

procedure TTMDBPage.Clear;
begin
  //TODO: Reference counting?
  FItems.Clear;
end;

procedure TTMDBPage.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBPageItem;
begin
  Clear;
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
    I:= TTMDBPageItem.Create(Self, O, X);
    FItems.Add(I);
  end;
end;

{ TTMDBPageItem }

constructor TTMDBPageItem.Create(AOwner: ITMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  FOwner:= AOwner;
  FObj:= AObj;
  FIndex:= AIndex;
end;

destructor TTMDBPageItem.Destroy;
begin

  inherited;
end;

function TTMDBPageItem.GetIndex: Integer;
begin
  Result:= FIndex;
end;

function TTMDBPageItem.GetOwner: ITMDBPage;
begin
  Result:= FOwner;
end;

{ TTMDBAccountDetail }

constructor TTMDBAccountDetail.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

function TTMDBAccountDetail.GetCountryCode: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBAccountDetail.GetGravatarHash: WideString;
begin
  Result:= FObj.O['avatar'].O['gravatar'].S['hash'];
end;

function TTMDBAccountDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBAccountDetail.GetIncludeAdult: Boolean;
begin
  Result:= FObj.B['include_adult'];
end;

function TTMDBAccountDetail.GetLanguageCode: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBAccountDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
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
  Result:= StrToDateTimeDef(S, 0);
  //TODO: This will probably fail and return 0 due to extra text in string...

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
  Result:= StrToDateTimeDef(S, 0);
  //TODO: This will probably fail and return 0 due to extra text in string...

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

constructor TTMDBCertificationItem.Create(AObj: ISuperObject; AOwner: ITMDBCertificationCountry);
begin
  FObj:= AObj;
  FOwner:= AOwner;
end;

destructor TTMDBCertificationItem.Destroy;
begin

  inherited;
end;

function TTMDBCertificationItem.GetCertification: WideString;
begin
  Result:= FObj.S['certification'];
end;

function TTMDBCertificationItem.GetMeaning: WideString;
begin
  Result:= FObj.S['meaning'];
end;

function TTMDBCertificationItem.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

{ TTMDBCertificationCountries }

procedure TTMDBCertificationCountries.Clear;
begin
  FItems.Clear;
end;

constructor TTMDBCertificationCountries.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBCertificationCountry>.Create;
  PopulateItems;
end;

destructor TTMDBCertificationCountries.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBCertificationCountries.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBCertificationCountries.GetItem(
  const Index: Integer): ITMDBCertificationCountry;
begin
  Result:= FItems[Index];
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
    FItems.Add(I);
  end;
end;

{ TTMDBCertificationCountry }

constructor TTMDBCertificationCountry.Create(AObj: ISuperArray; AOwner: ITMDBCertificationCountries;
  const CountryCode: WideString);
begin
  FObj:= AObj;
  FOwner:= AOwner;
  FItems:= TList<ITMDBCertificationItem>.Create;
  PopulateItems;
end;

destructor TTMDBCertificationCountry.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TTMDBCertificationCountry.Clear;
begin
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
  const Index: Integer): ITMDBCertificationItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBCertificationCountry.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCertificationItem;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCertificationItem.Create(O, Self);
    FItems.Add(I);
  end;
end;

{ TTMDBServiceCertifications }

function TTMDBServiceCertifications.GetMovieCertifications: ITMDBCertificationCountries;
var
  Res: ISuperObject;
begin
  Res:= Owner.FAPI.Certifications.GetMovieCertifications;
  Result:= TTMDBCertificationCountries.Create(Res);
end;

function TTMDBServiceCertifications.GetTVCertifications: ITMDBCertificationCountries;
var
  Res: ISuperObject;
begin
  Res:= Owner.FAPI.Certifications.GetTVCertifications;
  Result:= TTMDBCertificationCountries.Create(Res);
end;

{ TTMDBJobDepartmentList }

procedure TTMDBJobDepartmentList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBJobDepartmentList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBJobDepartmentItem>.Create;
  PopulateItems;
end;

destructor TTMDBJobDepartmentList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBJobDepartmentList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBJobDepartmentList.GetItem(
  const Index: Integer): ITMDBJobDepartmentItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBJobDepartmentList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBJobDepartmentItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBJobDepartmentItem.Create(O);
    FItems.Add(I);
  end;
end;

{ TTMDBJobDepartmentItem }

constructor TTMDBJobDepartmentItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBJobDepartmentItem.Destroy;
begin

  inherited;
end;

function TTMDBJobDepartmentItem.GetDepartment: WideString;
begin
  Result:= FObj.S['department'];
end;

function TTMDBJobDepartmentItem.GetJobs: TTMDBStrArray;
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

constructor TTMDBGenreList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBGenreItem>.Create;
  PopulateItems;
end;

destructor TTMDBGenreList.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TTMDBGenreList.Clear;
begin
  FItems.Clear;
end;

function TTMDBGenreList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBGenreList.GetItem(const Index: Integer): ITMDBGenreItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBGenreList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBGenreItem;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBGenreItem.Create(Self, O);
    FItems.Add(I);
  end;
end;

{ TTMDBGenreItem }

constructor TTMDBGenreItem.Create(AOwner: TTMDBGenreList; AObj: ISuperObject);
begin
  FOwner:= AOwner;
  FObj:= AObj;
end;

destructor TTMDBGenreItem.Destroy;
begin

  inherited;
end;

function TTMDBGenreItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBGenreItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBConfigurationImages }

function JSONToStrArray(Arr: ISuperArray): TTMDBStrArray;
var
  X: Integer;
begin
  SetLength(Result, Arr.Length);
  for X := 0 to Arr.Length-1 do begin
    Result[X]:= Arr.S[X];
  end;
end;

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

constructor TTMDBCountryList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBCountryItem>.Create;
  PopulateItems;
end;

destructor TTMDBCountryList.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBCountryList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBCountryList.GetItem(const Index: Integer): ITMDBCountryItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBCountryList.ClearItems;
begin
  FItems.Clear;
end;

procedure TTMDBCountryList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCountryItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCountryItem.Create(O);
    FItems.Add(I);
  end;
end;

{ TTMDBCountryItem }

constructor TTMDBCountryItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBCountryItem.Destroy;
begin

  inherited;
end;

function TTMDBCountryItem.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBCountryItem.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBCountryItem.GetNativeName: WideString;
begin
  Result:= FObj.S['native_name'];
end;

{ TTMDBLanguageList }

procedure TTMDBLanguageList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBLanguageList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBLanguageItem>.Create;
  PopulateItems;
end;

destructor TTMDBLanguageList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBLanguageList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBLanguageList.GetItem(const Index: Integer): ITMDBLanguageItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBLanguageList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBLanguageItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBLanguageItem.Create(O);
    FItems.Add(I);
  end;
end;

{ TTMDBLanguageItem }

constructor TTMDBLanguageItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBLanguageItem.Destroy;
begin

  inherited;
end;

function TTMDBLanguageItem.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBLanguageItem.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBLanguageItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBTimezoneList }

procedure TTMDBTimezoneList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTimezoneList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBTimezoneItem>.Create;
  PopulateItems;
end;

destructor TTMDBTimezoneList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBTimezoneList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBTimezoneList.GetItem(const Index: Integer): ITMDBTimezoneItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBTimezoneList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTimezoneItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBTimezoneItem.Create(O);
    FItems.Add(I);
  end;
end;

{ TTMDBTimezoneItem }

constructor TTMDBTimezoneItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBTimezoneItem.Destroy;
begin

  inherited;
end;

function TTMDBTimezoneItem.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBTimezoneItem.GetZones: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['zones']);
end;

{ TTMDBMoviePage }

function TTMDBMoviePage.GetItem(const Index: Integer): ITMDBMovieItem;
begin
  Result:= ITMDBMovieItem(inherited GetItem(Index));
end;

{ TTMDBMovieItem }

function TTMDBMovieItem.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBMovieItem.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBMovieItem.GetGenres: ITMDBGenreList;
var
  A: ISuperArray;
begin
  if FGenres = nil then begin
    A:= FObj.A['genre_ids'];
    //TODO


  end;
end;

function TTMDBMovieItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMovieItem.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBMovieItem.GetOriginalTitle: WideString;
begin
  Result:= FObj.S['original_title'];
end;

function TTMDBMovieItem.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBMovieItem.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBMovieItem.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBMovieItem.GetReleaseDate: TDateTime;
var
  S: String;
begin
  S:= FObj.S['release_date'];
  Result:= StrToDateTimeDef(S, 0);
end;

function TTMDBMovieItem.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

function TTMDBMovieItem.GetVideo: Boolean;
begin
  Result:= FObj.B['video'];
end;

function TTMDBMovieItem.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBMovieItem.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBRatedMoviePage }

function TTMDBRatedMoviePage.GetItem(const Index: Integer): ITMDBRatedMovieItem;
begin
  Result:= ITMDBRatedMovieItem(inherited GetItem(Index));
end;

{ TTMDBRatedMovieItem }

function TTMDBRatedMovieItem.GetRating: Single;
begin
  Result:= FObj.F['rating'];
end;

{ TTMDBTVPage }

function TTMDBTVPage.GetItem(const Index: Integer): ITMDBTVItem;
begin
  Result:= ITMDBTVItem(inherited GetItem(Index));
end;

{ TTMDBTVItem }

function TTMDBTVItem.GetAdult: Boolean;
begin

end;

function TTMDBTVItem.GetBackdropPath: WideString;
begin

end;

function TTMDBTVItem.GetFirstAirDate: TDateTime;
begin

end;

function TTMDBTVItem.GetGenres: ITMDBGenreList;
begin

end;

function TTMDBTVItem.GetID: Integer;
begin

end;

function TTMDBTVItem.GetName: WideString;
begin

end;

function TTMDBTVItem.GetOriginalLanguage: WideString;
begin

end;

function TTMDBTVItem.GetOriginalName: WideString;
begin

end;

function TTMDBTVItem.GetOriginCountry: TTMDBStrArray;
begin

end;

function TTMDBTVItem.GetOverview: WideString;
begin

end;

function TTMDBTVItem.GetPopularity: Single;
begin

end;

function TTMDBTVItem.GetPosterPath: WideString;
begin

end;

function TTMDBTVItem.GetVoteAverage: Single;
begin

end;

function TTMDBTVItem.GetVoteCount: Integer;
begin

end;

{ TTMDBRatedTVPage }

function TTMDBRatedTVPage.GetItem(const Index: Integer): ITMDBRatedTVItem;
begin

end;

{ TTMDBRatedTVItem }

function TTMDBRatedTVItem.GetRating: Single;
begin

end;

{ TTMDBListPage }

function TTMDBListPage.GetItem(const Index: Integer): ITMDBListPageItem;
begin

end;

{ TTMDBListPageItem }

function TTMDBListPageItem.GetDescription: WideString;
begin

end;

function TTMDBListPageItem.GetFavoriteCount: Integer;
begin

end;

function TTMDBListPageItem.GetID: Integer;
begin

end;

function TTMDBListPageItem.GetISO639_1: WideString;
begin

end;

function TTMDBListPageItem.GetItemCount: Integer;
begin

end;

function TTMDBListPageItem.GetListType: TTMDBListType;
begin

end;

function TTMDBListPageItem.GetName: WideString;
begin

end;

function TTMDBListPageItem.GetPosterPath: WideString;
begin

end;











////////////////////////////////////////////////////////////////////////////////











{ TTMDBService }

constructor TTMDBService.Create(AOwner: TTMDB);
begin
  FOwner:= AOwner;
end;

destructor TTMDBService.Destroy;
begin

  inherited;
end;

{ TTMDBServiceAccount }

function TTMDBServiceAccount.GetDetails(AAccountID: Integer;
  ASessionID: WideString): ITMDBAccountDetail;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetDetails(AAccountID, ASessionID);
  Result:= TTMDBAccountDetail.Create(O);
end;

function TTMDBServiceAccount.SetFavorite(const AccountID: Integer;
  const MediaType: TTMDBMediaType; const MediaID: Integer;
  const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.AddFavorite(AccountID, MediaTypeStr(MediaType), MediaID, Favorite, SessionID);
  Result:= TTMDBAccountAddFavoriteResult.Create(O);
end;

function TTMDBServiceAccount.SetWatchlist(const AccountID: Integer;
  const MediaType: TTMDBMediaType; const MediaID: Integer;
  const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.AddToWatchlist(AccountID, MediaTypeStr(MediaType), MediaID, Watchlist, SessionID);
  Result:= TTMDBAccountAddWatchlistResult.Create(O);
end;

function TTMDBServiceAccount.GetFavoriteMovies(const AccountID: Integer; const Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetFavoriteMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBMoviePage.Create(O);
end;

function TTMDBServiceAccount.GetFavoriteTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVPage;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetFavoriteTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVPage.Create(O);
end;

function TTMDBServiceAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: WideString): ITMDBListPage;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetLists(AccountID, Page, SessionID);
  Result:= TTMDBListPage.Create(O);
end;

function TTMDBServiceAccount.GetRatedMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedMoviePage;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetRatedMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedMoviePage.Create(O);
end;

function TTMDBServiceAccount.GetRatedTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedTVPage;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Account.GetRatedTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedTVPage.Create(O);
end;

{ TTMDBServiceAuthentication }

function TTMDBServiceAuthentication.CreateGuestSession: ITMDBAuthGuestSessionResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.CreateGuestSession;
  Result:= TTMDBAuthGuestSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateRequestToken: ITMDBAuthRequestTokenResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.CreateRequestToken;
  Result:= TTMDBAuthRequestTokenResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateSession(
  const ARequestToken: WideString): ITMDBAuthSessionResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.CreateSession(ARequestToken);
  Result:= TTMDBAuthSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.CreateSessionLogin(const AUsername,
  APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.CreateSessionLogin(AUsername, APassword, ARequestToken);
  Result:= TTMDBAuthSessionResultLogin.Create(O);
end;

function TTMDBServiceAuthentication.CreateSessionV4(
  const AAccessToken: WideString): ITMDBAuthSessionResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.CreateSessionV4(AAccessToken);
  Result:= TTMDBAuthSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.DeleteSession(
  const SessionID: WideString): ITMDBAuthDeleteSessionResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.DeleteSession(SessionID);
  Result:= TTMDBAuthDeleteSessionResult.Create(O);
end;

function TTMDBServiceAuthentication.ValidateKey: ITMDBAuthValidateKeyResult;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Authentication.GetValidateKey;
  Result:= TTMDBAuthValidateKeyResult.Create(O);
end;

{ TTMDBServiceConfiguration }

function TTMDBServiceConfiguration.GetDetails: ITMDBConfiguration;
var
  O: ISuperObject;
begin
  O:= Owner.FAPI.Configuration.GetDetails;
  Result:= TTMDBConfiguration.Create(O);
end;

function TTMDBServiceConfiguration.GetCountries: ITMDBCountryList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Configuration.GetCountries;
  Result:= TTMDBCountryList.Create(A);
end;

function TTMDBServiceConfiguration.GetJobs: ITMDBJobDepartmentList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Configuration.GetJobs;
  Result:= TTMDBJobDepartmentList.Create(A);
end;

function TTMDBServiceConfiguration.GetLanguages: ITMDBLanguageList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Configuration.GetLanguages;
  Result:= TTMDBLanguageList.Create(A);
end;

function TTMDBServiceConfiguration.GetPrimaryTranslations: TTMDBStrArray;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Configuration.GetPrimaryTranslations;
  Result:= JSONToStrArray(A);
end;

function TTMDBServiceConfiguration.GetTimezones: ITMDBTimezoneList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Configuration.GetTimeZones;
  Result:= TTMDBTimezoneList.Create(A);
end;

{ TTMDBServiceGenres }

function TTMDBServiceGenres.GetMovieList(
  const Language: WideString): ITMDBGenreList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Genres.GetMovieList(Language);
  Result:= TTMDBGenreList.Create(A);
end;

function TTMDBServiceGenres.GetTVList(
  const Language: WideString): ITMDBGenreList;
var
  A: ISuperArray;
begin
  A:= Owner.FAPI.Genres.GetTVList(Language);
  Result:= TTMDBGenreList.Create(A);
end;

{ TTMDBServiceMovies }

function TTMDBServiceMovies.GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieDetails = [];
  const Language: WideString = ''): ITMDBMovieDetail;
var
  O: ISuperObject;
  ATR: String;
begin
  ATR:= '';
  //TODO: Popular ATR with comma separated string based on AppendToResposne...
  O:= Owner.FAPI.Movies.GetDetails(MovieID, ATR, Language);

end;

{ TTMDBServiceSearch }

function TTMDBServiceSearch.SearchMovies(const Query: WideString;
  const IncludeAdult: Boolean; const Language, Region, PrimaryReleaseYear,
  Year: WideString; const Page: Integer): ITMDBMoviePage;
begin

end;

{ TTMDB }

constructor TTMDB.Create;
begin
  FAPI:= TTMDBAPI.Create(nil);

  { Servicers }

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
end;

destructor TTMDB.Destroy;
begin

  FreeAndNil(FAPI);
  inherited;
end;

function TTMDB.GetAccessToken: WideString;
begin
  Result:= FAPI.APIReadAccessToken;
end;

function TTMDB.GetAPIKey: WideString;
begin
  Result:= FAPI.APIKey;
end;

function TTMDB.GetAuthMethod: TTMDBAuthMethod;
begin
  Result:= FAPIAuth;
end;

function TTMDB.GetUserAuth: TTMDBUserAuth;
begin
  Result:= FUserAuth;
end;

procedure TTMDB.SetAccessToken(const Value: WideString);
begin
  FAPI.APIReadAccessToken:= Value;
end;

procedure TTMDB.SetAPIKey(const Value: WideString);
begin
  FAPI.APIKey:= Value;
end;

procedure TTMDB.SetAuthMethod(const Value: TTMDBAuthMethod);
begin
  FAPIAuth:= Value;
end;

procedure TTMDB.SetUserAuth(const Value: TTMDBUserAuth);
begin
  FUserAuth:= Value;
end;

{ Services }

function TTMDB.Account: ITMDBServiceAccount;
begin
  Result:= FAccount;
end;

function TTMDB.Authentication: ITMDBServiceAuthentication;
begin
  Result:= FAuthentication;
end;

function TTMDB.Certifications: ITMDBServiceCertifications;
begin
  Result:= FCertifications;
end;

function TTMDB.Changes: ITMDBServiceChanges;
begin
  Result:= FChanges;
end;

function TTMDB.Collections: ITMDBServiceCollections;
begin
  Result:= FCollections;
end;

function TTMDB.Companies: ITMDBServiceCompanies;
begin
  Result:= FCompanies;
end;

function TTMDB.Configuration: ITMDBServiceConfiguration;
begin
  Result:= FConfiguration;
end;

function TTMDB.Credits: ITMDBServiceCredits;
begin
  Result:= FCredits;
end;

function TTMDB.Discover: ITMDBServiceDiscover;
begin
  Result:= FDiscover;
end;

function TTMDB.Find: ITMDBServiceFind;
begin
  Result:= FFind;
end;

function TTMDB.Genres: ITMDBServiceGenres;
begin
  Result:= FGenres;
end;

function TTMDB.GuestSessions: ITMDBServiceGuestSessions;
begin
  Result:= FGuestSessions;
end;

function TTMDB.Keywords: ITMDBServiceKeywords;
begin
  Result:= FKeywords;
end;

function TTMDB.Lists: ITMDBServiceLists;
begin
  Result:= FLists;
end;

function TTMDB.MovieLists: ITMDBServiceMovieLists;
begin
  Result:= FMovieLists;
end;

function TTMDB.Movies: ITMDBServiceMovies;
begin
  Result:= FMovies;
end;

function TTMDB.Networks: ITMDBServiceNetworks;
begin
  Result:= FNetworks;
end;

function TTMDB.People: ITMDBServicePeople;
begin
  Result:= FPeople;
end;

function TTMDB.PeopleLists: ITMDBServicePeopleLists;
begin
  Result:= FPeopleLists;
end;

function TTMDB.Reviews: ITMDBServiceReviews;
begin
  Result:= FReviews;
end;

function TTMDB.Search: ITMDBServiceSearch;
begin
  Result:= FSearch;
end;

function TTMDB.Trending: ITMDBServiceTrending;
begin
  Result:= FTrending;
end;

function TTMDB.TVEpisodeGroups: ITMDBServiceTVEpisodeGroups;
begin
  Result:= FTVEpisodeGroups;
end;

function TTMDB.TVEpisodes: ITMDBServiceTVEpisodes;
begin
  Result:= FTVEpisodes;
end;

function TTMDB.TVSeasons: ITMDBServiceTVSeasons;
begin
  Result:= FTVSeasons;
end;

function TTMDB.TVSeries: ITMDBServiceTVSeries;
begin
  Result:= FTVSeries;
end;

function TTMDB.TVSeriesLists: ITMDBServiceTVSeriesLists;
begin
  Result:= FTVSeriesLists;
end;

function TTMDB.WatchProviders: ITMDBServiceWatchProviders;
begin
  Result:= FWatchProviders;
end;

end.
