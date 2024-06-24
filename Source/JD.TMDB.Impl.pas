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

  { Forward Definitions }

  TTMDBPageItem = class;

  TTMDBMoviePage = class;

  TTMDBMovieItem = class;

  TTMDBClient = class;



{$REGION 'Lists Pages and Items'}

  { Pagination Related }

  TTMDBPageItemClass = class of TTMDBPageItem;

  //[DONE]
  TTMDBPage = class(TInterfacedObject, ITMDBPage)
  private
    FTMDB: TTMDBClient;
    FObj: ISuperObject;
    FItems: TObjectList<TTMDBPageItem>;
    FItemClass: TTMDBPageItemClass;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetTMDB: ITMDBClient; stdcall;
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetPageItem(const Index: Integer): ITMDBPageItem; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: TTMDBClient;
      AItemClass: TTMDBPageItemClass); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property PageItems[const Index: Integer]: ITMDBPageItem read GetPageItem; default;

    property TMDB: TTMDBClient read FTMDB;
  end;

  //[DONE]
  TTMDBPageItem = class(TInterfacedObject, ITMDBPageItem)
  private
    FOwner: TTMDBPage;
    FObj: ISuperObject;
    FIndex: Integer;
  protected
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;
  public
    constructor Create(AOwner: TTMDBPage; AObj: ISuperObject;
      const AIndex: Integer); virtual;
    destructor Destroy; override;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;

  /// [DONE]
  TTMDBItemList = class(TInterfacedObject, ITMDBItemList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBPageItem>;
    FItemClass: TTMDBPageItemClass;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; AItemClass: TTMDBPageItemClass); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
  end;

  TTMDBMediaBase = class;

  TTMDBMediaBaseClass = class of TTMDBMediaBase;

  TTMDBMediaBase = class(TTMDBPageItem, ITMDBMediaBase)
  protected
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetAdult: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetPopularity: Single; stdcall;
  public
    property MediaType: TTMDBMediaType read GetMediaType;
    property Adult: Boolean read GetAdult;
    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
    property Popularity: Single read GetPopularity;
  end;

  TTMDBMediaList = class(TInterfacedObject, ITMDBMediaList)
  private
    FObj: ISuperArray;
    FItems: TInterfaceList;
    FBaseClass: TTMDBMediaBaseClass;
    procedure PopulateItems; virtual;
    procedure ClearItems; virtual;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBMediaBase; stdcall;
  public
    constructor Create(AObj: ISuperArray; ABaseClass: TTMDBMediaBaseClass); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBMediaBase read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Account Related'}

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

  /// [DONE]
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

{$ENDREGION}



{$REGION 'Certification Related'}

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
    //FItems: TList<ITMDBCertificationItem>;
    FItems: TInterfaceList;
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

  { Release Date Related }

  TTMDBReleaseDateItem = class;
  TTMDBReleaseDateCountry = class;
  TTMDBReleaseDateCountries = class;

  TTMDBReleaseDateItem = class(TInterfacedObject, ITMDBReleaseDateItem)
  private
    FObj: ISuperObject;
    FOwner: TTMDBReleaseDateCountry;
  protected
    function GetCertification: WideString; stdcall;
    function GetDescriptors: TTMDBStrArray; stdcall; //https://www.themoviedb.org/talk/63bcd118a6e2d20083e25c74
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
    function GetItem(const Index: Integer): ITMDBReleaseDateItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; AOwner: TTMDBReleaseDateCountries;
      const CountryCode: WideString); virtual;
    destructor Destroy; override;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDateItem read GetItem;
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

  { Changes Related }

  TTMDBChangeItem = class(TTMDBPageItem, ITMDBChangeItem)
  protected
    function GetKey: WideString; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;
  public
    constructor Create(AOwner: TTMDBPage; AObj: ISuperObject;
      const AIndex: Integer); override;
    destructor Destroy; override;
  end;

  TTMDBChangePage = class(TTMDBPage, ITMDBChangePage)
  protected
    function GetItem(const Index: Integer): ITMDBChangeItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBChangeItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Company Related'}

  { Companies Related }

  TTMDBCompanyItem = class(TTMDBPageItem, ITMDBCompanyItem)
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

  TTMDBCompanyPage = class(TTMDBPage, ITMDBCompanyPage)
  protected
    function GetItem(const Index: Integer): ITMDBCompanyItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCompanyItem read GetItem; default;
  end;

  TTMDBCompanyList = class(TInterfacedObject, ITMDBCompanyList)
  private
    FItems: TInterfaceList;
    FObj: ISuperArray;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCompanyItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCompanyItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Configuration Related'}

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

{$ENDREGION}



{$REGION 'Country Related'}

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

    function GetByCode(const Code: WideString): ITMDBCountryItem; stdcall;

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

{$ENDREGION}



{$REGION 'Translation Related'}

  { Translation Related }

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

  TTMDBTranslationItem = class(TInterfacedObject, ITMDBTranslationItem)
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

  TTMDBTranslationList = class(TInterfacedObject, ITMDBTranslationList)
  private
    FObj: ISuperObject;
    FItems: TInterfaceList;
    FDataType: TTMDBTranslationType;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTranslationItem; stdcall;
  public
    constructor Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTranslationItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Job / Department Related'}

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

{$ENDREGION}



{$REGION 'Language Related'}

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

    function GetByCode(const Code: WideString): ITMDBLanguageItem; stdcall;

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

{$ENDREGION}



{$REGION 'Timezone Related'}

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

{$ENDREGION}



