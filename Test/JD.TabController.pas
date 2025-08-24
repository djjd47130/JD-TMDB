unit JD.TabController;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  System.UITypes,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms,
  ChromeTabs, ChromeTabsClasses

  , uContentBase

  ;

type
  TJDTabForm = class;
  TJDTabRef = class;
  TJDTabController = class;


  TJDTabFormClass = class of TJDTabForm;

  //TODO: Migrate form-related stuff to central form class as part of library...
  //NOTE: The following approach is not likely to suffice, as it is not a typical actual VCL form
  //  tied to the VCL framework via DFM. Need to create base form in separate dedicated unit instead.
  TJDTabForm = class(TForm)
  private

  public

  published

  end;



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
    function CloseQuery: Boolean;

    property Owner: TJDTabController read FOwner;
    function Index: Integer;
    property FormClass: TfrmContentBaseClass read FClass;
    property Caption: String read GetCaption write SetCaption;
    property ID: Int64 read FID;
    property Content: TfrmContentBase read FContent;
    property ChromeTab: TChromeTab read FChromeTab;
  end;

  //TODO: Change to component on form rather than global instance...
  TJDTabController = class(TComponent)
  private
    FItems: TObjectList<TJDTabRef>;
    FChromeTabs: TChromeTabs;
    FContainer: TPanel;
    FMainForm: TForm;
    FCreating: Boolean;
    function GetTab(const Index: Integer): TJDTabRef;
    procedure SetChromeTabs(const Value: TChromeTabs);
    procedure SetContainer(const Value: TPanel);
    function GetActiveTabIndex: Integer;
    procedure SetActiveTabIndex(const Value: Integer);
    procedure HideAll;
    procedure SetMainForm(const Value: TForm);
    function GetActiveTabID: Integer;
    procedure SetActiveTabID(const Value: Integer);
    function GetActiveTab: TJDTabRef;
    procedure SetActiveTab(const Value: TJDTabRef);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>
    /// Creates a new tab in the main UI as a specific class of TfrmContentBase.
    /// - AClass: TfrmContentBaseClass - The content form class to be created.
    /// - AIndex: Integer (Optional) - The index where to insert the new tab.
    /// - AID: Integer (Optional) - The unique ID of the resource being opened.
    /// </summary>
    function CreateTab(AClass: TfrmContentBaseClass;
      const AIndex: Integer = -1;
      const AID: Integer = -1): TJDTabRef;

    //procedure QueryCloseTab(const Tab: TJDTabRef);
    procedure DeleteTab(const Index: Integer);
    function TabCount: Integer;
    property Tabs[const Index: Integer]: TJDTabRef read GetTab; default;

    procedure HandleTabChanged(ATab: TChromeTab);

    function TabByID(const ID: Integer): TJDTabRef;
    function TabByForm(AForm: TfrmContentBase): TJDTabRef;
    function TabByTab(ATab: TChromeTab): TJDTabRef;

    function CloseQuery: Boolean;
  published
    property ActiveTabIndex: Integer read GetActiveTabIndex write SetActiveTabIndex;
    property ActiveTabID: Integer read GetActiveTabID write SetActiveTabID;
    property ActiveTab: TJDTabRef read GetActiveTab write SetActiveTab;
    property ChromeTabs: TChromeTabs read FChromeTabs write SetChromeTabs;
    property Container: TPanel read FContainer write SetContainer;
    property MainForm: TForm read FMainForm write SetMainForm;
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
  FContent.Tag:= FID;
  FContent.Parent:= FOwner.FContainer;
  FContent.BorderStyle:= bsNone;
  FContent.Align:= alClient;
  FContent.Show;

  FChromeTab:= FOwner.ChromeTabs.Tabs.Add;
  FChromeTab.Tag:= FID;
  FChromeTab.Caption:= Caption;

  FOwner.ChromeTabs.Invalidate;

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

function TJDTabRef.Index: Integer;
begin
  Result:= FOwner.FItems.IndexOf(Self);
end;

