inherited frmTMDBAppSetup: TfrmTMDBAppSetup
  Caption = 'App Setup'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 187
    Align = alTop
    TabOrder = 0
    object gbAPIAuthMethod: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 341
      Height = 179
      Align = alLeft
      Caption = 'API Authentication'
      TabOrder = 0
      object gbAPIAuthMethodAPIKey: TPanel
        Left = 2
        Top = 48
        Width = 337
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          337
          55)
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 64
          Height = 18
          Caption = 'API Key:'
        end
        object txtAPIKey: TEdit
          Left = 16
          Top = 29
          Width = 305
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = txtAPIKeyChange
        end
      end
      object gbAPIAuthMethodAccessToken: TPanel
        Tag = 1
        Left = 2
        Top = 103
        Width = 337
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        DesignSize = (
          337
          60)
        object Label3: TLabel
          Left = 16
          Top = 8
          Width = 178
          Height = 18
          Caption = 'API Read Access Token:'
        end
        object txtAccessToken: TEdit
          Left = 16
          Top = 32
          Width = 305
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = txtAccessTokenChange
        end
      end
      object Panel2: TPanel
        Left = 2
        Top = 20
        Width = 337
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object rAuthToken: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 103
          Top = 3
          Width = 130
          Height = 22
          Align = alLeft
          Caption = 'Access Token'
          TabOrder = 0
          OnClick = APIAuthMethodRadioClick
        end
        object rAuthKey: TRadioButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 94
          Height = 22
          Align = alLeft
          Caption = 'API Key'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = APIAuthMethodRadioClick
        end
        object btnValidateKey: TButton
          AlignWithMargins = True
          Left = 268
          Top = 3
          Width = 66
          Height = 22
          Cursor = crHandPoint
          Align = alRight
          Caption = 'Validate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnValidateKeyClick
        end
      end
    end
    object gbLocaleOptions: TGroupBox
      AlignWithMargins = True
      Left = 351
      Top = 4
      Width = 170
      Height = 179
      Align = alLeft
      Caption = 'Locale Options'
      TabOrder = 1
      object Panel6: TPanel
        Left = 2
        Top = 20
        Width = 166
        Height = 69
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 160
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Default Language:'
          ExplicitLeft = 16
          ExplicitTop = 8
          ExplicitWidth = 64
        end
        object cboLanguage: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 27
          Width = 160
          Height = 26
          Cursor = crHandPoint
          Align = alTop
          TabOrder = 0
          OnChange = cboLanguageChange
        end
      end
    end
  end
  object btnSave: TJDFontButton
    Left = 0
    Top = 187
    Width = 754
    Height = 46
    Cursor = crHandPoint
    Align = alTop
    DrawStyle = fdTransparent
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Image.AutoSize = False
    Image.Text = #61572
    Image.Font.Charset = DEFAULT_CHARSET
    Image.Font.Color = clWindowText
    Image.Font.Height = -24
    Image.Font.Name = 'FontAwesome'
    Image.Font.Style = []
    Image.Font.Quality = fqAntialiased
    Image.StandardColor = fcOrange
    Overlay.Text = #57715
    Overlay.Font.Charset = DEFAULT_CHARSET
    Overlay.Font.Color = clWindowText
    Overlay.Font.Height = -7
    Overlay.Font.Name = 'FontAwesome'
    Overlay.Font.Style = []
    Overlay.Font.Quality = fqAntialiased
    Overlay.Position = foNone
    Overlay.Margin = 3
    Margin = 8
    Spacing = 8
    SubTextFont.Charset = DEFAULT_CHARSET
    SubTextFont.Color = clGray
    SubTextFont.Height = -11
    SubTextFont.Name = 'Tahoma'
    SubTextFont.Style = []
    TabOrder = 1
    Text = 'Save Setup'
    OnClick = btnSaveClick
  end
end