{$REGION 'Keyword Related'}

  TTMDBKeywordItem = class(TInterfacedObject, ITMDBKeywordItem)
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

  TTMDBKeywordList = class(TInterfacedObject, ITMDBKeywordList)
  private
    FObj: ISuperArray;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBKeywordItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBKeywordItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Images Related'}

  { Image Related }

  /// [DONE]
  TTMDBMediaImage = class(TInterfacedObject, ITMDBMediaImage)
  private
    FObj: ISuperObject;
  protected
    function GetAspectRatio: Single; stdcall;
    function GetHeight: Integer; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetFilePath: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetWidth: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property AspectRatio: Single read GetAspectRatio;
    property Height: Integer read GetHeight;
    property ISO639_1: WideString read GetISO639_1;
    property FilePath: WideString read GetFilePath;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property Width: Integer read GetWidth;
  end;

  /// [DONE]
  TTMDBMediaImageList = class(TInterfacedObject, ITMDBMediaImageList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBMediaImage>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBMediaImage; stdcall;
  public
    constructor Create(AObj: ISuperArray); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBMediaImage read GetItem; default;
  end;

  /// [DONE]
  TTMDBMediaImages = class(TInterfacedObject, ITMDBMediaImages)
  private
    FObj: ISuperObject;
    FBackdrops: ITMDBMediaImageList;
    FLogos: ITMDBMediaImageList;
    FPosters: ITMDBMediaImageList;
  protected
    function GetBackdrops: ITMDBMediaImageList; stdcall;
    function GetLogos: ITMDBMediaImageList; stdcall;
    function GetPosters: ITMDBMediaImageList; stdcall;
    function GetID: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Backdrops: ITMDBMediaImageList read GetBackdrops;
    property Logos: ITMDBMediaImageList read GetLogos;
    property Posters: ITMDBMediaImageList read GetPosters;
    property ID: Integer read GetID;
  end;

{$ENDREGION}



{$REGION 'Video Related'}

  { Video Related }

  TTMDBVideoItem = class(TInterfacedObject, ITMDBVideoItem)
  private
    FObj: ISuperObject;
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
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

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

  TTMDBVideoList = class(TInterfacedObject, ITMDBVideoList)
  private
    FObj: ISuperObject;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBVideoItem; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBVideoItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Genre Related'}

  { Genres Related }

  TTMDBGenreItem = class;

  //[DONE]
  TTMDBGenreList = class(TInterfacedObject, ITMDBGenreList)
  private
    FObj: ISuperArray;
    //FItems: TObjectList<TTMDBGenreItem>;
    FItems: TInterfaceList;
    FMediaType: TTMDBMediaType;
    FTMDB: ITMDBClient;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBGenreItem; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
  public
    constructor Create(AObj: ISuperArray; const AMediaType: TTMDBMediaType;
      ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property TMDB: ITMDBClient read FTMDB;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem;
    property MediaType: TTMDBMediaType read GetMediaType;
  end;

  //[DONE]
  TTMDBGenreItem = class(TInterfacedObject, ITMDBGenreItem)
  private
    FObj: ISuperObject;
    FOwner: TTMDBGenreList;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(AOwner: TTMDBGenreList; AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

{$ENDREGION}



{$REGION 'Alternative Title Related'}

  /// [DONE]
  TTMDBAlternativeTitleItem = class(TInterfacedObject, ITMDBAlternativeTitleItem)
  private
    FObj: ISuperObject;
  protected
    function GetISO3166_1: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetType: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property ISO3166_1: WideString read GetISO3166_1;
    property Title: WideString read GetTitle;
    property &Type: WideString read GetType;
  end;

  /// [DONE]
  TTMDBAlternativeTitleList = class(TInterfacedObject, ITMDBAlternativeTitleList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBAlternativeTitleItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBAlternativeTitleItem; stdcall;
  public
    constructor Create(AObj: ISuperArray); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBAlternativeTitleItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Discover Related'}

  /// [DONE]
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

  { Person Related }

  TTMDBPersonItem = class(TTMDBMediaBase, ITMDBPersonItem)
  private
    FKnownFor: ITMDBMediaList;
  protected
    function GetGender: TTMDBGender; stdcall;
    function GetKnownFor: ITMDBMediaList; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetProfilePath: WideString; stdcall;
  public
    constructor Create(AOwner: TTMDBPage; AObj: ISuperObject;
      const AIndex: Integer); override;
    destructor Destroy; override;

    property Gender: TTMDBGender read GetGender;
    property KnownFor: ITMDBMediaList read GetKnownFor;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property ProfilePath: WideString read GetProfilePath;
  end;

  /// [DONE]
  TTMDBPersonPage = class(TTMDBPage, ITMDBPersonPage)
  protected
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

  TTMDBPersonList = class(TTMDBMediaList, ITMDBPersonList)
  protected
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Credits Related'}

  { Credits Related }

  /// [DONE]
  TTMDBCastItem = class(TTMDBPersonItem, ITMDBCastItem)
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

  /// [DONE]
  TTMDBCastList = class(TTMDBPersonList, ITMDBCastList)
  private
    procedure PopulateItems; override;
  protected
    function GetItem(const Index: Integer): ITMDBCastItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCastItem read GetItem; default;
  end;

  /// [DONE]
  TTMDBCrewItem = class(TTMDBPersonItem, ITMDBCrewItem)
  protected
    function GetCreditID: WideString; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetJob: WideString; stdcall;
  public
    property CreditID: WideString read GetCreditID;
    property Department: WideString read GetDepartment;
    property Job: WideString read GetJob;
  end;

  /// [DONE]
  TTMDBCrewList = class(TTMDBPersonList, ITMDBCrewList)
  private
    procedure PopulateItems; override;
  protected
    function GetItem(const Index: Integer): ITMDBCrewItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCrewItem read GetItem; default;
  end;

  /// [DONE]
  TTMDBCredits = class(TInterfacedObject, ITMDBCredits)
  private
    FObj: ISuperObject;
    FTMDB: ITMDBClient;
    FCast: ITMDBCastList;
    FCrew: ITMDBCrewList;
  protected
    function GetCast: ITMDBCastList; stdcall;
    function GetCrew: ITMDBCrewList; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDBClient); virtual;
    destructor Destroy; override;

    property Cast: ITMDBCastList read GetCast;
    property Crew: ITMDBCrewList read GetCrew;
  end;

{$ENDREGION}



{$REGION 'Network Related'}

  /// [DONE]
  TTMDBTVNetworkList = class(TInterfacedObject, ITMDBTVNetworkList)
  private
    FObj: ISuperArray;
    FItems: TInterfaceList;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTVNetworkItem; stdcall;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTVNetworkItem read GetItem; default;
  end;

  /// [DONE]
  TTMDBTVNetworkItem = class(TInterfacedObject, ITMDBTVNetworkItem)
  private
    FObj: ISuperObject;
  protected
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  /// [DONE]
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

  { Collections Related}

  TTMDBCollectionItem = class(TTMDBPageItem, ITMDBCollectionItem)
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

  TTMDBCollectionPage = class(TTMDBPage, ITMDBCollectionPage)
  protected
    function GetItem(const Index: Integer): ITMDBCollectionItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCollectionItem read GetItem; default;
  end;

  TTMDBCollectionPart = class(TInterfacedObject, ITMDBCollectionPart)
  private
    FObj: ISuperObject;
    FGenres: ITMDBGenreList;
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
    function GetGenres: ITMDBGenreList; stdcall;
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
    property Genres: ITMDBGenreList read GetGenres;
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
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetTranslations: ITMDBTranslationList; stdcall;

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

  { Movie Related }

  /// <summary>
  /// A page of movie results.
  /// [DONE]
  /// </summary>
  TTMDBMoviePage = class(TTMDBPage, ITMDBMoviePage)
  protected
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBMovieItem read GetItem; default;
  end;

  /// <summary>
  /// A single movie result from ITMDBMoviePage.
  /// [DONE]
  /// </summary>
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
    function GetDetails: ITMDBMovieDetail; stdcall;

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

  /// <summary>
  /// A page of movie results which have an associated rating.
  /// [DONE]
  /// </summary>
  TTMDBRatedMoviePage = class(TTMDBMoviePage, ITMDBRatedMoviePage)
  protected
    function GetItem(const Index: Integer): ITMDBRatedMovieItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedMovieItem read GetItem; default;
  end;

  /// <summary>
  /// A single movie result from ITMDBRated MoviePage which has an associated rating.
  /// [DONE]
  /// </summary>
  TTMDBRatedMovieItem = class(TTMDBMovieItem, ITMDBRatedMovieItem)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;

  /// [DONE]
  TTMDBDatedMoviePage = class(TTMDBMoviePage, ITMDBDatedMoviePage)
  private
    FDates: ITMDBDateRange;
  protected
    function GetDates: ITMDBDateRange; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: TTMDBClient); reintroduce;
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

  /// <summary>
  /// The details of a specific movie.
  /// </summary>
  TTMDBMovieDetail = class(TInterfacedObject, ITMDBMovieDetail)
  private
    FTMDB: TTMDBClient;
    FObj: ISuperObject;
    FCollection: ITMDBMovieCollectionRef;
    FGenres: ITMDBGenreList;
    FProductionCompanies: ITMDBCompanyList;
    FProductionCountries: ITMDBCountryList;
    FSpokenLanguages: ITMDBLanguageList;
  protected
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCollection: ITMDBMovieCollectionRef; stdcall;
    function GetBudget: Currency; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetOriginalCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetProductionCompanies: ITMDBCompanyList; stdcall;
    function GetProductionCountries: ITMDBCountryList; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetRevenue: Currency; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSpokenLanguages: ITMDBLanguageList; stdcall;
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: TTMDBClient); virtual;
    destructor Destroy; override;

    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAlternativeTitles: ITMDBAlternativeTitleList; stdcall;
    function AppendedChanges: ITMDBChangePage; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    //function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImages; stdcall;
    function AppendedKeywords: ITMDBKeywordList; stdcall;
    //function AppendedLists: ITMDB; stdcall;
    //function AppendedRecommendations: ITMDB; stdcall;
    function AppendedReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function AppendedReviews: ITMDB; stdcall;
    function AppendedSimilar: ITMDBMoviePage; stdcall;
    function AppendedTranslations: ITMDBTranslationList; stdcall;
    function AppendedVideos: ITMDBVideoList; stdcall;

    function AddToFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function RemoveFromFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function AddToWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    function RemoveFromWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    //function AddRating(const Rating: Single): ITMDB...
    //function RemoveRating: ITMDB...

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Collection: ITMDBMovieCollectionRef read GetCollection;
    property Budget: Currency read GetBudget;
    property Genres: ITMDBGenreList read GetGenres;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property ITMDBID: WideString read GetIMDBID;
    property OriginalCountry: TTMDBStrArray read GetOriginalCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanyList read GetProductionCompanies;
    property ProductionCountries: ITMDBCountryList read GetProductionCountries;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Revenue: Currency read GetRevenue;
    property Runtime: Integer read GetRuntime;
    property SpokenLanguages: ITMDBLanguageList read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property Title: WideString read GetTitle;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



{$REGION 'TV Series Related'}

  { TVSeries Related }

  TTMDBTVSeriesItem = class(TTMDBPageItem, ITMDBTVSeriesItem)
  private
    FGenres: ITMDBGenreList;
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
    constructor Create(AOwner: TTMDBPage; AObj: ISuperObject;
      const AIndex: Integer); override;
    destructor Destroy; override;

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
  TTMDBTVSeriesPage = class(TTMDBPage, ITMDBTVSeriesPage)
  protected
    function GetItem(const Index: Integer): ITMDBTVSeriesItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVSeriesItem read GetItem; default;
  end;

  TTMDBTVSeriesList = class(TTMDBItemList, ITMDBTVSeriesList)
  protected
    function GetItem(const Index: Integer): ITMDBTVSeriesItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVSeriesItem read GetItem; default;
  end;

  //[DONE]
  TTMDBRatedTVSeriesPage = class(TTMDBTVSeriesPage, ITMDBRatedTVSeriesPage)
  protected
    function GetItem(const Index: Integer): ITMDBRatedTVSeriesItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBRatedTVSeriesItem read GetItem; default;
  end;

  //[DONE]
  TTMDBRatedTVSeriesItem = class(TTMDBTVSeriesItem, ITMDBRatedTVSeriesItem)
  protected
    function GetRating: Single; stdcall;
  public
    property Rating: Single read GetRating;
  end;

  TTMDBTVSeriesDetail = class(TInterfacedObject, ITMDBTVSeriesDetail)
  private
    FObj: ISuperObject;
    FTMDB: TTMDBClient;
  protected
    function GetAdult: Boolean;
    function GetBackdropPath: WideString;
    function GetCreatedBy: ITMDBPersonList;
    function GetEpisodeRunTime: TTMDBIntArray;
    function GetFirstAirDate: TDateTime;
    function GetGenres: ITMDBGenreList;
    function GetHomepage: WideString;
    function GetID: Integer;
    function GetInProduction: Boolean;
    function GetLanguages: TTMDBStrArray;
    function GetLastAirDate: TDateTime;
    function GetLastEpisodeToAir: ITMDBTVEpisodeItem;
    function GetName: WideString;
    function GetNextEpisodeToAir: ITMDBTVEpisodeItem;
    function GetNetworks: ITMDBTVNetworkList;
    function GetNumberOfEpisodes: Integer;
    function GetNumberOfSeasons: Integer;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString;
    function GetOriginalName: WideString;
    function GetOverview: WideString;
    function GetPopularity: Single;
    function GetPosterPath: WideString;
    function GetProductionCompanies: ITMDBCompanyList;
    function GetProductionCountries: ITMDBCountryList;
    //function GetSeasons: ITMDBTVSeasonList;
    function GetSpokenLanguages: ITMDBLanguageList;
    function GetStatus: WideString;
    function GetTagline: WideString;
    function GetType: WideString;
    function GetVoteAverage: Single;
    function GetVoteCount: Integer;

  public
    constructor Create(AObj: ISuperObject; ATMDB: TTMDBClient);
    destructor Destroy; override;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property CreatedBy: ITMDBPersonList read GetCreatedBy;
    property EpisodeRunTime: TTMDBIntArray read GetEpisodeRunTime;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property Genres: ITMDBGenreList read GetGenres;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property InProduction: Boolean read GetInProduction;
    property Languages: TTMDBStrArray read GetLanguages;
    property LastAirDate: TDateTime read GetLastAirDate;
    property LastEpisodeToAir: ITMDBTVEpisodeItem read GetLastEpisodeToAir;
    property Name: WideString read GetName;
    property NextEpisodeToAir: ITMDBTVEpisodeItem read GetNextEpisodeToAir;
    property Networks: ITMDBTVNetworkList read GetNetworks;
    property NumberOfEpisodes: Integer read GetNumberOfEpisodes;
    property NumberOfSeasons: Integer read GetNumberOfSeasons;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanyList read GetProductionCompanies;
    property ProductionCountries: ITMDBCountryList read GetProductionCountries;
    //TODO: Seasons
    property SpokenLanguages: ITMDBLanguageList read GetSpokenLanguages;
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

  //[DONE]
  TTMDBTVEpisodeItem = class(TTMDBPageItem, ITMDBTVEpisodeItem)
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

  //[DONE]
  TTMDBTVEpisodePage = class(TTMDBPage, ITMDBTVEpisodePage)
  protected
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

  //[DONE]
  TTMDBTVEpisodeList = class(TTMDBItemList, ITMDBTVEpisodeList)
  protected
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Lists Related'}

  { Lists Related }

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

{$ENDREGION}



{$REGION 'Watch Provider Related'}

  { Watch Providers Related }

  /// [DONE]
  TTMDBWatchProviderPriority = class(TInterfacedObject, ITMDBWatchProviderPriority)
  private
    FCountryCode: WideString;
    FPriority: Integer;
  protected
    function GetCountryCode: WideString; stdcall;
    function GetPriority: Integer; stdcall;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property CountryCode: WideString read GetCountryCode;
    property Priority: Integer read GetPriority;
  end;

  /// [DONE]
  TTMDBWatchProviderPriorities = class(TInterfacedObject, ITMDBWatchProviderPriorities)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBWatchProviderPriority>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderPriority; stdcall;
  public
    constructor Create(const AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderPriority read GetItem; default;
  end;

  /// [DONE]
  TTMDBWatchProviderItem = class(TInterfacedObject, ITMDBWatchProviderItem)
  private
    FObj: ISuperObject;
    FDisplayPriorities: ITMDBWatchProviderPriorities;
  protected
    function GetDisplayPriorities: ITMDBWatchProviderPriorities; stdcall;
    function GetDisplayPriority: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetProviderName: WideString; stdcall;
    function GetProviderID: Integer; stdcall;
  public
    constructor Create(const AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property DisplayPriorities: ITMDBWatchProviderPriorities read GetDisplayPriorities;
    property DisplayPriority: Integer read GetDisplayPriority;
    property LogoPath: WideString read GetLogoPath;
    property ProviderName: WideString read GetProviderName;
    property ProviderID: Integer read GetProviderID;
  end;

  /// [DONE]
  TTMDBWatchProviderList = class(TInterfacedObject, ITMDBWatchProviderList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBWatchProviderItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderItem; stdcall;
  public
    constructor Create(const AObj: ISuperArray); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderItem read GetItem; default;
  end;

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'API Service Related'}

  { API Services }

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

  end;

  TTMDBServiceCollections = class(TTMDBService, ITMDBServiceCollections)
  protected
    function GetDetails(const CollectionID: Integer;
      const Language: WideString = ''): ITMDBCollectionDetail; stdcall;
    function GetImages(const CollectionID: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetTranslations(const CollectionID: Integer): ITMDBTranslationList; stdcall;
  end;

  TTMDBServiceCompanies = class(TTMDBService, ITMDBServiceCompanies)
  protected

  end;

  TTMDBServiceConfiguration = class(TTMDBService, ITMDBServiceConfiguration)
  protected
    function GetDetails: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountryList; stdcall;
    function GetJobs: ITMDBJobDepartmentList; stdcall;
    function GetLanguages: ITMDBLanguageList; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezoneList; stdcall;
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
    function FindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ITMDBFindResults; stdcall;
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
    function GetDetails(const KeywordID: Integer): ITMDBKeywordItem; stdcall;
  end;

  TTMDBServiceLists = class(TTMDBService, ITMDBServiceLists)
  protected

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
      const Country: WideString = ''): ITMDBAlternativeTitleList; stdcall;
    //function GetChanges(): ITMDBChangePage; stdcall;
    function GetCredits(const MovieID: Integer; const Language: String = ''): ITMDBCredits; stdcall;
    //function GetExternalIDs(const MovieID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const MovieID: Integer; const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetKeywords(const MovieID: Integer): ITMDBKeywordList; stdcall;
    function GetLatest: ITMDBMovieDetail;
    //function GetLists
    //function GetRecommendations
    function GetReleaseDates(const MovieID: Integer): ITMDBReleaseDateCountries; stdcall;
    //function GetReviews
    function GetSimilar(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetTranslations(const MovieID: Integer): ITMDBTranslationList; stdcall;
    function GetVideos(const MovieID: Integer; const Language: WideString = ''): ITMDBVideoList; stdcall;
    //function GetWatchProviders
    //function AddRating
    //function DeleteRating
  end;

  TTMDBServiceNetworks = class(TTMDBService, ITMDBServiceNetworks)
  protected
    function GetDetails(const NetworkID: Integer): ITMDBTVNetworkDetail; stdcall;
    function GetAlternativeNames(const NetworkID: Integer): ITMDBAlternativeTitleList; stdcall;
    function GetImages(const NetworkID: Integer): ITMDBMediaImages; stdcall;
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
    //function SearchKeywords(const Query: WideString;
    //  const Page: Integer = 1): ITMDBKeywordPage; stdcall;
    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function SearchMulti(const Query: WideString; const IncludeAdult: Boolean = False;
    //  const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaList; stdcall;
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

  end;

  TTMDBServiceTVSeries = class(TTMDBService, ITMDBServiceTVSeries)
  protected
    function GetDetails(const SeriesID: Integer; const AppendToResponse: TTMDBTVSeriesRequests = [];
      const Language: WideString = ''): ITMDBTVSeriesDetail; stdcall;
    function GetAccountStates(const SeriesID: Integer): ITMDBAccountStates; stdcall;
    //GetAggregateCredits
    function GetAlternativeTitles(const SeriesID: Integer): ITMDBAlternativeTitleList; stdcall;
    //GetChanges
    //GetContentRatings
    function GetGetCredits(const SeriesID: Integer; const Language: WideString = ''): ITMDBCredits; stdcall;
    //GetEpisodeGroups
    //GetExternalIDs
    function GetImages(const SeriesID: Integer; const IncludeImageLanguage: WideString ='';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetKeywords(const SeriesID: Integer): ITMDBKeywordList; stdcall;
    function GetLatest: ITMDBTVSeriesDetail; stdcall;
    //GetLists
    //GetRecommendations
    //GetReviews
    //GetScreenedTheatrically
    function GetSimilar(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    //GetTranslations
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideoList; stdcall;
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
    //GetDetails
  end;

  TTMDBServiceWatchProviders = class(TTMDBService, ITMDBServiceWatchProviders)
  protected
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountryList; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
  end;

  /// [DONE]
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
    FCountries: ITMDBCountryList;
    //FJobs: ITMDBJobList;
    FLanguages: ITMDBLanguageList;
    FPrimaryTranslations: TTMDBStrArray;
    FTimezones: ITMDBTimezoneList;
    FMovieCerts: ITMDBCertificationCountries;
    FTVCerts: ITMDBCertificationCountries;
    FMovieGenres: ITMDBGenreList;
    FTVGenres: ITMDBGenreList;

  protected
    function GetConfig: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountryList; stdcall;
    //function GetJobs: ITMDBJobList; stdcall;
    function GetLanguages: ITMDBLanguageList; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezoneList; stdcall;
    function GetMovieCerts: ITMDBCertificationCountries; stdcall;
    function GetTVCerts: ITMDBCertificationCountries; stdcall;
    function GetMovieGenres: ITMDBGenreList; stdcall;
    function GetTVGenres: ITMDBGenreList; stdcall;
  public
    constructor Create(AOwner: TTMDBClient);
    destructor Destroy; override;

    procedure RefreshAll; stdcall;
    function MovieGenre(const ID: Integer): WideString; stdcall;
    function TVGenre(const ID: Integer): WideString; stdcall;

    property Config: ITMDBConfiguration read GetConfig;
    property Countries: ITMDBCountryList read GetCountries;
    //property Jobs: ITMDBJobList read GetJobs;
    property Languages: ITMDBLanguageList read GetLanguages;
    property PrimaryTranslations: TTMDBStrArray read GetPrimaryTranslations;
    property Timezones: ITMDBTimezoneList read GetTimezones;
    property MovieCerts: ITMDBCertificationCountries read GetMovieCerts;
    property TVCerts: ITMDBCertificationCountries read GetTVCerts;
    property MovieGenres: ITMDBGenreList read GetMovieGenres;
    property TVGenres: ITMDBGenreList read GetTVGenres;
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

{ TTMDBPage }

constructor TTMDBPage.Create(AObj: ISuperObject; ATMDB: TTMDBClient;
  AItemClass: TTMDBPageItemClass);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
  FItems:= TObjectList<TTMDBPageItem>.Create(False);
  FItemClass:= AItemClass;
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

function TTMDBPage.GetPageItem(const Index: Integer): ITMDBPageItem;
begin
  Result:= FItems[Index];
end;

function TTMDBPage.GetPage: Integer;
begin
  Result:= FObj.I['page'];
end;

function TTMDBPage.GetTMDB: ITMDBClient;
begin
  Result:= FTMDB;
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
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBPageItem(FItems[X])._Release;
    //TTMDBPageItem(FItems[X]).Free;
  end;
  FItems.Clear;
end;

procedure TTMDBPage.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: TTMDBPageItem;
begin
  Clear;
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
    I:= FItemClass.Create(Self, O, X);
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBPageItem }

constructor TTMDBPageItem.Create(AOwner: TTMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  FOwner:= AOwner;
  FObj:= AObj;
  FIndex:= AIndex;
end;

destructor TTMDBPageItem.Destroy;
begin
  FOwner:= nil;
  FObj:= nil;
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
  FObj:= nil;
  FOwner:= nil;
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
  Result:= ITMDBCertificationCountry(FItems[Index]);
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
    ITMDBCertificationItem(FItems[X])._Release;
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
  const Index: Integer): ITMDBCertificationItem;
begin
  Result:= ITMDBCertificationItem(FItems[Index]);
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
    I._AddRef;
    FItems.Add(I);
  end;
end;

{ TTMDBChangeItem }

constructor TTMDBChangeItem.Create(AOwner: TTMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  inherited;

end;

destructor TTMDBChangeItem.Destroy;
begin

  inherited;
end;

function TTMDBChangeItem.GetItem(const Index: Integer): ITMDBChangeRecord;
begin
  //Result:= ITMDBChangeRecord(inherited GetItem(Index));
end;

function TTMDBChangeItem.GetKey: WideString;
begin
  Result:= FObj.S['key'];
end;

{ TTMDBChangePage }

function TTMDBChangePage.GetItem(const Index: Integer): ITMDBChangeItem;
begin

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

constructor TTMDBGenreList.Create(AObj: ISuperArray; const AMediaType: TTMDBMediaType;
  ATMDB: ITMDBClient);
begin
  FObj:= AObj;
  //FItems:= TObjectList<TTMDBGenreItem>.Create(False);
  FItems:= TInterfaceList.Create;
  FMediaType:= AMediaType;
  FTMDB:= ATMDB;
  PopulateItems;
end;

destructor TTMDBGenreList.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  FObj:= nil;
  FTMDB:= nil;
  inherited;
end;

procedure TTMDBGenreList.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    //ITMDBGenreItem(FItems[X])._Release;
  end;
  FItems.Clear;
end;

function TTMDBGenreList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBGenreList.GetItem(const Index: Integer): ITMDBGenreItem;
begin
  Result:= ITMDBGenreItem(FItems[Index]);
end;

function TTMDBGenreList.GetMediaType: TTMDBMediaType;
begin
  Result:= FMediaType;
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
    //I._AddRef;
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
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBGenreItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBGenreItem.GetName: WideString;
begin
  if FObj.Null['name'] = jAssigned then
    Result:= FObj.S['name']
  else begin
    //If "name" doesn't exist, then lookup its "id" in cached genre list.
    case FOwner.MediaType of
      TTMDBMediaType.mtMovie: begin
        Result:= FOwner.TMDB.Cache.MovieGenre(GetID);
      end;
      TTMDBMediaType.mtTV: begin
        Result:= FOwner.TMDB.Cache.TVGenre(GetID);
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

function TTMDBCountryList.GetByCode(const Code: WideString): ITMDBCountryItem;
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

function TTMDBLanguageList.GetByCode(const Code: WideString): ITMDBLanguageItem;
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
  Result:= TTMDBMovieItem(inherited GetPageItem(Index));
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

function TTMDBMovieItem.GetDetails: ITMDBMovieDetail;
begin
  //TODO: Keep track of ownership so this can be executed...
  //Result:= FTMDB.Movies.GetDetails(ID);
end;

function TTMDBMovieItem.GetGenres: ITMDBGenreList;
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
    FGenres:= TTMDBGenreList.Create(A2, TTMDBMediaType.mtMovie, FOwner.TMDB);
  end;
  Result:= FGenres;
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
begin
  Result:= ConvertDate(FObj.S['release_date']);
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

{ TTMDBMovieDetail }

constructor TTMDBMovieDetail.Create(AObj: ISuperObject; ATMDB: TTMDBClient);
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

function TTMDBMovieDetail.AppendedAlternativeTitles: ITMDBAlternativeTitleList;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['alternative_titles'];
  if O <> nil then begin
    Result:= TTMDBAlternativeTitleList.Create(O.A['titles']);
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
    Result:= TTMDBChangePage.Create(O, FTMDB, TTMDBChangeItem);
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

function TTMDBMovieDetail.AppendedImages: ITMDBMediaImages;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['images'];
  if O <> nil then begin
    Result:= TTMDBMediaImages.Create(O);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedKeywords: ITMDBKeywordList;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['keywords'];
  if O <> nil then begin
    Result:= TTMDBKeywordList.Create(O.A['keywords']);
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
    Result:= TTMDBMoviePage.Create(O, FTMDB, TTMDBMovieItem);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedTranslations: ITMDBTranslationList;
var
  O: ISuperObject;
begin
  O:= FObj.O['translations'];
  if O <> nil then begin
    Result:= TTMDBTranslationList.Create(O, ttMovie);
    //TODO: Cache Result...
  end;
end;

function TTMDBMovieDetail.AppendedVideos: ITMDBVideoList;
var
  O: ISuperObject;
begin
  O:= FObj.O['videos'];
  if O <> nil then begin
    Result:= TTMDBVideoList.Create(O);
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

function TTMDBMovieDetail.GetGenres: ITMDBGenreList;
begin
  if FGenres = nil then begin
    FGenres:= TTMDBGenreList.Create(FObj.A['genres'], mtMovie, FTMDB);
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

function TTMDBMovieDetail.GetProductionCompanies: ITMDBCompanyList;
begin
  if FProductionCompanies = nil then begin
    FProductionCompanies:= TTMDBCompanyList.Create(FObj.A['production_companies']);
  end;
  Result:= FProductionCompanies;
end;

function TTMDBMovieDetail.GetProductionCountries: ITMDBCountryList;
begin
  //TODO: The structure is different than ITMDBCountryList...
  if FProductionCountries = nil then begin
    FProductionCountries:= TTMDBCountryList.Create(FObj.A['production_countries']);
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

function TTMDBMovieDetail.GetSpokenLanguages: ITMDBLanguageList;
begin
  if FSpokenLanguages = nil then begin
    FSpokenLanguages:= TTMDBLanguageList.Create(FObj.A['spoken_languages']);
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

function TTMDBTVSeriesPage.GetItem(const Index: Integer): ITMDBTVSeriesItem;
begin
  Result:= ITMDBTVSeriesItem(inherited GetPageItem(Index));
end;

{ TTMDBTVSeriesItem }

constructor TTMDBTVSeriesItem.Create(AOwner: TTMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  inherited;
  FGenres:= nil;
end;

destructor TTMDBTVSeriesItem.Destroy;
begin

  FGenres:= nil;
  inherited;
end;

function TTMDBTVSeriesItem.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBTVSeriesItem.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBTVSeriesItem.GetFirstAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['first_air_date']);
end;

function TTMDBTVSeriesItem.GetGenres: ITMDBGenreList;
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
    FGenres:= TTMDBGenreList.Create(A2, TTMDBMediaType.mtTV, FOwner.TMDB);
  end;
  Result:= FGenres;
end;

function TTMDBTVSeriesItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVSeriesItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVSeriesItem.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBTVSeriesItem.GetOriginalName: WideString;
begin
  Result:= FObj.S['original_name'];
end;

function TTMDBTVSeriesItem.GetOriginCountry: TTMDBStrArray;
begin
  //TODO
end;

function TTMDBTVSeriesItem.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVSeriesItem.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBTVSeriesItem.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBTVSeriesItem.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVSeriesItem.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBRatedTVSeriesPage }

function TTMDBRatedTVSeriesPage.GetItem(const Index: Integer): ITMDBRatedTVSeriesItem;
begin
  Result:= ITMDBRatedTVSeriesItem(inherited GetItem(Index));
end;

{ TTMDBRatedTVSeriesItem }

function TTMDBRatedTVSeriesItem.GetRating: Single;
begin
  Result:= FObj.F['rating'];
end;

{ TTMDBListPage }

function TTMDBListPage.GetItem(const Index: Integer): ITMDBListPageItem;
begin
  Result:= ITMDBListPageItem(inherited GetPageItem(Index));
end;

{ TTMDBListPageItem }

function TTMDBListPageItem.GetDescription: WideString;
begin
  Result:= FObj.S['description'];
end;

function TTMDBListPageItem.GetFavoriteCount: Integer;
begin
  Result:= FObj.I['favorite_count'];
end;

function TTMDBListPageItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBListPageItem.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBListPageItem.GetListType: TTMDBListType;
begin
  Result:= TMDBStrToListType(FObj.S['media_type']);
end;

function TTMDBListPageItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBListPageItem.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBWatchProviderPriority }

constructor TTMDBWatchProviderPriority.Create;
begin

end;

destructor TTMDBWatchProviderPriority.Destroy;
begin

  inherited;
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

constructor TTMDBWatchProviderPriorities.Create(const AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBWatchProviderPriority>.Create;
  PopulateItems;
end;

destructor TTMDBWatchProviderPriorities.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBWatchProviderPriorities.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBWatchProviderPriorities.GetItem(
  const Index: Integer): ITMDBWatchProviderPriority;
begin
  Result:= FItems[Index];
end;

procedure TTMDBWatchProviderPriorities.PopulateItems;
var
  M: IMember;
  I: TTMDBWatchProviderPriority;
begin
  ClearItems;
  for M in FObj do begin
    I:= TTMDBWatchProviderPriority.Create;
    I.FCountryCode:= M.Name;
    I.FPriority:= M.AsInteger;
    FItems.Add(I);
  end;
end;

procedure TTMDBWatchProviderPriorities.ClearItems;
begin
  FItems.Clear;
end;

{ TTMDBWatchProviderItem }

constructor TTMDBWatchProviderItem.Create(const AObj: ISuperObject);
begin
  FObj:= AObj;
  FDisplayPriorities:= TTMDBWatchProviderPriorities.Create(FObj.O['display_priorities']);
end;

destructor TTMDBWatchProviderItem.Destroy;
begin

  inherited;
end;

function TTMDBWatchProviderItem.GetDisplayPriorities: ITMDBWatchProviderPriorities;
begin
  Result:= FDisplayPriorities;
end;

function TTMDBWatchProviderItem.GetDisplayPriority: Integer;
begin
  Result:= FObj.I['display_priority'];
end;

function TTMDBWatchProviderItem.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBWatchProviderItem.GetProviderID: Integer;
begin
  Result:= FObj.I['provider_id'];
end;

function TTMDBWatchProviderItem.GetProviderName: WideString;
begin
  Result:= FObj.S['provider_name'];
end;

{ TTMDBWatchProviderList }

constructor TTMDBWatchProviderList.Create(const AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBWatchProviderItem>.Create;
  PopulateItems;
end;

destructor TTMDBWatchProviderList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBWatchProviderList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBWatchProviderList.GetItem(
  const Index: Integer): ITMDBWatchProviderItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBWatchProviderList.ClearItems;
begin
  FItems.Clear;
end;

procedure TTMDBWatchProviderList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBWatchProviderItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBWatchProviderItem.Create(O);
    FItems.Add(I);
  end;
end;









////////////////////////////////////////////////////////////////////////////////











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
  Result:= TTMDBAccountDetail.Create(O);
end;

function TTMDBServiceAccount.GetDetailsBySession(
  const ASessionID: WideString): ITMDBAccountDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetDetailsBySession(ASessionID);
  Result:= TTMDBAccountDetail.Create(O);
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
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
end;

function TTMDBServiceAccount.GetFavoriteTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetFavoriteTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSeriesItem);
end;

function TTMDBServiceAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: WideString): ITMDBListPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetLists(AccountID, Page, SessionID);
  Result:= TTMDBListPage.Create(O, FOwner, TTMDBListPageItem);
end;

function TTMDBServiceAccount.GetRatedMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedMoviePage.Create(O, FOwner, TTMDBRatedMovieItem);
end;

function TTMDBServiceAccount.GetRatedTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedTVSeriesPage.Create(O, FOwner, TTMDBRatedTVSeriesItem);
end;

function TTMDBServiceAccount.GetRatedTVEpisodes(AccountID: Integer;
  const Page: Integer; const Language, SessionID,
  SortBy: WideString): ITMDBRatedTVEpisodePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedTVEpisodes(AccountID, Language, Page, SessionID, SortBy);
  //Result:= TTMDBRatedTVEpisodePage.Create(O); //TODO
end;

function TTMDBServiceAccount.GetWatchlistMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetWatchlistMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
end;

function TTMDBServiceAccount.GetWatchlistTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetWatchlistTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSeriesItem);
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

{ TTMDBServiceConfiguration }

function TTMDBServiceConfiguration.GetDetails: ITMDBConfiguration;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Configuration.GetDetails;
  Result:= TTMDBConfiguration.Create(O);
end;

function TTMDBServiceConfiguration.GetCountries: ITMDBCountryList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetCountries;
  Result:= TTMDBCountryList.Create(A);
end;

function TTMDBServiceConfiguration.GetJobs: ITMDBJobDepartmentList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetJobs;
  Result:= TTMDBJobDepartmentList.Create(A);
end;

function TTMDBServiceConfiguration.GetLanguages: ITMDBLanguageList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetLanguages;
  Result:= TTMDBLanguageList.Create(A);
end;

function TTMDBServiceConfiguration.GetPrimaryTranslations: TTMDBStrArray;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetPrimaryTranslations;
  Result:= JSONToStrArray(A);
end;

function TTMDBServiceConfiguration.GetTimezones: ITMDBTimezoneList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Configuration.GetTimeZones;
  Result:= TTMDBTimezoneList.Create(A);
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
  const Language: WideString): ITMDBGenreList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Genres.GetMovieList(Language);
  Result:= TTMDBGenreList.Create(A, TTMDBMediaType.mtMovie, FOwner);
end;

function TTMDBServiceGenres.GetTVList(
  const Language: WideString): ITMDBGenreList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Genres.GetTVList(Language);
  Result:= TTMDBGenreList.Create(A, TTMDBMediaType.mtTV, FOwner);
end;

{ TTMDBServiceKeywords }

function TTMDBServiceKeywords.GetDetails(
  const KeywordID: Integer): ITMDBKeywordItem;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Keywords.GetDetails(KeywordID);
  //Result:= TTMDBKeywordItem.Create(O);
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
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
end;

function TTMDBServiceMovieLists.GetTopRated(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetTopRated(Language, Page, Region);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
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
  const Country: WideString): ITMDBAlternativeTitleList;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Movies.GetAlternativeTitles(MovieID, Country);
  Result:= TTMDBAlternativeTitleList.Create(O);
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
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImages;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetImages(MovieID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImages.Create(O);
end;

function TTMDBServiceMovies.GetKeywords(
  const MovieID: Integer): ITMDBKeywordList;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.Movies.GetKeywords(MovieID);
  Result:= TTMDBKeywordList.Create(O);
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
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
end;

function TTMDBServiceMovies.GetTranslations(
  const MovieID: Integer): ITMDBTranslationList;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetTranslations(MovieID);
  Result:= TTMDBTranslationList.Create(O, ttMovie);
end;

function TTMDBServiceMovies.GetVideos(const MovieID: Integer;
  const Language: WideString): ITMDBVideoList;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Movies.GetVideos(MovieID, Language);
  Result:= TTMDBVideoList.Create(O);
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
  Result:= TTMDBCollectionPage.Create(O, FOwner, TTMDBCollectionItem);
end;

function TTMDBServiceSearch.SearchCompanies(const Query: WideString;
  const Page: Integer): ITMDBCompanyPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchCompanies(Query, Page);
  Result:= TTMDBCompanyPage.Create(O, FOwner, TTMDBCompanyItem);
end;

function TTMDBServiceSearch.SearchMovies(const Query: WideString;
  const IncludeAdult: Boolean; const Language, Region, PrimaryReleaseYear,
  Year: WideString; const Page: Integer): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchMovies(Query, IncludeAdult, Language, PrimaryReleaseYear,
    Page, Region, Year);
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
end;

function TTMDBServiceSearch.SearchPeople(const Query: WideString;
  const IncludeAdult: Boolean; const Language: WideString;
  const Page: Integer): ITMDBPersonPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchPerson(Query, IncludeAdult, Language, Page);
  Result:= TTMDBPersonPage.Create(O, FOwner, TTMDBPersonItem);
end;

function TTMDBServiceSearch.SearchTV(const Query: String;
  const FirstAirDateYear: Integer; const IncludeAdult: Boolean;
  const Language: WideString; const Year, Page: Integer): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchTV(Query, IntToStr(FirstAirDateYear),
    IncludeAdult, Language, Page, IntToStr(Year));
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSeriesItem);
end;

{ TTMDBServiceWatchProviders }

function TTMDBServiceWatchProviders.GetAvailableRegions(
  const Language: WideString): ITMDBCountryList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetAvailableRegions(Language);
  Result:= TTMDBCountryList.Create(A);
end;

function TTMDBServiceWatchProviders.GetMovieProviders(const Language,
  WatchRegion: WideString): ITMDBWatchProviderList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetMovieProviders(Language, WatchRegion);
  //Result:= TTMDBWatchProviderList.Create(A);
end;

function TTMDBServiceWatchProviders.GetTVProviders(const Language,
  WatchRegion: WideString): ITMDBWatchProviderList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.WatchProviders.GetTVProviders(Language, WatchRegion);
  //Result:= TTMDBWatchProviderList.Create(A);
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

{ Services }

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

{ TTMDBAlternativeTitleItem }

constructor TTMDBAlternativeTitleItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBAlternativeTitleItem.Destroy;
begin

  inherited;
end;

function TTMDBAlternativeTitleItem.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBAlternativeTitleItem.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
end;

function TTMDBAlternativeTitleItem.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

{ TTMDBAlternativeTitleList }

constructor TTMDBAlternativeTitleList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBAlternativeTitleItem>.Create;
  PopulateItems;
end;

destructor TTMDBAlternativeTitleList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBAlternativeTitleList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBAlternativeTitleList.GetItem(
  const Index: Integer): ITMDBAlternativeTitleItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBAlternativeTitleList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBAlternativeTitleItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBAlternativeTitleItem.Create(O);
    FItems.Add(I);
  end;
end;

procedure TTMDBAlternativeTitleList.ClearItems;
begin
  FItems.Clear;
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
  FCast:= TTMDBCastList.Create(FObj.A['cast'], TTMDBCastItem);
  FCrew:= TTMDBCrewList.Create(FObj.A['crew'], TTMDBCrewItem);
end;

destructor TTMDBCredits.Destroy;
begin
  FCrew:= nil;
  FCast:= nil;
  FTMDB:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBCredits.GetCast: ITMDBCastList;
begin
  Result:= FCast;
end;

function TTMDBCredits.GetCrew: ITMDBCrewList;
begin
  Result:= FCrew;
end;

{ TTMDBPersonItem }

constructor TTMDBPersonItem.Create(AOwner: TTMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  inherited;
  FKnownFor:= nil;

end;

destructor TTMDBPersonItem.Destroy;
begin

  FKnownFor:= nil;
  inherited;
end;

function TTMDBPersonItem.GetGender: TTMDBGender;
begin
  Result:= TTMDBGender(FObj.I['gender']);
end;

function TTMDBPersonItem.GetKnownFor: ITMDBMediaList;
begin
  if FKnownFor = nil then begin
    FKnownFor:= TTMDBMediaList.Create(FObj.A['known_for'], TTMDBMediaBase);
  end;
  Result:= FKnownFor;
end;

function TTMDBPersonItem.GetKnownForDepartment: WideString;
begin
  Result:= FObj.S['known_for_department'];
end;

function TTMDBPersonItem.GetProfilePath: WideString;
begin
  Result:= FObj.S['profile_path'];
end;

{ TTMDBPersonPage }

function TTMDBPersonPage.GetItem(const Index: Integer): ITMDBPersonItem;
begin
  Result:= ITMDBPersonItem(inherited GetPageItem(Index));
end;

{ TTMDBPersonList }

function TTMDBPersonList.GetItem(const Index: Integer): ITMDBPersonItem;
begin
  Result:= ITMDBPersonItem(FItems[Index]);
end;

{ TTMDBItemList }

constructor TTMDBItemList.Create(AObj: ISuperArray;
  AItemClass: TTMDBPageItemClass);
begin
  FObj:= AObj;
  FItemClass:= AItemClass;
  FItems:= TList<ITMDBPageItem>.Create;
end;

destructor TTMDBItemList.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBItemList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBItemList.GetItem(const Index: Integer): ITMDBPageItem;
begin
  Result:= FItems[Index];
end;

{ TTMDBCastItem }

function TTMDBCastItem.GetCastID: Integer;
begin
  Result:= FObj.I['cast_id'];
end;

function TTMDBCastItem.GetCharacter: WideString;
begin
  Result:= FObj.S['character'];
end;

function TTMDBCastItem.GetCreditID: WideString;
begin
  Result:= FObj.S['credit_id'];
end;

function TTMDBCastItem.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

{ TTMDBCastList }

function TTMDBCastList.GetItem(const Index: Integer): ITMDBCastItem;
begin
  Result:= ITMDBCastItem(inherited GetItem(Index));
end;

procedure TTMDBCastList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCastItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCastItem.Create(nil, O, X);
    FItems.Add(I);
  end;
end;

{ TTMDBCrewItem }

function TTMDBCrewItem.GetCreditID: WideString;
begin
  Result:= FObj.S['credit_id'];
end;

function TTMDBCrewItem.GetDepartment: WideString;
begin
  Result:= FObj.S['department'];
end;

function TTMDBCrewItem.GetJob: WideString;
begin
  Result:= Fobj.S['job'];
end;

{ TTMDBCrewList }

function TTMDBCrewList.GetItem(const Index: Integer): ITMDBCrewItem;
begin
  Result:= ITMDBCrewItem(inherited GetItem(Index));
end;

procedure TTMDBCrewList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCrewItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCrewItem.Create(nil, O, X);
    FItems.Add(I);
  end;
end;

{ TTMDBMediaImage }

constructor TTMDBMediaImage.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
end;

destructor TTMDBMediaImage.Destroy;
begin

  inherited;
end;

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

constructor TTMDBMediaImageList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBMediaImage>.Create;
  PopulateItems;
end;

destructor TTMDBMediaImageList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBMediaImageList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBMediaImageList.GetItem(const Index: Integer): ITMDBMediaImage;
begin
  Result:= FItems[Index];
end;

procedure TTMDBMediaImageList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBMediaImage;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBMediaImage.Create(O);
    FItems.Add(I);
  end;
end;

procedure TTMDBMediaImageList.ClearItems;
begin
  FItems.Clear;
end;

{ TTMDBMediaImages }

constructor TTMDBMediaImages.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FBackdrops:= TTMDBMediaImageList.Create(FObj.A['backdrops']);
  FLogos:= TTMDBMediaImageList.Create(FObj.A['logos']);
  FPosters:= TTMDBMediaImageList.Create(FObj.A['posters']);
end;

destructor TTMDBMediaImages.Destroy;
begin

  inherited;
end;

function TTMDBMediaImages.GetBackdrops: ITMDBMediaImageList;
begin
  Result:= FBackdrops;
end;

function TTMDBMediaImages.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMediaImages.GetLogos: ITMDBMediaImageList;
begin
  Result:= FLogos;
end;

function TTMDBMediaImages.GetPosters: ITMDBMediaImageList;
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

constructor TTMDBDatedMoviePage.Create(AObj: ISuperObject; ATMDB: TTMDBClient);
begin
  inherited Create(AObj, ATMDB, TTMDBMovieItem);
  FObj:= AObj;
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
  FLanguages:= nil;
  FMovieCerts:= nil;
  FTimezones:= nil;
  FTVCerts:= nil;
  FMovieGenres:= nil;
  FTVGenres:= nil;

  inherited;
end;

function TTMDBCache.GetConfig: ITMDBConfiguration;
begin
  if FConfig = nil then
    FConfig:= FOwner.Configuration.GetDetails;
  Result:= FConfig;
end;

function TTMDBCache.GetCountries: ITMDBCountryList;
begin
  if FCountries = nil then begin

    FCountries:= FOwner.Configuration.GetCountries;
  end;
  Result:= FCountries;
end;

function TTMDBCache.GetLanguages: ITMDBLanguageList;
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

function TTMDBCache.GetMovieGenres: ITMDBGenreList;
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

function TTMDBCache.GetTimezones: ITMDBTimezoneList;
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

function TTMDBCache.GetTVGenres: ITMDBGenreList;
begin
  if FTVGenres = nil then
    FTVGenres:= FOwner.Genres.GetTVList;
  Result:= FTVGenres;
end;

procedure TTMDBCache.RefreshAll;
begin

  FConfig:= FOwner.Configuration.GetDetails;
  FCountries:= FOwner.Configuration.GetCountries;
  FLanguages:= FOwner.Configuration.GetLanguages;
  FMovieCerts:= FOwner.Certifications.GetMovieCertifications;
  FTimezones:= FOwner.Configuration.GetTimezones;
  FTVCerts:= FOwner.Certifications.GetTVCertifications;
  FMovieGenres:= FOwner.FGenres.GetMovieList;
  FTVGenres:= FOwner.FGenres.GetTVList;

  //TODO: Implement the rest of cached data...

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

constructor TTMDBKeywordItem.Create(AObj: ISuperObject);
begin
  Fobj:= AObj;
end;

destructor TTMDBKeywordItem.Destroy;
begin

  inherited;
end;

function TTMDBKeywordItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBKeywordItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

{ TTMDBKeywordList }

constructor TTMDBKeywordList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBKeywordList.Destroy;
begin
  Clear;
  inherited;
end;

function TTMDBKeywordList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBKeywordList.GetItem(const Index: Integer): ITMDBKeywordItem;
begin
  Result:= ITMDBKeywordItem(FItems[Index]);
end;

procedure TTMDBKeywordList.Clear;
begin
  FItems.Clear;
end;

procedure TTMDBKeywordList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBKeywordItem;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBKeywordItem.Create(O);
    FItems.Add(I);
  end;
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
begin
  RT:= FOwner.Authentication.CreateRequestToken;
  if RT.Success then begin
    Res:= False;
    //Trigger event to open browser of choice to URL...
    FOwner.DoUserAuthRequest(RT.RequestToken, Res);
    //TODO: How to wait for and validate result???

    if Res then begin
      Result:= FOwner.Authentication.CreateSession(RT.RequestToken);
      if Result.Success then begin
        FSessionID:= Result.SessionID;
        FIsAuthenticated:= True;
        FIsGuest:= False;
        FAccountDetail:= FOwner.Account.GetDetails(0, FSessionID);
      end;
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

constructor TTMDBReleaseDateItem.Create(AObj: ISuperObject;
  AOwner: TTMDBReleaseDateCountry);
begin
  FObj:= AObj;
  FOwner:= AOwner;
end;

destructor TTMDBReleaseDateItem.Destroy;
begin
  FObj:= nil;
  FOwner:= nil;
  inherited;
end;

function TTMDBReleaseDateItem.GetCertification: WideString;
begin
  Result:= FObj.S['certification'];
end;

function TTMDBReleaseDateItem.GetDescriptors: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['descriptors']);
end;

function TTMDBReleaseDateItem.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBReleaseDateItem.GetNote: WideString;
begin
  Result:= FObj.S['note'];
end;

function TTMDBReleaseDateItem.GetReleaseDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['release_date']);
end;

function TTMDBReleaseDateItem.GetType: TTMDBReleaseType;
begin
  Result:= TTMDBReleaseType(FObj.I['type']);
end;

{ TTMDBReleaseDateCountry }

procedure TTMDBReleaseDateCountry.Clear;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do begin
    ITMDBReleaseDateItem(FItems[X])._Release;
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
  const Index: Integer): ITMDBReleaseDateItem;
begin
  Result:= ITMDBReleaseDateItem(FItems[Index]);
end;

procedure TTMDBReleaseDateCountry.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBReleaseDateItem;
begin
  Clear;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBReleaseDateItem.Create(O, Self);
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
  Result:= ITMDBReleaseDateCountry(FItems[Index]);
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

function TTMDBCollectionItem.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBCollectionItem.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBCollectionItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCollectionItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCollectionItem.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBCollectionItem.GetOriginalName: WideString;
begin
  Result:= Fobj.S['original_name'];
end;

function TTMDBCollectionItem.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBCollectionItem.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBCollectionPage }

