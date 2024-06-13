program TMDBTestApp;

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
  uTabGenres in 'Genres\uTabGenres.pas' {frmTabBase1},
  uContentListBase in 'uContentListBase.pas' {frmContentBase1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TfrmTMDBTestMain, frmTMDBTestMain);
  Application.CreateForm(TfrmTabBase1, frmTabBase1);
  Application.CreateForm(TfrmContentBase1, frmContentBase1);
  Application.Run;
end.
