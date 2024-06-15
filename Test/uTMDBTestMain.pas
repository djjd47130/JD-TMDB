unit uTMDBTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  JD.TMDB.Intf,
  JD.TMDB.Impl,
  JD.TMDB.Common,
  XSuperObject, XSuperJSON,
  uTabBase, uContentBase,
  uTabConfiguration,
  uTabSearch,
  uTabGenres,
  Clipbrd, JD.Common, JD.Ctrls, JD.Ctrls.FontButton, JD.Ctrls.SideMenu, JD.TMDB;

type
  TfrmTMDBTestMain = class(TForm)
    Pages: TPageControl;
    tabCertifications: TTabSheet;
    tabSetup: TTabSheet;
    Panel1: TPanel;
    gbAPIAuthMethod: TGroupBox;
    gbAPIAuthMethodAPIKey: TPanel;
    Label1: TLabel;
    txtAPIKey: TEdit;
    gbAPIAuthMethodAccessToken: TPanel;
    Label3: TLabel;
    txtAccessToken: TEdit;
    Panel2: TPanel;
    rAuthToken: TRadioButton;
    rAuthKey: TRadioButton;
    MM: TMainMenu;
    Services1: TMenuItem;
    Setup1: TMenuItem;
    AppSetup1: TMenuItem;
    CertPages: TPageControl;
    tabCertsMovies: TTabSheet;
    tabCertsTV: TTabSheet;
    Button1: TButton;
    btnRefreshCertsMovies: TButton;
    btnRefreshCertsTV: TButton;
    lstCertsMovies: TListView;
    lstCertsTV: TListView;
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
    lblUserSessionID: TLabel;
    lblUserAccountID: TLabel;
    Panel5: TPanel;
    imgUserAvatar: TImage;
    btnLogout: TButton;
    TMDB: TTMDB;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure APIAuthMethodRadioClick(Sender: TObject);
    procedure AppSetup1Click(Sender: TObject);
    procedure Services1Click(Sender: TObject);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnRefreshCertsMoviesClick(Sender: TObject);
    procedure btnRefreshCertsTVClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblUserSessionIDDblClick(Sender: TObject);
    procedure btnUserClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure txtAuthPassKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FAppSetup: ISuperObject;
    FAuthMethod: Integer;

    procedure LoadSetup;
    procedure SaveSetup;
    function SetupFilename: String;

    procedure ServiceClicked(Sender: TObject);

    function EmbedTab(ATabClass: TfrmTabBaseClass): TfrmTabBase;
    procedure EmbedTabs;
    function GetAPIAuth: TTMDBAuthMethod;
    procedure SetAPIAuth(const Value: TTMDBAuthMethod);
    procedure ShowUserInfo;

  public
    procedure PrepAPI;

    property APIAuth: TTMDBAuthMethod read GetAPIAuth write SetAPIAuth;
  end;

var
  frmTMDBTestMain: TfrmTMDBTestMain;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TfrmTMDBTestMain.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}

  Pages.Align:= alClient;
  gbUserInfo.Align:= alClient;
  gbUserLogin.Align:= alClient;
  CertPages.Align:= alClient;

  FAuthMethod:= 2;

  EmbedTabs;
  LoadSetup;

  Services1.Click;

  Width:= 1200;
  Height:= 800;

end;

procedure TfrmTMDBTestMain.FormDestroy(Sender: TObject);
begin
  FAppSetup:= nil;
end;

procedure TfrmTMDBTestMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSetup;
end;

procedure TfrmTMDBTestMain.lblUserSessionIDDblClick(Sender: TObject);
begin
  Clipboard.AsText:= lblUserSessionID.Caption;
end;

procedure TfrmTMDBTestMain.LoadSetup;
var
  C: TControl;
begin
  if FileExists(SetupFilename) then begin
    FAppSetup:= TSuperObject.ParseFile(SetupFilename);
  end else begin
    FAppSetup:= SO;
  end;

  txtAPIKey.Text:= FAppSetup.S['api_key'];
  txtAccessToken.Text:= FAppSetup.S['access_token'];
  APIAuth:= TTMDBAuthMethod(FAppSetup.I['api_auth']);

  PrepAPI;

  Pages.ActivePageIndex:= FAppSetup.I['current_tab'];
  C:= Pages.ActivePage.Controls[0];
  if C is TfrmTabBase then begin
    TfrmTabBase(C).Pages.ActivePageIndex:= FAppSetup.I['current_sub_tab'];
  end;

  Caption:= 'TMDB API Test - ' + Pages.ActivePage.Caption;

  if (FAppSetup.S['session_id'] <> '') and (FAppSetup.B['session_guest'] = False) then begin
    if TMDB.LoginState.RestoreSession(FAppSetup.S['session_id']) then begin
      ShowUserInfo;
    end;
  end;

