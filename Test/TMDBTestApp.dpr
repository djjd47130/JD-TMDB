program TMDBTestApp;

uses
  Vcl.Forms,
  uTMDBTestMain in 'uTMDBTestMain.pas' {frmTMDBTestMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTMDBTestMain, frmTMDBTestMain);
  Application.Run;
end.
