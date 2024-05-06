unit uTMDBTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus,
  JD.TMDB.API, XSuperObject;

type
  TfrmTMDBTestMain = class(TForm)
    TMDB: TTMDBAPI;
    Pages: TPageControl;
    tabAccount: TTabSheet;
    tabCertifications: TTabSheet;
    tabChanges: TTabSheet;
    tabCollections: TTabSheet;
    tabCompanies: TTabSheet;
    tabConfiguration: TTabSheet;
    tabCredits: TTabSheet;
    tabDiscover: TTabSheet;
    tabFind: TTabSheet;
    tabGenres: TTabSheet;
    tabGuestSessions: TTabSheet;
    tabKeywords: TTabSheet;
    tabLists: TTabSheet;
    tabMovieLists: TTabSheet;
    tabMovies: TTabSheet;
    tabNetworks: TTabSheet;
    tabPeopleLists: TTabSheet;
    tabPeople: TTabSheet;
    tabReviews: TTabSheet;
    tabSearch: TTabSheet;
    tabTrending: TTabSheet;
    tabTVSeriesLists: TTabSheet;
    tabTVSeries: TTabSheet;
    tabTVSeasons: TTabSheet;
    tabTVEpisodes: TTabSheet;
    tabTVEpisodeGroups: TTabSheet;
    tabWatchProviders: TTabSheet;
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
    AccountPages: TPageControl;
    tabAccountDetails: TTabSheet;
    CertPages: TPageControl;
    tabCertsMovies: TTabSheet;
    tabCertsTV: TTabSheet;
    tabAccountFavorites: TTabSheet;
    tabAccountWatchlists: TTabSheet;
    tabAccountLists: TTabSheet;
    Ratings: TTabSheet;
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
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure APIAuthMethodRadioClick(Sender: TObject);
    procedure AppSetup1Click(Sender: TObject);
    procedure Services1Click(Sender: TObject);
    procedure UserAuthMethodClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure btnLoginLogoutClick(Sender: TObject);
  private
    FAuthMethod: Integer;
    FSessionID: String;
    FSessionGuest: Boolean;
    procedure ServiceClicked(Sender: TObject);
    procedure PrepAPI;
  public

  end;

var
  frmTMDBTestMain: TfrmTMDBTestMain;

implementation

{$R *.dfm}

procedure TfrmTMDBTestMain.FormCreate(Sender: TObject);
var
  X: Integer;
begin
  Pages.Align:= alClient;
  for X := 0 to Pages.PageCount-1 do
    Pages.Pages[X].TabVisible:= False;
  Pages.ActivePageIndex:= 0;
  Services1Click(Services1);
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

procedure TfrmTMDBTestMain.PrepAPI;
begin
  TMDB.APIKey:= Self.txtAPIKey.Text;
  TMDB.APIReadAccessToken:= Self.txtAccessToken.Text;

end;

procedure TfrmTMDBTestMain.Button1Click(Sender: TObject);
var
  O: ISuperObject;
begin
  PrepAPI;
  O:= TMDB.Authentication.GetValidateKey;
  ShowMessage('API Key Validation Result: '+O.S['status_message']);
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
