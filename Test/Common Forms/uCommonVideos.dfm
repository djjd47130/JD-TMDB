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
    Top = 249
    Width = 882
    Height = 7
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
    ExplicitTop = 251
  end
  object lstVideos: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 876
    Height = 243
    Align = alClient
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
    Top = 256
    Width = 882
    Height = 239
    Align = alBottom
    TabOrder = 1
    object Edge: TEdgeBrowser
      AlignWithMargins = True
      Left = 21
      Top = 21
      Width = 840
      Height = 197
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 20
      Align = alClient
      TabOrder = 0
    end
  end
end
