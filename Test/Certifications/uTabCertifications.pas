unit uTabCertifications;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls;

type
  TfrmTabCertifications = class(TfrmTabBase)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabCertifications: TfrmTabCertifications;

implementation

{$R *.dfm}

uses
  uContentCertsMovies,
  uContentCertsTV;

{ TfrmTabCertifications }

constructor TfrmTabCertifications.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabCertifications.Destroy;
begin

  inherited;
end;

procedure TfrmTabCertifications.EmbedAllContent;
begin
  inherited;

  EmbedContent(TfrmContentCertsMovies);
  EmbedContent(TfrmContentCertsTV);

end;

end.
