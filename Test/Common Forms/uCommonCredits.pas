unit uCommonCredits;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmCommonCredits = class(TfrmCommonFormBase)
    lstCredits: TListView;
  private
    FCredits: ITMDBCredits;
  public
    procedure LoadCredits(const Credits: ITMDBCredits);
  end;

var
  frmCommonCredits: TfrmCommonCredits;

implementation

{$R *.dfm}

{ TfrmCommonCredits }

procedure TfrmCommonCredits.LoadCredits(const Credits: ITMDBCredits);
var
  Ca: ITMDBCastItem;
  Cr: ITMDBCrewItem;
  X: Integer;
  I: TListItem;
begin
  FCredits:= Credits;
  lstCredits.Items.BeginUpdate;
  try
    lstCredits.Items.Clear;

    for X := 0 to FCredits.Cast.Count-1 do begin
      Ca:= FCredits.Cast[X];
      I:= lstCredits.Items.Add;
      I.GroupID:= 0;
      I.Caption:= Ca.Title;
      I.SubItems.Add(Ca.Character);
    end;

    for X := 0 to FCredits.Crew.Count-1 do begin
      Cr:= FCredits.Crew[X];
      I:= lstCredits.Items.Add;
      I.GroupID:= 1;
      I.Caption:= Cr.Title;
      I.SubItems.Add(Cr.Job);
    end;

  finally
    lstCredits.Items.EndUpdate;
  end;
end;

end.
