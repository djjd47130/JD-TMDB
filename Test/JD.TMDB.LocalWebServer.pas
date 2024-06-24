unit JD.TMDB.LocalWebServer;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  IdHTTPServer,
  IdCustomHTTPServer,
  IdCustomTCPServer,
  IdContext,
  IdURI,
  JD.TMDB,
  JD.TMDB.Intf,
  JD.TMDB.Common;

type
  TTMDBLocalWebServerContext = class(TIdServerContext)

  end;

  TTMDBLocalWebServer = class(TThread)
  private
    FTMDB: TTMDB;
    FServer: TIdHTTPServer;
    FPort: Integer;
    procedure Init;
    procedure Uninit;
    procedure ServerCommand(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure SetPort(const Value: Integer);
  protected
    procedure Execute; override;
  public
    constructor Create(ATMDB: TTMDB); reintroduce;
    destructor Destroy; override;

    property Port: Integer read FPort write SetPort;
  end;

implementation

{ TTMDBLocalWebServer }

constructor TTMDBLocalWebServer.Create(ATMDB: TTMDB);
begin
  inherited Create(True);
  FTMDB:= ATMDB;
  FPort:= 1420;

end;

destructor TTMDBLocalWebServer.Destroy;
begin

  FTMDB:= nil;
  inherited;
end;

procedure TTMDBLocalWebServer.Execute;
begin
  Init;
  try
    while not Terminated do begin

      Sleep(0);
    end;
  finally
    Uninit;
  end;
end;

procedure TTMDBLocalWebServer.Init;
begin
  FServer:= TIdHTTPServer.Create(nil);
  FServer.DefaultPort:= FPort;
  FServer.OnCommandGet:= ServerCommand;
  FServer.OnCommandOther:= ServerCommand;
  FServer.ContextClass:= TTMDBLocalWebServerContext;

  FServer.Active:= True;
end;

function BaseHTML(const Title, Head, Body: String): String;
  procedure A(const S: String);
  begin
    Result:= Result + S + sLineBreak; // ' ';
  end;
begin
  Result:= '';
  A('<!DOCTYPE html>');
  A('<html lang="en">');
  A('<head>');
  A('  <meta charset="utf-8">');
  A('  <meta name="viewport" content="width=device-width, initial-scale=1">');
  A('  <title>');
  A('    '+Title);
  A('  </title>');
  A('  <meta name="description" content="YouTube Embedded Video Viewer">');
  A('  <meta name="author" content="JD TMDB API Wrapper for Delphi">');
  A(Head);
  A('</head>');
  A('<body>');
  A(Body);
  A('</body>');
  A('</html>');
end;

function EmbedYouTubeHTML(const Key: String): String;
var
  H: String;
  procedure A(const S: String);
  begin
    H:= H + S + sLineBreak;
  end;
begin
  A('  <iframe id="video" title="YouTube Video" width="420" height="315"');
  A('    src="https://www.youtube.com/embed/'+Key+'" allowfullscreen="1">');
  A('  </iframe>');
  Result:= BaseHTML('YouTube Video', '', H);
end;

procedure TTMDBLocalWebServer.ServerCommand(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  C: TTMDBLocalWebServerContext;
  U: TIdURI;
  Doc: TStringList;
  X: Integer;
begin
  C:= TTMDBLocalWebServerContext(AContext);
  Doc:= TStringList.Create;
  try
    U:= TIdURI.Create(ARequestInfo.URI);
    try
      Doc.Delimiter:= '/';
      Doc.DelimitedText:= U.Path+U.Document;
      for X := Doc.Count-1 downto 0 do begin
        if Trim(Doc[X]) = '' then
          Doc.Delete(X);
      end;

      case ARequestInfo.CommandType of
        hcUnknown: ;
        hcHEAD: ;
        hcGET: begin
          AResponseInfo.ContentType:= 'text/html';
          if Doc.Count = 0 then begin
            //Main page

          end else
          if SameText(Doc[0], 'youtube') then begin
            //Embedded YouTube video
            AResponseInfo.ContentText:= EmbedYouTubeHTML(Doc[1]);
          end else
          if SameText(Doc[0], 'vimeo') then begin
            //Embedded Vimeo video
            //TODO
          end;
        end;
        hcPOST: ;
        hcDELETE: ;
        hcPUT: ;
        hcTRACE: ;
        hcOPTION: ;
      end;

    finally
      U.Free;
    end;
  finally
    Doc.Free;
  end;
end;

procedure TTMDBLocalWebServer.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

procedure TTMDBLocalWebServer.Uninit;
begin
  FServer.Active:= False;
  FreeAndNil(FServer);
end;

end.
