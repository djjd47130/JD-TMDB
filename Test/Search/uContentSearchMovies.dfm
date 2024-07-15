inherited frmContentSearchMovies: TfrmContentSearchMovies
  Caption = 'Search Movies'
  ClientWidth = 1000
  ExplicitWidth = 1016
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    Width = 735
    ExplicitWidth = 735
    inherited Splitter1: TSplitter
      Top = 32
      Width = 735
      Align = alTop
      Beveled = False
      Visible = True
      ExplicitLeft = -16
      ExplicitTop = 443
      ExplicitWidth = 735
    end
    inherited lstResults: TListView
      Top = 42
      Width = 729
      Height = 411
      Columns = <
        item
          Caption = 'Movie'
          Width = 300
        end
        item
          Caption = 'Popularity'
          Width = 100
        end
        item
          Caption = 'Genre'
          Width = 170
        end
        item
          Caption = 'Released'
          Width = 120
        end
        item
          Caption = 'Description'
          Width = 500
        end>
      ExplicitTop = 42
      ExplicitWidth = 729
      ExplicitHeight = 411
    end
    inherited pTop: TPanel
      Width = 735
      ExplicitWidth = 735
      inherited btnRefresh: TJDFontButton
        Left = 691
        ExplicitLeft = 691
        ExplicitTop = 3
        ExplicitHeight = 26
      end
    end
    inherited pDetail: TPanel
      Top = 456
      Width = 735
      Height = 44
      Visible = True
      ExplicitTop = 456
      ExplicitWidth = 735
      ExplicitHeight = 44
    end
  end
  inherited pSearch: TPanel
    object Panel7: TPanel [0]
      Left = 0
      Top = 0
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
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
    object Panel8: TPanel [1]
      Left = 0
      Top = 57
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
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
        Text = 'Default'
        Items.Strings = (
          'Default'
          'False'
          'True')
      end
    end
    object Panel10: TPanel [2]
      Left = 0
      Top = 114
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
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
    object Panel13: TPanel [3]
      Left = 0
      Top = 171
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
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
    object Panel14: TPanel [4]
      Left = 0
      Top = 228
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
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
    inherited btnApply: TJDFontButton
      TabOrder = 5
    end
  end
end
