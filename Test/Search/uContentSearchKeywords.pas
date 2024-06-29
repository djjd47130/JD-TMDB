unit uContentSearchKeywords;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmContentSearchKeywords = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtQuery: TEdit;
    lstDetail: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDetail: ITMDBKeywordDetail;
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
  frmContentSearchKeywords: TfrmContentSearchKeywords;

implementation

{$R *.dfm}

{ TfrmContentSearchKeywords }

procedure TfrmContentSearchKeywords.FormCreate(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchKeywords.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentSearchKeywords.GetData(const APageNum: Integer): ITMDBPage;
var
  Q: String;
begin
  inherited;
  Q:= txtQuery.Text;
  Result:= TMDB.Client.Search.SearchKeywords(Q, APageNum);
end;

function TfrmContentSearchKeywords.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBKeywordPage;
begin
  P:= ITMDBKeywordPage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchKeywords.HideDetail;
begin
  inherited;
  FDetail:= nil
end;

procedure TfrmContentSearchKeywords.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

function TfrmContentSearchKeywords.Page: ITMDBPage;
begin
  Result:= ITMDBKeywordPage(inherited Page);
end;

procedure TfrmContentSearchKeywords.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBKeywordItem;
begin
  inherited;
  O:= Obj as ITMDBKeywordItem;
  Item.Caption:= O.Name;
  Item.SubItems.Add(IntToStr(O.ID));
end;

procedure TfrmContentSearchKeywords.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentSearchKeywords.SetupCols;
begin
  inherited;
  AddCol('Keyword', 400);
  AddCol('ID', 100);

end;

procedure TfrmContentSearchKeywords.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  ID: Integer;
  I: TListItem;
  O: ITMDBKeywordItem;
begin
  inherited;
  O:= Obj as ITMDBKeywordItem;
  lstDetail.Items.Clear;
  ID:= O.ID;
  FDetail:= TMDB.Client.Keywords.GetDetails(ID);

  I:= lstDetail.Items.Add;
  I.Caption:= 'Name';
  I.SubItems.Add(FDetail.Name);

  I:= lstDetail.Items.Add;
  I.Caption:= 'ID';
  I.SubItems.Add(IntToStr(FDetail.ID));

end;

end.