end;

procedure TfrmTMDBTestMain.SaveSetup;
var
  C: TControl;
begin
  if Assigned(FAppSetup) then begin
    FAppSetup.S['api_key']:= txtAPIKey.Text;
    FAppSetup.S['access_token']:= txtAccessToken.Text;
    FAppSetup.I['api_auth']:= Integer(APIAuth);
    FAppSetup.S['session_id']:= TMDB.LoginState.SessionID;
    FAppSetup.B['session_guest']:= TMDB.LoginState.IsGuest;
    FAppSetup.I['current_tab']:= Pages.ActivePageIndex;
    C:= Pages.ActivePage.Controls[0];
    if C is TfrmTabBase then begin
      FAppSetup.I['current_sub_tab']:=  TfrmTabBase(C).Pages.ActivePageIndex;
    end;

    FAppSetup.SaveTo(SetupFilename);
  end;
end;

procedure TfrmTMDBTestMain.APIAuthMethodRadioClick(Sender: TObject);
var
  T: Integer;
  procedure HideAll;
  begin
    gbAPIAuthMethodAPIKey.Visible:= False;
    gbAPIAuthMethodAccessToken.Visible:= False;
  end;
begin
  HideAll;
  T:= TControl(Sender).Tag;
  case T of
    0: gbAPIAuthMethodAPIKey.Visible:= True;
    1: gbAPIAuthMethodAccessToken.Visible:= True;
  end;
end;

procedure TfrmTMDBTestMain.AppSetup1Click(Sender: TObject);
begin
  ServiceClicked(AppSetup1);
end;

procedure TfrmTMDBTestMain.ShowUserInfo;
var
  D: ITMDBAccountDetail;
begin
  if TMDB.LoginState.IsAuthenticated then begin
    btnLogin.Tag:= 1;
    gbUserInfo.Visible:= True;
    gbUserLogin.Visible:= False;
    gbUserInfo.Align:= alClient;
    lblUserSessionID.Caption:= TMDB.LoginState.SessionID;
    if TMDB.LoginState.IsGuest then begin
      lblUserName.Caption:= 'GUEST';
      lblUserFullName.Caption:= 'GUEST USER';
      lblUserAccountID.Caption:= '';
      btnUser.Text:= 'GUEST';
    end else begin
      D:= TMDB.LoginState.AccountDetail;
      lblUserName.Caption:= D.UserName;
      lblUserFullName.Caption:= D.Name;
      lblUserAccountID.Caption:= IntToStr(D.ID);
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

procedure TfrmTMDBTestMain.btnLoginClick(Sender: TObject);
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

  end else begin
    //TODO: Login failed...
  end;

end;

procedure TfrmTMDBTestMain.EmbedTabs;
var
  X: Integer;
begin
  EmbedTab(TfrmTabConfiguration);
  EmbedTab(TfrmTabGenres);
  EmbedTab(TfrmTabSearch);

  for X := 0 to Pages.PageCount-1 do
    Pages.Pages[X].TabVisible:= False;
  Pages.ActivePageIndex:= 0;
end;

function TfrmTMDBTestMain.EmbedTab(ATabClass: TfrmTabBaseClass): TfrmTabBase;
var
  T: TTabSheet;
begin
  T:= TTabSheet.Create(Pages);
  T.PageControl:= Pages;
  Result:= ATabClass.Create(T);
  Result.Parent:= T;
  Result.Align:= alClient;
  Result.BorderStyle:= bsNone;
  Result.Show;
  T.Caption:= Result.Caption;
  T.TabVisible:= False;
end;

function TfrmTMDBTestMain.GetAPIAuth: TTMDBAuthMethod;
begin
  if rAuthKey.Checked then
    Result:= TTMDBAuthMethod.amAPIKey
  else
    Result:= TTMDBAuthMethod.amAccessToken;
end;

procedure TfrmTMDBTestMain.SetAPIAuth(const Value: TTMDBAuthMethod);
var
  R: TRadioButton;
begin
  case Value of
    amAPIKey: R:= rAuthKey;
    else R:= rAuthToken;
  end;
  R.Checked:= True;
  APIAuthMethodRadioClick(R);
end;

