unit uContentDiscoverMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentMoviePage, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,

  JD.TMDB.Intf,
  JD.TMDB.Common, Vcl.CheckLst, JD.FontGlyphs, System.ImageList, Vcl.ImgList,
  VirtualTrees.BaseAncestorVCL, VirtualTrees.BaseTree, VirtualTrees.AncestorVCL,
  VirtualTrees,
  uContentPageBase, uCommonDblCheckList, JD.Ctrls.ChipList,
  JD.Ctrls.ListBox, Vcl.WinXCtrls, Vcl.WinXPanels;


type
  PTMDBDualCheckNode = ^TTMDBDualCheckNode;
  TTMDBDualCheckNode = record
    Intf: IInterface;
    WithChecked: Boolean;
    WithoutChecked: Boolean;
  end;


type
  TInterfaceWrapper = class
  private
    FIntf: IInterface;
  public
    constructor Create(AIntf: IInterface);
    property Intf: IInterface read FIntf;
  end;


type
  TfrmContentDiscoverMovies = class(TfrmContentMoviePage)
    Img16: TImageList;
    Glyphs: TJDFontGlyphs;
    CategoryPanelGroup1: TCategoryPanelGroup;
    cpRelease: TCategoryPanel;
    Panel13: TPanel;
    Label14: TLabel;
    txtSearchMoviesPrimaryReleaseYear: TEdit;
    Panel14: TPanel;
    Label15: TLabel;
    txtSearchMoviesYear: TEdit;
    cpRegion: TCategoryPanel;
    Panel10: TPanel;
    Label11: TLabel;
    cboSearchMoviesRegion: TComboBox;
    cpCerts: TCategoryPanel;
    Label1: TLabel;
    cboCertCountry: TComboBox;
    lstCerts: TCheckListBox;
    Panel8: TPanel;
    Label9: TLabel;
    cboSearchMoviesAdult: TComboBox;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Panel2: TPanel;
    Label3: TLabel;
    Edit2: TEdit;
    CategoryPanel3: TCategoryPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Edit3: TEdit;
    Panel4: TPanel;
    Label5: TLabel;
    Edit4: TEdit;
    CategoryPanel4: TCategoryPanel;
    CategoryPanel6: TCategoryPanel;
    Panel11: TPanel;
    Label12: TLabel;
    CategoryPanel5: TCategoryPanel;
    Panel7: TPanel;
    Label8: TLabel;
    Edit7: TEdit;
    Panel9: TPanel;
    Label10: TLabel;
    Edit8: TEdit;
    CategoryPanel7: TCategoryPanel;
    Panel15: TPanel;
    Label16: TLabel;
    Edit11: TEdit;
    Panel16: TPanel;
    Label17: TLabel;
    Edit12: TEdit;
    frmGenres: TfrmCommonDblCheckList;
    JDChipList1: TJDChipList;
    Splitter2: TSplitter;
    clCompanies: TJDChipList;
    Panel5: TPanel;
    Label6: TLabel;
    txtSearchCompanies: TButtonedEdit;
    txtSearchKeyword: TSearchBox;
    procedure cboCertCountryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstCertsClickCheck(Sender: TObject);
    procedure cboSearchMoviesAdultClick(Sender: TObject);
    procedure cboSearchMoviesRegionClick(Sender: TObject);
    procedure cboSearchMoviesRegionChange(Sender: TObject);
    procedure cboSearchMoviesRegionCloseUp(Sender: TObject);
    procedure JDChipList1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtSearchCompaniesRightButtonClick(Sender: TObject);
    procedure txtSearchKeywordInvokeSearch(Sender: TObject);
  private
    FPrepped: Boolean;
    function GetCertString: String;
    procedure ClearCertCountries;
    procedure UpdateImageIndices;
  public
    function Page: ITMDBPage; override;
    procedure SetupCols; override;
    procedure PrepSearch; override;
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBItem; override;
    //procedure HideDetail; override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    //procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
    //procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBItem); override;
  end;

var
  frmContentDiscoverMovies: TfrmContentDiscoverMovies;

implementation

{$R *.dfm}

uses
  uMain;

{ TInterfaceWrapper }

