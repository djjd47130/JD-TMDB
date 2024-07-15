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
  Winapi.Windows,
  JD.TMDB.Intf,
  JD.TMDB.Impl,
  JD.TMDB.Common,
  JD.TMDB.LocalWebServer;

type

  TTMDB = class(TComponent)
  private
    FTMDB: ITMDBClient;
    FOnUserAuthRequest: TTMDBUserAuthRequestEvent;
    FWebServer: TTMDBLocalWebServer;

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
    function GetRateLimiting: Boolean;
    function GetRateLimitMsec: DWORD;
    procedure SetRateLimiting(const Value: Boolean);
    procedure SetRateLimitMsec(const Value: DWORD);
    function GetAppUserAgent: String;
    procedure SetAppUserAgent(const Value: String);
    function GetAgreedToWatchProviderAttribution: Boolean;
    procedure SetAgreedToWatchProviderAttribution(const Value: Boolean);
    function GetWebServerPort: Integer;
    procedure SetWebServerPort(const Value: Integer);
  protected
    procedure DoUserAuthRequest(const URL: WideString; var Result: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Client: ITMDBClient read FTMDB;
    property Cache: ITMDBCache read GetCache;
    property LoginState: ITMDBLoginState read GetLoginState;
    property WebServer: TTMDBLocalWebServer read FWebServer;

    function CountryName(const Code: String): String;
    function LanguageName(const Code: String): String;
    procedure ListLanguages(AList: TStrings);
    procedure ListCountries(AList: TStrings);
    procedure ListPrimaryTranslations(AList: TStrings);

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

  published
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property APIKey: String read GetAPIKey write SetAPIKey;
    property AccessToken: String read GetAccessToken write SetAccessToken;
    property AppUserAgent: String read GetAppUserAgent write SetAppUserAgent;
    property RateLimiting: Boolean read GetRateLimiting write SetRateLimiting;
    property RateLimitMsec: DWORD read GetRateLimitMsec write SetRateLimitMsec;
    property AgreedToWatchProviderAttribution: Boolean
      read GetAgreedToWatchProviderAttribution write SetAgreedToWatchProviderAttribution;
    property WebServerPort: Integer read GetWebServerPort write SetWebServerPort;

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

  FWebServer:= TTMDBLocalWebServer.Create(FTMDB);
  FWebServer.Start;

end;

destructor TTMDB.Destroy;
begin

  FWebServer.Terminate;
  FreeAndNil(FWebServer);

  FTMDB._Release;
  FTMDB:= nil;
  inherited;
end;

function TTMDB.Credits: ITMDBNamespaceCredits;
begin
  Result:= FTMDB.Credits;
end;

function TTMDB.Discover: ITMDBNamespaceDiscover;
begin
  Result:= FTMDB.Discover;
end;

procedure TTMDB.DoUserAuthRequest(const URL: WideString; var Result: Boolean);
begin
  if Assigned(FOnUserAuthRequest) then begin
    //U:= 'https://www.themoviedb.org/authenticate/'+RequestToken;
    FOnUserAuthRequest(Self, URL, Result);
    //TODO: Add optional internal browser to be used instead of triggering event.
    //NOTE: This will also require moving the HTTP server into TTMDB as well.
  end;
end;

function TTMDB.Find: ITMDBNamespaceFind;
begin
  Result:= FTMDB.Find;
end;

function TTMDB.Genres: ITMDBNamespaceGenres;
begin
  Result:= FTMDB.Genres;
end;

function TTMDB.GetAccessToken: String;
begin
  Result:= FTMDB.AccessToken;
end;

function TTMDB.GetAgreedToWatchProviderAttribution: Boolean;
begin
  Result:= FTMDB.AgreedToWatchProviderAttribution;
end;

function TTMDB.GetAPIKey: String;
begin
  Result:= FTMDB.APIKey;
end;

function TTMDB.GetAppUserAgent: String;
begin
  Result:= FTMDB.AppUserAgent;
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

function TTMDB.GetRateLimiting: Boolean;
begin
  Result:= FTMDB.RateLimiting;
end;

function TTMDB.GetRateLimitMsec: DWORD;
begin
  Result:= FTMDB.RateLimitMsec;
end;

function TTMDB.GetWebServerPort: Integer;
begin
  Result:= FWebServer.Port;
end;

function TTMDB.GuestSessions: ITMDBNamespaceGuestSessions;
begin
  Result:= FTMDB.GuestSessions;
end;

function TTMDB.Keywords: ITMDBNamespaceKeywords;
begin
  Result:= FTMDB.Keywords;
end;

function TTMDB.Search: ITMDBNamespaceSearch;
begin
  Result:= FTMDB.Search;
end;

procedure TTMDB.SetAccessToken(const Value: String);
begin
  FTMDB.AccessToken:= Value;
end;

procedure TTMDB.SetAgreedToWatchProviderAttribution(const Value: Boolean);
begin
  FTMDB.AgreedToWatchProviderAttribution:= Value;
end;

procedure TTMDB.SetAPIKey(const Value: String);
begin
  FTMDB.APIKey:= Value;
end;

procedure TTMDB.SetAppUserAgent(const Value: String);
begin
  FTMDB.AppUserAgent:= Value;
end;

procedure TTMDB.SetAuthMethod(const Value: TTMDBAuthMethod);
begin
  FTMDB.AuthMethod:= Value;
end;

procedure TTMDB.SetRateLimiting(const Value: Boolean);
begin
  FTMDB.RateLimiting:= Value;
end;

procedure TTMDB.SetRateLimitMsec(const Value: DWORD);
begin
  FTMDB.RateLimitMsec:= Value;
end;

procedure TTMDB.SetWebServerPort(const Value: Integer);
begin
  FWebServer.Port:= Value;
end;

function TTMDB.Trending: ITMDBNamespaceTrending;
begin
  Result:= FTMDB.Trending;
end;

function TTMDB.TVEpisodeGroups: ITMDBNamespaceTVEpisodeGroups;
begin
  Result:= FTMDB.TVEpisodeGroups;
end;

function TTMDB.TVEpisodes: ITMDBNamespaceTVEpisodes;
begin
  Result:= FTMDB.TVEpisodes;
end;

function TTMDB.TVSeasons: ITMDBNamespaceTVSeasons;
begin
  Result:= FTMDB.TVSeasons;
end;

function TTMDB.TVSeries: ITMDBNamespaceTVSeries;
begin
  Result:= FTMDB.TVSeries;
end;

function TTMDB.TVSeriesLists: ITMDBNamespaceTVSeriesLists;
begin
  Result:= FTMDB.TVSeriesLists;
end;

procedure TTMDB.UserAuthRequst(Sender: TObject; const URL: WideString;
  var Result: Boolean);
begin
  DoUserAuthRequest(URL, Result);
end;

function TTMDB.Account: ITMDBNamespaceAccount;
begin
  Result:= FTMDB.Account;
end;

function TTMDB.Authentication: ITMDBNamespaceAuthentication;
begin
  Result:= FTMDB.Authentication;
end;

function TTMDB.Certifications: ITMDBNamespaceCertifications;
begin
  Result:= FTMDB.Certifications;
end;

function TTMDB.Changes: ITMDBNamespaceChanges;
begin
  Result:= FTMDB.Changes;
end;

function TTMDB.Collections: ITMDBNamespaceCollections;
begin
  Result:= FTMDB.Collections;
end;

function TTMDB.Companies: ITMDBNamespaceCompanies;
begin
  Result:= FTMDB.Companies;
end;

function TTMDB.Configuration: ITMDBNamespaceConfiguration;
begin
  Result:= FTMDB.Configuration;
end;

function TTMDB.WatchProviders: ITMDBNamespaceWatchProviders;
begin
  Result:= FTMDB.WatchProviders;
end;

function TTMDB.CountryName(const Code: String): String;
var
  C: ITMDBCountry;
begin
  Result:= Code;
  C:= Cache.Countries.GetByCode(Code);
  if C <> nil then
    Result:= C.EnglishName;
end;

function TTMDB.LanguageName(const Code: String): String;
var
  L: ITMDBLanguage;
begin
  Result:= Code;
  L:= Cache.Languages.GetByCode(Code);
  if L <> nil then
    Result:= L.EnglishName;
end;

procedure TTMDB.ListCountries(AList: TStrings);
var
  X: Integer;
  O: ITMDBCountry;
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
  O: ITMDBLanguage;
begin
  AList.Clear;
  for X := 0 to FTMDB.Cache.Languages.Count-1 do begin
    O:= FTMDB.Cache.Languages[X];
    AList.Append(O.ISO639_1);
  end;
end;

procedure TTMDB.ListPrimaryTranslations(AList: TStrings);
var
  A: TTMDBStrArray;
  X: Integer;
begin
  AList.Clear;
  A:= FTMDB.Cache.PrimaryTranslations;
  for X := 0 to Length(A)-1 do begin
    AList.Append(A[X]);
  end;
end;

function TTMDB.Lists: ITMDBNamespaceLists;
begin
  Result:= FTMDB.Lists;
end;

function TTMDB.MovieLists: ITMDBNamespaceMovieLists;
begin
  Result:= FTMDB.MovieLists;
end;

function TTMDB.Movies: ITMDBNamespaceMovies;
begin
  Result:= FTMDB.Movies;
end;

function TTMDB.Networks: ITMDBNamespaceNetworks;
begin
  Result:= FTMDB.Networks;
end;

function TTMDB.People: ITMDBNamespacePeople;
begin
  Result:= FTMDB.People;
end;

function TTMDB.PeopleLists: ITMDBNamespacePeopleLists;
begin
  Result:= FTMDB.PeopleLists;
end;

function TTMDB.Reviews: ITMDBNamespaceReviews;
begin
  Result:= FTMDB.Reviews;
end;

end.
