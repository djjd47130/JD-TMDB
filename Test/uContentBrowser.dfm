inherited frmContentBrowser: TfrmContentBrowser
  Caption = 'Browser'
  ClientHeight = 505
  ClientWidth = 845
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 861
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 18
  object Edge: TEdgeBrowser
    Left = 0
    Top = 160
    Width = 845
    Height = 345
    Align = alBottom
    TabOrder = 1
    OnContainsFullScreenElementChanged = EdgeContainsFullScreenElementChanged
    OnContentLoading = EdgeContentLoading
    OnDocumentTitleChanged = EdgeDocumentTitleChanged
    OnNavigationStarting = EdgeNavigationStarting
    OnNavigationCompleted = EdgeNavigationCompleted
    OnNewWindowRequested = EdgeNewWindowRequested
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 845
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object txtAddress: TEdit
      AlignWithMargins = True
      Left = 102
      Top = 3
      Width = 708
      Height = 27
      Align = alClient
      TabOrder = 3
      OnDblClick = txtAddressDblClick
      ExplicitHeight = 26
    end
    object btnGo: TJDFontButton
      Left = 813
      Top = 0
      Width = 32
      Height = 33
      Cursor = crHandPoint
      Align = alRight
      Default = True
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61537
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -21
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcGreen
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
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 4
      Text = 'btnGo'
      OnClick = btnGoClick
    end
    object btnBack: TJDFontButton
      Left = 0
      Top = 0
      Width = 33
      Height = 33
      Cursor = crHandPoint
      Align = alLeft
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61523
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -21
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcGreen
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
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 0
      Text = 'JDFontButton1'
      OnClick = btnBackClick
    end
    object btnForward: TJDFontButton
      Left = 33
      Top = 0
      Width = 33
      Height = 33
      Cursor = crHandPoint
      Align = alLeft
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61524
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -21
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcGreen
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
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 1
      Text = 'JDFontButton1'
      OnClick = btnForwardClick
    end
    object btnRefresh: TJDFontButton
      Left = 66
      Top = 0
      Width = 33
      Height = 33
      Cursor = crHandPoint
      Align = alLeft
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61666
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -21
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcGreen
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
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 2
      Text = 'JDFontButton1'
      OnClick = btnRefreshClick
    end
  end
end