inherited frmCommonVideos: TfrmCommonVideos
  Caption = 'Videos'
  ClientHeight = 495
  ClientWidth = 882
  ExplicitWidth = 898
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 188
    Width = 882
    Height = 7
    Cursor = crVSplit
    Align = alTop
    ResizeStyle = rsUpdate
    ExplicitLeft = -5
    ExplicitTop = 253
  end
  object lstVideos: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 876
    Height = 182
    Align = alTop
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Title'
        Width = 400
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
    OnDblClick = lstVideosDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 195
    Width = 882
    Height = 300
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 256
    ExplicitHeight = 239
    object Edge: TEdgeBrowser
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 866
      Height = 284
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 21
      ExplicitTop = 21
      ExplicitWidth = 840
      ExplicitHeight = 197
    end
  end
end
