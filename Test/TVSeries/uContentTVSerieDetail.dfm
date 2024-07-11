inherited frmContentTVSerieDetail: TfrmContentTVSerieDetail
  Caption = 'TV Serie Detail'
  ClientHeight = 537
  ClientWidth = 985
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1001
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 18
  object Pages: TPageControl
    Left = 0
    Top = 104
    Width = 985
    Height = 433
    ActivePage = TabSheet1
    Align = alBottom
    MultiLine = True
    TabOrder = 0
    OnChange = PagesChange
    object TabSheet1: TTabSheet
      Caption = 'Detail'
      object Splitter1: TSplitter
        Left = 0
        Top = 286
        Width = 977
        Height = 7
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitTop = -126
      end
      object lstDetail: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 971
        Height = 280
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
        OnCustomDrawSubItem = lstDetailCustomDrawSubItem
      end
      object txtOverview: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 296
        Width = 971
        Height = 78
        Align = alBottom
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Account States'
      ImageIndex = 1
      object lblRating: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 971
        Height = 18
        Align = alTop
        AutoSize = False
        Caption = 'Rating'
        ExplicitLeft = 6
        ExplicitTop = 11
      end
      object btnFavorite: TJDFontButton
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 971
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
      end
      object btnWatchlist: TJDFontButton
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 971
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
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Aggregate Credits'
      ImageIndex = 2
    end
    object tabAlternativeTitles: TTabSheet
      Caption = 'Alternative Titles'
      ImageIndex = 3
    end
    object TabSheet5: TTabSheet
      Caption = 'Changes'
      ImageIndex = 4
    end
    object TabSheet6: TTabSheet
      Caption = 'Content Ratings'
      ImageIndex = 5
    end
    object tabCredits: TTabSheet
      Caption = 'Credits'
      ImageIndex = 6
    end
    object TabSheet8: TTabSheet
      Caption = 'Episode Groups'
      ImageIndex = 7
    end
    object TabSheet9: TTabSheet
      Caption = 'External IDs'
      ImageIndex = 8
    end
    object tabImages: TTabSheet
      Caption = 'Images'
      ImageIndex = 9
    end
    object TabSheet11: TTabSheet
      Caption = 'Keywords'
      ImageIndex = 10
    end
    object TabSheet12: TTabSheet
      Caption = 'Lists'
      ImageIndex = 11
    end
    object TabSheet13: TTabSheet
      Caption = 'Recommendations'
      ImageIndex = 12
    end
    object tabReviews: TTabSheet
      Caption = 'Reviews'
      ImageIndex = 13
    end
    object TabSheet15: TTabSheet
      Caption = 'Screened Theatrically'
      ImageIndex = 14
    end
    object TabSheet16: TTabSheet
      Caption = 'Similar'
      ImageIndex = 15
    end
    object TabSheet17: TTabSheet
      Caption = 'Translations'
      ImageIndex = 16
    end
    object tabVideos: TTabSheet
      Caption = 'Videos'
      ImageIndex = 17
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 985
    Height = 33
    Align = alTop
    TabOrder = 1
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
      ExplicitHeight = 26
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
