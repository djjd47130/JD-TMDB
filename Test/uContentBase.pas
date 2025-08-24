unit uContentBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  JD.TMDB.Intf, JD.TMDB,
  ChromeTabs, ChromeTabsClasses, ChromeTabsTypes;



type

  //References to detail list items, and handling click events.

  TDetailRef = class;

  TDetailRefEvent = reference to procedure(Ref: TDetailRef);

  TDetailRef = class(TObject)
  private
    FOnClick: TDetailRefEvent;
    FItem: TListItem;
    procedure SetOnClick(const Value: TDetailRefEvent);
    function GetClickable: Boolean;
  public
    constructor Create(AItem: TListItem);
    property Clickable: Boolean read GetClickable;
    property Item: TListItem read FItem;
    property OnClick: TDetailRefEvent read FOnClick write SetOnClick;
  end;



type
  TfrmContentBase = class;

  TfrmContentBaseClass = class of TfrmContentBase;

  TfrmContentBase = class(TForm)
  protected
    function TMDB: TTMDB;
    function Client: ITMDBClient;
    procedure PrepAPI;
    function GetTabCaption: String;
    procedure SetTabCaption(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>
    /// Controls the caption of the tab and form simultaneously.
    /// </summary>
    property TabCaption: String read GetTabCaption write SetTabCaption;

    /// <summary>
    /// Virtual method to refresh any data within the form.
    /// </summary>
    procedure RefreshData; virtual;

    /// <summary>
    /// Virtual function to return whether the form is allowed to close.
    /// </summary>
    function CanClose: Boolean; virtual;

    /// <summary>
    /// Virtual function to return the image index associated with the tab.
    /// </summary>
    function GetImageIndex: Integer; virtual;

  end;

var
  frmContentBase: TfrmContentBase;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;



{ TDetailRef }

constructor TDetailRef.Create(AItem: TListItem);
begin
  FItem:= AItem;
end;

function TDetailRef.GetClickable: Boolean;
begin
  Result:= Assigned(FOnClick);
end;

procedure TDetailRef.SetOnClick(const Value: TDetailRefEvent);
begin
  FOnClick := Value;
end;




{ TfrmContentBase }

constructor TfrmContentBase.Create(AOwner: TComponent);
begin
  inherited;
  TabCaption:= Caption;
end;

destructor TfrmContentBase.Destroy;
begin

  inherited;
end;

function TfrmContentBase.GetImageIndex: Integer;
begin
  Result:= -1;
end;

function TfrmContentBase.GetTabCaption: String;
var
  T: TJDTabRef;
begin
  T:= TabController.TabByForm(Self);
  if T <> nil then
    Result:= T.Caption;
end;

function TfrmContentBase.CanClose: Boolean;
begin
  Result:= True;
end;

procedure TfrmContentBase.PrepAPI;
begin
  frmMain.PrepAPI;
end;

procedure TfrmContentBase.RefreshData;
begin

end;

procedure TfrmContentBase.SetTabCaption(const Value: String);
var
  T: TJDTabRef;
begin
  T:= TabController.TabByForm(Self);
  if T <> nil then
    T.Caption:= Value;
end;

function TfrmContentBase.TMDB: TTMDB;
begin
  Result:= frmMain.TMDB;
end;

function TfrmContentBase.Client: ITMDBClient;
begin
  Result:= TMDB.Client;
end;

end.
