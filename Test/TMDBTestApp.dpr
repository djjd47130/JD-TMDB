program TMDBTestApp;

uses
  Vcl.Forms,
  uTMDBTestMain in 'uTMDBTestMain.pas' {frmTMDBTestMain},
  JD.TMDB.API in '..\Source\JD.TMDB.API.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTMDBTestMain, frmTMDBTestMain);
  Application.Run;
end.
