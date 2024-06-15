inherited frmContentGenresMovie: TfrmContentGenresMovie
  Caption = 'Movie Genres'
  PixelsPerInch = 96
  TextHeight = 18
  object Button2: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh List'
    TabOrder = 0
    OnClick = Button2Click
    ExplicitLeft = -215
    ExplicitWidth = 969
  end
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
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitLeft = -215
    ExplicitWidth = 969
    ExplicitHeight = 346
  end
end
