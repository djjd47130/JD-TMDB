inherited frmContentSearchMulti: TfrmContentSearchMulti
  Caption = 'Search Multi'
  PixelsPerInch = 96
  TextHeight = 18
  inherited pSearch: TPanel
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label8: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 107
        Height = 18
        Align = alTop
        Caption = 'Search Query:'
      end
      object txtQuery: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 27
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 26
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 57
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label9: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Include Adult:'
        ExplicitWidth = 104
      end
      object cboIncludeAdult: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Default'
        Items.Strings = (
          'Default'
          'False'
          'True')
      end
    end
  end
end
