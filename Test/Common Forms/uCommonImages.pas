unit uCommonImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmCommonImages = class(TfrmCommonFormBase)
    lstImages: TListView;
  private
    FImages: ITMDBMediaImages;
  public
    procedure LoadImages(const Images: ITMDBMediaImages);
  end;

var
  frmCommonImages: TfrmCommonImages;

implementation

{$R *.dfm}

{ TfrmCommonImages }

procedure TfrmCommonImages.LoadImages(const Images: ITMDBMediaImages);
var
  L: ITMDBMediaImageList;
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

end.
