unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  System.NetEncoding,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton, JD.Graphics,
  JD.TMDB,
  JD.TMDB.Intf,
  JD.TMDB.Common,
  JD.TabController,
  uContentBase,
  uContentBrowser,

  Jpeg, PngImage,

  XSuperObject, XSuperJSON,

  ChromeTabs, ChromeTabsClasses,

  Vcl.Styles.Utils,
  Vcl.Styles.Fixes,

  uLoginBrowser,
  uTMDBMenu,
  uTMDBAppSetup, System.ImageList, Vcl.ImgList;

type

  TDetailRef = class;

  TDetailRefEvent = reference to procedure(Ref: TDetailRef);

  TDetailRef = class(TObject)
  private
    FOnClick: TDetailRefEvent;
    FItem: TListItem;
    procedure SetOnClick(const Value: TDetailRefEvent);
    function GetClickable: Boolean;
  public
    constructor Create(AItem: TListItem);
    property Clickable: Boolean read GetClickable;
    property Item: TListItem read FItem;
    property OnClick: TDetailRefEvent read FOnClick write SetOnClick;
  end;


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
    pContent: TPanel;
    Stat: TStatusBar;
    pMenu: TPanel;
    btnMenu: TJDFontButton;
    JDFontButton1: TJDFontButton;
    Tabs: TChromeTabs;
    Favicons: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnUserClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure txtAuthPassKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TMDBUserAuthRequest(Sender: TObject; const URL: WideString;
      var Result: Boolean);
    procedure TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
    procedure TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure btnMenuClick(Sender: TObject);
    procedure TabsButtonAddClick(Sender: TObject; var Handled: Boolean);
  private
    FAuthMethod: Integer;
    FMenu: TfrmTMDBHome;
    FFullScreen: Boolean;
    FRect: TRect;
    FState: TWindowState;
    FContentOnly: Boolean;
    FFaviconRefs: TDictionary<String, Integer>;
    procedure ShowUserInfo;
    procedure ShowUserAvatar(const Path: String);
    procedure SetFullScreen(const Value: Boolean);
    procedure SetContentOnly(const Value: Boolean);
  public
    procedure PrepAPI;
    function MenuVisible: Boolean;
    procedure ShowMenu(const Value: Boolean);
    property FullScreen: Boolean read FFullScreen write SetFullScreen;
    property ContentOnly: Boolean read FContentOnly write SetContentOnly;
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


{ TDetailRef }

constructor TDetailRef.Create(AItem: TListItem);
begin
  FItem:= AItem;
end;

function TDetailRef.GetClickable: Boolean;
begin
  Result:= Assigned(FOnClick);
end;

procedure TDetailRef.SetOnClick(const Value: TDetailRefEvent);
begin
  FOnClick := Value;
end;


{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= True;
  //MEMORY LEAKS! TEMPORARILY DISABLING!
  {$ENDIF}

  //UI
  TStyleManager.TrySetStyle('Carbon', False);
  ColorManager.BaseColor:= clBlack; // TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scButtonNormal);
  pContent.Align:= alClient;
  gbUserInfo.Align:= alClient;
  gbUserLogin.Align:= alClient;
  Width:= 1200;
  Height:= 800;

  //Tabs
  InitTabController;
  TabController.ChromeTabs:= Tabs;
  TabController.Container:= pContent;
  TabController.MainForm:= Self;
  FFaviconRefs:= TDictionary<String, Integer>.Create;

  //User Auth
  FAuthMethod:= 2;

  //Main Menu
  FMenu:= TfrmTMDBHome.Create(pMenu);
  FMenu.Parent:= pMenu;
  FMenu.BorderStyle:= bsNone;
  FMenu.Align:= alClient;
  FMenu.Show;

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  //Tabs
  UninitTabController;
  FreeAndNil(FFaviconRefs);
end;

procedure TfrmMain.FormShow(Sender: TObject);
//var
//  T: TJDTabRef;
begin
  PrepAPI;

  //User Auth
  //Restore user login session
  if (AppSetup.SessionID <> '') and (AppSetup.SessionGuest = False) then begin
    try
      if TMDB.LoginState.RestoreSession(AppSetup.SessionID) then begin
        ShowUserInfo;
      end;
    except
      on E: Exception do begin
        //TODO
      end;
    end;
  end;
end;

function TfrmMain.MenuVisible: Boolean;
begin
  //Main Menu
  Result:= pMenu.Tag = 1;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Tabs
  CanClose:= TabController.CloseQuery;
end;

procedure TfrmMain.ShowUserInfo;
var
  D: ITMDBAccountDetail;
begin
  //User Auth
  imgUserAvatar.Picture.Assign(nil);
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
      ShowUserAvatar(D.TMDBAvatarPath);
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

procedure TfrmMain.ShowUserAvatar(const Path: String);
var
  D: WideString;
  S: TStringStream;
  Enc: TBase64Encoding;
begin
  //User Auth
  imgUserAvatar.Picture.Assign(nil);
  if Path <> '' then begin
    if TMDB.Client.GetImage(D, Path, 'w185') then begin
      Enc:= TBase64Encoding.Create(0);
      try
        D:= Enc.Decode(D);
        S:= TStringStream.Create(D);
        try
          S.Position:= 0;
          imgUserAvatar.Picture.LoadFromStream(S);
        finally
          S.Free;
        end;
      finally
        Enc.Free;
      end;
    end else begin
      //raise Exception.Create('Failed to fetch image.');
    end;
  end;
end;

procedure TfrmMain.TabsActiveTabChanged(Sender: TObject; ATab: TChromeTab);
begin
  //Tabs
  TabController.HandleTabChanged(ATab);
end;

procedure TfrmMain.TabsButtonAddClick(Sender: TObject; var Handled: Boolean);
var
  T: TJDTabRef;
begin
  //Tabs
  Handled:= True;
  T:= TabController.CreateTab(TfrmContentBrowser);
  (T.Content as TfrmContentBrowser).Navigate('https://google.com');
  ShowMenu(False);
end;

procedure TfrmMain.TabsButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
  var Close: Boolean);
