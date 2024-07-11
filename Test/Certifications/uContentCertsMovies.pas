unit uContentCertsMovies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.ComCtrls, Vcl.StdCtrls,
  JD.TMDB.Common, JD.TMDB.Intf, Vcl.ExtCtrls;

type
  TfrmContentCertsMovies = class(TfrmContentBase)
    lstCertsMovies: TListView;
    Panel1: TPanel;
    cboCountry: TComboBox;
    btnRefreshCertsMovies: TButton;
    procedure btnRefreshCertsMoviesClick(Sender: TObject);
    procedure cboCountryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCerts: ITMDBCertificationCountries;
    procedure RefreshDetails;
    function SelectedCountry: ITMDBCertificationCountry;
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
  X: Integer;
  SelCountry: String;
begin
  inherited;
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    FCerts:= TMDB.Cache.MovieCerts;
    lstCertsMovies.Items.BeginUpdate;
    try
      SelCountry:= cboCountry.Text;
      lstCertsMovies.Items.Clear;
      cboCountry.Items.Clear;
      for X := 0 to FCerts.Count-1 do begin
        C:= FCerts[X];
        cboCountry.Items.Add(TMDB.CountryName(C.CountryCode));
      end;
      if SelCountry <> '' then
        cboCountry.ItemIndex:= cboCountry.Items.IndexOf(SelCountry)
      else
        cboCountry.ItemIndex:= 0;
      RefreshDetails;
    finally
      lstCertsMovies.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmContentCertsMovies.cboCountryClick(Sender: TObject);
begin
  inherited;
  RefreshDetails;
end;

procedure TfrmContentCertsMovies.FormCreate(Sender: TObject);
begin
  inherited;
  FCerts:= nil;
end;

procedure TfrmContentCertsMovies.FormDestroy(Sender: TObject);
begin
  inherited;
  FCerts:= nil;
end;

procedure TfrmContentCertsMovies.FormShow(Sender: TObject);
begin
  inherited;
  btnRefreshCertsMoviesClick(nil);
end;

procedure TfrmContentCertsMovies.RefreshDetails;
var
  C: ITMDBCertificationCountry;
  Y: Integer;
  O: ITMDBCertification;
  I: TListItem;
begin
  lstCertsMovies.Items.Clear;
  C:= SelectedCountry;
  if C = nil then Exit;
  for Y := 0 to C.Count-1 do begin
    O:= C[Y];
    I:= lstCertsMovies.Items.Add;
    I.Caption:= IntToStr(O.Order);
    I.SubItems.Add(O.Certification);
    I.SubItems.Add(O.Meaning);
  end;
  lstCertsMovies.SortType:= TSortType.stText;
end;

function TfrmContentCertsMovies.SelectedCountry: ITMDBCertificationCountry;
begin
  Result:= FCerts.Items[cboCountry.ItemIndex];
end;

end.
