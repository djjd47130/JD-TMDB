inherited frmContentSearchMovies: TfrmContentSearchMovies
  Caption = 'Search Movies'
  ClientWidth = 974
  ExplicitWidth = 990
  PixelsPerInch = 96
  TextHeight = 18
  inherited Panel11: TPanel
    Width = 709
    ExplicitLeft = 265
    ExplicitWidth = 489
    ExplicitHeight = 473
    inherited lstSearchMovies: TListView
      Width = 703
      Columns = <
        item
          Caption = 'Movie'
          Width = 250
        end
        item
          Caption = 'Popularity'
          Width = 100
        end
        item
          Caption = 'Genre'
          Width = 200
        end
        item
          Caption = 'Released'
          Width = 100
        end
        item
          Caption = 'Description'
          Width = 400
        end>
      ExplicitWidth = 703
    end
    inherited Panel12: TPanel
      Width = 709
    end
  end
  inherited Panel6: TPanel
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 8
      object Label8: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Search Query:'
        ExplicitWidth = 107
      end
      object txtSearchMoviesQuery: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 27
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 26
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 57
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label9: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Include Adult:'
        ExplicitWidth = 104
      end
      object cboSearchMoviesAdult: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'False'
        Items.Strings = (
          'False'
          'True')
      end
    end
    object Panel9: TPanel
      Left = 0
      Top = 114
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label10: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Language:'
        ExplicitWidth = 77
      end
      object cboSearchMoviesLanguage: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel10: TPanel
      Left = 0
      Top = 171
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object Label11: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Region:'
        ExplicitWidth = 57
      end
      object cboSearchMoviesRegion: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel13: TPanel
      Left = 0
      Top = 228
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object Label14: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Primary Release Year:'
        ExplicitWidth = 169
      end
      object txtSearchMoviesPrimaryReleaseYear: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 27
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 26
      end
    end
    object Panel14: TPanel
      Left = 0
      Top = 285
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object Label15: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Year:'
        ExplicitWidth = 41
      end
      object txtSearchMoviesYear: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 27
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 26
      end
    end
  end
end
