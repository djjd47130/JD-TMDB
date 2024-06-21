unit JD.TMDB;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  ----------------------------------------------------------------------------
  Core Component to install and use in Delphi projects
  ----------------------------------------------------------------------------

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils,
  JD.TMDB.Intf,
  JD.TMDB.Impl,
  JD.TMDB.Common;

type

  TTMDB = class(TComponent)
  private
    FTMDB: ITMDBClient;
    FOnUserAuthRequest: TTMDBUserAuthRequestEvent;
    function GetAccessToken: String;
    function GetAPIKey: String;
    function GetAuthMethod: TTMDBAuthMethod;
    procedure SetAccessToken(const Value: String);
    procedure SetAPIKey(const Value: String);
    procedure SetAuthMethod(const Value: TTMDBAuthMethod);
    function GetCache: ITMDBCache;
    function GetLoginState: ITMDBLoginState;
    procedure UserAuthRequst(Sender: TObject;
      const URL: WideString; var Result: Boolean);
  protected
    procedure DoUserAuthRequest(const URL: WideString; var Result: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Client: ITMDBClient read FTMDB;
    property Cache: ITMDBCache read GetCache;
    property LoginState: ITMDBLoginState read GetLoginState;

    function CountryName(const Code: String): String;
    function LanguageName(const Code: String): String;
    procedure ListLanguages(AList: TStrings);
    procedure ListCountries(AList: TStrings);
  published
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property APIKey: String read GetAPIKey write SetAPIKey;
    property AccessToken: String read GetAccessToken write SetAccessToken;

    property OnUserAuthRequest: TTMDBUserAuthRequestEvent
      read FOnUserAuthRequest write FOnUserAuthRequest;
  end;

implementation

{ TTMDB }

constructor TTMDB.Create(AOwner: TComponent);
begin
  inherited;
  FTMDB:= TTMDBClient.Create;
  FTMDB._AddRef;
  FTMDB.OnUserAuthRequest:= UserAuthRequst;
end;

destructor TTMDB.Destroy;
begin
  FTMDB._Release;
  FTMDB:= nil;
  inherited;
end;

procedure TTMDB.DoUserAuthRequest(const URL: WideString; var Result: Boolean);
begin
  if Assigned(FOnUserAuthRequest) then begin
    //U:= 'https://www.themoviedb.org/authenticate/'+RequestToken;
    FOnUserAuthRequest(Self, URL, Result);
  end;
end;

function TTMDB.GetAccessToken: String;
begin
  Result:= FTMDB.AccessToken;
end;

function TTMDB.GetAPIKey: String;
begin
  Result:= FTMDB.APIKey;
end;

function TTMDB.GetAuthMethod: TTMDBAuthMethod;
begin
  Result:= FTMDB.AuthMethod;
end;

function TTMDB.GetCache: ITMDBCache;
begin
  Result:= FTMDB.Cache;
end;

function TTMDB.GetLoginState: ITMDBLoginState;
begin
  Result:= FTMDB.LoginState;
end;

procedure TTMDB.SetAccessToken(const Value: String);
begin
  FTMDB.AccessToken:= Value;
end;

procedure TTMDB.SetAPIKey(const Value: String);
begin
  FTMDB.APIKey:= Value;
end;

procedure TTMDB.SetAuthMethod(const Value: TTMDBAuthMethod);
begin
  FTMDB.AuthMethod:= Value;
end;

procedure TTMDB.UserAuthRequst(Sender: TObject; const URL: WideString;
  var Result: Boolean);
begin
  DoUserAuthRequest(URL, Result);
end;

function TTMDB.CountryName(const Code: String): String;
var
  C: ITMDBCountryItem;
begin
  Result:= Code;
  C:= Cache.Countries.GetByCode(Code);
  if C <> nil then
    Result:= C.EnglishName;
end;

function TTMDB.LanguageName(const Code: String): String;
var
  L: ITMDBLanguageItem;
begin
  Result:= Code;
  L:= Cache.Languages.GetByCode(Code);
  if L <> nil then
    Result:= L.EnglishName;
end;

procedure TTMDB.ListCountries(AList: TStrings);
var
  X: Integer;
  O: ITMDBCountryItem;
begin
  AList.Clear;
  for X := 0 to FTMDB.Cache.Countries.Count-1 do begin
    O:= FTMDB.Cache.Countries[X];
    AList.Append(O.ISO3166_1);
  end;
end;

procedure TTMDB.ListLanguages(AList: TStrings);
var
  X: Integer;
  O: ITMDBLanguageItem;
begin
  AList.Clear;
  for X := 0 to FTMDB.Cache.Languages.Count-1 do begin
    O:= FTMDB.Cache.Languages[X];
    AList.Append(O.ISO639_1);
  end;
end;

end.