function TTMDBCollectionPage.GetItem(const Index: Integer): ITMDBCollectionItem;
begin
  Result:= TTMDBCollectionItem(inherited GetPageItem(Index));
end;

{ TTMDBCompanyItem }

function TTMDBCompanyItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBCompanyItem.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBCompanyItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBCompanyItem.GetOriginCountry: WideString;
begin
  Result:= FObj.S['origin_country'];
end;

{ TTMDBCompanyPage }

function TTMDBCompanyPage.GetItem(const Index: Integer): ITMDBCompanyItem;
begin
  Result:= ITMDBCompanyItem(inherited GetPageItem(Index));
end;

{ TTMDBCompanyList }

procedure TTMDBCompanyList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBCompanyList.Create(AObj: ISuperArray);
begin
  FItems:= TInterfaceList.Create;
  FObj:= AObj;
  PopulateItems;
end;

destructor TTMDBCompanyList.Destroy;
begin
  ClearItems;
  FObj:= nil;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBCompanyList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBCompanyList.GetItem(const Index: Integer): ITMDBCompanyItem;
begin
  Result:= ITMDBCompanyItem(FItems[Index]);
end;

procedure TTMDBCompanyList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBCompanyItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBCompanyItem.Create(nil, O, X);
    FItems.Add(I);
  end;
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
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImages;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Collections.GetImages(CollectionID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImages.Create(O);
end;

function TTMDBServiceCollections.GetTranslations(
  const CollectionID: Integer): ITMDBTranslationList;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Collections.GetTranslations(CollectionID);
  Result:= TTMDBTranslationList.Create(O, ttCollection);
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

function TTMDBCollectionPart.GetGenres: ITMDBGenreList;
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
    FGenres:= TTMDBGenreList.Create(A2, MediaType, FTMDB);
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
  Language: WideString): ITMDBMediaImages;
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
  Result:= ITMDBCollectionPart(FParts[Index]);
