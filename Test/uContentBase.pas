unit uContentBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JD.TMDB.Intf, JD.TMDB;

type
  TfrmContentBase = class;

  TfrmContentBaseClass = class of TfrmContentBase;

  TfrmContentBase = class(TForm)
  protected
    function TMDB: TTMDB;
    function Client: ITMDBClient;
    procedure PrepAPI;
    function GetTabCaption: String;
    procedure SetTabCaption(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property TabCaption: String read GetTabCaption write SetTabCaption;
    procedure RefreshData; virtual;
    function CanClose: Boolean; virtual;
  end;

var
  frmContentBase: TfrmContentBase;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

{ TfrmContentBase }

constructor TfrmContentBase.Create(AOwner: TComponent);
begin
  inherited;
  TabCaption:= Caption;
end;

destructor TfrmContentBase.Destroy;
begin

  inherited;
end;

function TfrmContentBase.GetTabCaption: String;
var
  T: TJDTabRef;
begin
  T:= TabController.RefByForm(Self);
  if T <> nil then
    Result:= T.Caption;
end;

function TfrmContentBase.CanClose: Boolean;
begin
  Result:= True;
end;

procedure TfrmContentBase.PrepAPI;
begin
  frmMain.PrepAPI;
end;

procedure TfrmContentBase.RefreshData;
begin

end;

procedure TfrmContentBase.SetTabCaption(const Value: String);
var
  T: TJDTabRef;
begin
  T:= TabController.RefByForm(Self);
  if T <> nil then
    T.Caption:= Value;
end;

function TfrmContentBase.TMDB: TTMDB;
begin
  Result:= frmMain.TMDB;
end;

function TfrmContentBase.Client: ITMDBClient;
begin
  Result:= TMDB.Client;
end;

end.
