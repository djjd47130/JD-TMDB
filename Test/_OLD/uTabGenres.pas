unit uTabGenres;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls;

type
  TfrmTabGenres = class(TfrmTabBase)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabGenres: TfrmTabGenres;

implementation

{$R *.dfm}

uses
  uContentGenresMovie,
  uContentGenresTV;

{ TfrmTabGenres }

constructor TfrmTabGenres.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabGenres.Destroy;
begin

  inherited;
end;

procedure TfrmTabGenres.EmbedAllContent;
begin
  inherited;

  EmbedContent(TfrmContentGenresMovie);
  EmbedContent(TfrmContentGenresTV);

end;

end.
