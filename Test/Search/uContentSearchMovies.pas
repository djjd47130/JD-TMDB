unit uContentSearchMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentPageBase, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  {$IFDEF USE_INTF}
  JD.TMDB.Intf,
  {$ENDIF}
  XSuperObject;

type
  TfrmContentSearchMovies = class(TfrmContentPageBase)
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
    Panel13: TPanel;
    Label14: TLabel;
    txtSearchMoviesPrimaryReleaseYear: TEdit;
    Panel14: TPanel;
    Label15: TLabel;
    txtSearchMoviesYear: TEdit;
    lblTitle: TLabel;
    lblReleaseDate: TLabel;
    lblGenres: TLabel;
    lblTagline: TLabel;
    txtOverview: TMemo;
  private
    {$IFDEF USE_INTF}
    FDetail: ITMDBMovieDetail;
    {$ELSE}
    FDetail: ISuperObject;
    {$ENDIF}
  protected
    procedure SetupCols; override;
    procedure PrepSearch; override;
    {$IFDEF USE_INTF}
    function GetData(const APageNum: Integer): ITMDBPage; override;
    function GetPage: ITMDBPage; override;
    function GetItem(const Index: Integer): ITMDBPageItem; override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ITMDBPageItem); override;
    {$ELSE}
    function GetData(const APageNum: Integer): ISuperObject; override;
    procedure ShowDetail(const Index: Integer; Item: TListItem; Obj: ISuperObject); override;
    procedure PopulateItem(const Index: Integer; Item: TListItem; Obj: ISuperObject); override;
    procedure ItemDblClick(const Index: Integer; Item: TListItem; Obj: ISuperObject); override;
    {$ENDIF}
    procedure HideDetail; override;
  end;

var
  frmContentSearchMovies: TfrmContentSearchMovies;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmContentSearchMovies }

procedure TfrmContentSearchMovies.PrepSearch;
begin
  inherited;
  //TODO: This should rather be fetching "Primary Translations"...
  frmTMDBTestMain.ListLanguages(cboSearchMoviesLanguage.Items);


  //TODO: Populate regions

end;

procedure TfrmContentSearchMovies.SetupCols;
begin
  inherited;
  AddCol('Movie', 400);
  AddCol('Popularity', 100);
  AddCol('Genre', 150);
  AddCol('Released', 160);
  AddCol('Description', 700);
end;

{$IFDEF USE_INTF}
function GetGenres(O: ITMDBMovieDetail): String;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to O.Genres.Count-1 do begin
    if Result <> '' then
      Result:= Result + ', ';
    Result:= Result + O.Genres[X].Name;
  end;
end;
{$ELSE}
function GetGenres(O: ISuperObject): String;
var
  X: Integer;
  A: ISuperArray;
begin
  Result:= '';
  A:= O.A['genres'];
  for X := 0 to A.Length-1 do begin
    if Result <> '' then
      Result:= Result + ', ';
    Result:= Result + A.O[X].S['name'];
  end;
end;
{$ENDIF}

{$IFDEF USE_INTF}
function TfrmContentSearchMovies.GetData(const APageNum: Integer): ITMDBPage;
begin
  Result:= API.Search.SearchMovies(txtSearchMoviesQuery.Text, cboSearchMoviesAdult.ItemIndex = 1,
    cboSearchMoviesLanguage.Text, cboSearchMoviesRegion.Text, txtSearchMoviesPrimaryReleaseYear.Text,
    txtSearchMoviesYear.Text, APageNum);
end;

function TfrmContentSearchMovies.GetItem(const Index: Integer): ITMDBPageItem;
begin
  Result:= ITMDBMovieItem(inherited GetItem(Index));
end;

function TfrmContentSearchMovies.GetPage: ITMDBPage;
begin
  Result:= ITMDBMoviePage(inherited GetPage);
end;

procedure TfrmContentSearchMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  ID: Integer;
  O: ITMDBMovieItem;
begin
  inherited;
  PrepAPI;
  O:= ITMDBMovieItem(Obj);
  ID:= O.ID;
  FDetail:= API.Movies.GetDetails(ID);

  lblTitle.Caption:= FDetail.Title;
  lblReleaseDate.Caption:= 'Release Date: '+FormatDateTime('yyyy-mm-dd', FDetail.ReleaseDate);
  lblGenres.Caption:= 'Genres: '+GetGenres(FDetail);
  txtOverview.Lines.Text:= FDetail.Overview;
  lblTagline.Caption:= FDetail.Tagline;

end;

procedure TfrmContentSearchMovies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
begin
  inherited;
  //TODO: Navigate to movie details tab...

end;

procedure TfrmContentSearchMovies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ITMDBPageItem);
var
  GenreID: Integer;
  Genre: String;
  O: ITMDBMovieItem;
begin
  inherited;
  O:= ITMDBMovieItem(Obj);
  Item.Caption:= O.Title;
  Item.SubItems.Add(FormatFloat('0.000', O.Popularity));

  GenreID:= O.Genres[0].ID;
  Genre:= frmTMDBTestMain.MovieGenreName(GenreID);
  Item.SubItems.Add(Genre);

  Item.SubItems.Add(FormatDateTime('yyyy-mm-dd', O.ReleaseDate));
  Item.SubItems.Add(O.Overview);
end;

{$ELSE}
function TfrmContentSearchMovies.GetData(const APageNum: Integer): ISuperObject;
begin
  Result:= API.Search.SearchMovies(txtSearchMoviesQuery.Text, cboSearchMoviesAdult.ItemIndex = 1,
    cboSearchMoviesLanguage.Text, txtSearchMoviesPrimaryReleaseYear.Text, PageNum,
    cboSearchMoviesRegion.Text, txtSearchMoviesYear.Text);
end;

procedure TfrmContentSearchMovies.ShowDetail(const Index: Integer;
  Item: TListItem; Obj: ISuperObject);
var
  ID: Integer;
begin
  inherited;
  PrepAPI;
  ID:= Obj.I['id'];
  FDetail:= Self.API.Movies.GetDetails(ID);

  lblTitle.Caption:= FDetail.S['title'];
  lblReleaseDate.Caption:= 'Release Date: '+FDetail.S['release_date'];
  lblGenres.Caption:= 'Genres: '+GetGenres(FDetail);
  txtOverview.Lines.Text:= FDetail.S['overview'];
  lblTagline.Caption:= FDetail.S['tagline'];

end;

procedure TfrmContentSearchMovies.ItemDblClick(const Index: Integer;
  Item: TListItem; Obj: ISuperObject);
begin
  inherited;
  //TODO: Navigate to movie details tab...

end;

procedure TfrmContentSearchMovies.PopulateItem(const Index: Integer;
  Item: TListItem; Obj: ISuperObject);
var
  GenreID: Integer;
  Genre: String;
begin
  inherited;
  Item.Caption:= Obj.S['title'];
  Item.SubItems.Add(FormatFloat('0.000', Obj.F['popularity']));

  GenreID:= Obj.A['genre_ids'].I[0];
  Genre:= frmTMDBTestMain.MovieGenreName(GenreID);

  Item.SubItems.Add(Genre);
  Item.SubItems.Add(Obj.S['release_date']);
  Item.SubItems.Add(Obj.S['overview']);
end;

{$ENDIF}

procedure TfrmContentSearchMovies.HideDetail;
begin
  inherited;
  FDetail:= nil;
end;

end.
