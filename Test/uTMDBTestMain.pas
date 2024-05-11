unit uTMDBTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  JD.TMDB.API, XSuperObject, XSuperJSON,
  uTabBase, uContentBase,
  uTabConfiguration,
  uTabSearch;

type
  TfrmTMDBTestMain = class(TForm)
    TMDB: TTMDBAPI;
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
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel5: TPanel;
    Image1: TImage;
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
    procedure APIAuthMethodRadioClick(Sender: TObject);
    procedure AppSetup1Click(Sender: TObject);
    procedure Services1Click(Sender: TObject);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure btnLoginLogoutClick(Sender: TObject);
    procedure btnRefreshCertsMoviesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshCertsTVClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FAuthMethod: Integer;
    FSessionID: String;
    FSessionGuest: Boolean;
    FAppSetup: ISuperObject;

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

    procedure LoadSetup;
    procedure SaveSetup;
    function SetupFilename: String;

    procedure ServiceClicked(Sender: TObject);

    function EmbedTab(ATabClass: TfrmTabBaseClass): TfrmTabBase;
    procedure EmbedTabs;

  public
    procedure PrepAPI;
    function CountryName(const Code: String): String;
    function MovieGenreName(const ID: Integer): String;
    function TVGenreName(const ID: Integer): String;
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
  Pages.Align:= alClient;

  EmbedTabs;

  CertPages.Align:= alClient;
  GenrePages.Align:= alClient;

  for X := 0 to Pages.PageCount-1 do
    Pages.Pages[X].TabVisible:= False;
  Pages.ActivePageIndex:= 0;
  Services1Click(Services1);
end;

procedure TfrmTMDBTestMain.FormShow(Sender: TObject);
begin
  LoadSetup;
  //TODO: Fetch and cache all configuration-level data...

  //Details

  //Countries

  //Jobs

  //Languages

  //Primary Translations

  //Timezones

  //Movie Genres

  //TV Genres

  //Movie Certifications

  //TV Certifications

end;

procedure TfrmTMDBTestMain.LoadSetup;
begin
  if FileExists(SetupFilename) then begin
    FAppSetup:= TSuperObject.ParseFile(SetupFilename);
  end else begin
    FAppSetup:= SO;
  end;

  Self.txtAPIKey.Text:= FAppSetup.S['api_key'];
  Self.txtAccessToken.Text:= FAppSetup.S['access_token'];
  Self.Pages.ActivePageIndex:= FAppSetup.I['current_tab'];
  //TODO: current_sub_tab

  Caption:= 'TMDB API Test - ' + Pages.ActivePage.Caption;
end;

function TfrmTMDBTestMain.MovieGenreName(const ID: Integer): String;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to FConfigMovieGenres.Length-1 do begin
    if FConfigMovieGenres.O[X].I['id'] = ID then begin
      Result:= FConfigMovieGenres.O[X].S['name'];
      Break;
    end;
  end;
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
  O, S: ISuperObject;
  RT: String;
