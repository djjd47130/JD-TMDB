inherited frmContentSearchCollections: TfrmContentSearchCollections
  Caption = 'Search Collections'
  PixelsPerInch = 96
  TextHeight = 18
  inherited pMain: TPanel
    inherited Splitter1: TSplitter
      Top = 241
      ExplicitTop = 241
    end
    inherited lstResults: TListView
      Height = 203
      Columns = <
        item
          Caption = 'Name'
          Width = 250
        end
        item
          Caption = 'Language'
          Width = 150
        end
        item
          Caption = 'Overview'
          Width = 600
        end>
      ExplicitHeight = 203
    end
    inherited pDetail: TPanel
      Top = 248
      Height = 252
      ExplicitTop = 248
      ExplicitHeight = 252
      object Pages: TPageControl
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 639
        Height = 246
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 0
        OnChange = PagesChange
        object TabSheet1: TTabSheet
          Caption = 'Details'
          object lblTitle: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 625
            Height = 29
            Align = alTop
            AutoSize = False
            Caption = 'Collection Title'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 19
          end
          object txtOverview: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 38
            Width = 625
            Height = 105
            Align = alTop
            BorderStyle = bsNone
            Color = clBtnFace
            Lines.Strings = (
              'txtOverview')
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Parts'
          ImageIndex = 1
          object lstParts: TListView
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 625
            Height = 207
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Item'
                Width = 300
              end
              item
                Caption = 'Popularity'
                Width = 100
              end
              item
                Caption = 'Media Type'
                Width = 120
              end
              item
                Caption = 'Genre'
                Width = 170
              end
              item
                Caption = 'Released'
                Width = 120
              end
              item
                Caption = 'Description'
                Width = 500
              end>
            HideSelection = False
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Images'
          ImageIndex = 2
        end
        object TabSheet4: TTabSheet
          Caption = 'Translations'
          ImageIndex = 3
        end
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
      object cboSearchMoviesAdult: TComboBox
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
    object Panel9: TPanel
      Left = 0
      Top = 114
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label10: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Language:'
        ExplicitWidth = 77
      end
      object cboSearchMoviesLanguage: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel10: TPanel
      Left = 0
      Top = 171
      Width = 265
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object Label11: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 259
        Height = 18
        Align = alTop
        Caption = 'Region:'
        ExplicitWidth = 57
      end
      object cboSearchMoviesRegion: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 259
        Height = 26
        Cursor = crHandPoint
        Align = alClient
        TabOrder = 0
      end
    end
  end
end
