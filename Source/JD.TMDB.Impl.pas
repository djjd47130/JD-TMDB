unit JD.TMDB.Impl;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.TMDB.API, JD.TMDB.Intf,
  XSuperObject;

type
  TTMDBPageItem = class;


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
    function GetItem(const Index: Integer): ITMDBPageItem;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem;
  end;

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


  { Configuration }

  TTMDBConfigurationImages = class(TInterfacedObject, ITMDBConfigurationImages)
  private
    FOwner: ITMDBConfiguration;
    FObj: ISuperObject;
  protected
    function GetBaseURL: WideString;
    function GetSecureBaseURL: WideString;
    function GetBackdropSizes: TTMDBStrArray;
    function GetLogoSizes: TTMDBStrArray;
    function GetPosterSizes: TTMDBStrArray;
    function GetProfileSizes: TTMDBStrArray;
    function GetStillSizes: TTMDBStrArray;
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
    function GetImages: ITMDBConfigurationImages;
    function GetChangeKeys: TTMDBStrArray;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;
    property Images: ITMDBConfigurationImages read GetImages;
    property ChangeKeys: TTMDBStrArray read GetChangeKeys;
  end;

  { Countries  }

  TTMDBCountryList = class(TInterfacedObject, ITMDBCountryList)
  private
    FObj: ISuperArray;
    FItems: TList<ITMDBCountryItem>;
    procedure PopulateItems;
    procedure ClearItems;
  protected
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBCountryItem;
  public
    constructor Create(AObj: ISuperArray);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCountryItem read GetItem; default;
  end;

  TTMDBCountryItem = class(TInterfacedObject, ITMDBCountryItem)
  private
    FObj: ISuperObject;
  protected
    function GetISO3166_1: WideString;
    function GetEnglishName: WideString;
    function GetNativeName: WideString;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;

    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;



  { Genres }

  TTMDBGenreItem = class;

  TTMDBGenreList = class(TInterfacedObject, ITMDBGenreList)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBGenreItem>;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBGenreItem;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem;
  end;

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






type
  TTMDB = class;

  TTMDBService = class(TInterfacedObject, ITMDBService)
  private
    FOwner: TTMDB;
  protected
    property Owner: TTMDB read FOwner;
  public
    constructor Create(AOwner: TTMDB);
    destructor Destroy; override;
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





  TTMDB = class(TInterfacedObject, ITMDB)
  private
    FAPI: TTMDBAPI;
    FAuthentication: ITMDBServiceAuthentication;
    FConfiguration: ITMDBServiceConfiguration;
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

    //function Account: ITMDBServiceAccount; stdcall;
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

{ TTMDBGenreList }

constructor TTMDBGenreList.Create(AObj: ISuperObject);
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
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
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

{ TTMDB }

constructor TTMDB.Create;
begin
  //TODO
  FAPI:= TTMDBAPI.Create(nil);
  //FAuthentication:= TTMDBServiceAuthentication.Create;
  FConfiguration:= TTMDBServiceConfiguration.Create(Self);
end;

destructor TTMDB.Destroy;
begin

  FreeAndNil(FAPI);
  inherited;
end;

function TTMDB.Authentication: ITMDBServiceAuthentication;
begin

end;

function TTMDB.Configuration: ITMDBServiceConfiguration;
begin

end;

function TTMDB.GetAccessToken: WideString;
begin

end;

function TTMDB.GetAPIKey: WideString;
begin

end;

function TTMDB.GetAuthMethod: TTMDBAuthMethod;
begin

end;

function TTMDB.GetUserAuth: TTMDBUserAuth;
begin

end;

procedure TTMDB.SetAccessToken(const Value: WideString);
begin

end;

procedure TTMDB.SetAPIKey(const Value: WideString);
begin

end;

procedure TTMDB.SetAuthMethod(const Value: TTMDBAuthMethod);
begin

end;

procedure TTMDB.SetUserAuth(const Value: TTMDBUserAuth);
begin

end;

{ TTMDBService }

constructor TTMDBService.Create(AOwner: TTMDB);
begin
  FOwner:= AOwner;
end;

destructor TTMDBService.Destroy;
begin

  inherited;
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
begin

end;

function TTMDBServiceConfiguration.GetLanguages: ITMDBLanguageList;
begin

end;

function TTMDBServiceConfiguration.GetPrimaryTranslations: TTMDBStrArray;
begin

end;

function TTMDBServiceConfiguration.GetTimezones: ITMDBTimezoneList;
begin

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

end.
