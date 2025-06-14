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
    ActivePage = tabVideos
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 0
    Visible = False
    OnChange = PagesChange
    object TabSheet1: TTabSheet
      Caption = 'Detail'
      object Splitter1: TSplitter
        Left = 0
        Top = 220
        Width = 911
        Height = 7
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitLeft = 3
        ExplicitTop = 230
      end
      object txtOverview: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 230
        Width = 905
        Height = 120
        Align = alBottom
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object lstDetail: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
        Height = 214
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 600
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnCustomDraw = lstDetailCustomDraw
        OnCustomDrawItem = lstDetailCustomDrawItem
        OnCustomDrawSubItem = lstDetailCustomDrawSubItem
        OnDblClick = lstDetailDblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Account States'
      ImageIndex = 1
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
      end
    end
    object tabAltTitles: TTabSheet
      Caption = 'Alternative Titles'
      ImageIndex = 2
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
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Changes'
      ImageIndex = 3
    end
    object tabCredits: TTabSheet
      Caption = 'Credits'
      ImageIndex = 4
    end
    object TabSheet6: TTabSheet
      Caption = 'External IDs'
      ImageIndex = 5
      object lstExternalIDs: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 905
        Height = 347
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 600
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tabImages: TTabSheet
      Caption = 'Images'
      ImageIndex = 6
    end
    object TabSheet8: TTabSheet
      Caption = 'Keywords'
      ImageIndex = 7
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
    end
    object TabSheet10: TTabSheet
      Caption = 'Recommendations'
      ImageIndex = 9
    end
    object tabReleaseDates: TTabSheet
      Caption = 'Release Dates'
      ImageIndex = 10
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
      end
    end
    object tabReviews: TTabSheet
      Caption = 'Reviews'
      ImageIndex = 11
    end
    object tabSimilar: TTabSheet
      Caption = 'Similar'
      ImageIndex = 12
    end
    object TabSheet14: TTabSheet
      Caption = 'Translations'
      ImageIndex = 13
    end
    object tabVideos: TTabSheet
      Caption = 'Videos'
      ImageIndex = 14
    end
  end
end
