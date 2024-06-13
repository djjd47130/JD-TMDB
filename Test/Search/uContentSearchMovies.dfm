inherited frmContentSearchMovies: TfrmContentSearchMovies
  Caption = 'Search Movies'
  ClientHeight = 523
  ClientWidth = 991
  OnCreate = nil
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1007
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    Width = 726
    Height = 523
    ExplicitWidth = 709
    inherited lstResults: TListView
      Width = 720
      Height = 182
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
      ExplicitHeight = 189
    end
    inherited pFooter: TPanel
      Top = 188
      Width = 726
      ExplicitTop = 223
      ExplicitWidth = 709
      inherited btnPagePrev: TButton
        OnClick = btnPagePrevClick
      end
      inherited btnPageNext: TButton
        OnClick = btnPageNextClick
      end
    end
    inherited pDetail: TPanel
      Top = 220
      Width = 726
      Height = 303
      ExplicitTop = 198
      ExplicitWidth = 709
      ExplicitHeight = 303
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 724
        Height = 301
        ActivePage = TabSheet1
        Align = alClient
        MultiLine = True
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Detail'
          ExplicitTop = 52
          ExplicitHeight = 245
          object lblTitle: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 29
            Align = alTop
            AutoSize = False
            Caption = 'Movie Title'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 6
            ExplicitTop = 11
            ExplicitWidth = 693
          end
          object lblReleaseDate: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 38
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Release Date'
            ExplicitLeft = 16
            ExplicitTop = 64
            ExplicitWidth = 99
          end
          object lblGenres: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 86
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Genres'
            ExplicitLeft = 16
            ExplicitTop = 88
            ExplicitWidth = 53
          end
          object lblTagline: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 62
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Tagline'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 4
            ExplicitTop = 39
            ExplicitWidth = 701
          end
          object txtOverview: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 110
            Width = 710
            Height = 105
            Align = alTop
            BorderStyle = bsNone
            Color = clBtnFace
            Lines.Strings = (
              'txtOverview')
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Account States'
          ImageIndex = 1
          ExplicitTop = 52
          ExplicitHeight = 245
          object lblFavorite: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Favorite'
            ExplicitLeft = 6
            ExplicitTop = 11
            ExplicitWidth = 693
          end
          object lblWatchlist: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 27
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Watchlist'
            ExplicitTop = 91
            ExplicitWidth = 693
          end
          object lblRating: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 51
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Rating'
            ExplicitTop = 123
            ExplicitWidth = 693
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Alternative Titles'
          ImageIndex = 2
          ExplicitTop = 52
          ExplicitHeight = 245
          object ListView1: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 216
            Align = alClient
            Columns = <
              item
                Caption = 'Title'
                Width = 250
              end
              item
                Caption = 'Country'
                Width = 250
              end>
            TabOrder = 0
            ViewStyle = vsReport
            ExplicitLeft = 6
            ExplicitTop = 6
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Changes'
          ImageIndex = 3
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet5: TTabSheet
          Caption = 'Credits'
          ImageIndex = 4
          ExplicitTop = 52
          ExplicitHeight = 245
          object lstCredits: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 216
            Align = alClient
            Columns = <
              item
                Caption = 'Name'
                Width = 250
              end
              item
                Caption = 'Role'
                Width = 250
              end>
            Groups = <
              item
                Header = 'Cast'
                GroupID = 0
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
              end
              item
                Header = 'Crew'
                GroupID = 1
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
              end>
            GroupView = True
            TabOrder = 0
            ViewStyle = vsReport
            ExplicitLeft = 163
            ExplicitTop = 83
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'External IDs'
          ImageIndex = 5
          ExplicitTop = 52
          ExplicitHeight = 245
          object lblIMDB: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'IMDB'
            ExplicitLeft = 6
            ExplicitTop = 11
            ExplicitWidth = 693
          end
          object lblWikidata: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 27
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Wikidata'
            ExplicitLeft = 19
            ExplicitTop = 75
            ExplicitWidth = 693
          end
          object lblFacebook: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 51
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Facebook'
            ExplicitLeft = 19
            ExplicitTop = 107
            ExplicitWidth = 693
          end
          object lblInstagram: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 75
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Instagram'
            ExplicitLeft = 19
            ExplicitTop = 147
            ExplicitWidth = 693
          end
          object lblTwitter: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 99
            Width = 710
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Twitter'
            ExplicitLeft = 27
            ExplicitTop = 155
            ExplicitWidth = 693
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Images'
          ImageIndex = 6
          ExplicitTop = 52
          ExplicitHeight = 245
          object ListView2: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 710
            Height = 216
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
            TabOrder = 0
            ViewStyle = vsReport
            ExplicitLeft = 35
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Keywords'
          ImageIndex = 7
          ExplicitTop = 52
          ExplicitHeight = 245
          object lstKeywords: TListBox
            Left = 0
            Top = 0
            Width = 217
            Height = 222
            Align = alLeft
            ItemHeight = 18
            TabOrder = 0
            ExplicitHeight = 245
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Lists'
          ImageIndex = 8
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet10: TTabSheet
          Caption = 'Recommendations'
          ImageIndex = 9
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet11: TTabSheet
          Caption = 'Release Dates'
          ImageIndex = 10
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet12: TTabSheet
          Caption = 'Reviews'
          ImageIndex = 11
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet13: TTabSheet
          Caption = 'Similar'
          ImageIndex = 12
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet14: TTabSheet
          Caption = 'Translations'
          ImageIndex = 13
          ExplicitTop = 52
          ExplicitHeight = 245
        end
        object TabSheet15: TTabSheet
          Caption = 'Videos'
          ImageIndex = 14
          ExplicitTop = 52
          ExplicitHeight = 245
        end
      end
    end
  end
  inherited pSearch: TPanel
    Height = 523
    inherited btnApply: TButton
      Top = 494
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
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
