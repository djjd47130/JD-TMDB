inherited frmCommonVideos: TfrmCommonVideos
  Caption = 'Videos'
  ClientHeight = 495
  ClientWidth = 882
  OnCreate = FormCreate
  ExplicitWidth = 898
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 13
  object lstVideos: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 876
    Height = 270
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
    ExplicitLeft = -2
  end
end
