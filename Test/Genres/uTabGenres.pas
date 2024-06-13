unit uTabGenres;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls;

type
  TfrmTabBase1 = class(TfrmTabBase)
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabBase1: TfrmTabBase1;

implementation

{$R *.dfm}

{ TfrmTabBase1 }

constructor TfrmTabBase1.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabBase1.Destroy;
begin

  inherited;
end;

procedure TfrmTabBase1.EmbedAllContent;
begin
  inherited;

  //TODO
end;

end.
