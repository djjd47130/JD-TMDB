unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton,
  JD.TMDB,
  JD.TMDB.Intf,
  JD.TMDB.Impl,
  JD.TMDB.Common,
  JD.TMDB.LocalWebServer,
  JD.TabController,
  uContentBase,

  XSuperObject, XSuperJSON,

  ChromeTabs, ChromeTabsClasses,

  Vcl.Styles.Utils,
  Vcl.Styles.Fixes,

  uLoginBrowser,
  uTMDBHome,
  uTMDBAppSetup;

type
  TfrmMain = class(TForm)
    pTop: TPanel;
    btnUser: TJDFontButton;
    pUser: TPanel;
    gbUserLogin: TGroupBox;
    Panel3: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    rbCreds: TRadioButton;
    pAuthUser: TPanel;
    Label2: TLabel;
    txtAuthUser: TEdit;
    pAuthPass: TPanel;
    Label4: TLabel;
    txtAuthPass: TEdit;
    btnLogin: TButton;
    gbUserInfo: TGroupBox;
    Panel4: TPanel;
    lblUserName: TLabel;
    lblUserFullName: TLabel;
    Panel5: TPanel;
    imgUserAvatar: TImage;
    btnLogout: TButton;
    TMDB: TTMDB;
    Tabs: TChromeTabs;
    pContent: TPanel;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure btnValidateKeyClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnUserClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure txtAuthPassKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TMDBUserAuthRequest(Sender: TObject; const URL: WideString;
      var Result: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
    procedure TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FWebServer: TTMDBLocalWebServer;
    FAuthMethod: Integer;
    procedure ShowUserInfo;
  public
    procedure PrepAPI;
    property WebServer: TTMDBLocalWebServer read FWebServer;
  end;

var
  frmMain: TfrmMain;

function AppSetup: TAppSetup;

implementation

uses
  System.IOUtils,
  Vcl.Themes;

{$R *.dfm}

var
  _AppSetup: TAppSetup;

function AppSetup: TAppSetup;
begin
  if _AppSetup = nil then
    _AppSetup:= TAppSetup.Create;
  Result:= _AppSetup;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
  //ReportMemoryLeaksOnShutdown:= True;
  //MEMORY LEAKS! TEMPORARILY DISABLING!
  {$ENDIF}

  InitTabController;
  TabController.ChromeTabs:= Tabs;
  TabController.Container:= pContent;
  TabController.MainForm:= Self;

  //TStyleManager.TrySetStyle('Light', False);
  TStyleManager.TrySetStyle('Windows10 Dark', False);

  pContent.Align:= alClient;
  gbUserInfo.Align:= alClient;
  gbUserLogin.Align:= alClient;

  FAuthMethod:= 2;

  FWebServer:= TTMDBLocalWebServer.Create(TMDB);
  FWebServer.Start;

  Width:= 1200;
  Height:= 800;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FWebServer.Terminate;
  FreeAndNil(FWebServer);

  UninitTabController;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  T: TJDTabRef;
begin
  PrepAPI;
  T:= TabController.CreateTab(TfrmTMDBHome);
  T.ChromeTab.HideCloseButton:= True;
  //T.ChromeTab.Pinned:= True;
  //TODO: Ensure this tab cannot be closed...

  if (AppSetup.SessionID <> '') and (AppSetup.SessionGuest = False) then begin
    if TMDB.LoginState.RestoreSession(AppSetup.SessionID) then begin
      ShowUserInfo;
    end;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //TODO: Query all open tabs...

end;

procedure TfrmMain.ShowUserInfo;
var
  D: ITMDBAccountDetail;
begin
  if TMDB.LoginState.IsAuthenticated then begin
    btnLogin.Tag:= 1;
    gbUserInfo.Visible:= True;
    gbUserLogin.Visible:= False;
    gbUserInfo.Align:= alClient;
    if TMDB.LoginState.IsGuest then begin
      lblUserName.Caption:= 'GUEST';
      lblUserFullName.Caption:= 'GUEST USER';
      btnUser.Text:= 'GUEST';
    end else begin
      D:= TMDB.LoginState.AccountDetail;
      lblUserName.Caption:= D.UserName;
      lblUserFullName.Caption:= D.Name;
      if D.Name <> '' then
        btnUser.Text:= D.Name
      else
        btnUser.Text:= D.UserName;
      //TODO: Gravatar...
    end;
  end else begin
    btnLogin.Tag:= 0;
    gbUserInfo.Visible:= False;
    gbUserLogin.Visible:= True;
    txtAuthUser.Text:= '';
    txtAuthPass.Text:= '';
    btnUser.Text:= 'User Login';
  end;
end;

procedure TfrmMain.TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
begin
  TabController.ActiveTabIndex:= ATab.Index;
end;

procedure TfrmMain.TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
  var Close: Boolean);
