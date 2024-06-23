unit uCommonFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  JD.TMDB;

type
  TfrmCommonFormBaseClass = class of TfrmCommonFormBase;

  TfrmCommonFormBase = class(TForm)
  private
    function GetTMDB: TTMDB;
  public
    property TMDB: TTMDB read GetTMDB;
  end;

var
  frmCommonFormBase: TfrmCommonFormBase;

implementation

{$R *.dfm}

uses
  uTMDBTestMain;

{ TfrmCommonFormBase }

function TfrmCommonFormBase.GetTMDB: TTMDB;
begin
  Result:= frmTMDBTestMain.TMDB;
end;

end.
