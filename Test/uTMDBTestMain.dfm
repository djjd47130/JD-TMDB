object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 484
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
    Top = 41
    Width = 971
    Height = 437
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
    object tabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 1
      object CertPages: TPageControl
        Left = 0
        Top = 0
        Width = 963
        Height = 349
        ActivePage = tabCertsMovies
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object tabCertsMovies: TTabSheet
          Caption = 'Movie Certifications'
          object btnRefreshCertsMovies: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 949
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsMoviesClick
          end
          object lstCertsMovies: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 949
            Height = 276
            Align = alClient
            Color = clSilver
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
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
          end
        end
        object tabCertsTV: TTabSheet
          Caption = 'TV Certifications'
          ImageIndex = 1
          object btnRefreshCertsTV: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 949
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsTVClick
          end
          object lstCertsTV: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 949
            Height = 276
            Align = alClient
            Color = clSilver
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
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
          end
        end
      end
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnUser: TJDFontButton
      AlignWithMargins = True
      Left = 797
      Top = 3
      Width = 171
      Height = 35
      Cursor = crHandPoint
      Align = alRight
      DrawStyle = fdTransparent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Image.AutoSize = False
      Image.Text = #61572
      Image.Font.Charset = DEFAULT_CHARSET
      Image.Font.Color = clWindowText
      Image.Font.Height = -21
      Image.Font.Name = 'FontAwesome'
      Image.Font.Style = []
      Image.Font.Quality = fqAntialiased
      Image.StandardColor = fcBlue
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
    Left = 152
    Top = 274
    Width = 697
    Height = 199
    TabOrder = 2
    Visible = False
    object gbUserLogin: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 293
      Height = 191
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
        Height = 53
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          289
          53)
        object Label2: TLabel
          Left = 15
          Top = 8
          Width = 63
          Height = 16
          Caption = 'Username:'
        end
        object txtAuthUser: TEdit
          Left = 15
          Top = 29
          Width = 259
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object pAuthPass: TPanel
        Left = 2
        Top = 95
        Width = 289
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        DesignSize = (
          289
          60)
        object Label4: TLabel
          Left = 15
          Top = 8
          Width = 60
          Height = 16
          Margins.Right = 15
          Caption = 'Password:'
        end
        object txtAuthPass: TEdit
          Left = 15
          Top = 32
          Width = 259
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object btnLogin: TButton
        AlignWithMargins = True
        Left = 17
        Top = 158
        Width = 259
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 15
        Margins.Right = 15
        Align = alBottom
        Caption = 'Login'
        TabOrder = 3
        OnClick = btnLoginClick
      end
    end
    object gbUserInfo: TGroupBox
      AlignWithMargins = True
      Left = 303
      Top = 4
      Width = 292
      Height = 191
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
        Left = 143
        Top = 21
        Width = 144
        Height = 131
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblUserName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 138
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
          Width = 138
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Full Name'
          ExplicitTop = 71
          ExplicitWidth = 181
        end
        object lblUserSessionID: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 138
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
          Width = 138
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
        Width = 132
        Height = 131
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object imgUserAvatar: TImage
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 126
          Height = 125
          Align = alClient
          ExplicitLeft = 8
          ExplicitTop = 4
          ExplicitWidth = 76
          ExplicitHeight = 87
        end
      end
      object btnLogout: TButton
        AlignWithMargins = True
        Left = 17
        Top = 158
        Width = 258
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 15
        Margins.Right = 15
        Align = alBottom
        Caption = 'Logout'
        TabOrder = 2
        OnClick = btnLogoutClick
      end
    end
  end
  object MM: TMainMenu
    Left = 32
    Top = 344
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
    Left = 92
    Top = 343
  end
end