procedure TfrmTMDBTestMain.PrepAPI;
begin
  TMDB.APIKey:= txtAPIKey.Text;
  TMDB.AccessToken:= txtAccessToken.Text;
  TMDB.AuthMethod:= GetAPIAuth;
  //TODO: Test connection and authentication...

end;

procedure TfrmTMDBTestMain.Button1Click(Sender: TObject);
var
  O: ITMDBAuthValidateKeyResult;
begin
  PrepAPI;
  O:= TMDB.Client.Authentication.ValidateKey;
  ShowMessage('API Key Validation Result: '+O.StatusMessage);
end;

procedure TfrmTMDBTestMain.btnLogoutClick(Sender: TObject);
begin
  pUser.Visible:= False;
  if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
    PrepAPI;
    if TMDB.LoginState.Logout then begin
      ShowUserInfo;
    end;
  end;
end;

procedure TfrmTMDBTestMain.btnRefreshCertsMoviesClick(Sender: TObject);
var
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  X, Y: Integer;
  I: TListItem;
  G: TListGroup;
begin
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstCertsMovies.Items.BeginUpdate;
    try
      lstCertsMovies.Items.Clear;
      lstCertsMovies.Groups.Clear;

      for X := 0 to TMDB.Cache.MovieCerts.Count-1 do begin
        C:= TMDB.Cache.MovieCerts[X];
        G:= lstCertsMovies.Groups.Add;
        G.Header:= TMDB.CountryName(C.CountryCode);
        for Y := 0 to C.Count-1 do begin
          O:= C[Y];
          I:= lstCertsMovies.Items.Add;
          I.Caption:= IntToStr(O.Order);
          I.SubItems.Add(O.Certification);
          I.SubItems.Add(O.Meaning);
          I.GroupID:= G.GroupID;
        end;
        C:= nil;
      end;

      lstCertsMovies.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstCertsMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.btnRefreshCertsTVClick(Sender: TObject);
var
  Y: Integer;
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  X: Integer;
  I: TListItem;
  G: TListGroup;
begin
  Self.PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstCertsTV.Items.BeginUpdate;
    try
      Self.lstCertsTV.Items.Clear;
      Self.lstCertsTV.Groups.Clear;
      for X := 0 to TMDB.Cache.TVCerts.Count-1 do begin
        C:= TMDB.Cache.TVCerts[X];
        G:= lstCertsTV.Groups.Add;
        G.Header:= TMDB.CountryName(C.CountryCode);
        for Y := 0 to C.Count-1 do begin
          O:= C[Y];
          I:= Self.lstCertsTV.Items.Add;
          I.Caption:= IntToStr(O.Order);
          I.SubItems.Add(O.Certification);
          I.SubItems.Add(O.Meaning);
          I.GroupID:= G.GroupID;
        end;
      end;
      lstCertsTV.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstCertsTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.btnUserClick(Sender: TObject);
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
end;

procedure TfrmTMDBTestMain.Services1Click(Sender: TObject);
var
  X: Integer;
  T: TTabSheet;
  I: TMenuItem;
begin
  Services1.Clear;
  //Skip the first SETUP tab...
  for X := 1 to Pages.PageCount-1 do begin
    T:= Pages.Pages[X];

    I:= TMenuItem.Create(Services1);
    try
      I.Caption:= T.Caption;
      I.RadioItem:= True;
      I.Tag:= T.PageIndex;
      if I.Tag = Pages.ActivePageIndex then
        I.Checked:= True;
      I.OnClick:= ServiceClicked;
    finally
      Services1.Add(I);
    end;
  end;
end;

procedure TfrmTMDBTestMain.Setup1Click(Sender: TObject);
var
  X: Integer;
begin
  for X := 0 to Setup1.Count-1 do begin
    Setup1[X].Checked:= Setup1[X].Tag = Pages.ActivePageIndex;
  end;
end;

function TfrmTMDBTestMain.SetupFilename: String;
begin
  Result:= ExtractFilePath(ParamStr(0));
  Result:= TPath.Combine(Result, 'AppConfig.json');
end;

procedure TfrmTMDBTestMain.txtAuthPassKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    btnLogin.Click;
  end;
end;

procedure TfrmTMDBTestMain.UserAuthMethodClick(Sender: TObject);
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

procedure TfrmTMDBTestMain.ServiceClicked(Sender: TObject);
var
  I: Integer;
  M: TMenuItem;
begin
  M:= TMenuItem(Sender);
  M.Checked:= True;
  I:= M.Tag;
  Pages.ActivePageIndex:= I;
  Caption:= 'TMDB API Test - ' + Pages.ActivePage.Caption;
end;

end.
