unit uContentBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, WebView2, Winapi.ActiveX,
  Vcl.Edge, Vcl.StdCtrls, Vcl.ExtCtrls, JD.Common, JD.Ctrls, JD.Ctrls.FontButton,
  JD.TabController,
  ChromeTabsTypes;

type
  TfrmContentBrowser = class(TfrmContentBase)
    Edge: TEdgeBrowser;
    pTop: TPanel;
    txtAddress: TEdit;
    btnGo: TJDFontButton;
    btnBack: TJDFontButton;
    btnForward: TJDFontButton;
    btnRefresh: TJDFontButton;
    procedure FormCreate(Sender: TObject);
    procedure EdgeDocumentTitleChanged(Sender: TCustomEdgeBrowser;
      const ADocumentTitle: string);
    procedure EdgeNewWindowRequested(Sender: TCustomEdgeBrowser;
      Args: TNewWindowRequestedEventArgs);
    procedure EdgeContentLoading(Sender: TCustomEdgeBrowser;
      IsErrorPage: Boolean; NavigationID: TUInt64);
    procedure btnGoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure EdgeContainsFullScreenElementChanged(Sender: TCustomEdgeBrowser;
      ContainsFullScreenElement: Boolean);
    procedure EdgeNavigationStarting(Sender: TCustomEdgeBrowser;
      Args: TNavigationStartingEventArgs);
    procedure EdgeNavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: TOleEnum);
    procedure txtAddressDblClick(Sender: TObject);
  private
    FInitialized: Boolean;
    procedure SetFullscreen(const Value: Boolean);
  public
    procedure UpdateHeader;
    procedure Navigate(const URL: String);
    function Tab: TJDTabRef;
  end;

var
  frmContentBrowser: TfrmContentBrowser;

implementation

{$R *.dfm}

uses
  uMain;

procedure TfrmContentBrowser.EdgeContainsFullScreenElementChanged(
  Sender: TCustomEdgeBrowser; ContainsFullScreenElement: Boolean);
begin
  inherited;
  SetFullscreen(ContainsFullScreenElement);
end;

procedure TfrmContentBrowser.SetFullscreen(const Value: Boolean);
begin
  frmMain.FullScreen:= Value;
  frmMain.ContentOnly:= Value;
  pTop.Visible:= not Value;
end;

function TfrmContentBrowser.Tab: TJDTabRef;
begin
  Result:= TabController.TabByForm(Self);
end;

procedure TfrmContentBrowser.txtAddressDblClick(Sender: TObject);
begin
  inherited;


  txtAddress.SelectAll;
end;

procedure TfrmContentBrowser.EdgeContentLoading(Sender: TCustomEdgeBrowser;
  IsErrorPage: Boolean; NavigationID: TUInt64);
begin
  inherited;
  UpdateHeader;
end;

procedure TfrmContentBrowser.EdgeDocumentTitleChanged(Sender: TCustomEdgeBrowser;
  const ADocumentTitle: string);
begin
  inherited;
  UpdateHeader;
end;

procedure TfrmContentBrowser.UpdateHeader;
var
  T: String;
begin
  T:= Edge.DocumentTitle;
  if T = '' then
    T:= '(Blank Page)';
  TabCaption:= T;
  txtAddress.Text:= Edge.LocationURL;
  btnBack.Enabled:= Edge.CanGoBack;
  btnForward.Enabled:= Edge.CanGoForward;
end;

procedure TfrmContentBrowser.EdgeNavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: TOleEnum);
begin
  inherited;
  Tab.ChromeTab.SpinnerState:= tssNone;
  btnGo.Tag:= 0;
  btnGo.Image.Text:= ''; //Go
end;

procedure TfrmContentBrowser.EdgeNavigationStarting(Sender: TCustomEdgeBrowser;
  Args: TNavigationStartingEventArgs);
begin
  inherited;
  Tab.ChromeTab.SpinnerState:= tssRenderedDownload;
  btnGo.Tag:= 1;
  btnGo.Image.Text:= ''; //Stop
end;

procedure TfrmContentBrowser.EdgeNewWindowRequested(Sender: TCustomEdgeBrowser;
  Args: TNewWindowRequestedEventArgs);
var
  URI: PWideChar;
  T: TJDTabRef;
begin
  inherited;
  Args.ArgsInterface.Set_Handled(1);
  if Args.ArgsInterface.Get_uri(URI) = S_OK then begin
    T:= TabController.CreateTab(TfrmContentBrowser);
    (T.Content as TfrmContentBrowser).Navigate(URI);
  end;
end;

procedure TfrmContentBrowser.FormCreate(Sender: TObject);
begin
  inherited;
  Edge.Align:= alClient;
  FInitialized:= False;
end;

procedure TfrmContentBrowser.FormShow(Sender: TObject);
begin
  inherited;
  if not FInitialized then begin
    Edge.ReinitializeWebView;
    FInitialized:= True;
  end;
  UpdateHeader;
end;

procedure TfrmContentBrowser.Navigate(const URL: String);
var
  S: String;
  P: Integer;
begin
  S:= URL;
  P:= Pos('://', S);
  if P < 1 then
    S:= 'https://' + S;
  txtAddress.Text:= S;
  Edge.Navigate(S);
  UpdateHeader;
end;

procedure TfrmContentBrowser.btnBackClick(Sender: TObject);
begin
  inherited;
  Edge.GoBack;
end;

procedure TfrmContentBrowser.btnForwardClick(Sender: TObject);
begin
  inherited;
  Edge.GoForward;
end;

procedure TfrmContentBrowser.btnGoClick(Sender: TObject);
begin
  inherited;
  case btnGo.Tag of
    0: Navigate(txtAddress.Text);
    1: Edge.Stop;
  end;
end;

procedure TfrmContentBrowser.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Edge.Refresh;
end;

end.
