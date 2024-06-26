program TMDBTestApp;

{$WARN DUPLICATE_CTOR_DTOR OFF}

uses
  Vcl.Forms,
  uTMDBTestMain in 'uTMDBTestMain.pas' {frmTMDBTestMain},
  JD.TMDB.API in '..\Source\JD.TMDB.API.pas',
  Vcl.Themes,
  Vcl.Styles,
  uTabBase in 'uTabBase.pas' {frmTabBase},
  uContentBase in 'uContentBase.pas' {frmContentBase},
  uTabSearch in 'Search\uTabSearch.pas' {frmTabSearch},
  uContentPageBase in 'uContentPageBase.pas' {frmContentPageBase},
  uContentSearchMovies in 'Search\uContentSearchMovies.pas' {frmContentSearchMovies},
  uTabConfiguration in 'Configuration\uTabConfiguration.pas' {frmTabConfiguration},
  uContentSearchCollections in 'Search\uContentSearchCollections.pas' {frmContentSearchCollections},
  JD.TMDB.Intf in '..\Source\JD.TMDB.Intf.pas',
  JD.TMDB.Impl in '..\Source\JD.TMDB.Impl.pas',
  JD.TMDB.Common in '..\Source\JD.TMDB.Common.pas',
  uTabGenres in 'Genres\uTabGenres.pas' {frmTabGenres},
  uContentListBase in 'uContentListBase.pas' {frmContentBase1},
  uContentGenresMovie in 'Genres\uContentGenresMovie.pas' {frmContentGenresMovie},
  uContentGenresTV in 'Genres\uContentGenresTV.pas' {frmContentGenresTV},
  JD.TMDB in '..\Source\JD.TMDB.pas',
  uTabCertifications in 'Certifications\uTabCertifications.pas' {frmTabCertifications},
  uContentCertsMovies in 'Certifications\uContentCertsMovies.pas' {frmContentCertsMovies},
  uContentCertsTV in 'Certifications\uContentCertsTV.pas' {frmContentCertsTV},
  uContentConfigCountries in 'Configuration\uContentConfigCountries.pas' {frmContentConfigCountries},
  uContentSearchCompanies in 'Search\uContentSearchCompanies.pas' {frmContentSearchCompanies},
  uTabMovies in 'Movies\uTabMovies.pas' {frmTabMovies},
  uContentMovieDetail in 'Movies\uContentMovieDetail.pas' {frmContentMovieDetail},
  uCommonFormBase in 'Common Forms\uCommonFormBase.pas' {frmCommonFormBase},
  uCommonVideos in 'Common Forms\uCommonVideos.pas' {frmCommonVideos},
  uCommonImages in 'Common Forms\uCommonImages.pas' {frmCommonImages},
  uCommonCredits in 'Common Forms\uCommonCredits.pas' {frmCommonCredits},
  JD.TMDB.LocalWebServer in 'JD.TMDB.LocalWebServer.pas',
  uContentSearchTV in 'Search\uContentSearchTV.pas' {frmContentSearchTV},
  uContentSearchPeople in 'Search\uContentSearchPeople.pas' {frmContentSearchPeople},
  uContentSearchMulti in 'Search\uContentSearchMulti.pas' {frmContentSearchMulti},
  uContentSearchKeywords in 'Search\uContentSearchKeywords.pas' {frmContentSearchKeywords},
  uLoginBrowser in 'uLoginBrowser.pas' {frmLoginBrowser};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTMDBTestMain, frmTMDBTestMain);
  Application.CreateForm(TfrmLoginBrowser, frmLoginBrowser);
  Application.Run;
end.
