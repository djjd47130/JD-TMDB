unit JD.TMDB;

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
    function GetAccessToken: String;
    function GetAPIKey: String;
    function GetAuthMethod: TTMDBAuthMethod;
    procedure SetAccessToken(const Value: String);
    procedure SetAPIKey(const Value: String);
    procedure SetAuthMethod(const Value: TTMDBAuthMethod);
    function GetCache: ITMDBCache;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Client: ITMDBClient read FTMDB;
    property Cache: ITMDBCache read GetCache;
  published
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property APIKey: String read GetAPIKey write SetAPIKey;
    property AccessToken: String read GetAccessToken write SetAccessToken;
  end;

implementation

{ TTMDB }

constructor TTMDB.Create(AOwner: TComponent);
begin
  inherited;
  FTMDB:= TTMDBClient.Create;
  FTMDB._AddRef;
end;

destructor TTMDB.Destroy;
begin
  FTMDB._Release;
  FTMDB:= nil;
  inherited;
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

end.
