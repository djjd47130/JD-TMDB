inherited frmContentSearchTV: TfrmContentSearchTV
  Caption = 'Search TV'
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    inherited Splitter1: TSplitter
      Top = 145
      ExplicitTop = 209
    end
    inherited lstResults: TListView
      Height = 107
      ExplicitHeight = 171
    end
    inherited pDetail: TPanel
      Top = 152
      Height = 348
      ExplicitTop = 152
      ExplicitHeight = 348
    end
  end
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
    object Panel13: TPanel
      Left = 0
      Top = 114
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label14: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 140
        Height = 18
        Align = alTop
        Caption = 'First Air Date Year'
      end
      object txtFirstAirDateYear: TEdit
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
    object Panel14: TPanel
      Left = 0
      Top = 171
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object Label15: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 41
        Height = 18
        Align = alTop
        Caption = 'Year:'
      end
      object txtYear: TEdit
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
  end
end
