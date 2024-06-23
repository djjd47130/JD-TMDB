unit uTabMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls,
  uContentMovieDetail;

type
  TfrmTabMovies = class(TfrmTabBase)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabMovies: TfrmTabMovies;

implementation

{$R *.dfm}

{ TfrmTabMovies }

constructor TfrmTabMovies.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabMovies.Destroy;
begin

  inherited;
end;

procedure TfrmTabMovies.EmbedAllContent;
begin
  inherited;

  EmbedContent(TfrmContentMovieDetail);

end;

end.
