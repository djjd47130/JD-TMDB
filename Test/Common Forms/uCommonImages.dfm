inherited frmCommonImages: TfrmCommonImages
  Caption = 'Images'
  PixelsPerInch = 96
  TextHeight = 13
  object lstImages: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 773
    Height = 439
    Align = alClient
    Columns = <
      item
        Caption = 'Filename'
        Width = 250
      end
      item
        Caption = 'Language'
        Width = 250
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
        Width = 120
      end>
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
    GroupView = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitLeft = -126
    ExplicitWidth = 905
    ExplicitHeight = 347
  end
end
