unit uContentPageBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls,
  XSuperObject;

type
  TfrmContentPageBase = class(TfrmContentBase)
    pMain: TPanel;
    lstResults: TListView;
    pFooter: TPanel;
    lblResults: TLabel;
    lblPage: TLabel;
    btnPagePrev: TButton;
    btnPageNext: TButton;
    pSearch: TPanel;
    btnApply: TButton;
    pDetail: TPanel;
    procedure btnApplyClick(Sender: TObject);
    procedure btnPagePrevClick(Sender: TObject);
    procedure btnPageNextClick(Sender: TObject);
    procedure lstResultsClick(Sender: TObject);
    procedure lstResultsDblClick(Sender: TObject);
    procedure lstResultsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    FObj: ISuperObject;
    procedure PopulateResults;
    procedure UpdateFooter;
  protected
    procedure SetupCols; virtual;
    function AddCol(const ACaption: String; const AWidth: Integer): TListColumn;
    procedure PrepSearch; virtual;
    function GetData(const APageNum: Integer): ISuperObject; virtual;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ISuperObject); virtual;
    procedure ItemClick(const Index: Integer; Item: TListItem; Obj: ISuperObject); virtual;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ISuperObject); virtual;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ISuperObject); virtual;
    procedure HideDetail; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PageNum: Integer; virtual;
    function PageCount: Integer;
    function ResultCount: Integer;

    function LoadPage(const APageNum: Integer): Boolean; virtual;
    procedure PagePrev; virtual;
    procedure PageNext; virtual;
    procedure Refresh; virtual;
  end;

var
  frmContentPageBase: TfrmContentPageBase;

implementation

{$R *.dfm}

{ TfrmContentPageBase }

constructor TfrmContentPageBase.Create(AOwner: TComponent);
begin
  inherited;
  SetupCols;
  UpdateFooter;
end;

destructor TfrmContentPageBase.Destroy;
begin

  inherited;
end;

function TfrmContentPageBase.AddCol(const ACaption: String;
  const AWidth: Integer): TListColumn;
begin
  Result:= lstResults.Columns.Add;
  Result.Caption:= ACaption;
  Result.Width:= AWidth;
end;

procedure TfrmContentPageBase.btnApplyClick(Sender: TObject);
begin
  inherited;
  LoadPage(1);
end;

procedure TfrmContentPageBase.btnPageNextClick(Sender: TObject);
begin
  inherited;
  PageNext;
end;

procedure TfrmContentPageBase.btnPagePrevClick(Sender: TObject);
begin
  inherited;
  PagePrev;
end;

function TfrmContentPageBase.LoadPage(const APageNum: Integer): Boolean;
begin
  PrepAPI;
  lstResults.Tag:= APageNum;
  FObj:= GetData(APageNum);
  PopulateResults;
  UpdateFooter;
  HideDetail;
  Result:= True;
end;

procedure TfrmContentPageBase.lstResultsClick(Sender: TObject);
var
  I: TListItem;
  X: Integer;
  O: ISuperObject;
begin
  inherited;
  if lstResults.Selected = nil then Exit;
  I:= lstResults.Selected;
  X:= I.Index;
  O:= FObj.A['results'].O[X];
  ItemClick(X, I, O);
end;

procedure TfrmContentPageBase.lstResultsDblClick(Sender: TObject);
var
  I: TListItem;
  X: Integer;
  O: ISuperObject;
begin
  inherited;
  if lstResults.Selected = nil then Exit;
  I:= lstResults.Selected;
  X:= I.Index;
  O:= FObj.A['results'].O[X];
  ItemDblClick(X, I, O);
end;

procedure TfrmContentPageBase.lstResultsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  I: TListItem;
  X: Integer;
  O: ISuperObject;
begin
  inherited;
  if not Selected then
    HideDetail
  else begin
    I:= lstResults.Selected;
    X:= I.Index;
    O:= FObj.A['results'].O[X];
    ShowDetail(X, I, O);
  end;
end;

function TfrmContentPageBase.PageCount: Integer;
begin
  if FObj <> nil then begin
    Result:= FObj.I['total_pages'];
  end else begin
    Result:= 0;
  end;
end;

function TfrmContentPageBase.PageNum: Integer;
begin
  Result:= lstResults.Tag;
end;

procedure TfrmContentPageBase.PageNext;
begin
  lstResults.Tag:= lstResults.Tag + 1;
  LoadPage(lstResults.Tag);
end;

procedure TfrmContentPageBase.PagePrev;
begin
  lstResults.Tag:= lstResults.Tag - 1;
  LoadPage(lstResults.Tag);
end;

procedure TfrmContentPageBase.Refresh;
begin
  LoadPage(PageNum);
end;

function TfrmContentPageBase.ResultCount: Integer;
begin
  if FObj <> nil then begin
    Result:= FObj.I['total_results'];
  end else begin
    Result:= 0;
  end;
end;

procedure TfrmContentPageBase.UpdateFooter;
begin
  lblResults.Caption:= IntToStr(ResultCount)+' Results';
  lblPage.Caption:= 'Page '+IntToStr(PageNum)+
    ' of '+IntToStr(PageCount);
  btnPagePrev.Enabled:= PageNum > 1;
  btnPageNext.Enabled:= PageNum < PageCount;
end;

procedure TfrmContentPageBase.PopulateResults;
var
  A: ISuperArray;
  O: ISuperObject;
  X: Integer;
  I: TListItem;
begin
  lstResults.Items.Clear;
  if FObj = nil then Exit;
  A:= FObj.A['results'];
  for X := 0 to A.Length-1 do begin
    O:= A.O[X];
    I:= lstResults.Items.Add;
    PopulateItem(X, I, O);
  end;
end;

procedure TfrmContentPageBase.PrepSearch;
begin
  //Override expected
end;

procedure TfrmContentPageBase.SetupCols;
begin
  lstResults.Columns.Clear;
  //Override required
end;

procedure TfrmContentPageBase.ShowDetail(const Index: Integer; Item: TListItem;
  Obj: ISuperObject);
begin
  pDetail.Visible:= True;
  pDetail.Top:= 1;
  //Override expected
end;

function TfrmContentPageBase.GetData(const APageNum: Integer): ISuperObject;
begin
  //Override required
end;

procedure TfrmContentPageBase.HideDetail;
begin
  pDetail.Visible:= False;
end;

procedure TfrmContentPageBase.ItemClick(const Index: Integer; Item: TListItem;
  Obj: ISuperObject);
begin
  //Override expected
end;

procedure TfrmContentPageBase.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ISuperObject);
begin
  //Override expected
end;

procedure TfrmContentPageBase.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ISuperObject);
begin
  //Override required
end;

end.
