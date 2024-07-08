unit uCommonVideos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf, Vcl.ExtCtrls, WebView2, Winapi.ActiveX, Vcl.Edge,
  Clipbrd;

type
  TfrmCommonVideos = class(TfrmCommonFormBase)
    lstVideos: TListView;
    Panel1: TPanel;
    Edge: TEdgeBrowser;
    Splitter1: TSplitter;
    procedure lstVideosDblClick(Sender: TObject);
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
  uMain;

{ TfrmCommonVideos }

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
  V: ITMDBVideo;
  U: String;
  function GetLocalBaseURL: String;
  begin
    Result:= 'http://localhost:'+IntToStr(frmMain.WebServer.Port);
  end;
begin
  inherited;
  //TODO: Open video in default browser, OR embedded...
  V:= FVideos[lstVideos.ItemIndex];
  Edge.ReinitializeWebView;
  if SameText(V.Site, 'YouTube') then begin
    U:= URLCombine('youtube', V.Key);
  end else begin
    //TODO
  end;
  if U <> '' then begin
    U:= URLCombine(GetLocalBaseURL, U);
    Edge.Navigate(U);
  end;
end;

end.