end;

function TTMDBCollectionDetail.GetPartCount: Integer;
begin
  Result:= FParts.Count;
end;

function TTMDBCollectionDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBCollectionDetail.GetTranslations: ITMDBTranslationList;
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

end;

destructor TTMDBMovieCollectionRef.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBMovieCollectionRef.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBMovieCollectionRef.GetBelongsToCollection: Boolean;
begin
  Result:= True; //TODO
end;

function TTMDBMovieCollectionRef.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMovieCollectionRef.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBMovieCollectionRef.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

{ TTMDBTranslationItem }

constructor TTMDBTranslationItem.Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
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

destructor TTMDBTranslationItem.Destroy;
begin
  FData:= nil;
  FObj:= nil;
  inherited;
end;

function TTMDBTranslationItem.GetMovieData: ITMDBMovieTranslationData;
begin
  Result:= ITMDBMovieTranslationData(FData);
end;

function TTMDBTranslationItem.GetCollectionData: ITMDBCollectionTranslationData;
begin
  Result:= ITMDBCollectionTranslationData(FData);
end;

function TTMDBTranslationItem.GetEnglishName: WideString;
begin
  Result:= FObj.S['english_name'];
end;

function TTMDBTranslationItem.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBTranslationItem.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBTranslationItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTranslationItem.GetPersonData: ITMDBPersonTranslationData;
begin
  Result:= ITMDBPersonTranslationData(FData);
