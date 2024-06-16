inherited frmContentConfigCountries: TfrmContentConfigCountries
  Caption = 'Countries'
  ClientWidth = 911
  ExplicitWidth = 927
  PixelsPerInch = 96
  TextHeight = 18
  object lstCountries: TListView
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 905
    Height = 433
    Align = alClient
    Columns = <
      item
        Caption = 'Code'
        Width = 80
      end
      item
        Caption = 'English Name'
        Width = 250
      end
      item
        Caption = 'Native Name'
        Width = 250
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 748
  end
  object Button2: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 905
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh List'
    TabOrder = 1
    OnClick = Button2Click
    ExplicitWidth = 748
  end
end