begin
  //TODO: Log in or out user depending on selected authentication method...
  Self.PrepAPI;
  if btnLoginLogout.Tag = 1 then begin
    //User is logged in, log them out?
    if MessageDlg('Are you sure you wish to log out?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin

      FSessionGuest:= True;
      btnLoginLogout.Caption:= 'Login';
      btnLoginLogout.Tag:= 0;
      if (FSessionID <> '') and (not FSessionGuest) then
        TMDB.Authentication.DeleteSession(FSessionID);
      FSessionID:= '';

    end;
  end else begin
    //User is logged out, execute login...
    Success:= False;
    case FAuthMethod of
      0: begin
        //Guest...
        S:= TMDB.Authentication.CreateGuestSession;
        if S.B['success'] then begin
          FSessionID:= S.S['guest_session_id'];
          FSessionGuest:= True;
          Success:= True;
        end;
      end;
      1: begin
        //Normal...
        O:= TMDB.Authentication.CreateRequestToken;
        if O.B['success'] then begin
          RT:= O.S['request_token'];
          S:= TMDB.Authentication.CreateSession(RT);
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
        O:= TMDB.Authentication.CreateSessionLogin(txtAuthUser.Text, txtAuthPass.Text, RT);
        if O.B['success'] then begin
          RT:= O.S['request_token'];
          S:= TMDB.Authentication.CreateSession(RT);
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
end;

function TfrmTMDBTestMain.CountryName(const Code: String): String;
var
  X: Integer;
  O: ISuperObject;
begin
  if FConfigCountries = nil then
    FConfigCountries:= TMDB.Configuration.GetCountries;
  for X := 0 to FConfigCountries.Length-1 do begin
    O:= FConfigCountries.O[X];
    if O.S['iso_3166_1'] = Code then begin
      Result:= O.S['english_name'];
      Break;
    end;
  end;
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
  TMDB.APIKey:= Self.txtAPIKey.Text;
  TMDB.APIReadAccessToken:= Self.txtAccessToken.Text;
  try
    if FConfig = nil then
      FConfig:= TMDB.Configuration.GetDetails;
    if FConfigCountries = nil then
      FConfigCountries:= TMDB.Configuration.GetCountries;
    if FConfigJobs = nil then
      FConfigJobs:= TMDB.Configuration.GetJobs;
    if FConfigLanguages = nil then
      FConfigLanguages:= TMDB.Configuration.GetLanguages;
    if FConfigPrimaryTranslations = nil then
      FConfigPrimaryTranslations:= TMDB.Configuration.GetPrimaryTranslations;
    if FConfigTimezones = nil then
      FConfigTimezones:= TMDB.Configuration.GetTimeZones;
    if FConfigMovieGenres = nil then
      FConfigMovieGenres:= TMDB.Genres.GetMovieList('');
    if FConfigTVGenres = nil then
      FConfigTVGenres:= TMDB.Genres.GetTVList('');
    if FConfigMovieCerts = nil then
      FConfigMovieCerts:= TMDB.Certifications.GetMovieCertifications;
    if FConfigTVCerts = nil then
      FConfigTVCerts:= TMDB.Certifications.GetTVCertifications;
  except
    //TODO
  end;

end;

procedure TfrmTMDBTestMain.Button1Click(Sender: TObject);
var
  O: ISuperObject;
begin
  PrepAPI;
  O:= TMDB.Authentication.GetValidateKey;
  ShowMessage('API Key Validation Result: '+O.S['status_message']);
end;

procedure TfrmTMDBTestMain.Button2Click(Sender: TObject);
var
  O: ISuperObject;
  C: ISuperArray;
  M: IMember;
  X: Integer;
  I: TListItem;
begin
  Self.PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstGenreMovies.Items.BeginUpdate;
    try
      Self.lstGenreMovies.Items.Clear;
      Self.lstGenreMovies.Groups.Clear;
      C:= TMDB.Genres.GetMovieList;
      for X := 0 to C.Length-1 do begin
        O:= C.O[X];
        I:= Self.lstGenreMovies.Items.Add;
        I.Caption:= O.S['name'];
        I.SubItems.Add(IntToStr(O.I['id']));
      end;
      lstGenreMovies.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstGenreMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.Button3Click(Sender: TObject);
var
  O: ISuperObject;
  C: ISuperArray;
  M: IMember;
  X: Integer;
  I: TListItem;
begin
  Self.PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstGenreTV.Items.BeginUpdate;
    try
      Self.lstGenreTV.Items.Clear;
      Self.lstGenreTV.Groups.Clear;
      C:= TMDB.Genres.GetTVList;
      for X := 0 to C.Length-1 do begin
        O:= C.O[X];
        I:= Self.lstGenreTV.Items.Add;
        I.Caption:= O.S['name'];
        I.SubItems.Add(IntToStr(O.I['id']));
      end;
      lstGenreTV.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstGenreTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTMDBTestMain.btnRefreshCertsMoviesClick(Sender: TObject);
var
  Res, O: ISuperObject;
  C: ISuperArray;
  M: IMember;
  X: Integer;
  I: TListItem;
  G: TListGroup;
begin
  Self.PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstCertsMovies.Items.BeginUpdate;
    try
      Self.lstCertsMovies.Items.Clear;
      Self.lstCertsMovies.Groups.Clear;
      Res:= TMDB.Certifications.GetMovieCertifications;
      for M in Res['certifications'].AsObject do begin
        C:= M.AsArray;
        G:= Self.lstCertsMovies.Groups.Add;
        G.Header:= CountryName(M.Name) + ' ('+M.Name+')';
        for X := 0 to C.Length-1 do begin
          O:= C.O[X];
          I:= Self.lstCertsMovies.Items.Add;
          I.Caption:= IntToStr(O.I['order']);
          I.SubItems.Add(O.S['certification']);
          I.SubItems.Add(O.S['meaning']);
          I.GroupID:= G.GroupID;
        end;
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
  Res, O: ISuperObject;
  C: ISuperArray;
  M: IMember;
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
      Res:= TMDB.Certifications.GetTVCertifications;
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
