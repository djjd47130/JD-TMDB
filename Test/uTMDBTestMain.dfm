object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 534
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MM
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 33
    Width = 971
    Height = 487
    ActivePage = tabSetup
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabHeight = 32
    TabOrder = 0
    object tabSetup: TTabSheet
      Caption = 'Application Setup'
      ImageIndex = 27
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 963
        Height = 201
        Align = alTop
        TabOrder = 0
        object gbAPIAuthMethod: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 357
          Height = 193
          Align = alLeft
          Caption = 'API Authentication'
          TabOrder = 0
          object gbAPIAuthMethodAPIKey: TPanel
            Left = 2
            Top = 48
            Width = 353
            Height = 53
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              353
              53)
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
              Width = 313
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
          end
          object gbAPIAuthMethodAccessToken: TPanel
            Tag = 1
            Left = 2
            Top = 101
            Width = 353
            Height = 60
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            Visible = False
            DesignSize = (
              353
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
              Width = 313
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
          end
          object Panel2: TPanel
            Left = 2
            Top = 20
            Width = 353
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
            object Button1: TButton
              AlignWithMargins = True
              Left = 284
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
              OnClick = Button1Click
            end
          end
        end
      end
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnUser: TJDFontButton
      AlignWithMargins = True
      Left = 760
      Top = 3
      Width = 208
      Height = 27
      Cursor = crHandPoint
      Align = alRight
      DrawStyle = fdTransparent
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
      ImagePosition = fpImgRight
      Margin = 8
      Spacing = 8
      SubTextFont.Charset = DEFAULT_CHARSET
      SubTextFont.Color = clGray
      SubTextFont.Height = -11
      SubTextFont.Name = 'Tahoma'
      SubTextFont.Style = []
      TabOrder = 0
      Text = 'User Login'
      OnClick = btnUserClick
    end
  end
  object pUser: TPanel
    Left = 56
    Top = 309
    Width = 697
    Height = 188
    TabOrder = 2
    Visible = False
    object gbUserLogin: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 293
      Height = 180
      Align = alLeft
      Caption = 'User Authentication'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 18
        Width = 289
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object RadioButton3: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 111
          Top = 3
          Width = 82
          Height = 18
          Align = alLeft
          Caption = 'Normal'
          TabOrder = 0
          Visible = False
          OnClick = UserAuthMethodClick
        end
        object RadioButton4: TRadioButton
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 70
          Height = 18
          Align = alLeft
          Caption = 'Guest'
          TabOrder = 1
          OnClick = UserAuthMethodClick
        end
        object rbCreds: TRadioButton
          Tag = 2
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 102
          Height = 18
          Align = alLeft
          Caption = 'Credentials'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = UserAuthMethodClick
        end
      end
      object pAuthUser: TPanel
        Left = 2
        Top = 42
        Width = 289
        Height = 51
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 283
          Height = 15
          Align = alClient
          Caption = 'Username:'
          Layout = tlCenter
          ExplicitWidth = 63
          ExplicitHeight = 16
        end
        object txtAuthUser: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 24
          Width = 283
          Height = 24
          Align = alBottom
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object pAuthPass: TPanel
        Left = 2
        Top = 93
        Width = 289
        Height = 50
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 271
          Height = 14
          Margins.Right = 15
          Align = alClient
          Caption = 'Password:'
          Layout = tlCenter
          ExplicitWidth = 60
          ExplicitHeight = 16
        end
        object txtAuthPass: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 23
          Width = 283
          Height = 24
          Align = alBottom
          PasswordChar = '*'
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object btnLogin: TButton
        AlignWithMargins = True
        Left = 52
        Top = 147
        Width = 189
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 50
        Margins.Right = 50
        Align = alBottom
        Caption = 'Login'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btnLoginClick
      end
    end
    object gbUserInfo: TGroupBox
      AlignWithMargins = True
      Left = 303
      Top = 4
      Width = 292
      Height = 180
      Align = alLeft
      Caption = 'User Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 127
        Top = 21
        Width = 160
        Height = 120
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblUserName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 154
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Username'
          ExplicitLeft = 0
          ExplicitTop = 4
          ExplicitWidth = 164
        end
        object lblUserFullName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 27
          Width = 154
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Full Name'
          ExplicitLeft = 0
        end
        object lblUserSessionID: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 154
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Session ID'
          OnDblClick = lblUserSessionIDDblClick
          ExplicitTop = 95
          ExplicitWidth = 181
        end
        object lblUserAccountID: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 75
          Width = 154
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Account ID'
          ExplicitLeft = 0
          ExplicitTop = 92
          ExplicitWidth = 164
        end
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 21
        Width = 116
        Height = 120
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object imgUserAvatar: TImage
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 110
          Height = 114
          Align = alClient
          ExplicitWidth = 22
          ExplicitHeight = 102
        end
      end
      object btnLogout: TButton
        AlignWithMargins = True
        Left = 52
        Top = 147
        Width = 188
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 50
        Margins.Right = 50
        Align = alBottom
        Caption = 'Logout'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnLogoutClick
      end
    end
  end
  object MM: TMainMenu
    Left = 240
    Top = 16
    object Services1: TMenuItem
      Caption = 'Services'
      OnClick = Services1Click
    end
    object Setup1: TMenuItem
      Caption = 'Setup'
      OnClick = Setup1Click
      object AppSetup1: TMenuItem
        Caption = 'Application Setup'
        RadioItem = True
        OnClick = AppSetup1Click
      end
    end
  end
  object TMDB: TTMDB
    AuthMethod = amAccessToken
    OnUserAuthRequest = TMDBUserAuthRequest
    Left = 292
    Top = 15
  end
end
