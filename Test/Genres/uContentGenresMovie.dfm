inherited frmContentGenresMovie: TfrmContentGenresMovie
  Caption = 'Movie Genres'
  PixelsPerInch = 96
  TextHeight = 18
  object lstGenreMovies: TListView
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 748
    Height = 426
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
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Button2: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 35
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh'
    TabOrder = 1
    OnClick = Button2Click
  end
end
