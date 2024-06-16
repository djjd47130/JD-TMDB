unit uContentCertsMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls, Vcl.StdCtrls,
  JD.TMDB.Common, JD.TMDB.Intf;

type
  TfrmContentCertsMovies = class(TfrmContentBase)
    btnRefreshCertsMovies: TButton;
    lstCertsMovies: TListView;
    procedure btnRefreshCertsMoviesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentCertsMovies: TfrmContentCertsMovies;

implementation

{$R *.dfm}

procedure TfrmContentCertsMovies.btnRefreshCertsMoviesClick(Sender: TObject);
var
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  X, Y: Integer;
  I: TListItem;
  G: TListGroup;
begin
  inherited;
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstCertsMovies.Items.BeginUpdate;
    lstCertsMovies.Groups.BeginUpdate;
    try
      lstCertsMovies.Items.Clear;
      lstCertsMovies.Groups.Clear;

      for X := 0 to TMDB.Cache.MovieCerts.Count-1 do begin
        C:= TMDB.Cache.MovieCerts[X];
        G:= lstCertsMovies.Groups.Add;
        G.Header:= TMDB.CountryName(C.CountryCode);
        for Y := 0 to C.Count-1 do begin
          O:= C[Y];
          I:= lstCertsMovies.Items.Add;
          I.Caption:= IntToStr(O.Order);
          I.SubItems.Add(O.Certification);
          I.SubItems.Add(O.Meaning);
          I.GroupID:= G.GroupID;
        end;
        C:= nil;
      end;

      lstCertsMovies.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstCertsMovies.Groups.EndUpdate;
      lstCertsMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
