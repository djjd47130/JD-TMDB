inherited frmContentSearchCompanies: TfrmContentSearchCompanies
  Caption = 'Search Companies'
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    ExplicitLeft = 268
    ExplicitTop = 288
    inherited Splitter1: TSplitter
      Top = 289
      Align = alTop
      ExplicitLeft = 6
      ExplicitTop = 328
    end
    inherited lstResults: TListView
      Height = 251
      Align = alTop
      ExplicitTop = 27
      ExplicitHeight = 251
    end
    inherited pDetail: TPanel
      Top = 296
      Height = 204
      Align = alClient
      ExplicitLeft = 3
      ExplicitTop = 299
      ExplicitHeight = 204
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
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Search Query:'
        ExplicitWidth = 107
      end
      object txtSearchMoviesQuery: TEdit
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
