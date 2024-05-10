unit uTabBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  uContentBase;

type
  TfrmTabBase = class;

  TfrmTabBaseClass = class of TfrmTabBase;



  TfrmTabBase = class(TForm)
    Pages: TPageControl;
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function EmbedContent(AContentClass: TfrmContentBaseClass): TfrmContentBase;
    procedure EmbedAllContent; virtual;

  end;

var
  frmTabBase: TfrmTabBase;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmTabBase }

constructor TfrmTabBase.Create(AOwner: TComponent);
begin
  inherited;
  Pages.Align:= alClient;
  EmbedAllContent;
  Pages.ActivePageIndex:= 0;
end;

destructor TfrmTabBase.Destroy;
begin

  inherited;
end;

procedure TfrmTabBase.EmbedAllContent;
begin

end;

function TfrmTabBase.EmbedContent(
  AContentClass: TfrmContentBaseClass): TfrmContentBase;
var
  T: TTabSheet;
begin
  T:= TTabSheet.Create(Pages);
  T.PageControl:= Pages;
  Result:= AContentClass.Create(T);
  Result.Parent:= T;
  Result.Align:= alClient;
  Result.BorderStyle:= bsNone;
  Result.Show;
  T.Caption:= Result.Caption;
end;

end.
