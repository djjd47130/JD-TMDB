unit uTabSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uTabBase,
  uContentSearchCollections,
  uContentSearchCompanies,
  uContentSearchMovies,
  uContentSearchTV,
  Vcl.ComCtrls;

type
  TfrmTabSearch = class(TfrmTabBase)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabSearch: TfrmTabSearch;

implementation

{$R *.dfm}

{ TfrmTabSearch }

constructor TfrmTabSearch.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabSearch.Destroy;
begin

  inherited;
end;

procedure TfrmTabSearch.EmbedAllContent;
begin
  inherited;

  EmbedContent(TfrmContentSearchCollections);
  EmbedContent(TfrmContentSearchCompanies);
  EmbedContent(TfrmContentSearchMovies);
  EmbedContent(TfrmContentSearchTV);

end;

end.
