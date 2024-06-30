unit uContentGenresMovie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls, Vcl.StdCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf, Vcl.ExtCtrls;

type
  TfrmContentGenresMovie = class(TfrmContentBase)
    lstGenreMovies: TListView;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentGenresMovie: TfrmContentGenresMovie;

implementation

{$R *.dfm}

procedure TfrmContentGenresMovie.Button2Click(Sender: TObject);
var
  L: ITMDBGenres;
  G: ITMDBGenre;
  X: Integer;
  I: TListItem;
begin
  inherited;
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstGenreMovies.Items.BeginUpdate;
    try
      lstGenreMovies.Items.Clear;
      L:= TMDB.Cache.MovieGenres;
      for X := 0 to L.Count-1 do begin
        G:= L[X];
        I:= lstGenreMovies.Items.Add;
        I.Caption:= G.Name;
        I.SubItems.Add(IntToStr(G.ID));
      end;
      G:= nil;
      lstGenreMovies.SortType:= TSortType.stText;
    finally
      lstGenreMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
