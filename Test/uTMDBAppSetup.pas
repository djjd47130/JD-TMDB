unit uTMDBAppSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  XSuperObject,
  JD.TMDB.Common,
  JD.TMDB.Intf, JD.Common, JD.Ctrls, JD.Ctrls.FontButton;

type

  TAppSetup = class(TObject)
  private
    FAppSetup: ISuperObject;
    function GetAccessToken: String;
    function GetAPIAuth: TTMDBAuthMethod;
    function GetAPIKey: String;
    function GetCountry: String;
    function GetLanguage: String;
    function GetSessionGuest: Boolean;
    function GetSessionID: String;
    function GetTimezone: String;
    procedure SetAccessToken(const Value: String);
    procedure SetAPIAuth(const Value: TTMDBAuthMethod);
    procedure SetAPIKey(const Value: String);
    procedure SetCountry(const Value: String);
    procedure SetLanguage(const Value: String);
    procedure SetSessionGuest(const Value: Boolean);
    procedure SetSessionID(const Value: String);
    procedure SetTimezones(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadSetup;
    procedure SaveSetup;
    function SetupFilename: String;

    property APIKey: String read GetAPIKey write SetAPIKey;
    property AccessToken: String read GetAccessToken write SetAccessToken;
    property APIAuth: TTMDBAuthMethod read GetAPIAuth write SetAPIAuth;
    property Language: String read GetLanguage write SetLanguage;
    property Country: String read GetCountry write SetCountry;
    property SessionID: String read GetSessionID write SetSessionID;
    property Timezone: String read GetTimezone write SetTimezones;
    property SessionGuest: Boolean read GetSessionGuest write SetSessionGuest;
  end;

  TfrmTMDBAppSetup = class(TfrmContentBase)
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
    btnValidateKey: TButton;
    gbLocaleOptions: TGroupBox;
    Panel6: TPanel;
    Label5: TLabel;
    cboLanguage: TComboBox;
    btnSave: TJDFontButton;
    procedure APIAuthMethodRadioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure txtAPIKeyChange(Sender: TObject);
    procedure txtAccessTokenChange(Sender: TObject);
    procedure cboLanguageChange(Sender: TObject);
    procedure btnValidateKeyClick(Sender: TObject);
  private
    function GetAPIAuth: TTMDBAuthMethod;
    procedure SetAPIAuth(const Value: TTMDBAuthMethod);

  public
    procedure LoadSetup;
    procedure SaveSetup;

    property APIAuth: TTMDBAuthMethod read GetAPIAuth write SetAPIAuth;
  end;

var
  frmTMDBAppSetup: TfrmTMDBAppSetup;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  uMain;

{ TAppSetup }

constructor TAppSetup.Create;
begin
  LoadSetup;

end;

destructor TAppSetup.Destroy;
begin

  SaveSetup;
  inherited;
end;

function TAppSetup.SetupFilename: String;
begin
  Result:= ExtractFilePath(ParamStr(0));
  Result:= TPath.Combine(Result, 'AppConfig.json');
end;

procedure TAppSetup.LoadSetup;
begin
  if FileExists(SetupFilename) then begin
    FAppSetup:= TSuperObject.ParseFile(SetupFilename);
  end else begin
    FAppSetup:= SO;
  end;
end;

procedure TAppSetup.SaveSetup;
begin
  if FAppSetup <> nil then
    FAppSetup.SaveTo(SetupFilename);
end;

function TAppSetup.GetAccessToken: String;
begin
  Result:= FAppSetup.S['access_token'];
end;

function TAppSetup.GetAPIAuth: TTMDBAuthMethod;
begin
  Result:= TTMDBAuthMethod(FAppSetup.I['api_auth']);
end;

function TAppSetup.GetAPIKey: String;
begin
  Result:= FAppSetup.S['api_key'];
end;

function TAppSetup.GetCountry: String;
begin
  Result:= FAppSetup.S['default_country'];
end;

function TAppSetup.GetLanguage: String;
begin
  Result:= FAppSetup.S['default_language'];
end;

function TAppSetup.GetSessionGuest: Boolean;
begin
  Result:= FAppSetup.B['session_guest'];
end;

function TAppSetup.GetSessionID: String;
begin
  Result:= FAppSetup.S['session_id'];
end;

function TAppSetup.GetTimezone: String;
begin
  Result:= FAppSetup.S['default_timezone'];
end;

procedure TAppSetup.SetAccessToken(const Value: String);
begin
  FAppSetup.S['access_token']:= Value;
end;

procedure TAppSetup.SetAPIAuth(const Value: TTMDBAuthMethod);
begin
  FAppSetup.I['api_auth']:= Integer(Value);
end;

procedure TAppSetup.SetAPIKey(const Value: String);
begin
  FAppSetup.S['api_key']:= Value;
end;

procedure TAppSetup.SetCountry(const Value: String);
begin
  FAppSetup.S['default_country']:= Value;
end;

procedure TAppSetup.SetLanguage(const Value: String);
begin
  FAppSetup.S['default_language']:= Value;
end;

procedure TAppSetup.SetSessionGuest(const Value: Boolean);
begin
  FAppSetup.B['session_guest']:= Value;
end;

procedure TAppSetup.SetSessionID(const Value: String);
begin
  FAppSetup.S['session_id']:= Value;
end;

procedure TAppSetup.SetTimezones(const Value: String);
begin
  FAppSetup.S['timezone']:= Value;
end;

{ TfrmTMDBAppSetup }

procedure TfrmTMDBAppSetup.FormShow(Sender: TObject);
begin
  inherited;
  LoadSetup;
  PrepAPI;
  //TMDB.ListPrimaryTranslations(cboLanguage.Items);
  TMDB.ListLanguages(cboLanguage.Items);
  btnSave.Enabled:= False;
end;

procedure TfrmTMDBAppSetup.LoadSetup;
begin
  txtAPIKey.Text:= AppSetup.APIKey;
  txtAccessToken.Text:= AppSetup.AccessToken;
  APIAuth:= AppSetup.APIAuth;
  cboLanguage.Text:= AppSetup.Language;
  //TODO: Default Country...
  //TODO: Timezone...
end;

procedure TfrmTMDBAppSetup.SaveSetup;
begin
  AppSetup.APIKey:= txtAPIKey.Text;
  AppSetup.AccessToken:= txtAccessToken.Text;
  AppSetup.APIAuth:= APIAuth;
  AppSetup.Language:= cboLanguage.Text;
  AppSetup.SaveSetup;
end;

procedure TfrmTMDBAppSetup.APIAuthMethodRadioClick(Sender: TObject);
var
  T: Integer;
  procedure HideAll;
  begin
    gbAPIAuthMethodAPIKey.Visible:= False;
    gbAPIAuthMethodAccessToken.Visible:= False;
  end;
begin
  inherited;
  HideAll;
  T:= TControl(Sender).Tag;
  case T of
    0: gbAPIAuthMethodAPIKey.Visible:= True;
    1: gbAPIAuthMethodAccessToken.Visible:= True;
  end;
  btnSave.Enabled:= True;
end;

procedure TfrmTMDBAppSetup.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveSetup;
  btnSave.Enabled:= False;
end;

procedure TfrmTMDBAppSetup.btnValidateKeyClick(Sender: TObject);
var
  O: ITMDBAuthValidateKeyResult;
begin
  inherited;
  PrepAPI;
  O:= TMDB.Client.Authentication.ValidateKey;
  ShowMessage('API Key Validation Result: '+O.StatusMessage);
end;

procedure TfrmTMDBAppSetup.cboLanguageChange(Sender: TObject);
begin
  inherited;
  btnSave.Enabled:= True;
end;

function TfrmTMDBAppSetup.GetAPIAuth: TTMDBAuthMethod;
begin
  if rAuthKey.Checked then
    Result:= TTMDBAuthMethod.amAPIKey
  else
    Result:= TTMDBAuthMethod.amAccessToken;
end;

procedure TfrmTMDBAppSetup.SetAPIAuth(const Value: TTMDBAuthMethod);
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

procedure TfrmTMDBAppSetup.txtAccessTokenChange(Sender: TObject);
begin
  inherited;
  btnSave.Enabled:= True;
end;

procedure TfrmTMDBAppSetup.txtAPIKeyChange(Sender: TObject);
begin
  inherited;
  btnSave.Enabled:= True;
end;

end.
