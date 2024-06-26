unit uContentSearchPeople;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmContentSearchPeople = class(TfrmContentPageBase)
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
    function GetItem(const Index: Integer): ITMDBPageItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
  end;

var
  frmContentSearchPeople: TfrmContentSearchPeople;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentSearchPeople }

function TfrmContentSearchPeople.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L: String;
  A: Boolean;
begin
  inherited;
  Q:= txtQuery.Text;
  A:= cboIncludeAdult.ItemIndex = 1;
  L:= frmTMDBTestMain.cboLanguage.Text;
  Result:= TMDB.Client.Search.SearchPeople(Q, A, L, APageNum);
end;

function TfrmContentSearchPeople.GetItem(const Index: Integer): ITMDBPageItem;
var
  P: ITMDBPersonPage;
begin
  P:= ITMDBPersonPage(Page);
  Result:= P.GetItem(Index);
end;

procedure TfrmContentSearchPeople.HideDetail;
begin
  inherited;
  //FDetail:= nil;
end;

procedure TfrmContentSearchPeople.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;

end;

function TfrmContentSearchPeople.Page: ITMDBPage;
begin
  Result:= ITMDBPersonPage(inherited Page);
end;

procedure TfrmContentSearchPeople.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  O: ITMDBPersonItem;
begin
  inherited;
  O:= Obj as ITMDBPersonItem;
  Item.Caption:= O.Title;
  Item.SubItems.Add(O.KnownForDepartment);
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));
  Item.SubItems.Add(TMDBGenderToStr(O.Gender));

end;

procedure TfrmContentSearchPeople.SetupCols;
begin
  inherited;
  AddCol('Name', 300);
  AddCol('Department', 200);
  AddCol('Popularity', 100);
  AddCol('Gender', 100);

end;

procedure TfrmContentSearchPeople.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentSearchPeople.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;

end;

end.