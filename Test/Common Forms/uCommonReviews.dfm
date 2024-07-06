inherited frmCommonReviews: TfrmCommonReviews
  Caption = 'Reviews'
  PixelsPerInch = 96
  TextHeight = 13
  object lstReviews: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 773
    Height = 439
    Align = alClient
    Columns = <
      item
        Caption = 'Author'
        Width = 220
      end
      item
        Caption = 'Date Cr'
        Width = 180
      end
      item
        Caption = 'Rating'
        Width = 80
      end
      item
        Caption = 'Content'
        Width = 400
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
  end
end
