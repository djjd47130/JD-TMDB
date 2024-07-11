unit uContentPageBase;

(*
  TODO: This design will NOT work once switching from plain JSON/XSuperObject to inherited interfaces!!!
  Problem is "ITMDBMoviePage" and "ITMDBMovieItem" inherit from "ITMDBPage" and "ITMDBPageItem",
  which inherfaces do not naturally support virtual/override of methods.

*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf, JD.Common, JD.Ctrls, JD.Ctrls.FontButton;

type
  TfrmContentPageBase = class(TfrmContentBase)
    pMain: TPanel;
    lstResults: TListView;
    pTop: TPanel;
    lblResults: TLabel;
    lblPage: TLabel;
    btnPagePrev: TButton;
    btnPageNext: TButton;
    pSearch: TPanel;
    pDetail: TPanel;
    Splitter1: TSplitter;
    btnApply: TJDFontButton;
    procedure lstResultsClick(Sender: TObject);
    procedure lstResultsDblClick(Sender: TObject);
    procedure lstResultsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnApplyClick(Sender: TObject);
    procedure btnPagePrevClick(Sender: TObject);
    procedure btnPageNextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FObj: ITMDBPage;
  protected
    function AddCol(const ACaption: String; const AWidth: Integer): TListColumn; virtual;
    procedure SetupCols; virtual;
    procedure PrepSearch; virtual;
    procedure UpdateFooter; virtual;
    procedure HideDetail; virtual;

    function Page: ITMDBPage; virtual;
    function LoadPage(const APageNum: Integer): Boolean; virtual;
    procedure PopulateResults; virtual;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); virtual;

    function GetData(const APageNum: Integer): ITMDBPage; virtual;
    function GetItem(const Index: Integer): ITMDBItem; virtual;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); virtual;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); virtual;
    procedure ItemClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); virtual;

  public
    procedure PageNext; virtual;
    procedure PagePrev; virtual;
    function PageCount: Integer; virtual;
    function ResultCount: Integer; virtual;
    function PageNum: Integer; virtual;
    procedure Refresh; virtual;

  end;

var
  frmContentPageBase: TfrmContentPageBase;

implementation

{$R *.dfm}

{ TfrmContentPageBase }

procedure TfrmContentPageBase.FormCreate(Sender: TObject);
begin
  inherited;
  SetupCols;
  UpdateFooter;
end;

procedure TfrmContentPageBase.FormDestroy(Sender: TObject);
begin
  inherited;
  FObj:= nil;
end;

procedure TfrmContentPageBase.FormShow(Sender: TObject);
begin
  inherited;
  PrepSearch;
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

function TfrmContentPageBase.GetData(const APageNum: Integer): ITMDBPage;
begin
  //Override required
end;

function TfrmContentPageBase.GetItem(const Index: Integer): ITMDBItem;
begin
  Result:= FObj.Items[Index];
end;

procedure TfrmContentPageBase.HideDetail;
begin
  Splitter1.Visible:= False;
  pDetail.Visible:= False;
end;

procedure TfrmContentPageBase.ItemClick(const Index: Integer; Item: TListItem;
  Obj: ITMDBItem);
begin
  //Override expected
end;

procedure TfrmContentPageBase.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  //Override expected
end;

function TfrmContentPageBase.LoadPage(const APageNum: Integer): Boolean;
begin
  inherited;
  PrepAPI;
  lstResults.Tag:= APageNum;
  FObj:= GetData(APageNum);
  HideDetail;
  UpdateFooter;
  PopulateResults;
  Result:= True;
end;

procedure TfrmContentPageBase.lstResultsClick(Sender: TObject);
var
  I: TListItem;
  X: Integer;
  O: ITMDBItem;
begin
  inherited;
  if lstResults.Selected = nil then Exit;
  I:= lstResults.Selected;
  X:= I.Index;
  O:= GetItem(X);
  ItemClick(X, I, O);
end;

procedure TfrmContentPageBase.lstResultsDblClick(Sender: TObject);
var
  I: TListItem;
  X: Integer;
  O: ITMDBItem;
begin
  inherited;
  if lstResults.Selected = nil then Exit;
  I:= lstResults.Selected;
  X:= I.Index;
  O:= GetItem(X);
  ItemDblClick(X, I, O);
end;

procedure TfrmContentPageBase.lstResultsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  I: TListItem;
  X: Integer;
  O: ITMDBItem;
begin
  inherited;
  if not Selected then
    HideDetail
  else begin
    I:= lstResults.Selected;
    X:= I.Index;
    O:= GetItem(X);
    ShowDetail(X, I, O);
  end;
end;

function TfrmContentPageBase.Page: ITMDBPage;
begin
  Result:= FObj;
end;

function TfrmContentPageBase.PageCount: Integer;
begin
  if FObj <> nil then begin
    Result:= FObj.TotalPages;
  end else begin
    Result:= 0;
  end;
end;

procedure TfrmContentPageBase.PageNext;
begin
  lstResults.Tag:= lstResults.Tag + 1;
  LoadPage(lstResults.Tag);
end;

function TfrmContentPageBase.PageNum: Integer;
begin
  Result:= lstResults.Tag;
end;

procedure TfrmContentPageBase.PagePrev;
begin
  lstResults.Tag:= lstResults.Tag - 1;
  LoadPage(lstResults.Tag);
end;

procedure TfrmContentPageBase.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  //Override required
end;

procedure TfrmContentPageBase.PopulateResults;
var
  O: ITMDBItem;
  X: Integer;
  I: TListItem;
begin
  lstResults.Items.Clear;
  if FObj = nil then Exit;
  for X := 0 to FObj.Items.Count-1 do begin
    O:= GetItem(X);
    I:= lstResults.Items.Add;
    PopulateItem(X, I, O);
  end;
end;

procedure TfrmContentPageBase.PrepSearch;
begin
  //Override expected
end;

procedure TfrmContentPageBase.Refresh;
begin
  LoadPage(PageNum);
end;

function TfrmContentPageBase.ResultCount: Integer;
begin
  if FObj <> nil then begin
    Result:= FObj.Items.Count;
  end else begin
    Result:= 0;
  end;
end;

procedure TfrmContentPageBase.SetupCols;
begin
  lstResults.Columns.Clear;
  //Override expected
end;

procedure TfrmContentPageBase.ShowDetail(const Index: Integer; Item: TListItem;
  Obj: ITMDBItem);
begin
  Splitter1.Visible:= True;
  pDetail.Visible:= True;
  pDetail.Top:= 1;
  Splitter1.Top:= 10000;
end;

procedure TfrmContentPageBase.UpdateFooter;
begin
  lblResults.Caption:= IntToStr(ResultCount)+' Results';
  lblPage.Caption:= 'Page '+IntToStr(PageNum)+
    ' of '+IntToStr(PageCount);
  btnPagePrev.Enabled:= PageNum > 1;
  btnPageNext.Enabled:= PageNum < PageCount;
end;

end.
