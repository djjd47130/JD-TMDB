unit uCommonVideos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf, Vcl.ExtCtrls, WebView2, Winapi.ActiveX, Vcl.Edge,
  uContentBrowser;

type
  TfrmCommonVideos = class(TfrmCommonFormBase)
    lstVideos: TListView;
    procedure lstVideosDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FVideos: ITMDBVideos;
  public
    procedure LoadVideoList(const Videos: ITMDBVideos);
  end;

var
  frmCommonVideos: TfrmCommonVideos;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

{ TfrmCommonVideos }

procedure TfrmCommonVideos.FormCreate(Sender: TObject);
begin
  inherited;
  lstVideos.Align:= alClient;
end;

procedure TfrmCommonVideos.LoadVideoList(const Videos: ITMDBVideos);
var
  V: ITMDBVideo;
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
var
  T: TJDTabRef;
  V: ITMDBVideo;
  U: String;
begin
  inherited;
  V:= FVideos[lstVideos.ItemIndex];
  if SameText(V.Site, 'YouTube') then begin
    U:= 'https://youtube.com/watch?v='+V.Key;
  end else begin
    //TODO
  end;
  if U <> '' then begin
    T:= TabController.CreateTab(TfrmContentBrowser);
    (T.Content as TfrmContentBrowser).Navigate(U);
  end;
end;

end.
