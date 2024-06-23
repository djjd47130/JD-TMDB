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

function EmbedYouTubeHTML(const Key: String): String;
//var
  //L: TStringList;
  procedure A(const S: String);
  begin
    //L.Append(S);
    Result:= Result + S + ' ';
  end;
begin
  //L:= TStringList.Create;
  try

    //{
    A('<html>');
    A('<head>');
    A('<title>');
    A('YouTube Video');
    A('</title>');
    A('</head>');
    A('<body>');
    //}

    A('<iframe width="420" height="315"');
    A('src="https://www.youtube.com/embed/'+Key+'">');
    A('</iframe>');

    //{
    A('</body>');
    A('</html>');
    //}

    //Result:= L.Text;
  finally
    //L.Free;
  end;
end;

procedure TfrmCommonVideos.lstVideosDblClick(Sender: TObject);
var
  V: ITMDBVideoItem;
  HTML: String;
begin
  inherited;
  //TODO: Open video in default browser, OR embedded...
  V:= FVideos[lstVideos.ItemIndex];

  if SameText(V.Site, 'YouTube') then begin
    HTML:= EmbedYouTubeHTML(V.Key);
  end else begin
    //TODO
  end;

  Clipboard.AsText:= HTML;


  Edge.ReinitializeWebView;
  Edge.Navigate('https://www.youtube.com/watch?v='+V.Key);
  //Edge.NavigateToString(HTML);


end;

end.
