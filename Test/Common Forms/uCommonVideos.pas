unit uCommonVideos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmCommonVideos = class(TfrmCommonFormBase)
    lstVideos: TListView;
    procedure lstVideosDblClick(Sender: TObject);
  private
    FVideos: ITMDBVideoList;
  public
    procedure LoadVideoList(const Videos: ITMDBVideoList);
  end;

var
  frmCommonVideos: TfrmCommonVideos;

implementation

{$R *.dfm}

{ TfrmCommonVideos }

procedure TfrmCommonVideos.LoadVideoList(const Videos: ITMDBVideoList);
var
  V: ITMDBVideoItem;
  X: Integer;
  I: TListItem;
begin
  FVideos:= Videos;
  lstVideos.Items.BeginUpdate;
  try
    lstVideos.Items.Clear;
    for X := 0 to FVideos.Count-1 do begin
      V:= FVideos[X];
      I:= lstVideos.Items.Add;
      I.Caption:= V.Name;
      I.SubItems.Add(V.Site);
      I.SubItems.Add(V.VideoType);
      I.SubItems.Add(FormatDateTime('yyyy-mm-dd', V.PublishedAt));
    end;
  finally
    lstVideos.Items.EndUpdate;
  end;
end;

procedure TfrmCommonVideos.lstVideosDblClick(Sender: TObject);
begin
  inherited;
  //TODO: Open video in default browser, OR embedded...

end;

end.
