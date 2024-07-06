inherited frmCommonImages: TfrmCommonImages
  Caption = 'Images'
  ClientHeight = 441
  ClientWidth = 964
  ExplicitWidth = 980
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 201
    Width = 964
    Height = 7
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
    ExplicitTop = 231
  end
  object lstImages: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 958
    Height = 195
    Align = alClient
    Columns = <
      item
        Caption = 'Filename'
        Width = 400
      end
      item
        Caption = 'Language'
        Width = 200
      end
      item
        Caption = 'Width'
        Width = 80
      end
      item
        Caption = 'Height'
        Width = 80
      end
      item
        Caption = 'Aspect Ratio'
        Width = 130
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Groups = <
      item
        Header = 'Backdrops'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Logos'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Posters'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Profiles'
        GroupID = 3
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Stills'
        GroupID = 4
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = lstImagesSelectItem
    ExplicitHeight = 234
  end
  object pDetail: TPanel
    Left = 0
    Top = 208
    Width = 964
    Height = 233
    Align = alBottom
    TabOrder = 1
    object Img: TImage
      AlignWithMargins = True
      Left = 21
      Top = 21
      Width = 922
      Height = 191
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 20
      Align = alClient
      Center = True
      Proportional = True
      Stretch = True
      ExplicitLeft = 200
      ExplicitTop = 32
      ExplicitWidth = 441
      ExplicitHeight = 97
    end
  end
end