constructor TInterfaceWrapper.Create(AIntf: IInterface);
begin
  inherited Create;
  FIntf := AIntf;
end;

{ TfrmContentDiscoverMovies }

procedure TfrmContentDiscoverMovies.FormCreate(Sender: TObject);
begin
  inherited;
  FPrepped:= False;
  CategoryPanelGroup1.CollapseAll;
  frmGenres.Align:= alClient;

  frmGenres.LoadList(TMDB.Cache.TVGenres);

end;

procedure TfrmContentDiscoverMovies.FormDestroy(Sender: TObject);
begin
  inherited;
  ClearCertCountries;
end;

procedure TfrmContentDiscoverMovies.FormShow(Sender: TObject);
begin
  inherited;
  if Self.lstResults.Items.Count = 0 then
    Self.btnApply.Click;
end;

function TfrmContentDiscoverMovies.GetData(const APageNum: Integer): ITMDBPage;
begin
  inherited;
  var Params:= TMDB.Discover.NewMovieParams;

  if cboCertCountry.ItemIndex > 0 then begin
    Params.CertificationCountry:= cboCertCountry.Text;
    Params.Certification:= GetCertString;
  end;
  Params.IncludeAdult:= TTMDBBoolean(cboSearchMoviesAdult.ItemIndex);
  Params.Language:= AppSetup.Language;
  Params.Region:= cboSearchMoviesRegion.Text;
  Params.PrimaryReleaseYear:= StrToIntDef(txtSearchMoviesPrimaryReleaseYear.Text, 0);
  Params.Year:= StrToIntDef(txtSearchMoviesYear.Text, 0);



  Result:= TMDB.Discover.DiscoverMovies(Params, APageNum);

  TabCaption:= 'Discover Movies';

end;

function TfrmContentDiscoverMovies.GetItem(const Index: Integer): ITMDBItem;
var
  P: ITMDBMoviePage;
begin
  P:= ITMDBMoviePage(Page);
  Result:= P.Items.GetItem(Index);
end;

procedure TfrmContentDiscoverMovies.JDChipList1Resize(Sender: TObject);
begin
  inherited;
  //TODO: Resize parent accordingly...
  var P:= JDChipList1.Parent as TCustomControl;
  if P is TCategoryPanel then begin
    TCategoryPanel(P).Height:= JDChipList1.Top + JDChipList1.Height + 2;
  end else
    P.Height:= JDChipList1.Top + JDChipList1.Height + 2;
end;

procedure TfrmContentDiscoverMovies.lstCertsClickCheck(Sender: TObject);
begin
  inherited;
  Self.UpdateImageIndices;

end;

function TfrmContentDiscoverMovies.Page: ITMDBPage;
begin
  Result:= ITMDBMoviePage(inherited Page);
end;

procedure TfrmContentDiscoverMovies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBItem);
var
  O: ITMDBMovie;
begin
  inherited;
  O:= Obj as ITMDBMovie;
  Item.Caption:= O.Title;
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));
  if O.Genres.Count > 0 then
    Item.SubItems.Add(O.Genres[0].Name)
  else
    Item.SubItems.Add('(Unknown)');
  if O.ReleaseDate <> 0 then
    Item.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.ReleaseDate))
  else
    Item.SubItems.Add('');
  Item.SubItems.Add(O.Overview);
end;

procedure TfrmContentDiscoverMovies.cboSearchMoviesAdultClick(Sender: TObject);
begin
  inherited;

  UpdateImageIndices;
end;

procedure TfrmContentDiscoverMovies.cboSearchMoviesRegionChange(
  Sender: TObject);
begin
  inherited;

  UpdateImageIndices;
end;

procedure TfrmContentDiscoverMovies.cboSearchMoviesRegionClick(Sender: TObject);
begin
  inherited;

  UpdateImageIndices;
end;

procedure TfrmContentDiscoverMovies.cboSearchMoviesRegionCloseUp(
  Sender: TObject);
begin
  inherited;

  UpdateImageIndices;
end;

procedure TfrmContentDiscoverMovies.ClearCertCountries;
begin
  for var X := 1 to cboCertCountry.Items.Count-1 do begin
    TInterfaceWrapper(cboCertCountry.Items.Objects[X]).Free;
  end;