begin
  Close:= False;
  TabController.DeleteTab(ATab.Index);
end;

procedure TfrmMain.TMDBUserAuthRequest(Sender: TObject;
  const URL: WideString; var Result: Boolean);
var
  F: TfrmLoginBrowser;
  U: String;
begin
  //TODO: Move local web server into TTMDB component
  //Open URL in web browser to authenticate user...
  F:= TfrmLoginBrowser.Create(nil);
  try
    //We instruct it to redirect to our web server upon successful login...
    U:= URL + '?redirect_to=http://localhost:'+IntToStr(FWebServer.Port)+'/authgranted';
    F.LoadURL(U);
    F.ShowModal;
    Result:= F.Success;
  finally
    F.Free;
  end;
end;

procedure TfrmMain.btnLoginClick(Sender: TObject);
var
  Success: Boolean;
  GS: ITMDBAuthGuestSessionResult;
  US: ITMDBAuthSessionResult;
begin
  PrepAPI;
  Success:= False;
  case FAuthMethod of
    0: begin
      //Guest...
      GS:= TMDB.LoginState.LoginAsGuest;
      Success:= GS.Success;
    end;
    1: begin
      //Normal...
      US:= TMDB.LoginState.LoginAsUser;
      Success:= US.Success;
    end;
    2: begin
      //Credentials...
      US:= TMDB.LoginState.LoginAsCreds(txtAuthUser.Text, txtAuthPass.Text);
      Success:= US.Success;
    end;
  end;
  if Success then begin
    pUser.Visible:= False;
    ShowUserInfo;
  end;
end;

procedure TfrmMain.PrepAPI;
begin
  TMDB.APIKey:= AppSetup.APIKey;
  TMDB.AccessToken:= AppSetup.AccessToken;
  TMDB.AuthMethod:= AppSetup.APIAuth;

end;

procedure TfrmMain.btnValidateKeyClick(Sender: TObject);
var
  O: ITMDBAuthValidateKeyResult;
begin
  PrepAPI;
  O:= TMDB.Client.Authentication.ValidateKey;
  ShowMessage('API Key Validation Result: '+O.StatusMessage);
end;

procedure TfrmMain.btnLogoutClick(Sender: TObject);
begin
  pUser.Visible:= False;
  if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
    PrepAPI;
    if TMDB.LoginState.Logout then begin
      ShowUserInfo;
    end;
  end;
end;

procedure TfrmMain.btnUserClick(Sender: TObject);
begin
  if pUser.Visible then begin
    pUser.Visible:= False;
  end else begin
    pUser.Width:= 300;
    pUser.Top:= pTop.Top + pTop.Height + 2;
    pUser.Left:= ClientWidth - pUser.Width;
    pUser.Visible:= True;
    pAuthUser.Top:= 200;
    pAuthPass.Top:= 200;
    btnLogin.Top:= 200;
    if gbUserLogin.Visible and rbCreds.Visible and txtAuthUser.CanFocus then begin
      txtAuthUser.SetFocus;
      txtAuthuser.SelectAll;
    end;
  end;
  pUser.BringToFront;
end;

procedure TfrmMain.txtAuthPassKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    btnLogin.Click;
  end;
end;

procedure TfrmMain.UserAuthMethodClick(Sender: TObject);
var
  I: Integer;
begin
  I:= TComponent(Sender).Tag;
  FAuthMethod:= I;
  case I of
    2: begin
      pAuthUser.Visible:= True;
      pAuthPass.Visible:= True;
      pAuthUser.Top:= 200;
      pAuthPass.Top:= 200;
      btnLogin.Top:= 200;
      txtAuthUser.SetFocus;
      txtAuthUser.SelectAll;
    end;
    else begin
      pAuthUser.Visible:= False;
      pAuthPass.Visible:= False;
    end;
  end;
end;

initialization
  _AppSetup:= nil;
finalization
  FreeAndNil(_AppSetup);
end.
