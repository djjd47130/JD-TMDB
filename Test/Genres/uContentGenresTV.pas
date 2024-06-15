unit uContentGenresTV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase,
  JD.TMDB.Common,
  JD.TMDB.Intf, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmContentGenresTV = class(TfrmContentBase)
    Button3: TButton;
    lstGenreTV: TListView;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentGenresTV: TfrmContentGenresTV;

implementation

{$R *.dfm}

procedure TfrmContentGenresTV.Button3Click(Sender: TObject);
var
  G: ITMDBGenreItem;
  X: Integer;
  I: TListItem;
begin
  inherited;
  PrepAPI;
  Screen.Cursor:= crHourglass;              
  try
    lstGenreTV.Items.BeginUpdate;
    try
      lstGenreTV.Items.Clear;
      lstGenreTV.Groups.Clear;
      for X := 0 to API.Cache.TVGenres.Count-1 do begin
        G:= API.Cache.TVGenres[X];
        I:= lstGenreTV.Items.Add;
        I.Caption:= G.Name;
        I.SubItems.Add(IntToStr(G.ID));
      end;
      lstGenreTV.SortType:= TSortType.stText;
    finally
      lstGenreTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
