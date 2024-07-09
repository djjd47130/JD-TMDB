unit uContentSearchTV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Intf,
  JD.TMDB.Common,
  uContentTVSerieDetail;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDetail: ITMDBTVSerieDetail;
    FDetailForm: TfrmContentTVSerieDetail;
    function GetSeriesDetail(const ID: Integer): ITMDBTVSerieDetail;
    procedure DisplaySeriesDetail(const Value: ITMDBTVSerieDetail);
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
  uMain,
  JD.TabController;

{ TfrmContentSearchTV }

procedure TfrmContentSearchTV.FormCreate(Sender: TObject);
begin
  inherited;
  FDetailForm:= TfrmContentTVSerieDetail.Create(pDetail);
  FDetailForm.Parent:= pDetail;
  FDetailForm.BorderStyle:= bsNone;
  FDetailForm.Align:= alClient;
  FDetailForm.pTop.Visible:= False;
  FDetailForm.Show;
end;

procedure TfrmContentSearchTV.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentSearchTV.GetData(const APageNum: Integer): ITMDBPage;
var
  Q, L: String;
  FADY, Y: Integer;
  A: TTMDBBoolean;
begin
  inherited;
  Q:= txtQuery.Text;
  A:= TTMDBBoolean(cboIncludeAdult.ItemIndex);
  L:= frmMain.cboLanguage.Text;
  FADY:= StrToIntDef(txtFirstAirDateYear.Text, 0);
  Y:= StrToIntDef(txtYear.Text, 0);
  Result:= TMDB.Client.Search.SearchTV(Q, FADY, A, L, Y, APageNum);

  TabCaption:= 'Search TV - ' + Q;
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
var
  T: TJDTabRef;
  M: ITMDBTVSerie;
begin
  inherited;
  //TODO: Navigate to series details tab within app...
  M:= Obj as ITMDBTVSerie;
  T:= TabController.CreateTab(TfrmContentTVSerieDetail);
  (T.Content as TfrmContentTVSerieDetail).pTop.Visible:= False;
  (T.Content as TfrmContentTVSerieDetail).LoadSeries(M.ID);
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

function TfrmContentSearchTV.GetSeriesDetail(const ID: Integer): ITMDBTVSerieDetail;
var
  Inc: TTMDBTVSeriesRequests;
begin
  PrepAPI;
  Inc:= [trAccountStates, trAggregateCredits, trAlternativeTitles,
    trChanges, trContentRatings, trCredits, trEpisodeGroups, trExternalIDs,
    trImages, trKeywords, trLists, trRecommendations, trReviews, trScreenedTheatrically,
    trSimilar, trTranslations, trVideos];
  Result:= TMDB.Client.TVSeries.GetDetails(ID, Inc, frmMain.cboLanguage.Text,
    TMDB.LoginState.SessionID);
end;

procedure TfrmContentSearchTV.ShowDetail(const Index: Integer; Item: TListItem;
  Obj: ITMDBItem);
var
  ID: Integer;
  O: ITMDBTVSerie;
begin
  Screen.Cursor:= crHourglass;
  try
    FDetail:= nil;
    PrepAPI;
    O:= (Obj) as ITMDBTVSerie;
    ID:= O.ID;
    FDetail:= GetSeriesDetail(ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  DisplaySeriesDetail(FDetail);
  inherited;
end;

procedure TfrmContentSearchTV.DisplaySeriesDetail(const Value: ITMDBTVSerieDetail);
begin
  //Refresh detail of selected tab...
  FDetail:= Value;
  Screen.Cursor:= crHourglass;
  try
    FDetailForm.LoadSeries(Value);

  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
