inherited frmCommonAlternativeTitles: TfrmCommonAlternativeTitles
  Caption = 'Alternative Titles'
  PixelsPerInch = 96
  TextHeight = 13
  object lstAltTitles: TListView
    AlignWithMargins = True
    Left = 3
    Top = 36
    Width = 773
    Height = 406
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 779
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
      ExplicitHeight = 21
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
    end
  end
end