end;

function TTMDBTranslationItem.GetTVEpisodeData: ITMDBTVEpisodeTranslationData;
begin
  Result:= ITMDBTVEpisodeTranslationData(FData);
end;

function TTMDBTranslationItem.GetTVSeasonData: ITMDBTVSeasonTranslationData;
begin
  Result:= ITMDBTVSeasonTranslationData(FData);
end;

function TTMDBTranslationItem.GetTVSeriesData: ITMDBTVSeriesTranslationData;
begin
  Result:= ITMDBTVSeriesTranslationData(FData);
end;

{ TTMDBTranslationList }

procedure TTMDBTranslationList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTranslationList.Create(AObj: ISuperObject; const ADataType: TTMDBTranslationType);
begin
  FObj:= AObj;
  FDataType:= ADataType;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBTranslationList.Destroy;
begin
  ClearItems;
  FObj:= nil;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBTranslationList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBTranslationList.GetItem(
  const Index: Integer): ITMDBTranslationItem;
begin
  Result:= ITMDBTranslationItem(FItems[Index]);
end;

procedure TTMDBTranslationList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTranslationItem;
begin
  ClearItems;
  for X := 0 to FObj.A['translations'].Length-1 do begin
    O:= FObj.A['translations'].O[X];
    I:= TTMDBTranslationItem.Create(O, FDataType);
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

