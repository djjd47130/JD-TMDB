unit uTMDBTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmTMDBTestMain = class(TForm)
    Panel1: TPanel;
    gbAPIAuthMethod: TGroupBox;
    gbAPIAuthMethodAPIKey: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    gbAPIAuthMethodAccessToken: TPanel;
    Label3: TLabel;
    Edit3: TEdit;
    Panel2: TPanel;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    procedure APIAuthMethodRadioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTMDBTestMain: TfrmTMDBTestMain;

implementation

{$R *.dfm}

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

end.
