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
    Panel9: TPanel;
    Label10: TLabel;
    cboSearchMoviesLanguage: TComboBox;
    Panel10: TPanel;
    Label11: TLabel;
    cboSearchMoviesRegion: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    //FDetail: ITMDBCollectionDetail;
  protected
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBPageItem; override;
    procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
  public
    { Public declarations }
  end;

var
  frmContentSearchCollections: TfrmContentSearchCollections;

implementation

{$R *.dfm}

procedure TfrmContentSearchCollections.FormCreate(Sender: TObject);
begin
  inherited;
  //Pages.ActivePageIndex:= 0;
end;

procedure TfrmContentSearchCollections.FormDestroy(Sender: TObject);
begin
  inherited;
  //FDetail:= nil;
end;

function TfrmContentSearchCollections.GetData(
  const APageNum: Integer): ITMDBPage;
var
  Q, L, R: String;
  A: Boolean;
begin
  inherited;
  Q:= txtSearchMoviesQuery.Text;
  A:= cboSearchMoviesAdult.ItemIndex = 1;
  L:= cboSearchMoviesLanguage.Text;
  R:= cboSearchMoviesRegion.Text;
  Result:= TMDB.Client.Search.SearchCollections(Q, A, L, R, APageNum);
end;

function TfrmContentSearchCollections.GetItem(
  const Index: Integer): ITMDBPageItem;
var
  P: ITMDBCollectionPage;
begin
  P:= ITMDBCollectionPage(Page);
  Result:= P.GetItem(Index);
end;

procedure TfrmContentSearchCollections.HideDetail;
begin
  inherited;
  //FDetail:= nil;
end;

procedure TfrmContentSearchCollections.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;
  //TODO: Navigate to movie details tab within app...

end;

function TfrmContentSearchCollections.Page: ITMDBPage;
begin
  Result:= ITMDBCollectionPage(inherited Page);
end;

procedure TfrmContentSearchCollections.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  O: ITMDBCollectionItem;
begin
  inherited;
  O:= Obj as ITMDBCollectionItem;
  Item.Caption:= O.Name;
  Item.SubItems.Add(O.OriginalLanguage);
  Item.SubItems.Add(O.Overview);
end;

procedure TfrmContentSearchCollections.PrepSearch;
begin
  inherited;

  //TODO: This should rather be fetching "Primary Translations"...
  TMDB.ListLanguages(cboSearchMoviesLanguage.Items);

  TMDB.ListCountries(cboSearchMoviesRegion.Items);

end;

procedure TfrmContentSearchCollections.SetupCols;
begin
  inherited;
  AddCol('Name', 250);
  AddCol('Language', 150);
  AddCol('Overview', 600);
end;

procedure TfrmContentSearchCollections.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;

end;

end.
