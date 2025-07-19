unit uCommonDblCheckList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  VirtualTrees.BaseAncestorVCL, VirtualTrees.BaseTree, VirtualTrees.AncestorVCL,
  VirtualTrees,
  JD.TMDB.Intf;


type
  PTMDBDualCheckNode = ^TTMDBDualCheckNode;
  TTMDBDualCheckNode = record
    Intf: ITMDBItem;
    WithChecked: Boolean;
    WithoutChecked: Boolean;
  end;


type
  TfrmCommonDblCheckList = class(TFrame)
    TV: TVirtualStringTree;
    procedure TVPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure TVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure TVGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadList(AList: ITMDBItems);
  end;

implementation

{$R *.dfm}

uses
  StrUtils;

{ TfrmCommonDblCheckList }

constructor TfrmCommonDblCheckList.Create(AOwner: TComponent);
begin
  inherited;
  TV.Align:= alClient;
  TV.TreeOptions.MiscOptions := TV.TreeOptions.MiscOptions + [toCheckSupport];

end;

destructor TfrmCommonDblCheckList.Destroy;
begin

  inherited;
end;

procedure TfrmCommonDblCheckList.LoadList(AList: ITMDBItems);
var
  i: Integer;
  Node: PVirtualNode;
  NodeData: PTMDBDualCheckNode;
begin
  if not Assigned(AList) then Exit;

  TV.BeginUpdate;
  try
    TV.Clear;

    for i := 0 to AList.GetCount - 1 do
    begin
      Node := TV.AddChild(nil); // Add node to the root level

      // Initialize node data
      NodeData := TV.GetNodeData(Node);
      if Assigned(NodeData) then
      begin
        NodeData^.Intf := AList.GetItem(i);
        NodeData^.WithChecked := False;
        NodeData^.WithoutChecked := False;
      end;
    end;
  finally
    TV.EndUpdate;
  end;
end;

procedure TfrmCommonDblCheckList.TVGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PTMDBDualCheckNode;
  //Genre: ITMDBGenre;
  //Keyword: ITMDBKeyword;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData) and Assigned(NodeData^.Intf) then begin
    CellText:= NodeData.Intf.GetText;
  end else begin
    CellText:= '(Unknown)';
  end;
end;

procedure TfrmCommonDblCheckList.TVInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData: PTMDBDualCheckNode;
begin
  NodeData := Sender.GetNodeData(Node);
  //NodeData^.Intf:= nil;
  NodeData^.WithChecked := False;
  NodeData^.WithoutChecked := False;
end;

procedure TfrmCommonDblCheckList.TVMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  HitInfo: THitInfo;
  NodeData: PTMDBDualCheckNode;
begin
  TV.GetHitTestInfoAt(X, Y, True, HitInfo);
  if Assigned(HitInfo.HitNode) then
  begin
    NodeData := TV.GetNodeData(HitInfo.HitNode);
    if Assigned(NodeData) then
    begin
      if HitInfo.HitColumn = 0 then
        NodeData^.WithChecked := not NodeData^.WithChecked
      else if HitInfo.HitColumn = 1 then
        NodeData^.WithoutChecked := not NodeData^.WithoutChecked;

      TV.InvalidateNode(HitInfo.HitNode);
    end;
  end;
end;

procedure TfrmCommonDblCheckList.TVPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeData: PTMDBDualCheckNode;
  CheckRect: TRect;
  Flag: Cardinal;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData) then
  begin
    // Define checkbox position (adjust X for spacing)
    //CheckRect := Sender.GetNodeRect(Node);
    CheckRect := Sender.GetDisplayRect(Node, Column, False);

    CheckRect.Right := CheckRect.Left + 16; // Checkbox width
    CheckRect.Left := CheckRect.Left + 2;   // Small padding

    // Draw "With" checkbox in first column
    if NodeData^.WithChecked then
      Flag:= DFCS_CHECKED
    else
      Flag:= 0;
    if Column = 0 then
      DrawFrameControl(TargetCanvas.Handle, CheckRect, DFC_BUTTON,
        DFCS_BUTTONCHECK or Flag);

    // Draw "Without" checkbox in second column
    if NodeData^.WithoutChecked then
      Flag:= DFCS_CHECKED
    else
      Flag:= 0;
    if Column = 1 then
      DrawFrameControl(TargetCanvas.Handle, CheckRect, DFC_BUTTON,
        DFCS_BUTTONCHECK or Flag);
  end;
end;

end.
