unit uTMDBTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  {$IFDEF USE_INTF}
  JD.TMDB.Intf,
  JD.TMDB.Impl,
  {$ELSE}
  JD.TMDB.API,
  {$ENDIF}
  XSuperObject, XSuperJSON,
  uTabBase, uContentBase,
  uTabConfiguration,
  uTabSearch,
  Clipbrd;

type
  TfrmTMDBTestMain = class(TForm)
    Pages: TPageControl;
    tabCertifications: TTabSheet;
    tabGenres: TTabSheet;
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
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton6: TRadioButton;
    pAuthUser: TPanel;
    Label2: TLabel;
    txtAuthUser: TEdit;
    pAuthPass: TPanel;
    Label4: TLabel;
    txtAuthPass: TEdit;
    MM: TMainMenu;
    Services1: TMenuItem;
    Setup1: TMenuItem;
    AppSetup1: TMenuItem;
    CertPages: TPageControl;
    tabCertsMovies: TTabSheet;
    tabCertsTV: TTabSheet;
    pLoginStatus: TGroupBox;
    btnLoginLogout: TButton;
    pLoginUserInfo: TGroupBox;
    Panel4: TPanel;
    lblUserName: TLabel;
    lblUserFullName: TLabel;
    lblUserSessionID: TLabel;
    Panel5: TPanel;
    imgUserAvatar: TImage;
    Button1: TButton;
    btnRefreshCertsMovies: TButton;
    btnRefreshCertsTV: TButton;
    lstCertsMovies: TListView;
    lstCertsTV: TListView;
    GenrePages: TPageControl;
    TabSheet7: TTabSheet;
    Button2: TButton;
    TabSheet8: TTabSheet;
    Button3: TButton;
    lstGenreTV: TListView;
    lstGenreMovies: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure APIAuthMethodRadioClick(Sender: TObject);
    procedure AppSetup1Click(Sender: TObject);
    procedure Services1Click(Sender: TObject);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure btnLoginLogoutClick(Sender: TObject);
    procedure btnRefreshCertsMoviesClick(Sender: TObject);
    procedure btnRefreshCertsTVClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgUserAvatarClick(Sender: TObject);
    procedure lblUserSessionIDDblClick(Sender: TObject);
  private
    FAuthMethod: Integer;
    FSessionID: String;
    FSessionGuest: Boolean;
    FAppSetup: ISuperObject;

    //TODO: Remove these in favor of using ITMDB's internal cache instead...
    {$IFDEF USE_INTF}
    FTMDB: ITMDB;

    {$ELSE}
    FTMDB: TTMDBAPI;
    FConfig: ISuperObject;
    FConfigCountries: ISuperArray;
    FConfigJobs: ISuperArray;
    FConfigLanguages: ISuperArray;
    FConfigPrimaryTranslations: ISuperArray;
    FConfigTimezones: ISuperArray;
    FConfigMovieGenres: ISuperArray;
    FConfigTVGenres: ISuperArray;
    FConfigMovieCerts: ISuperObject;
    FConfigTVCerts: ISuperObject;
    {$ENDIF}

    procedure LoadSetup;
    procedure SaveSetup;
    function SetupFilename: String;

    procedure ServiceClicked(Sender: TObject);

    function EmbedTab(ATabClass: TfrmTabBaseClass): TfrmTabBase;
    procedure EmbedTabs;

  public
    procedure PrepAPI;
    procedure ResetAPI;
    {$IFDEF USE_INTF}
    function TMDB: ITMDB;
    {$ELSE}
    function TMDB: TTMDBAPI;
    {$ENDIF}
    function CountryName(const Code: String): String;
    function MovieGenreName(const ID: Integer): String;
    function TVGenreName(const ID: Integer): String;
    procedure ListLanguages(AList: TStrings);
    procedure ListRegions(AList: TStrings);
  end;

var
  frmTMDBTestMain: TfrmTMDBTestMain;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TfrmTMDBTestMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSetup;
end;

procedure TfrmTMDBTestMain.FormCreate(Sender: TObject);
var
  X: Integer;
begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}


  Pages.Align:= alClient;

  {$IFDEF USE_INTF}
  FTMDB:= TTMDB.Create;
  {$ELSE}
  FTMDB:= TTMDBAPI.Create(nil);

  {$ENDIF}

  EmbedTabs;

  CertPages.Align:= alClient;
  GenrePages.Align:= alClient;

  for X := 0 to Pages.PageCount-1 do
    Pages.Pages[X].TabVisible:= False;
  Pages.ActivePageIndex:= 0;
  Services1Click(Services1);
end;

procedure TfrmTMDBTestMain.FormDestroy(Sender: TObject);
begin

  {$IFDEF USE_INTF}
  FTMDB:= nil;
  {$ELSE}
  FreeAndNil(FTMDB);
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.FormShow(Sender: TObject);
begin
  LoadSetup;
end;

procedure TfrmTMDBTestMain.imgUserAvatarClick(Sender: TObject);
var
  O: ISuperObject;
begin
  //TODO:
  O:= TMDB.Account.GetAccountInfo;
  ShowMessage(O.AsJSON(True));
end;

procedure TfrmTMDBTestMain.lblUserSessionIDDblClick(Sender: TObject);
begin
  Clipboard.AsText:= lblUserSessionID.Caption;
end;

procedure TfrmTMDBTestMain.LoadSetup;
begin
  if FileExists(SetupFilename) then begin
    FAppSetup:= TSuperObject.ParseFile(SetupFilename);
  end else begin
    FAppSetup:= SO;
  end;

  txtAPIKey.Text:= FAppSetup.S['api_key'];
  txtAccessToken.Text:= FAppSetup.S['access_token'];
  Pages.ActivePageIndex:= FAppSetup.I['current_tab'];
  //TODO: current_sub_tab

  Caption:= 'TMDB API Test - ' + Pages.ActivePage.Caption;
end;

procedure TfrmTMDBTestMain.SaveSetup;
begin
  if Assigned(FAppSetup) then begin
    FAppSetup.S['api_key']:= txtAPIKey.Text;
    FAppSetup.S['access_token']:= txtAccessToken.Text;
    FAppSetup.I['current_tab']:= Pages.ActivePageIndex;
    //TODO: current_sub_tab
    FAppSetup.SaveTo(SetupFilename);
  end;
end;

function TfrmTMDBTestMain.MovieGenreName(const ID: Integer): String;
//var
  //X: Integer;
begin
  Result:= '';
  {$IFDEF USE_INTF}
  //TODO
  {$ELSE}
  for X := 0 to FConfigMovieGenres.Length-1 do begin
    if FConfigMovieGenres.O[X].I['id'] = ID then begin
      Result:= FConfigMovieGenres.O[X].S['name'];
      Break;
    end;
  end;
  {$ENDIF}
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

procedure TfrmTMDBTestMain.btnLoginLogoutClick(Sender: TObject);
var
  Success: Boolean;
  {$IFDEF USE_INTF}
  RT: ITMDBAuthRequestTokenResult;
  GS: ITMDBAuthGuestSessionResult;
  US: ITMDBAuthSessionResult;
  LS: ITMDBAuthSessionResultLogin;
  {$ELSE}
  O, S: ISuperObject;
  {$ENDIF}
  D: ITMDBAccountDetail;
