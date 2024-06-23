inherited frmContentMovieDetail: TfrmContentMovieDetail
  Caption = 'Movie Detail'
  ClientWidth = 919
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 935
  PixelsPerInch = 96
  TextHeight = 18
  object Pages: TPageControl
    Left = 0
    Top = 64
    Width = 919
    Height = 409
    ActivePage = TabSheet8
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 0
    Visible = False
    OnChange = PagesChange
    object TabSheet1: TTabSheet
      Caption = 'Detail'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblTitle: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
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
        Width = 905
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
        Width = 905
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
        Width = 905
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
        Width = 905
        Height = 240
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 147
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Account States'
      ImageIndex = 1
      ExplicitWidth = 761
      ExplicitHeight = 247
      object lblRating: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
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
        Width = 905
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
        ExplicitWidth = 755
      end
      object btnWatchlist: TJDFontButton
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 905
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
        ExplicitWidth = 755
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Alternative Titles'
      ImageIndex = 2
      ExplicitWidth = 746
      ExplicitHeight = 313
      object lstAltTitles: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
        Height = 347
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
        ExplicitWidth = 740
        ExplicitHeight = 307
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Changes'
      ImageIndex = 3
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object tabCredits: TTabSheet
      Caption = 'Credits'
      ImageIndex = 4
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet6: TTabSheet
      Caption = 'External IDs'
      ImageIndex = 5
      ExplicitWidth = 761
      ExplicitHeight = 247
      object lblIMDB: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
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
        Width = 905
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
        Width = 905
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
        Width = 905
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
        Width = 905
        Height = 18
        Align = alTop
        AutoSize = False
        Caption = 'Twitter'
        ExplicitLeft = 27
        ExplicitTop = 155
        ExplicitWidth = 693
      end
    end
    object tabImages: TTabSheet
      Caption = 'Images'
      ImageIndex = 6
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet8: TTabSheet
      Caption = 'Keywords'
      ImageIndex = 7
      ExplicitWidth = 746
      ExplicitHeight = 313
      object lstKeywords: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 326
        Height = 347
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ItemHeight = 23
        ParentFont = False
        TabOrder = 0
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Lists'
      ImageIndex = 8
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet10: TTabSheet
      Caption = 'Recommendations'
      ImageIndex = 9
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet11: TTabSheet
      Caption = 'Release Dates'
      ImageIndex = 10
      ExplicitWidth = 746
      ExplicitHeight = 313
      object lstReleaseDates: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
        Height = 347
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
        ExplicitWidth = 740
        ExplicitHeight = 307
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'Reviews'
      ImageIndex = 11
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet13: TTabSheet
      Caption = 'Similar'
      ImageIndex = 12
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object TabSheet14: TTabSheet
      Caption = 'Translations'
      ImageIndex = 13
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
    object tabVideos: TTabSheet
      Caption = 'Videos'
      ImageIndex = 14
      ExplicitWidth = 746
      ExplicitHeight = 313
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 754
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 45
      Height = 25
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'ID:'
      Layout = tlCenter
    end
    object txtID: TEdit
      AlignWithMargins = True
      Left = 55
      Top = 4
      Width = 90
      Height = 25
      Margins.Right = 0
      Align = alLeft
      TabOrder = 0
    end
    object btnSearch: TJDFontButton
      AlignWithMargins = True
      Left = 145
      Top = 4
      Width = 32
      Height = 25
      Cursor = crHandPoint
      Margins.Left = 0
      Align = alLeft
      Default = True
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61442
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -19
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcBlue
      Overlay.Text = #57715
      Overlay.Font.Charset = DEFAULT_CHARSET
      Overlay.Font.Color = clWindowText
      Overlay.Font.Height = -7
      Overlay.Font.Name = 'FontAwesome'
      Overlay.Font.Style = []
      Overlay.Font.Quality = fqAntialiased
      Overlay.Position = foNone
      Overlay.Margin = 3
      ImagePosition = fpImgOnly
      Margin = 8
      Spacing = 8
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 1
      Text = 'User Login'
      OnClick = btnSearchClick
    end
  end
end
