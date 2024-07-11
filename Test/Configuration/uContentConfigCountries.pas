unit uContentConfigCountries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls,
  JD.TMDB.Intf, JD.TMDB.Common;

type
  TfrmContentConfigCountries = class(TfrmContentBase)
    lstCountries: TListView;
    btnRefresh: TButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentConfigCountries: TfrmContentConfigCountries;

implementation

{$R *.dfm}

procedure TfrmContentConfigCountries.btnRefreshClick(Sender: TObject);
var
  X: Integer;
  C: ITMDBCountry;
  I: TListItem;
begin
  inherited;
  lstCountries.Items.BeginUpdate;
  try
    lstCountries.Items.Clear;
    for X := 0 to TMDB.Cache.Countries.Count-1 do begin
      C:= TMDB.Cache.Countries[X];
      I:= lstCountries.Items.Add;
      I.Caption:= C.ISO3166_1;
      I.SubItems.Add(C.EnglishName);
      I.SubItems.Add(C.NativeName);
    end;
  finally
    lstCountries.Items.EndUpdate;
  end;
end;

procedure TfrmContentConfigCountries.FormShow(Sender: TObject);
begin
  inherited;
  btnRefreshClick(nil);
end;

end.
