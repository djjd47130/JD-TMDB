unit uTMDBHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.ExtCtrls,
  uContentSearchMovies;

type
  TfrmTMDBHome = class(TfrmContentBase)
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    JDFontButton1: TJDFontButton;
    CategoryPanel3: TCategoryPanel;
    JDFontButton2: TJDFontButton;
    JDFontButton3: TJDFontButton;
    JDFontButton4: TJDFontButton;
    JDFontButton5: TJDFontButton;
    JDFontButton6: TJDFontButton;
    JDFontButton7: TJDFontButton;
    JDFontButton8: TJDFontButton;
    JDFontButton9: TJDFontButton;
    JDFontButton10: TJDFontButton;
    JDFontButton11: TJDFontButton;
    CategoryPanel4: TCategoryPanel;
    JDFontButton12: TJDFontButton;
    JDFontButton13: TJDFontButton;
    CategoryPanel5: TCategoryPanel;
    JDFontButton14: TJDFontButton;
    JDFontButton15: TJDFontButton;
    JDFontButton16: TJDFontButton;
    CategoryPanel6: TCategoryPanel;
    CategoryPanel7: TCategoryPanel;
    CategoryPanel8: TCategoryPanel;
    JDFontButton17: TJDFontButton;
    JDFontButton18: TJDFontButton;
    JDFontButton19: TJDFontButton;
    JDFontButton20: TJDFontButton;
    JDFontButton21: TJDFontButton;
    JDFontButton22: TJDFontButton;
    CategoryPanel9: TCategoryPanel;
    JDFontButton23: TJDFontButton;
    CategoryPanel10: TCategoryPanel;
    JDFontButton24: TJDFontButton;
    JDFontButton25: TJDFontButton;
    CategoryPanel11: TCategoryPanel;
    JDFontButton26: TJDFontButton;
    CategoryPanel12: TCategoryPanel;
    JDFontButton27: TJDFontButton;
    JDFontButton28: TJDFontButton;
    CategoryPanel13: TCategoryPanel;
    CategoryPanel14: TCategoryPanel;
    CategoryPanel15: TCategoryPanel;
    CategoryPanel16: TCategoryPanel;
    CategoryPanel17: TCategoryPanel;
    JDFontButton29: TJDFontButton;
    JDFontButton30: TJDFontButton;
    JDFontButton31: TJDFontButton;
    JDFontButton32: TJDFontButton;
    JDFontButton33: TJDFontButton;
    JDFontButton34: TJDFontButton;
    JDFontButton35: TJDFontButton;
    JDFontButton36: TJDFontButton;
    JDFontButton37: TJDFontButton;
    JDFontButton38: TJDFontButton;
    JDFontButton39: TJDFontButton;
    JDFontButton40: TJDFontButton;
    JDFontButton41: TJDFontButton;
    CategoryPanel18: TCategoryPanel;
    CategoryPanel19: TCategoryPanel;
    CategoryPanel20: TCategoryPanel;
    CategoryPanel21: TCategoryPanel;
    CategoryPanel22: TCategoryPanel;
    JDFontButton42: TJDFontButton;
    JDFontButton43: TJDFontButton;
    JDFontButton44: TJDFontButton;
    JDFontButton45: TJDFontButton;
    JDFontButton46: TJDFontButton;
    JDFontButton47: TJDFontButton;
    JDFontButton48: TJDFontButton;
    JDFontButton49: TJDFontButton;
    procedure JDFontButton46Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTMDBHome: TfrmTMDBHome;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

procedure TfrmTMDBHome.JDFontButton46Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchMovies);

end;

end.
