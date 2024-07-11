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
  uContentSearchTV,
  uContentConfigCountries,
  uContentConfigLanguages, Vcl.StdCtrls;

type
  TfrmTMDBHome = class(TfrmContentBase)
    SB: TScrollBox;
    pMovies: TPanel;
    Label1: TLabel;
    JDFontButton12: TJDFontButton;
    JDFontButton27: TJDFontButton;
    JDFontButton9: TJDFontButton;
    JDFontButton2: TJDFontButton;
    JDFontButton29: TJDFontButton;
    JDFontButton36: TJDFontButton;
    JDFontButton37: TJDFontButton;
    JDFontButton35: TJDFontButton;
    JDFontButton34: TJDFontButton;
    JDFontButton24: TJDFontButton;
    JDFontButton42: TJDFontButton;
    JDFontButton46: TJDFontButton;
    pTV: TPanel;
    Label2: TLabel;
    JDFontButton43: TJDFontButton;
    JDFontButton25: TJDFontButton;
    JDFontButton4: TJDFontButton;
    JDFontButton31: TJDFontButton;
    JDFontButton7: TJDFontButton;
    JDFontButton8: TJDFontButton;
    JDFontButton10: TJDFontButton;
    JDFontButton28: TJDFontButton;
    JDFontButton13: TJDFontButton;
    pMisc: TPanel;
    Label3: TLabel;
    pConfig: TPanel;
    Label4: TLabel;
    JDFontButton26: TJDFontButton;
    JDFontButton45: TJDFontButton;
    JDFontButton47: TJDFontButton;
    JDFontButton44: TJDFontButton;
    JDFontButton5: TJDFontButton;
    JDFontButton1: TJDFontButton;
    JDFontButton3: TJDFontButton;
    JDFontButton22: TJDFontButton;
    JDFontButton21: TJDFontButton;
    JDFontButton20: TJDFontButton;
    JDFontButton19: TJDFontButton;
    JDFontButton18: TJDFontButton;
    JDFontButton17: TJDFontButton;
    JDFontButton49: TJDFontButton;
    pPeople: TPanel;
    Label5: TLabel;
    JDFontButton48: TJDFontButton;
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
    procedure JDFontButton18Click(Sender: TObject);
    procedure JDFontButton20Click(Sender: TObject);
  private
    { Private declarations }
  protected
    function CanClose: Boolean; override;
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

type
  THackCategoryPanelGroup = class(TCategoryPanelGroup)
  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

{ THackCategoryPanelGroup }

procedure THackCategoryPanelGroup.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style:= Params.Style  and  not  WS_BORDER;

end;

procedure TfrmTMDBHome.FormCreate(Sender: TObject);
var
  P: THackCategoryPanelGroup;
begin
  inherited;
  TabCaption:= 'Main Menu';

end;

function TfrmTMDBHome.CanClose: Boolean;
begin
  Result:= False;
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  SB.VertScrollBar.Position:= SB.VertScrollBar.Position + 20;
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  SB.VertScrollBar.Position:= SB.VertScrollBar.Position - 20;
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

procedure TfrmTMDBHome.JDFontButton18Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigCountries);
end;

procedure TfrmTMDBHome.JDFontButton20Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigLanguages);
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