begin
  Self.PrepAPI;
  {$IFDEF USE_INTF}
  if btnLoginLogout.Tag = 1 then begin
    //User is logged in, log them out?
    if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin

      FSessionGuest:= True;
      btnLoginLogout.Caption:= 'Login';
      btnLoginLogout.Tag:= 0;
      if (FSessionID <> '') and (not FSessionGuest) then
        FTMDB.Authentication.DeleteSession(FSessionID);
      FSessionID:= '';
      pLoginUserInfo.Visible:= False;

    end;
  end else begin
    //User is logged out, execute login...
    Success:= False;
    case FAuthMethod of
      0: begin
        //Guest...
        GS:= FTMDB.Authentication.CreateGuestSession;
        if GS.Success then begin
          FSessionID:= GS.GuestSessionID;
          FSessionGuest:= True;
          Success:= True;
        end;
      end;
      1: begin
        //Normal...
        RT:= FTMDB.Authentication.CreateRequestToken;
        if RT.Success then begin
          US:= FTMDB.Authentication.CreateSession(RT.RequestToken);
          //TODO
          if US.Success then begin
            FSessionID:= US.SessionID;
            FSessionGuest:= False;
            Success:= True;
          end;
        end;
      end;
      2: begin
        //Credentials...
        RT:= FTMDB.Authentication.CreateRequestToken;
        if RT.Success then begin
          LS:= FTMDB.Authentication.CreateSessionLogin(txtAuthUser.Text, txtAuthPass.Text, RT.RequestToken);
          if LS.Success then begin
            US:= FTMDB.Authentication.CreateSession(RT.RequestToken);
            //TODO
            if US.Success then begin
              FSessionID:= US.SessionID;
              FSessionGuest:= False;
              Success:= True;
            end;
          end;
        end;
      end;
    end;
    if Success then begin
      btnLoginLogout.Caption:= 'Logout';
      btnLoginLogout.Tag:= 1;
      pLoginUserInfo.Visible:= True; //TODO
        lblUserSessionID.Caption:= FSessionID;
      if FSessionGuest then begin
        lblUserName.Caption:= 'GUEST';
        lblUserFullName.Caption:= 'GUEST';
      end else begin
        D:= FTMDB.Account.GetDetailsBySession(FSessionID);
        lblUserName.Caption:= D.UserName;
        lblUserFullName.Caption:= D.Name;
        //TODO: Gravatar...
      end;
    end;
  end;

  {$ELSE}

  //TODO: Log in or out user depending on selected authentication method...
  if btnLoginLogout.Tag = 1 then begin
    //User is logged in, log them out?
    if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin

      FSessionGuest:= True;
      btnLoginLogout.Caption:= 'Login';
      btnLoginLogout.Tag:= 0;
      if (FSessionID <> '') and (not FSessionGuest) then
        FTMDB.Authentication.DeleteSession(FSessionID);
      FSessionID:= '';

    end;
  end else begin
    //User is logged out, execute login...
    Success:= False;
    case FAuthMethod of
      0: begin
        //Guest...
        S:= FTMDB.Authentication.CreateGuestSession;
        if S.B['success'] then begin
          FSessionID:= S.S['guest_session_id'];
          FSessionGuest:= True;
          Success:= True;
        end;
      end;
      1: begin
        //Normal...
        O:= FTMDB.Authentication.CreateRequestToken;
        if O.B['success'] then begin
          RT:= O.S['request_token'];
          S:= FTMDB.Authentication.CreateSession(RT);
          //TODO
          if S.B['success'] then begin
            FSessionID:= S.S['session_id'];
            FSessionGuest:= False;
            Success:= True;
          end;
        end;
      end;
      2: begin
        //Credentials...
        O:= FTMDB.Authentication.CreateSessionLogin(txtAuthUser.Text, txtAuthPass.Text, RT);
        if O.B['success'] then begin
          RT:= O.S['request_token'];
          S:= FTMDB.Authentication.CreateSession(RT);
          //TODO
          if S.B['success'] then begin
            FSessionID:= S.S['session_id'];
            FSessionGuest:= False;
            Success:= True;
          end;
        end;
      end;
    end;
    if Success then begin
      btnLoginLogout.Caption:= 'Logout';
      btnLoginLogout.Tag:= 1;
    end;
  end;
  {$ENDIF}
end;

function TfrmTMDBTestMain.CountryName(const Code: String): String;
var
  X: Integer;
  {$IFDEF USE_INTF}
  O: ITMDBCountryItem;
  {$ELSE}
  O: ISuperObject;
  {$ENDIF}
begin
  {$IFDEF USE_INTF}
  for X := 0 to FTMDB.Cache.Countries.Count-1 do begin
    O:= FTMDB.Cache.Countries[X];
    if O.ISO3166_1 = Code then begin
      Result:= O.EnglishName;
      Break;
    end;
  end;
  {$ELSE}
  if FConfigCountries = nil then
    FConfigCountries:= FTMDB.Configuration.GetCountries;
  for X := 0 to FConfigCountries.Length-1 do begin
    O:= FConfigCountries.O[X];
    if O.S['iso_3166_1'] = Code then begin
      Result:= O.S['english_name'];
      Break;
    end;
  end;
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.EmbedTabs;
begin
  EmbedTab(TfrmTabConfiguration);
  EmbedTab(TfrmTabSearch);

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

