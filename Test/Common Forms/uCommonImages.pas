unit uCommonImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  Imaging.Jpeg,
  Imaging.PngImage,
  System.NetEncoding;

type
  TfrmCommonImages = class(TfrmCommonFormBase)
    lstImages: TListView;
    pDetail: TPanel;
    Img: TImage;
    Splitter1: TSplitter;
    procedure lstImagesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    FImages: ITMDBMediaImageGroup;
    FImage: ITMDBMediaImage;
  public
    procedure LoadImages(const Images: ITMDBMediaImageGroup);
  end;

var
  frmCommonImages: TfrmCommonImages;

implementation

{$R *.dfm}

{ TfrmCommonImages }

procedure TfrmCommonImages.LoadImages(const Images: ITMDBMediaImageGroup);
var
  L: ITMDBMediaImages;
  Img: ITMDBMediaImage;
  I: TListItem;
  X: Integer;
  procedure PopulateItem;
  begin
    I.Caption:= Img.FilePath;
    I.SubItems.Add(TMDB.LanguageName(Img.ISO639_1));
    I.SubItems.Add(IntToStr(Img.Width));
    I.SubItems.Add(IntToStr(Img.Height));
    I.SubItems.Add(FormatFloat('0.000', Img.AspectRatio));
    I.Data:= Pointer(X);
  end;
begin
  FImages:= Images;
  lstImages.Items.BeginUpdate;
  try
    lstImages.Items.Clear;

    L:= FImages.Backdrops;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 0;
      PopulateItem;
    end;

    L:= FImages.Logos;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 1;
      PopulateItem;
    end;

    L:= FImages.Posters;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 2;
      PopulateItem;
    end;

  finally
    lstImages.Items.EndUpdate;
  end;
end;

procedure TfrmCommonImages.lstImagesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  L: ITMDBMediaImages;
  B64: WideString;
  S: TStringStream;
  Enc: TBase64Encoding;
begin
  inherited;
  Img.Picture.Assign(nil);
  if Selected then begin
    case Item.GroupID of
      0: L:= FImages.Backdrops;
      1: L:= FImages.Logos;
      2: L:= FImages.Posters;
      3: L:= FImages.Profiles;
      4: L:= FImages.Stills;
    end;
    FImage:= L[Integer(Item.Data)];
    if FImage.GetImage(B64) then begin
      Enc:= TBase64Encoding.Create(0);
      try
        B64:= Enc.Decode(B64);
        S:= TStringStream.Create(B64);
        try
          S.Position:= 0;
          Img.Picture.LoadFromStream(S);
        finally
          S.Free;
        end;
      finally
        Enc.Free;
      end;
    end else begin
      raise Exception.Create('Failed to fetch image.');
    end;

  end else begin
    FImage:= nil;
  end;
end;

end.
