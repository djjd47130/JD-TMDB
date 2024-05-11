inherited frmContentPageBase: TfrmContentPageBase
  Caption = 'Content Page Base'
  ClientHeight = 501
  ClientWidth = 910
  ExplicitWidth = 926
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 18
  object pMain: TPanel
    Left = 265
    Top = 0
    Width = 645
    Height = 501
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 44
    ExplicitWidth = 710
    ExplicitHeight = 444
    object lstResults: TListView
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 639
      Height = 463
      Align = alClient
      Color = clSilver
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
      ExplicitLeft = 6
      ExplicitTop = 0
      ExplicitHeight = 505
    end
    object pFooter: TPanel
      Left = 0
      Top = 469
      Width = 645
      Height = 32
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 441
      ExplicitWidth = 489
      object lblResults: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 165
        Height = 24
        Align = alLeft
        AutoSize = False
        Caption = '0 Results'
        Layout = tlCenter
        ExplicitTop = 3
      end
      object lblPage: TLabel
        AlignWithMargins = True
        Left = 218
        Top = 4
        Width = 119
        Height = 24
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'Page 0 of 0'
        Layout = tlCenter
        ExplicitTop = 3
      end
      object btnPagePrev: TButton
        AlignWithMargins = True
        Left = 175
        Top = 4
        Width = 37
        Height = 24
        Cursor = crHandPoint
        Align = alLeft
        Caption = '<'
        Enabled = False
        TabOrder = 0
        OnClick = btnPagePrevClick
      end
      object btnPageNext: TButton
        AlignWithMargins = True
        Left = 343
        Top = 4
        Width = 37
        Height = 24
        Cursor = crHandPoint
        Align = alLeft
        Caption = '>'
        Enabled = False
        TabOrder = 1
        OnClick = btnPageNextClick
        ExplicitTop = 3
      end
    end
  end
  object pSearch: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 501
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitHeight = 396
    object btnApply: TButton
      AlignWithMargins = True
      Left = 3
      Top = 473
      Width = 259
      Height = 25
      Cursor = crHandPoint
      Align = alBottom
      Caption = 'Apply Search -->'
      TabOrder = 0
      OnClick = btnApplyClick
      ExplicitTop = 445
    end
  end
end
