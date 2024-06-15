unit uContentBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JD.TMDB.Intf, JD.TMDB;

type
  TfrmContentBase = class;

  TfrmContentBaseClass = class of TfrmContentBase;



  TfrmContentBase = class(TForm)
  private
    { Private declarations }
  protected
    function TMDB: TTMDB;
    procedure PrepAPI;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmContentBase: TfrmContentBase;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentBase }

constructor TfrmContentBase.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmContentBase.Destroy;
begin

  inherited;
end;

procedure TfrmContentBase.PrepAPI;
begin
  frmTMDBTestMain.PrepAPI;
end;

function TfrmContentBase.TMDB: TTMDB;
begin
  Result:= frmTMDBTestMain.TMDB;
end;

end.
