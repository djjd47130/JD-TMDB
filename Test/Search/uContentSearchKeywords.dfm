inherited frmContentSearchKeywords: TfrmContentSearchKeywords
  Caption = 'Search Keywords'
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    inherited Splitter1: TSplitter
      Top = 321
      ExplicitTop = 321
    end
    inherited lstResults: TListView
      Height = 283
      ExplicitHeight = 283
    end
    inherited pDetail: TPanel
      Top = 328
      Height = 172
      ExplicitTop = 328
      ExplicitHeight = 172
      object lstDetail: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 639
        Height = 166
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 600
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitLeft = 6
        ExplicitTop = 6
        ExplicitHeight = 191
      end
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
      ExplicitTop = 8
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
  end
end
