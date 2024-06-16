unit uContentCertsTV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls,
  JD.TMDB.Common, JD.TMDB.Intf;

type
  TfrmContentCertsTV = class(TfrmContentBase)
    lstCertsTV: TListView;
    btnRefreshCertsTV: TButton;
    procedure btnRefreshCertsTVClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentCertsTV: TfrmContentCertsTV;

implementation

{$R *.dfm}

procedure TfrmContentCertsTV.btnRefreshCertsTVClick(Sender: TObject);
var
  Y: Integer;
  C: ITMDBCertificationCountry;
  O: ITMDBCertificationItem;
  X: Integer;
  I: TListItem;
  G: TListGroup;
begin
  inherited;
  PrepAPI;
  Screen.Cursor:= crHourglass;
  try
    lstCertsTV.Items.BeginUpdate;
    try
      Self.lstCertsTV.Items.Clear;
      Self.lstCertsTV.Groups.Clear;
      for X := 0 to TMDB.Cache.TVCerts.Count-1 do begin
        C:= TMDB.Cache.TVCerts[X];
        G:= lstCertsTV.Groups.Add;
        G.Header:= TMDB.CountryName(C.CountryCode);
        for Y := 0 to C.Count-1 do begin
          O:= C[Y];
          I:= Self.lstCertsTV.Items.Add;
          I.Caption:= IntToStr(O.Order);
          I.SubItems.Add(O.Certification);
          I.SubItems.Add(O.Meaning);
          I.GroupID:= G.GroupID;
        end;
      end;
      lstCertsTV.SortType:= TSortType.stText;
      //TODO: Sort groups...
    finally
      lstCertsTV.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
