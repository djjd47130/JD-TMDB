unit uCommonAlternativeTitles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCommonAlternativeTitles = class(TfrmCommonFormBase)
    lstAltTitles: TListView;
    pTop: TPanel;
    Label1: TLabel;
    txtID: TEdit;
    btnSearch: TJDFontButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCommonAlternativeTitles: TfrmCommonAlternativeTitles;

implementation

{$R *.dfm}

end.
