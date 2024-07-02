inherited frmCommonImages: TfrmCommonImages
  Caption = 'Images'
  ClientHeight = 504
  ClientWidth = 964
  ExplicitWidth = 980
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 13
  object lstImages: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 958
    Height = 498
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
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
  end
end