constructor TTMDBVideoItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBVideoItem.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBVideoItem.GetID: WideString;
begin
  Result:= FObj.S['id'];
end;

function TTMDBVideoItem.GetISO3166_1: WideString;
begin
  Result:= FObj.S['iso_3166_1'];
end;

function TTMDBVideoItem.GetISO639_1: WideString;
begin
  Result:= FObj.S['iso_639_1'];
end;

function TTMDBVideoItem.GetKey: WideString;
begin
  Result:= FObj.S['key'];
end;

function TTMDBVideoItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBVideoItem.GetOfficial: Boolean;
begin
  Result:= FObj.B['official'];
end;

function TTMDBVideoItem.GetPublishedAt: TDateTime;
begin
  Result:= ConvertDate(FObj.S['published_at']);
end;

function TTMDBVideoItem.GetSite: WideString;
begin
  Result:= FObj.S['site'];
end;

function TTMDBVideoItem.GetSize: Integer;
begin
  Result:= FObj.I['size'];
end;

function TTMDBVideoItem.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

{ TTMDBVideoList }

procedure TTMDBVideoList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBVideoList.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBVideoList.Destroy;
begin
  ClearItems;
  FObj:= nil;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBVideoList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBVideoList.GetItem(const Index: Integer): ITMDBVideoItem;
