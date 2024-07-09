unit uTMDBHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.ExtCtrls,

  uTMDBAppSetup,
  uContentCertsMovies,
  uContentCertsTV,
  uContentGenresMovie,
  uContentGenresTV,
  uContentSearchCollections,
  uContentSearchCompanies,
  uContentSearchKeywords,
  uContentSearchMovies,
  uContentSearchMulti,
  uContentSearchPeople,
  uContentSearchTV;

type
  TfrmTMDBHome = class(TfrmContentBase)
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    JDFontButton1: TJDFontButton;
    JDFontButton2: TJDFontButton;
    JDFontButton3: TJDFontButton;
    JDFontButton4: TJDFontButton;
    JDFontButton5: TJDFontButton;
    JDFontButton6: TJDFontButton;
    JDFontButton7: TJDFontButton;
    JDFontButton8: TJDFontButton;
    JDFontButton9: TJDFontButton;
    JDFontButton10: TJDFontButton;
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
    procedure FormCreate(Sender: TObject);
    procedure JDFontButton46Click(Sender: TObject);
    procedure JDFontButton42Click(Sender: TObject);
    procedure JDFontButton44Click(Sender: TObject);
    procedure JDFontButton45Click(Sender: TObject);
    procedure JDFontButton47Click(Sender: TObject);
    procedure JDFontButton48Click(Sender: TObject);
    procedure JDFontButton43Click(Sender: TObject);
    procedure JDFontButton49Click(Sender: TObject);
    procedure CategoryPanelGroup1MouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure CategoryPanelGroup1MouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure JDFontButton12Click(Sender: TObject);
    procedure JDFontButton13Click(Sender: TObject);
    procedure JDFontButton27Click(Sender: TObject);
    procedure JDFontButton28Click(Sender: TObject);
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

procedure TfrmTMDBHome.FormCreate(Sender: TObject);
begin
  inherited;
  TabCaption:= 'Main Menu';
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  CategoryPanelGroup1.VertScrollBar.Position:= CategoryPanelGroup1.VertScrollBar.Position + 20;
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  CategoryPanelGroup1.VertScrollBar.Position:= CategoryPanelGroup1.VertScrollBar.Position - 20;
end;

procedure TfrmTMDBHome.JDFontButton12Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentCertsMovies);
end;

procedure TfrmTMDBHome.JDFontButton13Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentCertsTV);
end;

procedure TfrmTMDBHome.JDFontButton27Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentGenresMovie);
end;

procedure TfrmTMDBHome.JDFontButton28Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentGenresTV);
end;

procedure TfrmTMDBHome.JDFontButton42Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchCollections);
end;

procedure TfrmTMDBHome.JDFontButton43Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchTV);
end;

procedure TfrmTMDBHome.JDFontButton44Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchCompanies);
end;

procedure TfrmTMDBHome.JDFontButton45Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchKeywords);
end;

procedure TfrmTMDBHome.JDFontButton46Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchMovies);
end;

procedure TfrmTMDBHome.JDFontButton47Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchMulti);
end;

procedure TfrmTMDBHome.JDFontButton48Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchPeople);
end;

procedure TfrmTMDBHome.JDFontButton49Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmTMDBAppSetup);
end;

end.
