unit uContentPersonDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Themes,
  PngImage,
  Jpeg,
  JD.Common, JD.Ctrls, JD.Ctrls.FontButton,
  JD.Graphics,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  JD.TabController,
  uCommonFormBase,
  uCommonVideos,
  uCommonCredits,
  uCommonImages,
  uCommonReviews,
  uCommonAlternativeTitles,
  uCommonChanges,
  uContentMoviePage,
  uContentBrowser,
  uCommonPersonCredits;

type
  TfrmContentPersonDetail = class(TfrmContentBase)
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    Splitter1: TSplitter;
    txtOverview: TMemo;
    lstDetail: TListView;
    tabChanges: TTabSheet;
    tabCombinedCredits: TTabSheet;
    TabSheet6: TTabSheet;
    lstExternalIDs: TListView;
    tabImages: TTabSheet;
    tabMovieCredits: TTabSheet;
    tabTVCredits: TTabSheet;
    tabTranslations: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure lstDetailAdvancedCustomDraw(Sender: TCustomListView;
      const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure lstDetailAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure lstDetailAdvancedCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure lstDetailDblClick(Sender: TObject);
  private
    FDetail: ITMDBPersonDetail;

    FCombinedCredits: TfrmCommonPersonCredits;
    FMovieCredits: TfrmCommonPersonCredits;
    FTVCredits: TfrmCommonPersonCredits;
    FImages: TfrmCommonImages;
    FChanges: TfrmContentChanges;

    procedure ClearDetails;
    function GetPersonDetail(const ID: Integer): ITMDBPersonDetail;
    function EmbedFormIntoTab(AClass: TfrmCommonFormBaseClass;
      ATab: TTabSheet): TfrmCommonFormBase; overload;
    function EmbedFormIntoTab(AClass: TfrmContentBaseClass;
      ATab: TTabSheet): TfrmContentBase; overload;
    procedure LoadTabContent;
    procedure LoadDetails;
    procedure LoadChanges;
    procedure LoadCombinedCredits;
    procedure LoadExternalIDs;
    procedure LoadImages;
    procedure LoadMovieCredits;
    procedure LoadTranslations;
    procedure LoadTVCredits;
  public
    procedure LoadPerson(const PersonID: Integer); overload;
    procedure LoadPerson(const Person: ITMDBPersonDetail); overload;
  end;

var
  frmContentPersonDetail: TfrmContentPersonDetail;

implementation

{$R *.dfm}

uses
  uMain;

procedure TfrmContentPersonDetail.FormCreate(Sender: TObject);
begin
  inherited;
  Pages.Align:= alClient;
  Pages.ActivePageIndex:= 0;

  FCombinedCredits:= TfrmCommonPersonCredits(EmbedFormIntoTab(TfrmCommonPersonCredits, tabCombinedCredits));
  FMovieCredits:= TfrmCommonPersonCredits(EmbedFormIntoTab(TfrmCommonPersonCredits, tabMovieCredits));
  FTVCredits:= TfrmCommonPersonCredits(EmbedFormIntoTab(TfrmCommonPersonCredits, tabTVCredits));
  FImages:= TfrmCommonImages(EmbedFormIntoTab(TfrmCommonImages, tabImages));
  FChanges:= TfrmContentChanges(EmbedFormIntoTab(TfrmContentChanges, tabChanges));

end;

function TfrmContentPersonDetail.GetPersonDetail(
  const ID: Integer): ITMDBPersonDetail;
var
  Inc: TTMDBPersonRequests;
begin
  PrepAPI;
  //TODO: Change this whole form so each tab fetches its own data
  //  instead of relying on append_to_response for everything,
  //  which also opens the door for additional tabs which are not
  //  supported by append_to_response anyway.
  Inc:= [prChanges, prCombinedCredits, prEdternalIDs, prImages,
    prMovieCredits, prTVCredits, prTranslations];
  Result:= TMDB.Client.People.GetDetails(ID, Inc, AppSetup.Language);
end;

procedure TfrmContentPersonDetail.LoadTabContent;
begin
  Screen.Cursor:= crHourglass;
  try
    case Pages.ActivePageIndex of
      0: LoadDetails;
      1: LoadChanges;
      2: LoadCombinedCredits;
      3: LoadExternalIDs;
      4: LoadImages;
      5: LoadMovieCredits;
      6: LoadTVCredits;
      7: LoadTranslations;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentPersonDetail.LoadDetails;
  function A(const N: String; const V: String; OnClick: TDetailRefEvent = nil): TDetailRef;
  var
    I: TListItem;
  begin
    I:= lstDetail.Items.Add;
    I.Caption:= N;
    I.SubItems.Add(V);
    Result:= TDetailRef.Create(I);
    Result.OnClick:= OnClick;
    I.Data:= Result;
  end;
var
  X: Integer;
  I: TDetailRef;
  BackdropPath: String;
begin
  lstDetail.Items.BeginUpdate;
  try
    ClearDetails;

    A('Name', FDetail.Title,
      procedure(Ref: TDetailRef)
      begin
        //TODO: Translations...
        //Pages.ActivePage:= tabAltTitles;
        PagesChange(Pages);
      end);

    for X := 0 to Length(FDetail.AlsoKnownAs)-1 do begin
      A('Also Known As', FDetail.AlsoKnownAs[X],
        procedure(Ref: TDetailRef)
        begin
        //TODO: Translations...
          //Pages.ActivePage:= tabAltTitles;
          PagesChange(Pages);
        end);
    end;
    A('Gender', TMDBGenderToStr(FDetail.Gender));
    A('Department', FDetail.KnownForDepartment);
    A('Birthday', FormatDateTime('yyyy-mm-dd', FDetail.Birthday));
    A('Birth Place', FDetail.PlaceOfBirth);
    if FDetail.Deathday <> 0 then
      A('Deathday', FormatDateTime('yyyy-mm-dd', FDetail.Deathday));
    A('Homepage', FDetail.Homepage,
      procedure(Ref: TDetailRef)
      begin
        //Open link in browser tab...
        var F:= TabController.CreateTab(TfrmContentBrowser);
        (F.Content as TfrmContentBrowser).Navigate(FDetail.Homepage);
      end);
    A('Popularity', FormatFloat('0.000', FDetail.Popularity));
    A('ID', IntToStr(FDetail.ID));
    A('IMDB ID', FDetail.IMDBID);
    A('Profile Path', FDetail.ProfilePath,
      procedure(Ref: TDetailRef)
      begin
        //Open image in browser tab...
        var F:= TabController.CreateTab(TfrmContentBrowser);
        var U:= TMDB.Client.GetImageURL(FDetail.ProfilePath);
        (F.Content as TfrmContentBrowser).Navigate(U);
      end);

  finally
    lstDetail.Items.EndUpdate;
  end;

  //TODO: Load backdrop...
  //if BackdropPath <> '' then begin
  //  BackdropPath:= TMDB.Client.GetImageURL(BackdropPath);
  //end;

  txtOverview.Lines.Text:= FDetail.Biography;

{

    A('Tagline', FDetail.Tagline);
    if FDetail.Collection <> nil then begin
      if FDetail.Collection.BelongsToCollection then begin
        A('Collection', FDetail.Collection.Name,
          procedure(Ref: TDetailRef)
          begin
            //Movie Collection Detail
            //var F:= TabController.CreateTab(TfrmContentCollectionDetail);
            //F.LoadDetail(FDetail.Collection.ID);
          end);
      end;
    end;
    A('Popularity', FormatFloat('0.000', FDetail.Popularity));
    A('Vote Average', FormatFloat('0.000', FDetail.VoteAverage));
    A('Vote Count', IntToStr(FDetail.VoteCount));
    for X := 0 to FDetail.Genres.Count-1 do begin
      I:= A('Genre', FDetail.Genres[X].Name);
      I.Item.Indent:= 1;
    end;
    A('Release Date', FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate),
      procedure(Ref: TDetailRef)
      begin
        //Relase Dates
        Pages.ActivePage:= tabReleaseDates;
        PagesChange(Pages);
      end);
    A('Status', FDetail.Status);
    A('Budget', FormatCurr('$#,###,###,##0.00', FDetail.Budget));
    A('Revenue', FormatCurr('$#,###,###,##0.00', FDetail.Revenue));
    for X := 0 to FDetail.ProductionCompanies.Count-1 do begin
      I:= A('Production Company', FDetail.ProductionCompanies[X].Name,
        procedure(Ref: TDetailRef)
        begin
          //Company Detail
          //var F:= TabController.CreateTab(TfrmContentCompanyDetail);
          //F.LoadDetail(FDetail.ProductionCompanies[X].ID);
        end);
      I.Item.Indent:= 1;
    end;
    A('Origin Country', TMDBStrArrayToStr(FDetail.OriginalCountry));
    for X := 0 to FDetail.ProductionCountries.Count-1 do begin
      I:= A('Production Country', TMDB.CountryName(FDetail.ProductionCountries[X].ISO3166_1));
      I.Item.Indent:= 1;
    end;
    A('Original Language', TMDB.LanguageName(FDetail.OriginalLanguage));
    for X := 0 to FDetail.SpokenLanguages.Count-1 do begin
      I:= A('Spoken Language', TMDB.LanguageName(FDetail.SpokenLanguages[X].ISO639_1));
      I.Item.Indent:= 1;
    end;
    A('Homepage', FDetail.Homepage,
      procedure(Ref: TDetailRef)
      begin
        //Web Browser
        var F:= TabController.CreateTab(TfrmContentBrowser);
        (F.Content as TfrmContentBrowser).Navigate(FDetail.Homepage);
      end);
    A('Runtime', IntToStr(FDetail.Runtime));
    BackdropPath:= FDetail.BackdropPath;
    A('Backdrop Path', FDetail.BackdropPath,
      procedure(Ref: TDetailRef)
      begin
        //Image Detail
        var F:= TabController.CreateTab(TfrmContentBrowser);
        var U:= TMDB.Client.GetImageURL(FDetail.BackdropPath);
        (F.Content as TfrmContentBrowser).Navigate(U);
      end);
    A('Poster Path', FDetail.PosterPath,
      procedure(Ref: TDetailRef)
      begin
        //Image Detail
        var F:= TabController.CreateTab(TfrmContentBrowser);
        var U:= TMDB.Client.GetImageURL(FDetail.PosterPath);
        (F.Content as TfrmContentBrowser).Navigate(U);
      end);
    if FDetail.Video then
      A('Video', 'True')
    else
      A('Video', 'False');
    if FDetail.Adult then
      A('Adult', 'True')
    else
      A('Adult', 'False');
    A('ID', IntToStr(FDetail.ID));
    A('IMDB ID', FDetail.IMDBID,
      procedure(Ref: TDetailRef)
      begin
        //IMDB Movie Detail
      end);

}


