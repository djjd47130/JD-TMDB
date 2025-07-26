inherited frmCommonPersonCredits: TfrmCommonPersonCredits
  Caption = 'frmCommonPersonCredits'
  ClientHeight = 516
  ClientWidth = 928
  ExplicitWidth = 944
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  object lstResults: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 922
    Height = 510
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Media Title'
        Width = 350
      end
      item
        Caption = 'Type'
        Width = 80
      end
      item
        Caption = 'Assoc.'
        Width = 80
      end
      item
        Caption = 'Role'
        Width = 150
      end
      item
        Caption = 'Genre'
        Width = 150
      end
      item
        Caption = 'Release Date'
        Width = 120
      end>
    HideSelection = False
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
end
