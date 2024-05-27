unit uContentBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  {$IFDEF USE_INTF}
  , JD.TMDB.Intf
  {$ELSE}
  , JD.TMDB.API
  {$ENDIF}
  ;

type
  TfrmContentBase = class;

  TfrmContentBaseClass = class of TfrmContentBase;



  TfrmContentBase = class(TForm)
  private
    { Private declarations }
  protected
    {$IFDEF USE_INTF}
    function API: ITMDB;
    {$ELSE}
    function API: TTMDBAPI;
    {$ENDIF}
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

{$IFDEF USE_INTF}
function TfrmContentBase.API: ITMDB;
begin
  Result:= frmTMDBTestMain.TMDB;
end;
{$ELSE}
function TfrmContentBase.API: TTMDBAPI;
begin
  Result:= frmTMDBTestMain.TMDB;
end;
{$ENDIF}

procedure TfrmContentBase.PrepAPI;
begin
  frmTMDBTestMain.PrepAPI;
end;

end.
