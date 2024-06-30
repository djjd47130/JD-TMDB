unit uContentSearchTV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf,
  JD.TMDB.Common;

type
  TfrmContentSearchTV = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtQuery: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    cboIncludeAdult: TComboBox;
    Panel13: TPanel;
    Label14: TLabel;
    txtFirstAirDateYear: TEdit;
    Panel14: TPanel;
    Label15: TLabel;
    txtYear: TEdit;
  private
    FDetail: ITMDBTVSeriesDetail;
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
  frmContentSearchTV: TfrmContentSearchTV;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentSearchTV }

function TfrmContentSearchTV.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L: String;
  FADY, Y: Integer;
  A: Boolean;
begin
  inherited;
  Q:= txtQuery.Text;
  A:= cboIncludeAdult.ItemIndex = 1;
  L:= frmTMDBTestMain.cboLanguage.Text;
  FADY:= StrToIntDef(txtFirstAirDateYear.Text, 0);
  Y:= StrToIntDef(txtYear.Text, 0);
  Result:= TMDB.Client.Search.SearchTV(Q, FADY, A, L, Y, APageNum);
end;

function TfrmContentSearchTV.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBTVSeriesPage;
begin
  P:= ITMDBTVSeriesPage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentSearchTV.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchTV.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;

end;

function TfrmContentSearchTV.Page: ITMDBPage;
begin
  Result:= ITMDBTVSeriesPage(inherited Page);
end;

procedure TfrmContentSearchTV.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBTVSerie;
begin
  inherited;
  O:= Obj as ITMDBTVSerie;
  Item.Caption:= O.Title;
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));
  if O.Genres.Count > 0 then
    Item.SubItems.Add(O.Genres[0].Name)
  else
    Item.SubItems.Add('(Unknown)');
  if O.FirstAirDate <> 0 then
    Item.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.FirstAirDate))
  else
    Item.SubItems.Add('');
  Item.SubItems.Add(O.Overview);
end;

procedure TfrmContentSearchTV.PrepSearch;
begin
  inherited;

end;

procedure TfrmContentSearchTV.SetupCols;
begin
  inherited;
  AddCol('TV Show', 400);
  AddCol('Popularity', 100);
  AddCol('Genre', 150);
  AddCol('First Air Date', 160);
  AddCol('Description', 700);
end;

procedure TfrmContentSearchTV.ShowDetail(const Index: Integer; Item: TListItem;
  Obj: ITMDBItem);
begin
  inherited;

end;

end.
