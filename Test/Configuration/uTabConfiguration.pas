unit uTabConfiguration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabBase, Vcl.ComCtrls;

type
  TfrmTabConfiguration = class(TfrmTabBase)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EmbedAllContent; override;
  end;

var
  frmTabConfiguration: TfrmTabConfiguration;

implementation

{$R *.dfm}

uses
  uContentConfigCountries,
  uContentConfigLanguages;

{ TfrmTabConfiguration }

constructor TfrmTabConfiguration.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrmTabConfiguration.Destroy;
begin

  inherited;
end;

procedure TfrmTabConfiguration.EmbedAllContent;
begin
  inherited;

  //Details
  EmbedContent(TfrmContentConfigCountries);
  //Jobs
  EmbedContent(TfrmContentConfigLanguages);
  //Primary Translations
  //Timezones

end;

end.
