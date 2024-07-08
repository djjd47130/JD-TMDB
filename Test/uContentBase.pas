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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RefreshData; virtual;
    function CloseQuery: Boolean; virtual;

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

end;

destructor TfrmContentBase.Destroy;
begin

  inherited;
end;

function TfrmContentBase.CloseQuery: Boolean;
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

function TfrmContentBase.TMDB: TTMDB;
begin
  Result:= frmMain.TMDB;
end;

function TfrmContentBase.Client: ITMDBClient;
begin
  Result:= TMDB.Client;
end;

end.
