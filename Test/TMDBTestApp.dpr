program TMDBTestApp;

{$WARN DUPLICATE_CTOR_DTOR OFF}

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  JD.TMDB.API in '..\Source\JD.TMDB.API.pas',
  Vcl.Themes,
  Vcl.Styles,
  uContentBase in 'uContentBase.pas' {frmContentBase},
  uContentPageBase in 'uContentPageBase.pas' {frmContentPageBase},
  uContentSearchMovies in 'Search\uContentSearchMovies.pas' {frmContentSearchMovies},
  uContentSearchCollections in 'Search\uContentSearchCollections.pas' {frmContentSearchCollections},
  JD.TMDB.Intf in '..\Source\JD.TMDB.Intf.pas',
  JD.TMDB.Impl in '..\Source\JD.TMDB.Impl.pas',
  JD.TMDB.Common in '..\Source\JD.TMDB.Common.pas',
  uContentListBase in 'uContentListBase.pas' {frmContentBase1},
  uContentGenresMovie in 'Genres\uContentGenresMovie.pas' {frmContentGenresMovie},
  uContentGenresTV in 'Genres\uContentGenresTV.pas' {frmContentGenresTV},
  JD.TMDB in '..\Source\JD.TMDB.pas',
  uContentCertsMovies in 'Certifications\uContentCertsMovies.pas' {frmContentCertsMovies},
  uContentCertsTV in 'Certifications\uContentCertsTV.pas' {frmContentCertsTV},
  uContentConfigCountries in 'Configuration\uContentConfigCountries.pas' {frmContentConfigCountries},
  uContentSearchCompanies in 'Search\uContentSearchCompanies.pas' {frmContentSearchCompanies},
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
  uLoginBrowser in 'uLoginBrowser.pas' {frmLoginBrowser},
  uCommonReviews in 'Common Forms\uCommonReviews.pas' {frmCommonReviews},
  uCommonAlternativeTitles in 'Common Forms\uCommonAlternativeTitles.pas' {frmCommonAlternativeTitles},
  uContentConfigLanguages in 'Configuration\uContentConfigLanguages.pas' {frmContentConfigLanguages},
  uContentTVSerieDetail in 'TVSeries\uContentTVSerieDetail.pas' {frmContentTVSerieDetail},
  JD.TabController in 'JD.TabController.pas',
  uTMDBHome in 'uTMDBHome.pas' {frmTMDBHome},
  uTMDBAppSetup in 'uTMDBAppSetup.pas' {frmTMDBAppSetup};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
