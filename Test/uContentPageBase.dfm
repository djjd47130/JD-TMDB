inherited frmContentPageBase: TfrmContentPageBase
  Caption = 'Content Page Base'
  ClientHeight = 543
  ClientWidth = 910
  ExplicitWidth = 926
  ExplicitHeight = 582
  PixelsPerInch = 96
  TextHeight = 18
  object Panel11: TPanel
    Left = 265
    Top = 0
    Width = 645
    Height = 543
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 44
    ExplicitWidth = 710
    ExplicitHeight = 444
    object lstSearchMovies: TListView
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 639
      Height = 505
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
    end
    object Panel12: TPanel
      Left = 0
      Top = 511
      Width = 645
      Height = 32
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 441
      ExplicitWidth = 489
      object lblSearchMoviesResults: TLabel
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
      object lblSearchMoviesPage: TLabel
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
      object btnSearchMoviesPagePrev: TButton
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
      end
      object btnSearchMoviesPageNext: TButton
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
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 543
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitHeight = 396
    object btnSearchMoviesApply: TButton
      AlignWithMargins = True
      Left = 3
      Top = 515
      Width = 259
      Height = 25
      Cursor = crHandPoint
      Align = alBottom
      Caption = 'Apply Search -->'
      TabOrder = 0
      ExplicitTop = 445
    end
  end
end