begin
  Result:= ITMDBVideoItem(FItems[Index]);
end;

procedure TTMDBVideoList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBVideoItem;
begin
  ClearItems;
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
    I:= TTMDBVideoItem.Create(O);
    FItems.Add(I);
  end;
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
  Result:= TTMDBMoviePage.Create(O, FOwner, TTMDBMovieItem);
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
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSeriesItem);
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
  const SeriesID: Integer): ITMDBAlternativeTitleList;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.TVSeries.GetAlternativeTitles(SeriesID);
  Result:= TTMDBAlternativeTitleList.Create(O);
end;

function TTMDBServiceTVSeries.GetDetails(const SeriesID: Integer;
  const AppendToResponse: TTMDBTVSeriesRequests;
  const Language: WideString): ITMDBTVSeriesDetail;
var
  ATR: String;
  O: ISuperObject;
begin
  ATR:= TMDBTVSeriesRequestsToStr(AppendToResponse);
  O:= FOwner.FAPI.TVSeries.GetDetails(SeriesID, ATR, Language);
  Result:= TTMDBTVSeriesDetail.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetGetCredits(const SeriesID: Integer;
  const Language: WideString): ITMDBCredits;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetCredits(SeriesID, Language);
  Result:= TTMDBCredits.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetImages(const SeriesID: Integer;
  const IncludeImageLanguage, Language: WideString): ITMDBMediaImages;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetImages(SeriesID, IncludeImageLanguage, Language);
  Result:= TTMDBMediaImages.Create(O);
end;

function TTMDBServiceTVSeries.GetKeywords(
  const SeriesID: Integer): ITMDBKeywordList;
var
  O: ISuperArray;
begin
  O:= FOwner.FAPI.TVSeries.GetKeywords(SeriesID);
  Result:= TTMDBKeywordList.Create(O);
end;

function TTMDBServiceTVSeries.GetLatest: ITMDBTVSeriesDetail;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetLatest;
  Result:= TTMDBTVSeriesDetail.Create(O, FOwner);
end;

function TTMDBServiceTVSeries.GetSimilar(const SeriesID: Integer;
  const Language: WideString; const Page: Integer): ITMDBTVSeriesPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetSimilar(SeriesID, Language, Page);
  Result:= TTMDBTVSeriesPage.Create(O, FOwner, TTMDBTVSeriesItem);
