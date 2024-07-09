unit JD.TabController;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  System.UITypes,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms,
  ChromeTabs, ChromeTabsClasses,

  uContentBase

  ;

type
  TJDTabRef = class;
  TJDTabController = class;



  TJDTabRef = class(TObject)
  private
    FOwner: TJDTabController;
    FClass: TfrmContentBaseClass;
    FID: Int64;
    FContent: TfrmContentBase;
    FChromeTab: TChromeTab;
    function GetCaption: String;
    procedure SetCaption(const Value: String);
  public
    constructor Create(AOwner: TJDTabController; AClass: TfrmContentBaseClass); virtual;
    destructor Destroy; override;

    procedure Show;

    property Owner: TJDTabController read FOwner;
    property FormClass: TfrmContentBaseClass read FClass;
    property Caption: String read GetCaption write SetCaption;
    property ID: Int64 read FID;
    property Content: TfrmContentBase read FContent;
    property ChromeTab: TChromeTab read FChromeTab;
  end;

  TJDTabController = class(TComponent)
  private
    FItems: TObjectList<TJDTabRef>;
    FChromeTabs: TChromeTabs;
    FContainer: TPanel;
    function GetTab(const Index: Integer): TJDTabRef;
    procedure SetChromeTabs(const Value: TChromeTabs);
    procedure SetContainer(const Value: TPanel);
    function GetActiveTabIndex: Integer;
    procedure SetActiveTabIndex(const Value: Integer);
    procedure HideAll;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CreateTab(AClass: TfrmContentBaseClass;
      const AIndex: Integer = -1): TJDTabRef;

    function RefByID(const ID: Integer): TJDTabRef;
    function RefByForm(AForm: TfrmContentBase): TJDTabRef;

    procedure DeleteTab(const Index: Integer);
    function Count: Integer;
    property Tabs[const Index: Integer]: TJDTabRef read GetTab; default;

  published
    property ActiveTabIndex: Integer read GetActiveTabIndex write SetActiveTabIndex;
    property ChromeTabs: TChromeTabs read FChromeTabs write SetChromeTabs;
    property Container: TPanel read FContainer write SetContainer;
  end;

procedure InitTabController;
procedure UninitTabController;
function TabController: TJDTabController;

implementation

var
  _TabController: TJDTabController;
  _TabLastID: Int64;

procedure InitTabController;
begin
  _TabController:= TJDTabController.Create(nil);
end;

procedure UninitTabController;
begin
  FreeAndNil(_TabController);
end;

function TabController: TJDTabController;
begin
  if _TabController = nil then
    InitTabController;
  Result:= _TabController;
end;

function NewTabID: Int64;
begin
  _TabLastID:= _TabLastID + 1;
  Result:= _TabLastID;
end;

{ TJDTabRef }

constructor TJDTabRef.Create(AOwner: TJDTabController; AClass: TfrmContentBaseClass);
begin
  FOwner:= AOwner;
  FClass:= AClass;

  FID:= NewTabID;

  FContent:= FClass.Create(nil);
  FContent.Parent:= FOwner.FContainer;
  FContent.BorderStyle:= bsNone;
  FContent.Align:= alClient;
  FContent.Tag:= FID;
  FContent.Show;

  FChromeTab:= FOwner.ChromeTabs.Tabs.Add;
  FChromeTab.Tag:= FID;
  FChromeTab.Caption:= Caption;

end;

destructor TJDTabRef.Destroy;
var
  I: Integer;
begin
  I:= FChromeTab.Index;
  FOwner.ChromeTabs.Tabs.Delete(I);
  FreeAndNil(FContent);
  FOwner.ChromeTabs.ActiveTabIndex:= I-1;

  inherited;
end;

function TJDTabRef.GetCaption: String;
begin
  if FContent <> nil then
    Result:= FContent.Caption
  else
    Result:= '';
end;

procedure TJDTabRef.SetCaption(const Value: String);
begin
  FContent.Caption:= Value;
  FChromeTab.Caption:= Value;
end;

procedure TJDTabRef.Show;
begin
  FContent.Show;
  FContent.BringToFront;
end;

{ TJDTabController }

function TJDTabController.Count: Integer;
begin
  Result:= FItems.Count;
end;

constructor TJDTabController.Create(AOwner: TComponent);
begin
  inherited;
  FItems:= TObjectList<TJDTabRef>.Create(True);

end;

destructor TJDTabController.Destroy;
begin

  FreeAndNil(FItems);
  inherited;
end;

procedure TJDTabController.DeleteTab(const Index: Integer);
begin
  FItems.Delete(Index);
  Self.ActiveTabIndex:= Index-1;
end;

function TJDTabController.CreateTab(AClass: TfrmContentBaseClass;
  const AIndex: Integer): TJDTabRef;
var
  I: Integer;
begin
  Result:= TJDTabRef.Create(Self, AClass);
  I:= FItems.Add(Result);

  if AIndex > -1 then begin
    FItems.Move(I, AIndex);
  end;

end;

function TJDTabController.GetActiveTabIndex: Integer;
begin
  Result:= FChromeTabs.ActiveTabIndex;
end;

function TJDTabController.GetTab(const Index: Integer): TJDTabRef;
begin
  Result:= FItems[Index];
end;

function TJDTabController.RefByForm(AForm: TfrmContentBase): TJDTabRef;
begin
  Result:= RefByID(AForm.Tag);
end;

function TJDTabController.RefByID(const ID: Integer): TJDTabRef;
var
  X: Integer;
begin
  Result:= nil;
  for X := 0 to FItems.Count-1 do begin
    if FItems[X].ID = ID then begin
      Result:= FItems[X];
      Break;
    end;
  end;
end;

procedure TJDTabController.HideAll;
var
  X: Integer;
begin
  for X := 0 to FItems.Count-1 do
    FItems[X].FContent.Hide;
end;

procedure TJDTabController.SetActiveTabIndex(const Value: Integer);
var
  T: TJDTabRef;
begin
  if (Value >= 0) and (Value < FItems.Count) then  begin
    FChromeTabs.ActiveTabIndex:= Value;
    HideAll;
    FItems[Value].FContent.Show;
    FItems[Value].FContent.BringToFront;
  end;
end;

procedure TJDTabController.SetChromeTabs(const Value: TChromeTabs);
begin
  FChromeTabs := Value;
end;

procedure TJDTabController.SetContainer(const Value: TPanel);
begin
  FContainer := Value;
end;

end.
