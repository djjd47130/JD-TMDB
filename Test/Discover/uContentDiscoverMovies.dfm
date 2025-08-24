inherited frmContentDiscoverMovies: TfrmContentDiscoverMovies
  Caption = 'Discover Movies'
  ClientHeight = 501
  ClientWidth = 929
  ExplicitWidth = 945
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 18
  object Splitter2: TSplitter [0]
    Left = 257
    Top = 0
    Width = 5
    Height = 501
    ExplicitLeft = 281
  end
  inherited pMain: TPanel
    Left = 262
    Width = 667
    Height = 501
    ExplicitLeft = 262
    ExplicitWidth = 667
    ExplicitHeight = 501
    inherited Splitter1: TSplitter
      Top = 431
      Width = 667
      ExplicitTop = 297
      ExplicitWidth = 664
    end
    inherited lstResults: TListView
      Width = 661
      Height = 393
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ExplicitWidth = 661
      ExplicitHeight = 393
    end
    inherited pTop: TPanel
      Width = 667
      ExplicitWidth = 667
      inherited btnRefresh: TJDFontButton
        Left = 623
        ExplicitLeft = 623
      end
    end
    inherited pDetail: TPanel
      Top = 438
      Width = 667
      Height = 63
      ExplicitTop = 438
      ExplicitWidth = 667
      ExplicitHeight = 63
    end
  end
  inherited pSearch: TPanel
    Width = 257
    Height = 501
    Visible = True
    ExplicitWidth = 257
    ExplicitHeight = 501
    inherited btnApply: TJDFontButton
      Top = 457
      Width = 251
      Default = False
      ExplicitTop = 457
      ExplicitWidth = 251
    end
    object CategoryPanelGroup1: TCategoryPanelGroup
      Left = 0
      Top = 0
      Width = 257
      Height = 457
      VertScrollBar.Tracking = True
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      DoubleBuffered = True
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      Images = Img16
      ParentDoubleBuffered = False
      TabOrder = 1
      object CategoryPanel7: TCategoryPanel
        Top = 1002
        Height = 30
        Caption = 'Watch'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 0
        ExpandedHeight = 146
        object Panel15: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label16: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Primary Release Year:'
            ExplicitWidth = 169
          end
          object Edit11: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
        object Panel16: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label17: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Year:'
            ExplicitWidth = 41
          end
          object Edit12: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
      end
      object CategoryPanel5: TCategoryPanel
        Top = 972
        Height = 30
        Caption = 'Runtime'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 1
        ExpandedHeight = 146
        object Panel7: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label8: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Primary Release Year:'
            ExplicitWidth = 169
          end
          object Edit7: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
        object Panel9: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label10: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Year:'
            ExplicitWidth = 41
          end
          object Edit8: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
      end
      object CategoryPanel3: TCategoryPanel
        Top = 942
        Height = 30
        Caption = 'People'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 2
        ExpandedHeight = 146
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label4: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Primary Release Year:'
            ExplicitWidth = 169
          end
          object Edit3: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Year:'
            ExplicitWidth = 41
          end
          object Edit4: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
      end
      object CategoryPanel4: TCategoryPanel
        Top = 742
        Caption = 'Companies'
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 3
        object clCompanies: TJDChipList
          Left = 0
          Top = 49
          Width = 234
          Height = 120
          Align = alTop
          AllowExclude = True
          AutoSize = False
          ChipHeight = 24
          ChipPadding = 3
          Color = clBackground
          ExcludeToggle = ctButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Items = <
            item
              Caption = 'Disney'
              Exclude = False
            end
            item
              Caption = 'Dasney'
              Exclude = True
            end>
          ParentBackground = False
          ParentColor = False
          UI.ChipColor = 12615680
          UI.ChipExcludeColor = clMaroon
          UI.DeleteButtonColor = clRed
          UI.ShowDeleteBtn = False
          UI.ChipNormal.Brush.Alpha = 255
          UI.ChipNormal.Brush.Color.StandardColor = fcNeutral
          UI.ChipNormal.Brush.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Alpha = 255
          UI.ChipNormal.Pen.Color.StandardColor = fcNeutral
          UI.ChipNormal.Pen.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Width = 1.000000000000000000
          OnResize = JDChipList1Resize
        end
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 49
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label6: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Search for Companies:'
            ExplicitWidth = 168
          end
          object txtSearchCompanies: TButtonedEdit
            Left = 0
            Top = 21
            Width = 228
            Height = 26
            Align = alTop
            Images = Img16
            RightButton.HotImageIndex = 2
            RightButton.ImageIndex = 0
            RightButton.PressedImageIndex = 3
            RightButton.Visible = True
            TabOrder = 0
            OnRightButtonClick = txtSearchCompaniesRightButtonClick
          end
        end
      end
      object CategoryPanel2: TCategoryPanel
        Top = 712
        Height = 30
        Caption = 'Votes'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 4
        ExpandedHeight = 146
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Primary Release Year:'
            ExplicitWidth = 169
          end
          object Edit1: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label3: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Year:'
            ExplicitWidth = 41
          end
          object Edit2: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
      end
      object cpRelease: TCategoryPanel
        Top = 682
        Height = 30
        Caption = 'Release Date'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 5
        ExpandedHeight = 280
        object Panel13: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label14: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Primary Release Year:'
            ExplicitWidth = 169
          end
          object txtSearchMoviesPrimaryReleaseYear: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
        object Panel14: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label15: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Year:'
            ExplicitWidth = 41
          end
          object txtSearchMoviesYear: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 28
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 26
          end
        end
      end
      object CategoryPanel6: TCategoryPanel
        Top = 470
        Height = 212
        Caption = 'Keywords'
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 6
        object Panel11: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 49
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label12: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Search for Keywords:'
            ExplicitWidth = 161
          end
          object txtSearchKeyword: TSearchBox
            Left = 0
            Top = 21
            Width = 228
            Height = 28
            Align = alClient
            TabOrder = 0
            OnInvokeSearch = txtSearchKeywordInvokeSearch
            ExplicitHeight = 26
          end
        end
        object JDChipList1: TJDChipList
          Left = 0
          Top = 49
          Width = 234
          Height = 104
          Align = alTop
          AllowExclude = True
          AutoSize = False
          ChipHeight = 24
          ChipPadding = 3
          Color = clBackground
          ExcludeToggle = ctButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Items = <
            item
              Caption = 'Science Fiction'
              Exclude = False
            end
            item
              Caption = 'Comedy'
              Exclude = False
            end
            item
              Caption = 'Horror'
              Exclude = True
            end>
          ParentBackground = False
          ParentColor = False
          UI.ChipColor = 12615680
          UI.ChipExcludeColor = clMaroon
          UI.DeleteButtonColor = clRed
          UI.ShowDeleteBtn = True
          UI.ChipNormal.Brush.Alpha = 255
          UI.ChipNormal.Brush.Color.StandardColor = fcNeutral
          UI.ChipNormal.Brush.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Alpha = 255
          UI.ChipNormal.Pen.Color.StandardColor = fcNeutral
          UI.ChipNormal.Pen.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Width = 1.000000000000000000
          OnResize = JDChipList1Resize
        end
      end
      object CategoryPanel1: TCategoryPanel
        Top = 287
        Height = 183
        Caption = 'Genres'
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 7
        object Label7: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 228
          Height = 18
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Search for Genres'
          ExplicitTop = 0
        end
        object clGenres: TJDChipList
          Left = 0
          Top = 49
          Width = 234
          Height = 92
          Align = alTop
          AllowExclude = True
          AutoSize = False
          ChipHeight = 24
          ChipPadding = 3
          Color = clBackground
          ExcludeToggle = ctButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Items = <
            item
              Caption = 'Science Fiction'
              Exclude = False
            end>
          ParentBackground = False
          ParentColor = False
          UI.ChipColor = 12615680
          UI.ChipExcludeColor = clMaroon
          UI.DeleteButtonColor = clRed
          UI.ShowDeleteBtn = True
          UI.ChipNormal.Brush.Alpha = 255
          UI.ChipNormal.Brush.Color.StandardColor = fcNeutral
          UI.ChipNormal.Brush.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Alpha = 255
          UI.ChipNormal.Pen.Color.StandardColor = fcNeutral
          UI.ChipNormal.Pen.Color.UseStandardColor = True
          UI.ChipNormal.Pen.Width = 1.000000000000000000
          OnResize = JDChipList1Resize
          ExplicitLeft = 3
        end
        object SearchBox1: TSearchBox
          Left = 0
          Top = 21
          Width = 234
          Height = 28
          Align = alTop
          TabOrder = 1
          OnInvokeSearch = txtSearchKeywordInvokeSearch
        end
      end
      object cpRegion: TCategoryPanel
        Top = 257
        Height = 30
        Caption = 'Region and Language'
        Collapsed = True
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        TabOrder = 8
        ExpandedHeight = 90
        object Panel10: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label11: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Region:'
            ExplicitWidth = 57
          end
          object cboSearchMoviesRegion: TComboBox
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 26
            Cursor = crHandPoint
            Align = alClient
            TabOrder = 0
            OnChange = cboSearchMoviesRegionChange
            OnClick = cboSearchMoviesRegionClick
            OnCloseUp = cboSearchMoviesRegionCloseUp
          end
        end
      end
      object cpCerts: TCategoryPanel
        Top = 0
        Height = 257
        Caption = 'Certification'
        CollapsedImageIndex = 0
        ExpandedImageIndex = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 228
          Height = 18
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Country:'
          ExplicitWidth = 64
        end
        object cboCertCountry: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 24
          Width = 228
          Height = 26
          Cursor = crHandPoint
          Align = alTop
          Style = csDropDownList
          TabOrder = 0
          OnClick = cboCertCountryClick
        end
        object lstCerts: TCheckListBox
          AlignWithMargins = True
          Left = 3
          Top = 56
          Width = 228
          Height = 92
          OnClickCheck = lstCertsClickCheck
          Align = alTop
          ItemHeight = 18
          TabOrder = 1
        end
        object Panel8: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 176
          Width = 228
          Height = 55
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object Label9: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 222
            Height = 18
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Include Adult:'
            ExplicitWidth = 104
          end
          object cboSearchMoviesAdult: TComboBox
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 222
            Height = 26
            Cursor = crHandPoint
            Align = alClient
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Default'
            OnClick = cboSearchMoviesAdultClick
            Items.Strings = (
              'Default'
              'False'
              'True')
          end
        end
      end
    end
  end
  object Img16: TImageList
    Left = 312
    Top = 248
    Bitmap = {
      494C010104000800040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0FB
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2E2
      E200DEDEDE0000000000EEEEEE00DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5F5F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008CDF
      8C007CDB7C0000000000BDECBD007CDB7C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D9F4D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE0000000000E9E9E900DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F3F3F300C0C0C000DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007CDB7C007CDB7C0000000000A7E6A7007CDB7C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D0F2D00000B900007CDB7C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE00DEDEDE0000000000E9E9E900DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3F3F300C0C0C000F3F3F300E9E9E900DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007CDB7C007CDB7C0000000000A7E6A7007CDB7C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D0F2D00000B90000D0F2D000A7E6A7007CDB7C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00DEDEDE0000000000E9E9E900DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F300C0C0C000F3F3F300FBFBFB0000000000E9E9E900DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007CDB7C007CDB7C0000000000A7E6A7007CDB7C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D0F2D00000B90000D0F2D000F0FBF00000000000A7E6A7007CDB7C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F9F9F900D3D3D300F3F3F30000000000DEDEDE00E9E9E9000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F900C0C0C000F3F3F300F9F9F900D3D3D300DEDEDE0000000000E9E9E900E2E2
      E200000000000000000000000000000000000000000000000000000000000000
      000000000000E9F9E9004DCE4D00D0F2D000000000007CDB7C00A7E6A7000000
      000000000000000000000000000000000000000000000000000000000000E9F9
      E90000B90000D0F2D000E9F9E9004DCE4D007CDB7C0000000000A7E6A7008CDF
      8C00000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900D3D3D300F3F3F30000000000DEDEDE00E9E9E900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900F9F9F900D3D3D300F1F1F100DEDEDE00DEDEDE0000000000FBFB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000E9F9E9004DCE4D00D0F2D000000000007CDB7C00A7E6A700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E9F9E900E9F9E9004DCE4D00C7EFC7007CDB7C007CDB7C0000000000F0FB
      F00000000000000000000000000000000000000000000000000000000000F9F9
      F900D3D3D300F3F3F30000000000DEDEDE00E9E9E90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900D3D3D300F3F3F3000000000000000000DEDEDE00DEDEDE000000
      000000000000000000000000000000000000000000000000000000000000E9F9
      E9004DCE4D00D0F2D000000000007CDB7C00A7E6A70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E9F9E9004DCE4D00D0F2D00000000000000000007CDB7C007CDB7C000000
      000000000000000000000000000000000000000000000000000000000000E2E2
      E200F3F3F30000000000EEEEEE00E9E9E9000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB00D3D3D300F3F3F30000000000000000000000000000000000DEDEDE00DEDE
      DE00000000000000000000000000000000000000000000000000000000008CDF
      8C00D0F2D00000000000BDECBD00A7E6A7000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0FB
      F0004DCE4D00D0F2D000000000000000000000000000000000007CDB7C007CDB
      7C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F5F5F500000000000000000000000000000000000000000000000000F5F5
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D9F4D900000000000000000000000000000000000000000000000000D9F4
      D900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFE4FFFEFFE4FFFEFFF27FFC7FF27FFC7F
      F93FF83FF93FF83FFC9FF09FFC9FF09FF89FE04FF89FE04FF13FF02FF13FF02F
      E27FF19FE27FF19FE4FFE3CFE4FFE3CFFFFFF7EFFFFFF7EFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  end
  object Glyphs: TJDFontGlyphs
    ImageLists = <
      item
        ImageList = Img16
      end>
    Glyphs = <
      item
        Caption = 'Blue Collapsed'
        Glyph = #61697
        Color = fcGray
        Scale = 0.960000000000000000
        Ref.FontName = 'FontAwesome'
        Ref.Glyph = #61697
        Ref.Color = clBlue
        Ref.StandardColor = fcGray
        Ref.UseStandardColor = True
      end
      item
        Caption = 'Blue Expanded'
        Glyph = #61699
        Color = fcGray
        Scale = 0.960000000000000000
        Ref.FontName = 'FontAwesome'
        Ref.Glyph = #61699
        Ref.Color = clBlue
        Ref.StandardColor = fcGray
        Ref.UseStandardColor = True
      end
      item
        Caption = 'Green Collapsed'
        Glyph = #61697
        Color = fcGreen
        Scale = 0.960000000000000000
        Ref.FontName = 'FontAwesome'
        Ref.Glyph = #61697
        Ref.Color = clBlue
        Ref.StandardColor = fcGreen
        Ref.UseStandardColor = True
      end
      item
        Caption = 'Green Expanded'
        Glyph = #61699
        Color = fcGreen
        Scale = 0.960000000000000000
        Ref.FontName = 'FontAwesome'
        Ref.Glyph = #61699
        Ref.Color = clBlue
        Ref.StandardColor = fcGreen
        Ref.UseStandardColor = True
      end>
    Left = 312
    Top = 200
  end
end
