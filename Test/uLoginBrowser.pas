unit uLoginBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WebView2, Winapi.ActiveX, Vcl.Edge,
  IdURI;

type
  TfrmLoginBrowser = class(TForm)
    Edge: TEdgeBrowser;
    procedure EdgeNavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: TOleEnum);
  private
    { Private declarations }
  public
    procedure LoadURL(const URL: String);
    function Success: Boolean;
  end;

var
  frmLoginBrowser: TfrmLoginBrowser;

implementation

{$R *.dfm}

{ TfrmLoginBrowser }

procedure TfrmLoginBrowser.EdgeNavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: TOleEnum);
begin
  //Caption:= Sender.LocationURL;
  // https://www.themoviedb.org/authenticate/<token>/allow
  if Success then
    ModalResult:= mrOK;
end;

procedure TfrmLoginBrowser.LoadURL(const URL: String);
begin
  Edge.ReinitializeWebView;
  Edge.Navigate(URL);
end;

function TfrmLoginBrowser.Success: Boolean;
var
  U: String;
  URI: TIdURI;
begin
  Result:= False;
  U:= Edge.LocationURL;
  URI:= TIdURI.Create(U);
  try
    if URI.Document = 'authgranted' then begin
      Result:= True;
    end;
  finally
    URI.Free;
  end;
end;

end.
