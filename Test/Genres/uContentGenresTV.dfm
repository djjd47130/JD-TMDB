inherited frmContentGenresTV: TfrmContentGenresTV
  Caption = 'TV Genres'
  PixelsPerInch = 96
  TextHeight = 18
  object Button3: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh List'
    TabOrder = 0
    OnClick = Button3Click
  end
  object lstGenreTV: TListView
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 748
    Height = 433
    Align = alClient
    Columns = <
      item
        Caption = 'Genre Name'
        Width = 250
      end
      item
        Caption = 'ID'
        Width = 100
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