begin
  //Tabs
  Close:= False;
  TabController.DeleteTab(ATab.Index);
end;

procedure TfrmMain.TMDBUserAuthRequest(Sender: TObject;
  const URL: WideString; var Result: Boolean);
var
  F: TfrmLoginBrowser;
  U: String;
begin
  //User Auth
  //TODO: Move local web server into TTMDB component
  //Open URL in web browser to authenticate user...
  F:= TfrmLoginBrowser.Create(nil);
  try
    //We instruct it to redirect to our web server upon successful login...
    U:= URL + '?redirect_to=http://localhost:'+IntToStr(TMDB.WebServer.Port)+'/authgranted';
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
  //User Auth
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
    AppSetup.SessionID:= US.SessionID;
    AppSetup.SessionGuest:= TMDB.LoginState.IsGuest;
    ShowUserInfo;
  end;
end;

procedure TfrmMain.PrepAPI;
begin
  //API Auth
  TMDB.APIKey:= AppSetup.APIKey;
  TMDB.AccessToken:= AppSetup.AccessToken;
  TMDB.AuthMethod:= AppSetup.APIAuth;
end;

procedure TfrmMain.btnLogoutClick(Sender: TObject);
begin
  //User Auth
  pUser.Visible:= False;
  if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
    PrepAPI;
    if TMDB.LoginState.Logout then begin
      ShowUserInfo;
    end;
  end;
end;

procedure TfrmMain.SetContentOnly(const Value: Boolean);
begin
  FContentOnly := Value;
  pTop.Visible:= not Value;
  pMenu.Visible:= not Value;
  Stat.Visible:= not Value;
end;

procedure TfrmMain.SetFullScreen(const Value: Boolean);
var
  M: TMonitor;
begin
  FFullScreen := Value;
  M:= Screen.MonitorFromRect(BoundsRect);

  if Value then begin
    FRect:= BoundsRect;
    FState:= WindowState;
    //Parent:= nil;
    //BringToFront;
    BorderStyle:= bsNone;
    WindowState:= wsMaximized;
    SetBounds(M.Left, M.Top, M.Width, M.Height);
  end else begin
    //Parent:= TabController.Container;
    BorderStyle:= bsSizeable;
    SetBounds(FRect.Left, FRect.Top, FRect.Right, FRect.Bottom);
    WindowState:= FState;
  end;
end;

procedure TfrmMain.ShowMenu(const Value: Boolean);
begin
  //Main Menu
  if Value then begin
    pMenu.Tag:= 1;
    pMenu.Width:= 365;
  end else begin
    pMenu.Tag:= 0;
    pMenu.Width:= 70;
  end;
end;

procedure TfrmMain.btnMenuClick(Sender: TObject);
begin
  //Main Menu
  case pMenu.Tag of
    0: begin
      ShowMenu(True);
    end;
    1: begin
      ShowMenu(False);
    end;
  end;
end;

procedure TfrmMain.btnUserClick(Sender: TObject);
begin
  //User Auth
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
  //User Auth
  if Key = VK_RETURN then begin
    btnLogin.Click;
  end;
end;

procedure TfrmMain.UserAuthMethodClick(Sender: TObject);
var
  I: Integer;
begin
  //User Auth
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
