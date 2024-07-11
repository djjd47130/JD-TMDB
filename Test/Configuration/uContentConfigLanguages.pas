unit uContentConfigLanguages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmContentConfigLanguages = class(TfrmContentBase)
    lstLanguages: TListView;
    btnRefresh: TButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentConfigLanguages: TfrmContentConfigLanguages;

implementation

{$R *.dfm}

procedure TfrmContentConfigLanguages.btnRefreshClick(Sender: TObject);
var
  X: Integer;
  L: ITMDBLanguages;
  I: TListItem;
  O: ITMDBLanguage;
begin
  inherited;
  lstLanguages.Items.BeginUpdate;
  try
    lstLanguages.Items.Clear;
    L:= TMDB.Cache.Languages;
    for X := 0 to L.Count-1 do begin
      O:= L[X];
      I:= lstLanguages.Items.Add;
      I.Caption:= O.ISO639_1;
      I.SubItems.Add(O.EnglishName);
      I.SubItems.Add(O.Name);
    end;
  finally
    lstLanguages.Items.EndUpdate;
  end;
end;

procedure TfrmContentConfigLanguages.FormShow(Sender: TObject);
begin
  inherited;
  btnRefreshClick(nil);
end;

end.
