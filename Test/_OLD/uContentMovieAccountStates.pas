unit uContentMovieAccountStates;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.StdCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  JD.Graphics,
  Vcl.ExtCtrls;

type
  TfrmContentMovieAccountStates = class(TfrmContentBase)
    lblRating: TLabel;
    btnFavorite: TJDFontButton;
    btnWatchlist: TJDFontButton;
    pTop: TPanel;
    Label1: TLabel;
    txtID: TEdit;
    btnSearch: TJDFontButton;
    procedure btnSearchClick(Sender: TObject);
  private
    FObj: ITMDBAccountStates;
  public
    procedure LoadByID(const MovieID: Integer);
    procedure Load(AObj: ITMDBAccountStates);
  end;

var
  frmContentMovieAccountStates: TfrmContentMovieAccountStates;

implementation

{$R *.dfm}

{ TfrmContentMovieAccountStates }

procedure TfrmContentMovieAccountStates.btnSearchClick(Sender: TObject);
var
  ID: Integer;
begin
  inherited;
  ID:= StrToIntDef(txtID.Text, 0);
  if ID < 1 then
    raise Exception.Create('Please enter a valid movie ID.');
  LoadByID(ID);
end;

procedure TfrmContentMovieAccountStates.Load(AObj: ITMDBAccountStates);
begin
  FObj:= AObj;
  if FObj.Favorite then begin
    btnFavorite.Text:= 'Remove from Favorites';
    btnFavorite.Image.Text:= '';
    btnFavorite.Image.StandardColor:= fcRed;
    btnFavorite.Tag:= 1;
  end else begin
    btnFavorite.Text:= 'Add to Favorites';
    btnFavorite.Image.Text:= '';
    btnFavorite.Image.StandardColor:= fcBlue;
    btnFavorite.Tag:= 0;
  end;

  if FObj.Watchlist then begin
    btnWatchlist.Text:= 'Remove from Watchlist';
    btnWatchlist.Image.Text:= '';
    btnWatchlist.Image.StandardColor:= fcRed;
    btnWatchlist.Tag:= 1;
  end else begin
    btnWatchlist.Text:= 'Add to Watchlist';
    btnWatchlist.Image.Text:= '';
    btnWatchlist.Image.StandardColor:= fcBlue;
    btnWatchlist.Tag:= 0;
  end;

  lblRating.Caption:= 'Rating: '+FormatFloat('0.0', FObj.RatedValue);
end;

procedure TfrmContentMovieAccountStates.LoadByID(const MovieID: Integer);
begin
  FObj:= TMDB.Client.Movies.GetAccountStates(MovieID, TMDB.LoginState.SessionID);
  Load(FObj);
end;

end.
