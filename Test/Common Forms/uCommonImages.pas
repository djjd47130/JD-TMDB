unit uCommonImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls, Vcl.ExtCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf,
  Imaging.Jpeg,
  Imaging.PngImage,
  System.NetEncoding, JD.Ctrls.ImageGrid, System.ImageList, Vcl.ImgList;

type
  TfrmCommonImages = class(TfrmCommonFormBase)
    lstImages: TListView;
    pDetail: TPanel;
    Img: TImage;
    Splitter1: TSplitter;
    ImgList: TImageList;
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
  Idx: Integer;

  procedure PopulateItem;
  begin
    I.Caption:= Img.FilePath;
    I.SubItems.Add(TMDB.LanguageName(Img.ISO639_1));
    I.SubItems.Add(IntToStr(Img.Width));
    I.SubItems.Add(IntToStr(Img.Height));
    I.SubItems.Add(FormatFloat('0.000', Img.AspectRatio));
    I.Data:= Pointer(X);
  end;

  function AddImage(const AImg: ITMDBMediaImage; const ASize: String = 'Original'): Integer;
  var
    B64: WideString;
    S: TStringStream;
    Enc: TBase64Encoding;
    ImgBitmap: TBitmap;
    P: TPicture;
    SrcWidth, SrcHeight, DestWidth, DestHeight, XOffset, YOffset: Integer;
  begin
    if AImg.GetImage(B64, ASize) then
    begin
      Enc := TBase64Encoding.Create(0);
      try
        B64 := Enc.Decode(B64);
        S := TStringStream.Create(B64);
        try
          S.Position := 0;
          P := TPicture.Create;
          try
            P.LoadFromStream(S);

            // Create a bitmap matching the image list size
            ImgBitmap := TBitmap.Create;
            try
              ImgBitmap.SetSize(ImgList.Width, ImgList.Height);
              ImgBitmap.Canvas.FillRect(Rect(0, 0, ImgBitmap.Width, ImgBitmap.Height)); // Clear the background

              // Determine proportional size
              SrcWidth := P.Width;
              SrcHeight := P.Height;
              if (SrcWidth / SrcHeight) > (ImgList.Width / ImgList.Height) then
              begin
                DestWidth := ImgList.Width;
                DestHeight := Round(SrcHeight * (ImgList.Width / SrcWidth));
              end
              else
              begin
                DestHeight := ImgList.Height;
                DestWidth := Round(SrcWidth * (ImgList.Height / SrcHeight));
              end;

              // Calculate centering offsets
              XOffset := (ImgList.Width - DestWidth) div 2;
              YOffset := (ImgList.Height - DestHeight) div 2;

              // Stretch and center the image
              ImgBitmap.Canvas.StretchDraw(Rect(XOffset, YOffset, XOffset + DestWidth, YOffset + DestHeight), P.Graphic);

              // Add to image list
              ImgList.Add(ImgBitmap, nil);
              Result := ImgList.Count - 1;

            finally
              ImgBitmap.Free;
            end;

          finally
            P.Free;
          end;
        finally
          S.Free;
        end;
      finally
        Enc.Free;
      end;
    end else
      raise Exception.Create('Failed to fetch image.');
  end;

begin
  FImages:= Images;

  ImgList.Clear;

  lstImages.Items.BeginUpdate;
  try
    lstImages.Items.Clear;

    L:= FImages.Backdrops;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 0;
      PopulateItem;
      Idx:= AddImage(Img, 'w300');
      I.ImageIndex:= Idx;
    end;

    L:= FImages.Logos;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 1;
      PopulateItem;
      Idx:= AddImage(Img, 'w45');
      I.ImageIndex:= Idx;
    end;

    L:= FImages.Posters;
    for X := 0 to L.Count-1 do begin
      Img:= L[X];
      I:= lstImages.Items.Add;
      I.GroupID:= 2;
      PopulateItem;
      Idx:= AddImage(Img, 'w92');
      I.ImageIndex:= Idx;
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