procedure TfrmTMDBTestMain.PrepAPI;
begin
  {$IFDEF USE_INTF}
  FTMDB.APIKey:= txtAPIKey.Text;
  FTMDB.AccessToken:= txtAccessToken.Text;
  //TODO: Test connection and authentication...

  {$ELSE}
  FTMDB.APIKey:= txtAPIKey.Text;
  FTMDB.APIAccessToken:= txtAccessToken.Text;
  //TODO: Test connection and authentication...
  try
    if FConfig = nil then
      FConfig:= FTMDB.Configuration.GetDetails;
    if FConfigCountries = nil then
      FConfigCountries:= FTMDB.Configuration.GetCountries;
    if FConfigJobs = nil then
      FConfigJobs:= FTMDB.Configuration.GetJobs;
    if FConfigLanguages = nil then
      FConfigLanguages:= FTMDB.Configuration.GetLanguages;
    if FConfigPrimaryTranslations = nil then
      FConfigPrimaryTranslations:= FTMDB.Configuration.GetPrimaryTranslations;
    if FConfigTimezones = nil then
      FConfigTimezones:= FTMDB.Configuration.GetTimeZones;
    if FConfigMovieGenres = nil then
      FConfigMovieGenres:= FTMDB.Genres.GetMovieList('');
    if FConfigTVGenres = nil then
      FConfigTVGenres:= FTMDB.Genres.GetTVList('');
    if FConfigMovieCerts = nil then
      FConfigMovieCerts:= FTMDB.Certifications.GetMovieCertifications;
    if FConfigTVCerts = nil then
      FConfigTVCerts:= FTMDB.Certifications.GetTVCertifications;
  except
    //TODO
  end;
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.ResetAPI;
begin
  {$IFDEF USE_INTF}

  {$ELSE}
  FConfig:= nil;
  FConfigCountries:= nil;
  FConfigJobs:= nil;
  FConfigLanguages:= nil;
  FConfigPrimaryTranslations:= nil;
  FConfigTimezones:= nil;
  FConfigMovieGenres:= nil;
  FConfigTVGenres:= nil;
  FConfigMovieCerts:= nil;
  FConfigTVCerts:= nil;
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.Button1Click(Sender: TObject);
{$IFDEF USE_INTF}
var
  O: ITMDBAuthValidateKeyResult;
{$ELSE}
var
  O: ISuperObject;
{$ENDIF}
begin
  PrepAPI;
  {$IFDEF USE_INTF}
  O:= FTMDB.Authentication.ValidateKey;
  ShowMessage('API Key Validation Result: '+O.StatusMessage);
  {$ELSE}
  O:= FTMDB.Authentication.GetValidateKey;
  ShowMessage('API Key Validation Result: '+O.S['status_message']);
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.ListLanguages(AList: TStrings);
var
  X: Integer;
  {$IFDEF USE_INTF}
  O: ITMDBLanguageItem;
  {$ELSE}
  O: ISuperObject;
  {$ENDIF}
begin
  PrepAPI;
  AList.Clear;
  {$IFDEF USE_INTF}
  for X := 0 to FTMDB.Cache.Languages.Count-1 do begin
    O:= FTMDB.Cache.Languages[X];
    AList.Append(O.ISO639_1);
  end;
  {$ELSE}
  for X := 0 to FConfigLanguages.Length-1 do begin
    O:= FConfigLanguages.O[X];
    AList.Append(O.S['iso_639_1']);
  end;
  {$ENDIF}
end;

procedure TfrmTMDBTestMain.ListRegions(AList: TStrings);
begin
  AList.Clear;

end;

procedure TfrmTMDBTestMain.Button2Click(Sender: TObject);
var
  G: ITMDBGenreItem;
  X: Integer;
  I: TListItem;