end;

function TTMDBServiceTVSeries.GetVideos(const SeriesID: Integer;
  const IncludeVideoLanguage, Language: WideString): ITMDBVideoList;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.TVSeries.GetVideos(SeriesID, IncludeVideoLanguage, Language);
  Result:= TTMDBVideoList.Create(O);
end;

{ TTMDBTVSeriesDetail }

constructor TTMDBTVSeriesDetail.Create(AObj: ISuperObject; ATMDB: TTMDBClient);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;

end;

destructor TTMDBTVSeriesDetail.Destroy;
begin

  FObj:= nil;
  FTMDB:= nil;
  inherited;
end;

function TTMDBTVSeriesDetail.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBTVSeriesDetail.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBTVSeriesDetail.GetCreatedBy: ITMDBPersonList;
begin
  //TODO
end;

function TTMDBTVSeriesDetail.GetEpisodeRunTime: TTMDBIntArray;
begin
  Result:= JSONToIntArray(FObj.A['episode_run_time']);
end;

function TTMDBTVSeriesDetail.GetFirstAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['first_air_date']);
end;

function TTMDBTVSeriesDetail.GetGenres: ITMDBGenreList;
begin
  Result:= TTMDBGenreList.Create(FObj.A['genres'], mtTV, FTMDB);
end;

function TTMDBTVSeriesDetail.GetHomepage: WideString;
begin
  Result:= FObj.S['homepage'];
end;

function TTMDBTVSeriesDetail.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVSeriesDetail.GetInProduction: Boolean;
begin
  Result:= FObj.B['in_production'];
end;

function TTMDBTVSeriesDetail.GetLanguages: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['languages']);
end;

function TTMDBTVSeriesDetail.GetLastAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['last_air_date']);
end;

function TTMDBTVSeriesDetail.GetLastEpisodeToAir: ITMDBTVEpisodeItem;
begin
  Result:= TTMDBTVEpisodeItem.Create(nil, FObj.O['last_episode_to_air'], 0);
end;

function TTMDBTVSeriesDetail.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVSeriesDetail.GetNetworks: ITMDBTVNetworkList;
begin
  //TODO
end;

function TTMDBTVSeriesDetail.GetNextEpisodeToAir: ITMDBTVEpisodeItem;
begin
  Result:= TTMDBTVEpisodeItem.Create(nil, FObj.O['next_episode_to_air'], 0);
end;

function TTMDBTVSeriesDetail.GetNumberOfEpisodes: Integer;
begin
  Result:= FObj.I['number_of_episodes'];
end;

function TTMDBTVSeriesDetail.GetNumberOfSeasons: Integer;
begin
  Result:= FObj.I['number_of_seasons'];
end;

function TTMDBTVSeriesDetail.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBTVSeriesDetail.GetOriginalName: WideString;
begin
  Result:= FObj.S['original_name'];
end;

function TTMDBTVSeriesDetail.GetOriginCountry: TTMDBStrArray;
begin
  Result:= JSONToStrArray(FObj.A['origin_country']);
end;

function TTMDBTVSeriesDetail.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVSeriesDetail.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBTVSeriesDetail.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBTVSeriesDetail.GetProductionCompanies: ITMDBCompanyList;
begin
  Result:= TTMDBCompanyList.Create(FObj.A['production_companies']);
end;

function TTMDBTVSeriesDetail.GetProductionCountries: ITMDBCountryList;
begin
  Result:= TTMDBCountryList.Create(FObj.A['production_countries']);
end;

function TTMDBTVSeriesDetail.GetSpokenLanguages: ITMDBLanguageList;
begin
  Result:= TTMDBLanguageList.Create(FObj.A['spoken_languages']);
end;

function TTMDBTVSeriesDetail.GetStatus: WideString;
begin
  Result:= FObj.S['status'];
end;

function TTMDBTVSeriesDetail.GetTagline: WideString;
begin
  Result:= FObj.S['tagline'];
end;

function TTMDBTVSeriesDetail.GetType: WideString;
begin
  Result:= FObj.S['type'];
end;

function TTMDBTVSeriesDetail.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVSeriesDetail.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBTVSeriesList }

function TTMDBTVSeriesList.GetItem(const Index: Integer): ITMDBTVSeriesItem;
begin
  Result:= ITMDBTVSeriesItem(inherited Items[Index]);
end;

{ TTMDBTVEpisodeItem }

function TTMDBTVEpisodeItem.GetAirDate: TDateTime;
begin
  Result:= ConvertDate(FObj.S['air_date']);
end;

function TTMDBTVEpisodeItem.GetEpisodeNumber: Integer;
begin
  Result:= FObj.I['episode_number'];
end;

function TTMDBTVEpisodeItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVEpisodeItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVEpisodeItem.GetOrder: Integer;
begin
  Result:= FObj.I['order'];
end;

function TTMDBTVEpisodeItem.GetOverview: WideString;
begin
  Result:= Fobj.S['overview'];
end;

function TTMDBTVEpisodeItem.GetProductionCode: WideString;
begin
  Result:= FObj.S['production_code'];
end;

function TTMDBTVEpisodeItem.GetRuntime: Integer;
begin
  Result:= FObj.I['runtime'];
end;

function TTMDBTVEpisodeItem.GetSeasonNumber: Integer;
begin
  Result:= FObj.I['season_number'];
end;

function TTMDBTVEpisodeItem.GetShowID: Integer;
begin
  Result:= FObj.I['show_id'];
end;

function TTMDBTVEpisodeItem.GetStillPath: WideString;
begin
  Result:= FObj.S['still_path'];
end;

function TTMDBTVEpisodeItem.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVEpisodeItem.GetVoteCount: Integer;
begin
  Result:= Fobj.I['vote_count'];
end;

{ TTMDBTVEpisodePage }

function TTMDBTVEpisodePage.GetItem(const Index: Integer): ITMDBTVEpisodeItem;
begin
  Result:= ITMDBTVEpisodeItem(inherited PageItems[Index]);
end;

{ TTMDBTVEpisodeList }

function TTMDBTVEpisodeList.GetItem(const Index: Integer): ITMDBTVEpisodeItem;
begin
  Result:= ITMDBTVEpisodeItem(inherited Items[Index]);
end;

{ TTMDBTVNetworkList }

procedure TTMDBTVNetworkList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBTVNetworkList.Create(AObj: ISuperArray);
begin
  FObj:= AObj;
  FItems:= TInterfaceList.Create;
  PopulateItems;
end;

destructor TTMDBTVNetworkList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  FObj:= nil;
  inherited;
end;

function TTMDBTVNetworkList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBTVNetworkList.GetItem(const Index: Integer): ITMDBTVNetworkItem;
begin
  Result:= ITMDBTVNetworkItem(FItems[Index]);
end;

procedure TTMDBTVNetworkList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBTVNetworkItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBTVNetworkItem.Create(O);
    FItems.Add(I);
  end;
end;

{ TTMDBTVNetworkItem }

constructor TTMDBTVNetworkItem.Create(AObj: ISuperObject);
begin
  FObj:= AObj;

end;

destructor TTMDBTVNetworkItem.Destroy;
begin

  FObj:= nil;
  inherited;
end;

function TTMDBTVNetworkItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVNetworkItem.GetLogoPath: WideString;
begin
  Result:= FObj.S['logo_path'];
end;

function TTMDBTVNetworkItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVNetworkItem.GetOriginCountry: WideString;
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

{ TTMDBServiceNetworks }

function TTMDBServiceNetworks.GetAlternativeNames(
  const NetworkID: Integer): ITMDBAlternativeTitleList;
begin
  //TODO
end;

function TTMDBServiceNetworks.GetDetails(
  const NetworkID: Integer): ITMDBTVNetworkDetail;
begin
  //TODO
end;

function TTMDBServiceNetworks.GetImages(
  const NetworkID: Integer): ITMDBMediaImages;
begin
  //TODO
end;

{ TTMDBMediaBase }

function TTMDBMediaBase.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBMediaBase.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBMediaBase.GetMediaType: TTMDBMediaType;
begin
  Result:= TMDBStrToMediaType(FObj.S['media_type']);
end;

function TTMDBMediaBase.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBMediaBase.GetTitle: WideString;
begin
  Result:= FObj.S['title'];
  if Result = '' then
    Result:= FObj.S['name'];
end;

{ TTMDBMediaList }

procedure TTMDBMediaList.ClearItems;
begin
  FItems.Clear;
end;

constructor TTMDBMediaList.Create(AObj: ISuperArray; ABaseClass: TTMDBMediaBaseClass);
begin
  FObj:= AObj;
  FItems:= TInterfaceList.Create;
  FBaseClass:= ABaseClass;

end;

destructor TTMDBMediaList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  FObj:= nil;
  inherited;
end;

function TTMDBMediaList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBMediaList.GetItem(const Index: Integer): ITMDBMediaBase;
begin
  Result:= ITMDBMediaBase(Index);
end;

procedure TTMDBMediaList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBMediaBase;
  MT: TTMDBMediaType;
  T: TTMDBMediaBaseClass;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    MT:= TMDBStrToMediaType(O.S['media_type']);
    case MT of
      //mtMovie:  T:= TTMDBMovieItem; //TODO
      //mtTV:     T:= TTMDBTVSeriesItem; //TODO
      mtPerson: T:= TTMDBPersonItem;
      else      T:= TTMDBMediaBase;
    end;
    I:= T.Create(nil, O, X);
    FItems.Add(I);
  end;
end;

end.
