unit uContentSearchCompanies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common, JD.TMDB.Intf;

type
  TfrmContentSearchCompanies = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtSearchMoviesQuery: TEdit;
  private
    { Private declarations }
  protected
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
  public
    { Public declarations }
  end;

var
  frmContentSearchCompanies: TfrmContentSearchCompanies;

implementation

{$R *.dfm}

{ TfrmContentSearchCompanies }

function TfrmContentSearchCompanies.GetData(const APageNum: Integer): ITMDBPage;
var
  Q: String;
begin
  inherited;
  Q:= txtSearchMoviesQuery.Text;
  Result:= TMDB.Client.Search.SearchCompanies(Q, APageNum);

  TabCaption:= 'Search Companies - "'+Q+'"';
end;

function TfrmContentSearchCompanies.GetItem(
  const Index: Integer): ITMDBItem;
var
  P: ITMDBCompanyPage;
begin
  P:= ITMDBCompanyPage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchCompanies.HideDetail;
begin
  inherited;
  //FDetail:= nil;
end;

procedure TfrmContentSearchCompanies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;
  //TODO: Navigate to company details tab within app...
end;

function TfrmContentSearchCompanies.Page: ITMDBPage;
begin
  Result:= ITMDBCompanyPage(inherited Page);
end;

procedure TfrmContentSearchCompanies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBCompany;
begin
  inherited;
  O:= Obj as ITMDBCompany;
  Item.Caption:= O.Name;
  Item.SubItems.Add(O.OriginCountry);
end;

procedure TfrmContentSearchCompanies.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentSearchCompanies.SetupCols;
begin
  inherited;
  AddCol('Name', 350);
  AddCol('Country', 150);
end;

procedure TfrmContentSearchCompanies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

end.