begin
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstGenreMovies.Items.BeginUpdate;
    try
      lstGenreMovies.Items.Clear;
      lstGenreMovies.Groups.Clear;
      for X := 0 to FTMDB.Cache.MovieGenres.Count-1 do begin
        G:= FTMDB.Cache.MovieGenres[X];
        I:= lstGenreMovies.Items.Add;
        I.Caption:= G.Name;
        I.SubItems.Add(IntToStr(G.ID));
      end;
      lstGenreMovies.SortType:= TSortType.stText;
    finally
      lstGenreMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.Button3Click(Sender: TObject);
var
  G: ITMDBGenreItem;
  X: Integer;
  I: TListItem;
begin
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstGenreTV.Items.BeginUpdate;
    try
      lstGenreTV.Items.Clear;
      lstGenreTV.Groups.Clear;
      for X := 0 to FTMDB.Cache.TVGenres.Count-1 do begin
        G:= FTMDB.Cache.TVGenres[X];
        I:= lstGenreTV.Items.Add;
        I.Caption:= G.Name;
        I.SubItems.Add(IntToStr(G.ID));
      end;
      lstGenreTV.SortType:= TSortType.stText;
    finally
      lstGenreTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.btnRefreshCertsMoviesClick(Sender: TObject);
var
  {$IFDEF USE_INTF}
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  {$ELSE}
  Res, O: ISuperObject;
  C: ISuperArray;
  M: IMember;
  {$ENDIF}
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

      {$IFDEF USE_INTF}
      for X := 0 to FTMDB.Cache.MovieCerts.Count-1 do begin
        C:= FTMDB.Cache.MovieCerts[X];
        G:= lstCertsMovies.Groups.Add;
        G.Header:= CountryName(C.CountryCode);
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
      {$ELSE}
      Res:= FTMDB.Certifications.GetMovieCertifications;
      for M in Res['certifications'].AsObject do begin
        C:= M.AsArray;
        G:= lstCertsMovies.Groups.Add;
        G.Header:= CountryName(M.Name) + ' ('+M.Name+')';
        for X := 0 to C.Length-1 do begin
          O:= C.O[X];
          I:= lstCertsMovies.Items.Add;
          I.Caption:= IntToStr(O.I['order']);
          I.SubItems.Add(O.S['certification']);
          I.SubItems.Add(O.S['meaning']);
          I.GroupID:= G.GroupID;
        end;
      end;
      Res:= nil;
      {$ENDIF}

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
  {$IFDEF USE_INTF}
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  {$ELSE}
  Res, O: ISuperObject;
  C: ISuperArray;
  M: IMember;
  {$ENDIF}
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
      {$IFDEF USE_INTF}
      for X := 0 to FTMDB.Cache.TVCerts.Count-1 do begin
        C:= FTMDB.Cache.TVCerts[X];
        G:= lstCertsTV.Groups.Add;
        G.Header:= CountryName(C.CountryCode);
        for Y := 0 to C.Count-1 do begin
          O:= C[Y];
          I:= Self.lstCertsTV.Items.Add;
          I.Caption:= IntToStr(O.Order);
          I.SubItems.Add(O.Certification);
          I.SubItems.Add(O.Meaning);
          I.GroupID:= G.GroupID;
        end;
      end;
      {$ELSE}
      Res:= FTMDB.Certifications.GetTVCertifications;
      for M in Res['certifications'].AsObject do begin
        C:= M.AsArray;
        G:= Self.lstCertsTV.Groups.Add;
        G.Header:= CountryName(M.Name) + ' ('+M.Name+')';
        for X := 0 to C.Length-1 do begin
          O:= C.O[X];
          I:= Self.lstCertsTV.Items.Add;
          I.Caption:= IntToStr(O.I['order']);
          I.SubItems.Add(O.S['certification']);
          I.SubItems.Add(O.S['meaning']);
          I.GroupID:= G.GroupID;
        end;
      end;
      {$ENDIF}
      lstCertsTV.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstCertsTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
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

{$IFDEF USE_INTF}
function TfrmTMDBTestMain.TMDB: ITMDB;
begin
  Result:= FTMDB;
end;
{$ELSE}
function TfrmTMDBTestMain.TMDB: TTMDBAPI;
begin
  Result:= FTMDB;
end;
{$ENDIF}

function TfrmTMDBTestMain.TVGenreName(const ID: Integer): String;
begin

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