end;

procedure TfrmContentPersonDetail.LoadChanges;
begin

end;

procedure TfrmContentPersonDetail.LoadCombinedCredits;
begin
  FCombinedCredits.LoadCombinedCredits(FDetail.AppendedCombinedCredits);
end;

procedure TfrmContentPersonDetail.LoadExternalIDs;
begin

end;

procedure TfrmContentPersonDetail.LoadImages;
begin
  FImages.LoadImages(FDetail.AppendedImages);
end;

procedure TfrmContentPersonDetail.LoadMovieCredits;
begin
  FMovieCredits.LoadMovieCredits(FDetail.AppendedMovieCredits);
end;

procedure TfrmContentPersonDetail.LoadTVCredits;
begin
  FTVCredits.LoadTVCredits(FDetail.AppendedTVCredits);
end;

procedure TfrmContentPersonDetail.lstDetailAdvancedCustomDraw(
  Sender: TCustomListView; const ARect: TRect; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  inherited;

  Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetSystemColor(clWindow);
  //Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scWindow); // clBlack;
  Sender.Canvas.Font.Color:= clWhite;
  Sender.Canvas.Font.Style:= [fsBold];

  //TODO: Paint backdrop...?
end;

procedure TfrmContentPersonDetail.lstDetailAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;

  Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetSystemColor(clWindow);
  //Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scWindow); // clBlack;
  Sender.Canvas.Font.Color:= clWhite;
  Sender.Canvas.Font.Style:= [fsBold];
end;

procedure TfrmContentPersonDetail.lstDetailAdvancedCustomDrawSubItem(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);

var
  I: TDetailRef;
begin
  inherited;

  Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetSystemColor(clWindow);
  //Sender.Canvas.Brush.Color:= TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scWindow); // clBlack;
  Sender.Canvas.Font.Color:= clWhite;
  Sender.Canvas.Font.Style:= [fsBold];
  if SubItem = 1 then begin
    I:= TDetailRef(Item.Data);
    if I.Clickable then begin
      Sender.Canvas.Font.Color:= clBlue;
      Sender.Canvas.Font.Style:= [fsBold,fsUnderline];
    end;

  end;

end;

procedure TfrmContentPersonDetail.lstDetailDblClick(Sender: TObject);
var
  I: TDetailRef;
begin
  inherited;
  //Execute procedure associated with corresponding detail reference...
  if lstDetail.Selected <> nil then begin
    I:= TDetailRef(lstDetail.Selected.Data);
    if Assigned(I.OnClick) then
      I.OnClick(I);
  end;
end;

procedure TfrmContentPersonDetail.PagesChange(Sender: TObject);
begin
  inherited;

  LoadTabContent;
end;

procedure TfrmContentPersonDetail.LoadTranslations;
begin

end;

procedure TfrmContentPersonDetail.LoadPerson(const Person: ITMDBPersonDetail);
begin
  Screen.Cursor:= crHourglass;
  try
    //FBackdrop.Assign(nil);
    Pages.Visible:= False;
    FDetail:= Person;
    if FDetail <> nil then begin
      TabCaption:= 'Person: '+FDetail.Title;
      Pages.Visible:= True;
      LoadTabContent;
    end else begin
      TabCaption:= 'Person Detail';
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentPersonDetail.LoadPerson(const PersonID: Integer);
begin
  Screen.Cursor:= crHourglass;
  try
    //FBackdrop.Assign(nil);
    Pages.Visible:= False;
    FDetail:= GetPersonDetail(PersonID);
    if FDetail <> nil then begin
      TabCaption:= 'Person: '+FDetail.Title;
      Pages.Visible:= True;
      LoadTabContent;
    end else begin
      TabCaption:= 'Person Detail';
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

function TfrmContentPersonDetail.EmbedFormIntoTab(AClass: TfrmCommonFormBaseClass;
  ATab: TTabSheet): TfrmCommonFormBase;
begin
  Result:= AClass.Create(ATab);
  Result.Parent:= ATab;
  Result.BorderStyle:= bsNone;
  Result.Align:= alClient;
  Result.Show;
end;

procedure TfrmContentPersonDetail.ClearDetails;
begin
  //FBackdrop.Assign(nil);
  while lstDetail.Items.Count > 0 do begin
    TDetailRef(lstDetail.Items[0].Data).Free;
    lstDetail.Items.Delete(0);
  end;
  lstDetail.Invalidate;
end;

function TfrmContentPersonDetail.EmbedFormIntoTab(AClass: TfrmContentBaseClass;
  ATab: TTabSheet): TfrmContentBase;
begin
  Result:= AClass.Create(ATab);
  Result.Parent:= ATab;
  Result.BorderStyle:= bsNone;
  Result.Align:= alClient;
  Result.Show;
end;

end.
