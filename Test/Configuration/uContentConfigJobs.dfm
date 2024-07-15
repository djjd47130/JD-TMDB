inherited frmContentConfigJobs: TfrmContentConfigJobs
  Caption = 'Jobs and Departments'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object lstJobs: TListView
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 748
    Height = 433
    Align = alClient
    Columns = <
      item
        Caption = 'Department'
        Width = 250
      end
      item
        Caption = 'Job'
        Width = 250
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnRefresh: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Refresh List'
    TabOrder = 1
    Visible = False
    OnClick = btnRefreshClick
  end
end
