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

  { Forward Definitions }

  TTMDBMoviePage = class;

  TTMDBMovieItem = class;



  { Pagination Related }

  TTMDBPageItem = class;

  //[DONE]
  TTMDBPage = class(TInterfacedObject, ITMDBPage)
  private
    FTMDB: ITMDB;
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
    constructor Create(AObj: ISuperObject; ATMDB: ITMDB); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
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



  { Item Lists }

  TTMDBListItemClass = class of TTMDBPageItem;

  /// [DONE]
  TTMDBItemList = class(TInterfacedObject, ITMDBItemList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBPageItem>;
    FItemClass: TTMDBListItemClass;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; AItemClass: TTMDBListItemClass); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
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

  TTMDBChangeItem = class(TTMDBPageItem, ITMDBChangeItem)
  private
    FObj: ISuperObject;
  protected
    function GetKey: WideString; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;
  public
    constructor Create(AOwner: ITMDBPage; AObj: ISuperObject;
      const AIndex: Integer); override;
    destructor Destroy; override;
  end;

  TTMDBChangePage = class(TTMDBPage, ITMDBChangePage)
  protected
    function GetItem(const Index: Integer): ITMDBChangeItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBChangeItem read GetItem; default;
  end;



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



  { Person Related }

  TTMDBPersonItem = class(TTMDBPageItem, ITMDBPersonItem)
  private
    //FKnownFor: ???;
  protected
    function GetAdult: Boolean; stdcall;
    function GetGender: TTMDBGender; stdcall;
    function GetID: Integer; stdcall;
    //TODO: GetKnownFor (array of media item objects)
    function GetKnownForDepartment: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetProfilePath: WideString; stdcall;
  public
    constructor Create(AOwner: ITMDBPage; AObj: ISuperObject;
      const AIndex: Integer); override;
    destructor Destroy; override;

    property Adult: Boolean read GetAdult;
    property Gender: TTMDBGender read GetGender;
    property ID: Integer read GetID;
    //TODO: KnownFor
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property Name: WideString read GetName;
    property Popularity: Single read GetPopularity;
    property ProfilePath: WideString read GetProfilePath;
  end;

  /// [DONE]
  TTMDBPersonPage = class(TTMDBPage, ITMDBPersonPage)
  protected
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

  /// [DONE]
  TTMDBPersonList = class(TTMDBItemList, ITMDBPersonList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBPersonItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;
  public
    constructor Create(AObj: ISuperArray; AItemClass: TTMDBListItemClass); override;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;



  { Cast Related }

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
  protected
    function GetItem(const Index: Integer): ITMDBCastItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCastItem read GetItem; default;
  end;



  { Crew Related }

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
  protected
    function GetItem(const Index: Integer): ITMDBCrewItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBCrewItem read GetItem; default;
  end;




  { Credits Related }

  /// [DONE]
  TTMDBCredits = class(TInterfacedObject, ITMDBCredits)
  private
    FObj: ISuperObject;
    FCast: ITMDBCastList;
    FCrew: ITMDBCrewList;
  protected
    function GetCast: ITMDBCastList; stdcall;
    function GetCrew: ITMDBCrewList; stdcall;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Cast: ITMDBCastList read GetCast;
    property Crew: ITMDBCrewList read GetCrew;
  end;



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



  { Discover Related }



  { Find Related }



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

  { Guest Session Related }



  { Keyword Related }



  { Lists Related }



  { Movie Lists Related }



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



  { Discover Movie Related }

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

  /// [DONE]
  TTMDBDatedMoviePage = class(TTMDBMoviePage, ITMDBDatedMoviePage)
  private
    FDates: ITMDBDateRange;
  protected
    function GetDates: ITMDBDateRange; stdcall;
  public
    constructor Create(AObj: ISuperObject; ATMDB: ITMDB); override;
    destructor Destroy; override;

    property Dates: ITMDBDateRange read GetDates;
  end;



  { Movie Details Related }

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

  /// <summary>
  /// The details of a specific movie.
  /// </summary>
  TTMDBMovieDetail = class(TInterfacedObject, ITMDBMovieDetail)
  private
    FTMDB: ITMDB;
    FObj: ISuperObject;
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
    constructor Create(AObj: ISuperObject; ATMDB: ITMDB); virtual;
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
    //function AppendedReleaseDates: ITMDB; stdcall;
    //function AppendedReviews: ITMDB; stdcall;
    //function AppendedSimilar: ITMDB; stdcall;
    //function AppendedTranslations: ITMDB; stdcall;
    //function AppendedVideos: ITMDB; stdcall;

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



  { TV Related }

  TTMDBTVItem = class;

  //[DONE]
  TTMDBTVPage = class(TTMDBPage, ITMDBTVPage)
  protected
    function GetItem(const Index: Integer): ITMDBTVItem; stdcall;
  public
    property Items[const Index: Integer]: ITMDBTVItem read GetItem; default;
  end;

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






////////////////////////////////////////////////////////////////////////////////



type
  TTMDB = class;

  { API Services }

  TTMDBService = class(TInterfacedObject, ITMDBService)
  private
    FOwner: TTMDB;
  protected
    function GetOwner: ITMDB;
    property Owner: ITMDB read GetOwner;
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
    function GetRatedTVEpisodes(AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVEpisodePage; stdcall;
    function GetWatchlistMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetWatchlistTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBTVPage; stdcall;
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
    function GetDetails(const KeywordID: Integer): ITMDBKeywordItem;
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
      const Language: WideString = ''): ITMDBMovieDetail; stdcall;
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
    //function GetLatest
    //function GetLists
    //function GetRecommendations
    //function GetReleaseDates
    //function GetReviews
    //function GetSimilar
    //function GetTranslations
    //function GetVideos
    //function GetWatchProviders
    //function AddRating
    //function DeleteRating
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
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountryList; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
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

constructor TTMDBPage.Create(AObj: ISuperObject; ATMDB: ITMDB);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
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

{ TTMDBChangeItem }

constructor TTMDBChangeItem.Create(AOwner: ITMDBPage; AObj: ISuperObject;
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

end;

function TTMDBChangeItem.GetKey: WideString;
begin

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

function TTMDBMovieItem.GetDetails: ITMDBMovieDetail;
begin
  //TODO: Keep track of ownership so this can be executed...
  //Result:= FTMDB.Movies.GetDetails(ID);
end;

function TTMDBMovieItem.GetGenres: ITMDBGenreList;
var
  A: ISuperArray;
  X, I: Integer;
begin
  //One-time lookup and cache...
  if FGenres = nil then begin
    A:= FObj.A['genre_ids'];
    FGenres:= TTMDBGenreList.Create(A);
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

{ TTMDBMovieDetail }

constructor TTMDBMovieDetail.Create(AObj: ISuperObject; ATMDB: ITMDB);
begin
  FObj:= AObj;
  FTMDB:= ATMDB;
end;

destructor TTMDBMovieDetail.Destroy;
begin

  inherited;
end;

function TTMDBMovieDetail.AppendedAccountStates: ITMDBAccountStates;
var
  O: ISuperObject;
begin
  Result:= nil;
  O:= FObj.O['account_states'];
  if O <> nil then begin
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
    Result:= TTMDBChangePage.Create(O, FTMDB);
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
    Result:= TTMDBCredits.Create(O);
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
    //Result:= TTMDBKeywordList.Create(O);
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
begin
  //TODO

end;

function TTMDBMovieDetail.GetGenres: ITMDBGenreList;
begin
  //TODO

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
  //TODO
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
  //TODO
end;

function TTMDBMovieDetail.GetProductionCountries: ITMDBCountryList;
begin
  //TODO
end;

function TTMDBMovieDetail.GetReleaseDate: TDateTime;
begin
  Result:= StrToDateTimeDef(FObj.S['release_date'], 0);
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
  //TODO
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

{ TTMDBTVPage }

function TTMDBTVPage.GetItem(const Index: Integer): ITMDBTVItem;
begin
  Result:= ITMDBTVItem(inherited GetItem(Index));
end;

{ TTMDBTVItem }

function TTMDBTVItem.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBTVItem.GetBackdropPath: WideString;
begin
  Result:= FObj.S['backdrop_path'];
end;

function TTMDBTVItem.GetFirstAirDate: TDateTime;
begin
  Result:= StrToDateTimeDef(FObj.S['first_air_date'], 0);
end;

function TTMDBTVItem.GetGenres: ITMDBGenreList;
begin
  //TODO
end;

function TTMDBTVItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBTVItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBTVItem.GetOriginalLanguage: WideString;
begin
  Result:= FObj.S['original_language'];
end;

function TTMDBTVItem.GetOriginalName: WideString;
begin
  Result:= FObj.S['original_name'];
end;

function TTMDBTVItem.GetOriginCountry: TTMDBStrArray;
begin
  //TODO
end;

function TTMDBTVItem.GetOverview: WideString;
begin
  Result:= FObj.S['overview'];
end;

function TTMDBTVItem.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBTVItem.GetPosterPath: WideString;
begin
  Result:= FObj.S['poster_path'];
end;

function TTMDBTVItem.GetVoteAverage: Single;
begin
  Result:= FObj.F['vote_average'];
end;

function TTMDBTVItem.GetVoteCount: Integer;
begin
  Result:= FObj.I['vote_count'];
end;

{ TTMDBRatedTVPage }

function TTMDBRatedTVPage.GetItem(const Index: Integer): ITMDBRatedTVItem;
begin
  Result:= ITMDBRatedTVItem(inherited GetItem(Index));
end;

{ TTMDBRatedTVItem }

function TTMDBRatedTVItem.GetRating: Single;
begin
  Result:= FObj.F['rating'];
end;

{ TTMDBListPage }

function TTMDBListPage.GetItem(const Index: Integer): ITMDBListPageItem;
begin
  Result:= ITMDBListPageItem(inherited GetItem(Index));
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

function TTMDBListPageItem.GetItemCount: Integer;
begin
  //Result:= FItems.Count; //TODO
end;

function TTMDBListPageItem.GetListType: TTMDBListType;
begin
  //TODO
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

constructor TTMDBService.Create(AOwner: TTMDB);
begin
  FOwner:= AOwner;
end;

destructor TTMDBService.Destroy;
begin

  inherited;
end;

function TTMDBService.GetOwner: ITMDB;
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
  Result:= TTMDBMoviePage.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetFavoriteTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetFavoriteTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVPage.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetLists(const AccountID, Page: Integer;
  const SessionID: WideString): ITMDBListPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetLists(AccountID, Page, SessionID);
  Result:= TTMDBListPage.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetRatedMovies(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedMovies(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedMoviePage.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetRatedTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBRatedTVPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetRatedTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBRatedTVPage.Create(O, FOwner);
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
  Result:= TTMDBMoviePage.Create(O, FOwner);
end;

function TTMDBServiceAccount.GetWatchlistTV(const AccountID, Page: Integer;
  const Language, SessionID, SortBy: WideString): ITMDBTVPage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Account.GetWatchlistTV(AccountID, Language, Page, SessionID, SortBy);
  Result:= TTMDBTVPage.Create(O, FOwner);
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
  Result:= TTMDBGenreList.Create(A);
end;

function TTMDBServiceGenres.GetTVList(
  const Language: WideString): ITMDBGenreList;
var
  A: ISuperArray;
begin
  A:= FOwner.FAPI.Genres.GetTVList(Language);
  Result:= TTMDBGenreList.Create(A);
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
  Result:= TTMDBMoviePage.Create(O, FOwner);
end;

function TTMDBServiceMovieLists.GetTopRated(const Language: WideString;
  const Page: Integer; const Region: String): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.MovieLists.GetTopRated(Language, Page, Region);
  Result:= TTMDBMoviePage.Create(O, FOwner);
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
  Result:= TTMDBCredits.Create(O);
end;

function TTMDBServiceMovies.GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
  const Language: WideString = ''): ITMDBMovieDetail;
var
  O: ISuperObject;
  ATR: String;
begin
  ATR:= TMDBMovieRequestsToStr(AppendToResponse);
  O:= FOwner.FAPI.Movies.GetDetails(MovieID, ATR, Language);
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
  //Result:= TTMDBKeywordList.Create(O);
end;

{ TTMDBServiceSearch }

function TTMDBServiceSearch.SearchMovies(const Query: WideString;
  const IncludeAdult: Boolean; const Language, Region, PrimaryReleaseYear,
  Year: WideString; const Page: Integer): ITMDBMoviePage;
var
  O: ISuperObject;
begin
  O:= FOwner.FAPI.Search.SearchMovies(Query, IncludeAdult, Language, PrimaryReleaseYear,
    Page, Region, Year);
  Result:= TTMDBMoviePage.Create(O, FOwner);
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

{ TTMDB }

constructor TTMDB.Create;
begin
  FAPI:= TTMDBAPI.Create(nil);

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
begin
  Result:= -1;
  O:= FObj.O['rated'];
  if O <> nil then
    Result:= O.F['value'];
end;

function TTMDBAccountStates.GetWatchlist: Boolean;
begin
  Result:= FObj.B['watchlist'];
end;

{ TTMDBCredits }

constructor TTMDBCredits.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FCast:= TTMDBCastList.Create(FObj.A['cast']);
  FCrew:= TTMDBCrewList.Create(FObj.A['crew']);
end;

destructor TTMDBCredits.Destroy;
begin

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

constructor TTMDBPersonItem.Create(AOwner: ITMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  inherited;
  //TODO: Create "KnownFor"...
end;

destructor TTMDBPersonItem.Destroy;
begin

  inherited;
end;

function TTMDBPersonItem.GetAdult: Boolean;
begin
  Result:= FObj.B['adult'];
end;

function TTMDBPersonItem.GetGender: TTMDBGender;
begin
  Result:= TTMDBGender(FObj.I['gender']);
end;

function TTMDBPersonItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBPersonItem.GetKnownForDepartment: WideString;
begin
  Result:= FObj.S['known_for_department'];
end;

function TTMDBPersonItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

function TTMDBPersonItem.GetPopularity: Single;
begin
  Result:= FObj.F['popularity'];
end;

function TTMDBPersonItem.GetProfilePath: WideString;
begin
  Result:= FObj.S['profile_path'];
end;

{ TTMDBPersonPage }

function TTMDBPersonPage.GetItem(const Index: Integer): ITMDBPersonItem;
begin
  Result:= ITMDBPersonItem(inherited GetItem(Index));
end;

{ TTMDBPersonList }

constructor TTMDBPersonList.Create(AObj: ISuperArray; AItemClass: TTMDBListItemClass);
begin
  inherited;
  FObj:= AObj;
  FItems:= TList<ITMDBPersonItem>.Create;
  PopulateItems;
end;

destructor TTMDBPersonList.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBPersonList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBPersonList.GetItem(const Index: Integer): ITMDBPersonItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBPersonList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBPersonItem;
begin
  ClearItems;
  for X := 0 to FObj.Length-1 do begin
    O:= FObj.O[X];
    I:= TTMDBPersonItem.Create(nil, O, X);
    FItems.Add(I);
  end;
end;

procedure TTMDBPersonList.ClearItems;
begin
  FItems.Clear;
end;

{ TTMDBItemList }

constructor TTMDBItemList.Create(AObj: ISuperArray;
  AItemClass: TTMDBListItemClass);
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

constructor TTMDBDatedMoviePage.Create(AObj: ISuperObject; ATMDB: ITMDB);
begin
  inherited;
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

end.
