inherited frmContentSearchMovies: TfrmContentSearchMovies
  Caption = 'Search Movies'
  ClientHeight = 561
  ClientWidth = 1034
  ExplicitWidth = 1050
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    Width = 769
    Height = 561
    ExplicitWidth = 769
    ExplicitHeight = 561
    inherited Splitter1: TSplitter
      Top = 251
      Width = 769
      ExplicitTop = 253
      ExplicitWidth = 769
    end
    inherited lstResults: TListView
      Width = 763
      Height = 213
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
      ExplicitWidth = 763
      ExplicitHeight = 213
    end
    inherited pTop: TPanel
      Width = 769
      ExplicitWidth = 769
    end
    inherited pDetail: TPanel
      Top = 258
      Width = 769
      Height = 303
      ExplicitTop = 258
      ExplicitWidth = 769
      ExplicitHeight = 303
      object Pages: TPageControl
        Left = 0
        Top = 0
        Width = 769
        Height = 303
        ActivePage = TabSheet1
        Align = alClient
        MultiLine = True
        TabOrder = 0
        OnChange = PagesChange
        object TabSheet1: TTabSheet
          Caption = 'Detail'
          object lblTitle: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
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
            Width = 755
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
            Width = 755
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
            Width = 755
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
            Width = 755
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
          object lblRating: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 18
            Align = alTop
            AutoSize = False
            Caption = 'Rating'
            ExplicitTop = 123
            ExplicitWidth = 693
          end
          object btnFavorite: TJDFontButton
            AlignWithMargins = True
            Left = 3
            Top = 27
            Width = 755
            Height = 38
            Cursor = crHandPoint
            Align = alTop
            DrawStyle = fdTransparent
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            Image.AutoSize = False
            Image.Text = #61578
            Image.Font.Charset = DEFAULT_CHARSET
            Image.Font.Color = clWindowText
            Image.Font.Height = -21
            Image.Font.Name = 'FontAwesome'
            Image.Font.Style = []
            Image.Font.Quality = fqAntialiased
            Image.StandardColor = fcRed
            Overlay.Text = #57715
            Overlay.Font.Charset = DEFAULT_CHARSET
            Overlay.Font.Color = clWindowText
            Overlay.Font.Height = -7
            Overlay.Font.Name = 'FontAwesome'
            Overlay.Font.Style = []
            Overlay.Font.Quality = fqAntialiased
            Overlay.Position = foNone
            Overlay.Margin = 3
            Margin = 8
            Spacing = 8
            SubTextFont.Charset = DEFAULT_CHARSET
            SubTextFont.Color = clGray
            SubTextFont.Height = -11
            SubTextFont.Name = 'Tahoma'
            SubTextFont.Style = []
            TabOrder = 0
            Text = 'Add to Favorites'
            OnClick = btnFavoriteClick
          end
          object btnWatchlist: TJDFontButton
            AlignWithMargins = True
            Left = 3
            Top = 71
            Width = 755
            Height = 38
            Cursor = crHandPoint
            Align = alTop
            DrawStyle = fdTransparent
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            Image.AutoSize = False
            Image.Text = #61591
            Image.Font.Charset = DEFAULT_CHARSET
            Image.Font.Color = clWindowText
            Image.Font.Height = -21
            Image.Font.Name = 'FontAwesome'
            Image.Font.Style = []
            Image.Font.Quality = fqAntialiased
            Image.StandardColor = fcRed
            Overlay.Text = #57715
            Overlay.Font.Charset = DEFAULT_CHARSET
            Overlay.Font.Color = clWindowText
            Overlay.Font.Height = -7
            Overlay.Font.Name = 'FontAwesome'
            Overlay.Font.Style = []
            Overlay.Font.Quality = fqAntialiased
            Overlay.Position = foNone
            Overlay.Margin = 3
            Margin = 8
            Spacing = 8
            SubTextFont.Charset = DEFAULT_CHARSET
            SubTextFont.Color = clGray
            SubTextFont.Height = -11
            SubTextFont.Name = 'Tahoma'
            SubTextFont.Style = []
            TabOrder = 1
            Text = 'Add to Watchlist'
            OnClick = btnWatchlistClick
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Alternative Titles'
          ImageIndex = 2
          object lstAltTitles: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 241
            Align = alClient
            Columns = <
              item
                Caption = 'Title'
                Width = 350
              end
              item
                Caption = 'Country'
                Width = 250
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Changes'
          ImageIndex = 3
        end
        object TabSheet5: TTabSheet
          Caption = 'Credits'
          ImageIndex = 4
          object lstCredits: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 241
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Name'
                Width = 250
              end
              item
                Caption = 'Role'
                Width = 350
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
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'External IDs'
          ImageIndex = 5
          object lblIMDB: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
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
            Width = 755
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
            Width = 755
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
            Width = 755
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
            Width = 755
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
          object ListView2: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 241
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
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Keywords'
          ImageIndex = 7
          object lstKeywords: TListBox
            Left = 0
            Top = 0
            Width = 217
            Height = 247
            Align = alLeft
            ItemHeight = 18
            TabOrder = 0
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Lists'
          ImageIndex = 8
        end
        object TabSheet10: TTabSheet
          Caption = 'Recommendations'
          ImageIndex = 9
        end
        object TabSheet11: TTabSheet
          Caption = 'Release Dates'
          ImageIndex = 10
          object lstReleaseDates: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 241
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Release Date'
                Width = 130
              end
              item
                Caption = 'Type'
                Width = 180
              end
              item
                Caption = 'Note'
                Width = 150
              end
              item
                Caption = 'Certification'
                Width = 120
              end
              item
                Caption = 'Descriptors'
                Width = 200
              end
              item
                Caption = 'Language'
                Width = 150
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'Reviews'
          ImageIndex = 11
        end
        object TabSheet13: TTabSheet
          Caption = 'Similar'
          ImageIndex = 12
        end
        object TabSheet14: TTabSheet
          Caption = 'Translations'
          ImageIndex = 13
        end
        object TabSheet15: TTabSheet
          Caption = 'Videos'
          ImageIndex = 14
          object lstVideos: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 755
            Height = 241
            Align = alClient
            Columns = <
              item
                Caption = 'Title'
                Width = 250
              end
              item
                Caption = 'Site'
                Width = 120
              end
              item
                Caption = 'Type'
                Width = 150
              end
              item
                Caption = 'Published'
                Width = 180
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnDblClick = lstVideosDblClick
          end
        end
      end
    end
  end
  inherited pSearch: TPanel
    Height = 561
    ExplicitHeight = 561
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
        Text = 'False'
        Items.Strings = (
          'False'
          'True')
      end
    end
    object Panel9: TPanel [2]
      Left = 0
      Top = 114
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
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
    object Panel10: TPanel [3]
      Left = 0
      Top = 171
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
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
    object Panel13: TPanel [4]
      Left = 0
      Top = 228
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
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
    object Panel14: TPanel [5]
      Left = 0
      Top = 285
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
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
      Top = 517
      TabOrder = 6
      ExplicitTop = 517
    end
  end
end