end;

procedure TfrmContentDiscoverMovies.PrepSearch;
begin
  inherited;

  if not FPrepped then begin

    //Region
    TMDB.ListCountries(cboSearchMoviesRegion.Items);

    //Certifications
    lstCerts.Align:= alClient;
    cboCertCountry.Items.Clear;
    var Certs:= TMDB.Certifications.GetMovieCertifications;
    var Lst:= TStringList.Create;
    try
      for var X := 0 to Certs.Count-1 do begin
        var C:= Certs.Items[X];
        var O:= TInterfaceWrapper.Create(C);
        Lst.AddObject(C.CountryCode, O);
      end;
      Lst.Sort;
      cboCertCountry.Items.Assign(Lst);
    finally
      Lst.Free;
    end;
    cboCertCountry.ItemIndex:= cboCertCountry.Items.IndexOf('US'); //TODO
    cboCertCountryClick(nil);


    //TODO.............................................................

    FPrepped:= True;
  end;
end;

function CheckListBoxHasChecks(ACheckListBox: TCheckListBox): Boolean;
begin
  Result:= False;
  for var X := 0 to ACheckListBox.Items.Count-1 do begin
    if ACheckListBox.Checked[X] then begin
      Result:= True;
      Break;
    end;
  end;
end;

procedure SetCategoryPanelImageIndices(APanel: TCategoryPanel; const AUsed: Boolean);
begin
  if AUsed then begin
    APanel.CollapsedImageIndex:= 2;
    APanel.ExpandedImageIndex:= 3;
  end else begin
    APanel.CollapsedImageIndex:= 0;
    APanel.ExpandedImageIndex:= 1;
  end;

  //TODO: This is a very sloppy solution to images not refreshing when changed.
  //  The REAL solution is to replace it with something custom and robust...
  //APanel.Visible:= False;
  //APanel.Visible:= True;
end;

procedure TfrmContentDiscoverMovies.UpdateImageIndices;
begin

  SetCategoryPanelImageIndices(cpCerts, CheckListBoxHasChecks(lstCerts) or (cboSearchMoviesAdult.ItemIndex > 0));
  SetCategoryPanelImageIndices(cpRegion, (cboSearchMoviesRegion.ItemIndex >= 0));

end;

procedure TfrmContentDiscoverMovies.txtSearchCompaniesRightButtonClick(
  Sender: TObject);
begin
  inherited;

  var S:= txtSearchCompanies.Text;
  txtSearchCompanies.Text:= '';
  var I:= clCompanies.Items.Add;
  I.Caption:= S;
end;

procedure TfrmContentDiscoverMovies.cboCertCountryClick(Sender: TObject);
var
  O: TInterfaceWrapper;
  C: ITMDBCertificationCountry;
begin
  inherited;
  lstCerts.Items.Clear;
  if cboCertCountry.ItemIndex > 0 then begin
    O:= TInterfaceWrapper(cboCertCountry.Items.Objects[cboCertCountry.ItemIndex]);
    C:= ITMDBCertificationCountry(O.Intf);
    for var X := 0 to C.Count-1 do begin
      lstCerts.Items.Add(C.Items[X].Certification);
    end;
  end;
  UpdateImageIndices;
end;

function TfrmContentDiscoverMovies.GetCertString: String;
begin
  Result:= '';
  for var X := 0 to lstCerts.Items.Count-1 do begin
    if lstCerts.Checked[X] then begin
      if Result <> '' then
        Result:= Result + '|';
      Result:= Result + lstCerts.Items[X];
    end;
  end;
end;

procedure TfrmContentDiscoverMovies.txtSearchKeywordInvokeSearch(Sender: TObject);
begin
  inherited;

  var S:= txtSearchKeyword.Text;
  txtSearchKeyword.Text:= '';
  var I:= JDChipList1.Items.Add;
  I.Caption:= S;
end;

procedure TfrmContentDiscoverMovies.SetupCols;
begin
  inherited;
  AddCol('Movie', 400);
  AddCol('Popularity', 100);
  AddCol('Genre', 150);
  AddCol('Released', 160);
  AddCol('Description', 700);
end;

end.
