unit uCommonChanges;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls,
  JD.TMDB.Common, JD.TMDB.Intf, uContentBase;

type
  TfrmContentChanges = class(TfrmCommonFormBase)
    lstChangeKeys: TListView;
    Splitter1: TSplitter;
    pMain: TPanel;
    lstResults: TListView;
    pValues: TPanel;
    Splitter2: TSplitter;
    pValue: TPanel;
    lstValues: TListView;
    procedure FormCreate(Sender: TObject);
  private
    FChanges: ITMDBChanges;
    FMediaType: TTMDBMediaType;
  public
    procedure LoadChanges(AChanges: ITMDBChanges; const AMediaType: TTMDBMediaType);
  end;

var
  frmContentChanges: TfrmContentChanges;

implementation

{$R *.dfm}

procedure TfrmContentChanges.FormCreate(Sender: TObject);
begin
  inherited;
  pMain.Align:= alClient;
  lstResults.Align:= alClient;
  pValue.Align:= alClient;

end;

procedure TfrmContentChanges.LoadChanges(AChanges: ITMDBChanges;
  const AMediaType: TTMDBMediaType);
begin
  FChanges:= AChanges;
  FMediaType:= AMediaType;

  lstChangeKeys.Items.Clear;
  lstResults.Items.Clear;
  lstValues.Items.Clear;



end;

end.
