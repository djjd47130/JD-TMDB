unit uContentSearchMulti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf,
  JD.TMDB.Common;

type
  TfrmContentSearchMulti = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtQuery: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    cboIncludeAdult: TComboBox;
  private
    { Private declarations }
  public
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
  end;

var
  frmContentSearchMulti: TfrmContentSearchMulti;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentSearchMulti }

function TfrmContentSearchMulti.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L: String;
  A: TTMDBBoolean;
begin
  inherited;
  Q:= txtQuery.Text;
  A:= TTMDBBoolean(cboIncludeAdult.ItemIndex);
  L:= frmTMDBTestMain.cboLanguage.Text;
  Result:= TMDB.Client.Search.SearchMulti(Q, A, L, APageNum);
end;

function TfrmContentSearchMulti.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBMediaPage;
begin
  P:= ITMDBMediaPage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchMulti.HideDetail;
begin
  inherited;
  //FDetail:= nil;
end;

procedure TfrmContentSearchMulti.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

function TfrmContentSearchMulti.Page: ITMDBPage;
begin
  Result:= ITMDBMediaPage(inherited Page);
end;

procedure TfrmContentSearchMulti.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBMedium;
begin
  inherited;
  O:= Obj as ITMDBMedium;
  Item.Caption:= O.Title;
  Item.SubItems.Add(TMDBMediaTypeToStr(O.MediaType));
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));

end;

procedure TfrmContentSearchMulti.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentSearchMulti.SetupCols;
begin
  inherited;
  AddCol('Title', 400);
  AddCol('Media Type', 150);
  AddCol('Popularity', 100);

end;

procedure TfrmContentSearchMulti.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

end.
