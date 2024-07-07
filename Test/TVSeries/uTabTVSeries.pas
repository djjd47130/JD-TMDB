unit uTabTVSeries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls,
  uContentTVSerieDetail;

type
  TfrmTabTVSeries = class(TfrmTabBase)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabTVSeries: TfrmTabTVSeries;

implementation

{$R *.dfm}

{ TfrmTabTVSeries }

constructor TfrmTabTVSeries.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabTVSeries.Destroy;
begin

  inherited;
end;

procedure TfrmTabTVSeries.EmbedAllContent;
begin
  inherited;
  EmbedContent(TfrmContentTVSerieDetail);

end;

end.
