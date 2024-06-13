inherited frmContentBase1: TfrmContentBase1
  Caption = 'frmContentBase1'
  PixelsPerInch = 96
  TextHeight = 18
  object lstGenreMovies: TListView
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 748
    Height = 433
    Align = alClient
    Color = clSilver
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
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitLeft = -2
  end
  object Button2: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh List'
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitTop = -2
  end
end
