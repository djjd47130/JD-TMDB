unit uCommonAlternativeTitles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmCommonAlternativeTitles = class(TfrmCommonFormBase)
    lstAltTitles: TListView;
    pTop: TPanel;
    Label1: TLabel;
    txtID: TEdit;
    btnSearch: TJDFontButton;
  private
    FObj: ITMDBAlternativeTitles;
  public
    procedure Load(const Reviews: ITMDBAlternativeTitles);
  end;

var
  frmCommonAlternativeTitles: TfrmCommonAlternativeTitles;

implementation

{$R *.dfm}

{ TfrmCommonAlternativeTitles }

procedure TfrmCommonAlternativeTitles.Load(
  const Reviews: ITMDBAlternativeTitles);
var
  X: Integer;
  R: ITMDBAlternativeTitle;
  I: TListItem;
begin
  FObj:= Reviews;
  lstAltTitles.Items.BeginUpdate;
  try
    lstAltTitles.Items.Clear;
    for X := 0 to FObj.Count-1 do begin
      R:= FObj.Items[X];
      I:= lstAltTitles.Items.Add;
      I.Caption:= R.Title;
      I.SubItems.Add(R.ISO3166_1);
    end;
  finally
    lstAltTitles.Items.EndUpdate;
  end;
end;

end.
