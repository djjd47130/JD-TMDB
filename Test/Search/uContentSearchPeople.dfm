inherited frmContentSearchPeople: TfrmContentSearchPeople
  Caption = 'Search People'
  ClientHeight = 557
  ClientWidth = 946
  ExplicitWidth = 962
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    Width = 681
    Height = 557
    inherited Splitter1: TSplitter
      Top = 273
      Width = 681
    end
    inherited lstResults: TListView
      Width = 675
      Height = 235
      ExplicitLeft = 6
      ExplicitWidth = 675
      ExplicitHeight = 276
    end
    inherited pTop: TPanel
      Width = 681
    end
    inherited pDetail: TPanel
      Top = 280
      Width = 681
      Height = 277
      ExplicitTop = 280
      ExplicitWidth = 681
      ExplicitHeight = 277
    end
  end
  inherited pSearch: TPanel
    Height = 557
    ExplicitLeft = -3
    ExplicitHeight = 557
    inherited btnApply: TJDFontButton
      Top = 513
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 8
      object Label8: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Search Query:'
        ExplicitWidth = 107
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
        Text = 'False'
        Items.Strings = (
          'False'
          'True')
      end
    end
  end
end
