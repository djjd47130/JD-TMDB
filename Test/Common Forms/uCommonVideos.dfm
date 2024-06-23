inherited frmCommonVideos: TfrmCommonVideos
  Caption = 'Videos'
  ClientHeight = 495
  ClientWidth = 882
  ExplicitWidth = 898
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 13
  object lstVideos: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 876
    Height = 489
    Align = alClient
    Columns = <
      item
        Caption = 'Title'
        Width = 300
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
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lstVideosDblClick
    ExplicitLeft = -126
    ExplicitWidth = 905
    ExplicitHeight = 347
  end
end
