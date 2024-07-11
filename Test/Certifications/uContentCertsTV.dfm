inherited frmContentCertsTV: TfrmContentCertsTV
  Caption = 'TV Certifications'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object lstCertsTV: TListView
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 748
    Height = 433
    Align = alClient
    Color = clSilver
    Columns = <
      item
        Caption = 'Order'
        Width = 0
      end
      item
        Caption = 'Certification'
        Width = 120
      end
      item
        Caption = 'Meaning'
        Width = 700
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    GroupView = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnRefreshCertsTV: TButton
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
    OnClick = btnRefreshCertsTVClick
    ExplicitLeft = -2
  end
end
