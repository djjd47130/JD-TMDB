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
    function GetItem(const Index: Integer): ITMDBItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
  end;

var
  frmContentSearchPeople: TfrmContentSearchPeople;

implementation

{$R *.dfm}

uses
  uMain;

{ TfrmContentSearchPeople }

function TfrmContentSearchPeople.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L: String;
  A: TTMDBBoolean;
begin
  inherited;
  Q:= txtQuery.Text;
  A:= TTMDBBoolean(cboIncludeAdult.ItemIndex);
  L:= frmMain.cboLanguage.Text;
  Result:= TMDB.Client.Search.SearchPeople(Q, A, L, APageNum);
end;

function TfrmContentSearchPeople.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBPersonPage;
begin
  P:= Page as ITMDBPersonPage;
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchPeople.HideDetail;
begin
  inherited;
  //FDetail:= nil;
end;

procedure TfrmContentSearchPeople.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

function TfrmContentSearchPeople.Page: ITMDBPage;
begin
  Result:= (inherited Page) as ITMDBPersonPage;
end;

procedure TfrmContentSearchPeople.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBPerson;
begin
  inherited;
  O:= Obj as ITMDBPerson;
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
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

end.
