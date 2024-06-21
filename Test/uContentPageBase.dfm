inherited frmContentPageBase: TfrmContentPageBase
  Caption = 'Content Page Base'
  ClientHeight = 500
  ClientWidth = 910
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 926
  ExplicitHeight = 539
  PixelsPerInch = 96
  TextHeight = 18
  object pMain: TPanel
    Left = 265
    Top = 0
    Width = 645
    Height = 500
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 0
      Top = 296
      Width = 645
      Height = 7
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
      ResizeStyle = rsUpdate
      Visible = False
      ExplicitTop = 298
    end
    object lstResults: TListView
      AlignWithMargins = True
      Left = 3
      Top = 35
      Width = 639
      Height = 258
      Align = alClient
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'Caption'
          Width = 250
        end>
      HideSelection = False
      HotTrackStyles = [htHandPoint, htUnderlineHot]
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lstResultsClick
      OnDblClick = lstResultsDblClick
      OnSelectItem = lstResultsSelectItem
    end
    object pTop: TPanel
      Left = 0
      Top = 0
      Width = 645
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblResults: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 165
        Height = 26
        Align = alLeft
        AutoSize = False
        Caption = '0 Results'
        Layout = tlCenter
        ExplicitLeft = 4
        ExplicitHeight = 24
      end
      object lblPage: TLabel
        AlignWithMargins = True
        Left = 217
        Top = 3
        Width = 119
        Height = 26
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'Page 0 of 0'
        Layout = tlCenter
        ExplicitLeft = 218
        ExplicitHeight = 24
      end
      object btnPagePrev: TButton
        AlignWithMargins = True
        Left = 174
        Top = 3
        Width = 37
        Height = 26
        Cursor = crHandPoint
        Align = alLeft
        Caption = '<'
        Enabled = False
        TabOrder = 0
        OnClick = btnPagePrevClick
      end
      object btnPageNext: TButton
        AlignWithMargins = True
        Left = 342
        Top = 3
        Width = 37
        Height = 26
        Cursor = crHandPoint
        Align = alLeft
        Caption = '>'
        Enabled = False
        TabOrder = 1
        OnClick = btnPageNextClick
      end
    end
    object pDetail: TPanel
      Left = 0
      Top = 303
      Width = 645
      Height = 197
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
    end
  end
  object pSearch: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 500
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object btnApply: TJDFontButton
      AlignWithMargins = True
      Left = 3
      Top = 456
      Width = 259
      Height = 41
      Cursor = crHandPoint
      Align = alBottom
      Default = True
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61537
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -24
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
      ImagePosition = fpImgRight
      Margin = 8
      Spacing = 8
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 0
      Text = 'Apply Search'
      OnClick = btnApplyClick
    end
  end
end
