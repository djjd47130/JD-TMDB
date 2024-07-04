unit uContentSearchCollections;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, JD.Common, JD.Ctrls, JD.Ctrls.FontButton,
  JD.TMDB.Common, JD.TMDB.Intf;

type
  TfrmContentSearchCollections = class(TfrmContentPageBase)
    Panel7: TPanel;
    Label8: TLabel;
    txtSearchMoviesQuery: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    cboSearchMoviesAdult: TComboBox;
    Panel10: TPanel;
    Label11: TLabel;
    cboSearchMoviesRegion: TComboBox;
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    lblTitle: TLabel;
    txtOverview: TMemo;
    lstParts: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PagesChange(Sender: TObject);
  private
    FDetail: ITMDBCollectionDetail;
    //FImages: ITMDBImageList;
    //FTranslations: ITMDBTranslationList;
    function GetCollectionDetail(const ID: Integer): ITMDBCollectionDetail;
    procedure DisplayCollectionDetail(const Value: ITMDBCollectionDetail);
    procedure LoadDetails;
    procedure LoadParts;
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
  frmContentSearchCollections: TfrmContentSearchCollections;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

procedure TfrmContentSearchCollections.FormCreate(Sender: TObject);
begin
  inherited;
  Pages.ActivePageIndex:= 0;
end;

procedure TfrmContentSearchCollections.FormDestroy(Sender: TObject);
begin
  inherited;
  FDetail:= nil;
end;

function TfrmContentSearchCollections.GetData(
  const APageNum: Integer): ITMDBPage;
var
  Q, L, R: String;
  A: TTMDBBoolean;
begin
  inherited;
  Q:= txtSearchMoviesQuery.Text;
  A:= TTMDBBoolean(cboSearchMoviesAdult.ItemIndex);
  L:= frmTMDBTestMain.cboLanguage.Text;
  R:= cboSearchMoviesRegion.Text;
  Result:= ITMDBCollectionPage(TMDB.Client.Search.SearchCollections(Q, A, L, R, APageNum));
end;

function TfrmContentSearchCollections.GetItem(
  const Index: Integer): ITMDBItem;
var
  P: ITMDBCollectionPage;
begin
  P:= ITMDBCollectionPage(Page);
  Result:= ITMDBCollection(P.Items.GetItem(Index));
end;

procedure TfrmContentSearchCollections.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

procedure TfrmContentSearchCollections.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
begin
  inherited;
  //TODO: Navigate to movie details tab within app...

end;

function TfrmContentSearchCollections.Page: ITMDBPage;
begin
  Result:= ITMDBCollectionPage(inherited Page);
end;

procedure TfrmContentSearchCollections.PagesChange(Sender: TObject);
begin
  inherited;
  DisplayCollectionDetail(FDetail);
end;

procedure TfrmContentSearchCollections.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBCollection;
begin
  inherited;
  O:= Obj as ITMDBCollection;
  Item.Caption:= O.Name;
  Item.SubItems.Add(O.OriginalLanguage);
  Item.SubItems.Add(O.Overview);
end;

procedure TfrmContentSearchCollections.PrepSearch;
begin
  inherited;
  TMDB.ListCountries(cboSearchMoviesRegion.Items);
end;

procedure TfrmContentSearchCollections.SetupCols;
begin
  inherited;
  AddCol('Name', 250);
  AddCol('Language', 150);
  AddCol('Overview', 600);
end;

function TfrmContentSearchCollections.GetCollectionDetail(const ID: Integer): ITMDBCollectionDetail;
begin
  PrepAPI;
  Result:= TMDB.Client.Collections.GetDetails(ID, frmTMDBTestMain.cboLanguage.Text);
end;

procedure TfrmContentSearchCollections.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  ID: Integer;
  O: ITMDBCollection;
begin
  Screen.Cursor:= crHourglass;
  try
    FDetail:= nil;
    PrepAPI;
    O:= (Obj) as ITMDBCollection;
    ID:= O.ID;
    FDetail:= GetCollectionDetail(ID);
  finally
    Screen.Cursor:= crDefault;
  end;
  DisplayCollectionDetail(FDetail);
  inherited;
end;

procedure TfrmContentSearchCollections.DisplayCollectionDetail(const Value: ITMDBCollectionDetail);
begin
  //Refresh detail of selected tab...
  FDetail:= Value;
  Screen.Cursor:= crHourglass;
  try
    case Pages.ActivePageIndex of
      0: LoadDetails;
      1: LoadParts;
      2: ; //LoadImages
      3: ; //LoadTranslations
      //TODO
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentSearchCollections.LoadDetails;
begin
  lblTitle.Caption:= FDetail.Name;
  txtOverview.Lines.Text:= FDetail.Overview;

end;

procedure TfrmContentSearchCollections.LoadParts;
var
  X: Integer;
  I: TListItem;
  O: ITMDBCollectionPart;
begin
  lstParts.Items.BeginUpdate;
  try
    lstParts.Items.Clear;
    for X := 0 to FDetail.PartCount-1 do begin
      O:= FDetail[X];
      I:= lstParts.Items.Add;
      I.Caption:= O.Title; //TODO: ACCESS VIOLATION - treated as TSuperObject???!!!
      I.SubItems.Add(FormatFloat('0.0', O.Popularity));
      I.SubItems.Add(TMDBMediaTypeToStr(O.MediaType));
      if O.Genres.Count > 0 then
        I.SubItems.Add(O.Genres.Items[0].Name)
      else
        I.SubItems.Add('');
      if O.ReleaseDate > 0 then
        I.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.ReleaseDate))
      else
        I.SubItems.Add('');
      I.SubItems.Add(O.Overview);
    end;
  finally
    lstParts.Items.EndUpdate;
  end;
end;

end.