procedure TJDTabRef.SetCaption(const Value: String);
begin
  FContent.Caption:= Value;
  FChromeTab.Caption:= Value;
end;

function TJDTabRef.CloseQuery: Boolean;
begin
  Result:= FContent.CanClose;
end;

procedure TJDTabRef.Show;
begin
  FContent.Show;
  FContent.BringToFront;
end;

{ TJDTabController }

constructor TJDTabController.Create(AOwner: TComponent);
begin
  inherited;
  FItems:= TObjectList<TJDTabRef>.Create(True);
  FCreating:= False;
end;

destructor TJDTabController.Destroy;
begin

  FreeAndNil(FItems);
  inherited;
end;

procedure TJDTabController.DeleteTab(const Index: Integer);
begin
  FItems.Delete(Index);
  if Index > 0 then
    ActiveTabIndex:= Index-1
  else if TabCount > 0 then
    ActiveTabIndex:= Index;
end;

function TJDTabController.CreateTab(AClass: TfrmContentBaseClass;
  const AIndex: Integer;
  const AID: Integer): TJDTabRef;
var
  I: Integer;
begin
  //TODO: If AID is specified, and identical tab already exists,
  //  prompt whether to open existing tab or create new tab.
  FCreating:= True;
  try
    Result:= TJDTabRef.Create(Self, AClass);
    I:= FItems.Add(Result);
    if AIndex > -1 then begin
      FItems.Move(I, AIndex);
    end;
  finally
    FCreating:= False;
  end;
  ActiveTab:= Result;
end;

function TJDTabController.TabCount: Integer;
begin
  Result:= FItems.Count;
end;

function TJDTabController.CloseQuery: Boolean;
var
  X: Integer;
begin
  Result:= True;
  for X := FItems.Count-1 downto 0 do begin
    Result:= FItems[X].CloseQuery;
    if not Result then
      Break;
  end;
end;

function TJDTabController.GetActiveTab: TJDTabRef;
begin
  Result:= TabByTab(FChromeTabs.ActiveTab);
end;

function TJDTabController.GetActiveTabID: Integer;
begin
  Result:= GetActiveTab.ID;
end;

function TJDTabController.GetActiveTabIndex: Integer;
begin
  Result:= GetActiveTab.Index;
end;

function TJDTabController.GetTab(const Index: Integer): TJDTabRef;
begin
  Result:= FItems[Index];
end;

procedure TJDTabController.HandleTabChanged(ATab: TChromeTab);
begin
  if not FCreating then
    ActiveTab:= TabByTab(ATab);
end;

function TJDTabController.TabByForm(AForm: TfrmContentBase): TJDTabRef;
var
  X: Integer;
begin
  Result:= nil;
  for X := 0 to FItems.Count-1 do begin
    if FItems[X].Content = AForm then begin
      Result:= FItems[X];
      Break;
    end;
  end;
end;

function TJDTabController.TabByID(const ID: Integer): TJDTabRef;
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

function TJDTabController.TabByTab(ATab: TChromeTab): TJDTabRef;
var
  X: Integer;
begin
  Result:= nil;
  for X := 0 to FItems.Count-1 do begin
    if FItems[X].FChromeTab = ATab then begin
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

procedure TJDTabController.SetActiveTab(const Value: TJDTabRef);
begin
  SetActiveTabIndex(Value.Index);
end;

procedure TJDTabController.SetActiveTabID(const Value: Integer);
var
  T: TJDTabRef;
begin
  T:= TabByID(Value);
  SetActiveTab(T);
end;

procedure TJDTabController.SetActiveTabIndex(const Value: Integer);
var
  T: TJDTabRef;
begin
  if (Value >= 0) and (Value < FItems.Count) { and
    (Value <> FChromeTabs.ActiveTabIndex) } then
  begin
    T:= FItems[Value];
    FChromeTabs.ActiveTabIndex:= T.ChromeTab.Index;
    HideAll;
    T.FContent.Show;
    T.FContent.BringToFront;
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

procedure TJDTabController.SetMainForm(const Value: TForm);
begin
  FMainForm := Value;
end;

end.
