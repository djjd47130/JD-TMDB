unit JD.TabController;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types,
  System.UITypes,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Forms,
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
    FTab: TTabSheet;
    FChromeTab: TChromeTab;
  public
    constructor Create(AOwner: TJDTabController; AClass: TfrmContentBaseClass); virtual;
    destructor Destroy; override;

    function GetID: Int64;
    function GetCaption: String;

    property Owner: TJDTabController read FOwner;
    property FormClass: TfrmContentBaseClass read FClass;
    property ID: Int64 read FID;
    property Content: TfrmContentBase read FContent;
    property Tab: TTabSheet read FTab;
    property ChromeTab: TChromeTab read FChromeTab;
  end;

  TJDTabController = class(TComponent)
  private
    FItems: TObjectList<TJDTabRef>;
    FPageControl: TPageControl;
    FChromeTabs: TChromeTabs;
    function GetTab(const Index: Integer): TJDTabRef;
    procedure SetChromeTabs(const Value: TChromeTabs);
    procedure SetPageControl(const Value: TPageControl);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CreateTab(AClass: TfrmContentBaseClass;
      const AIndex: Integer = -1): TJDTabRef;

    procedure DeleteTab(const Index: Integer);
    function Count: Integer;
    property Tabs[const Index: Integer]: TJDTabRef read GetTab; default;

  published
    property ChromeTabs: TChromeTabs read FChromeTabs write SetChromeTabs;
    property PageControl: TPageControl read FPageControl write SetPageControl;
  end;

function TabController: TJDTabController;

implementation

var
  _TabController: TJDTabController;
  _TabLastID: Int64;

function TabController: TJDTabController;
begin
  if _TabController = nil then
    _TabController:= TJDTabController.Create(nil);
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

  FTab:= TTabSheet.Create(FOwner.PageControl);
  FTab.PageControl:= FOwner.PageControl;
  FTab.Tag:= FID;
  FTab.TabVisible:= False;

  Application.ProcessMessages;

  FContent:= FClass.Create(FTab);
  FContent.Parent:= FTab;
  FContent.BorderStyle:= bsNone;
  FContent.Align:= alClient;
  FContent.Tag:= FID;
  FContent.Show;

  Application.ProcessMessages;

  FChromeTab:= FOwner.ChromeTabs.Tabs.Add;
  FChromeTab.Tag:= FID;
  FChromeTab.Caption:= FContent.Caption;

end;

destructor TJDTabRef.Destroy;
begin

  FOwner.ChromeTabs.Tabs.Delete(FChromeTab.Index);

  FreeAndNil(FContent);

  FreeAndNil(FTab);

  inherited;
end;

function TJDTabRef.GetCaption: String;
begin
  Result:= FContent.Caption;
end;

function TJDTabRef.GetID: Int64;
begin
  Result:= FID;
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

function TJDTabController.GetTab(const Index: Integer): TJDTabRef;
begin
  Result:= FItems[Index];
end;

procedure TJDTabController.SetChromeTabs(const Value: TChromeTabs);
begin
  FChromeTabs := Value;
end;

procedure TJDTabController.SetPageControl(const Value: TPageControl);
begin
  FPageControl := Value;
end;

initialization
  _TabController:= nil;
  _TabLastID:= 0;
finalization
  FreeAndNil(_TabController);
end.
