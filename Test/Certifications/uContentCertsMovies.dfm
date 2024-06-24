inherited frmContentCertsMovies: TfrmContentCertsMovies
  Caption = 'Movie Certifications'
  PixelsPerInch = 96
  TextHeight = 18
  object lstCertsMovies: TListView
    AlignWithMargins = True
    Left = 3
    Top = 38
    Width = 748
    Height = 432
    Align = alClient
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
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitTop = 37
    ExplicitHeight = 433
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 35
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 31
    object cboCountry: TComboBox
      AlignWithMargins = True
      Left = 111
      Top = 4
      Width = 309
      Height = 26
      Align = alLeft
      Style = csDropDownList
      TabOrder = 0
      OnClick = cboCountryClick
    end
    object btnRefreshCertsMovies: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 101
      Height = 27
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'Refresh'
      TabOrder = 1
      OnClick = btnRefreshCertsMoviesClick
    end
  end
end
