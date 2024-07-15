unit uContentConfigTimezones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls,
  JD.TMDB.Intf;

type
  TfrmContentConfigTimezones = class(TfrmContentBase)
    lstTimezones: TListView;
    btnRefresh: TButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentConfigTimezones: TfrmContentConfigTimezones;

implementation

{$R *.dfm}

procedure TfrmContentConfigTimezones.btnRefreshClick(Sender: TObject);
var
  X, Y: Integer;
  L: ITMDBTimezones;
  Z: ITMDBTimezone;
  I: TListItem;
  S: String;
begin
  inherited;
  lstTimezones.Items.BeginUpdate;
  try
    lstTimezones.Items.Clear;
    L:= TMDB.Configuration.GetTimezones;
    for X := 0 to L.Count-1 do begin
      Z:= L[X];
      for Y := 0 to Length(Z.Zones)-1 do begin
        S:= Z.Zones[Y];
        I:= lstTimezones.Items.Add;
        I.Caption:= Z.ISO3166_1; //TODO: Name
        I.SubItems.Add(S);
      end;
    end;
  finally
    lstTimezones.Items.EndUpdate;
  end;
end;

procedure TfrmContentConfigTimezones.FormShow(Sender: TObject);
begin
  inherited;
  btnRefreshClick(nil);
end;

end.
