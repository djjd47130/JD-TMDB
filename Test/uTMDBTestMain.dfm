object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 554
  ClientWidth = 991
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 991
    Height = 507
    ActivePage = tabCertifications
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
      ExplicitWidth = 953
      ExplicitHeight = 431
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 193
        Align = alTop
        TabOrder = 0
        object gbAPIAuthMethod: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 357
          Height = 185
          Align = alLeft
          Caption = 'API Authentication'
          TabOrder = 0
          ExplicitHeight = 177
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
            ExplicitLeft = 1
            ExplicitTop = 22
            object RadioButton2: TRadioButton
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
            object RadioButton1: TRadioButton
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
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 367
          Top = 4
          Width = 306
          Height = 185
          Align = alLeft
          Caption = 'User Authentication'
          TabOrder = 1
          ExplicitHeight = 177
          object Panel3: TPanel
            Left = 2
            Top = 20
            Width = 302
            Height = 28
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object RadioButton3: TRadioButton
              Tag = 1
              AlignWithMargins = True
              Left = 79
              Top = 3
              Width = 90
              Height = 22
              Align = alLeft
              Caption = 'Normal'
              TabOrder = 0
              OnClick = UserAuthMethodClick
            end
            object RadioButton4: TRadioButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 70
              Height = 22
              Align = alLeft
              Caption = 'Guest'
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = UserAuthMethodClick
            end
            object RadioButton6: TRadioButton
              Tag = 2
              AlignWithMargins = True
              Left = 175
              Top = 3
              Width = 114
              Height = 22
              Align = alLeft
              Caption = 'Credentials'
              TabOrder = 2
              OnClick = UserAuthMethodClick
            end
          end
          object pAuthUser: TPanel
            Left = 2
            Top = 48
            Width = 302
            Height = 53
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            Visible = False
            DesignSize = (
              302
              53)
            object Label2: TLabel
              Left = 16
              Top = 8
              Width = 80
              Height = 18
              Caption = 'Username:'
            end
            object txtAuthUser: TEdit
              Left = 16
              Top = 29
              Width = 265
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
          end
          object pAuthPass: TPanel
            Left = 2
            Top = 101
            Width = 302
            Height = 60
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            Visible = False
            ExplicitLeft = -2
            ExplicitTop = 149
            DesignSize = (
              302
              60)
            object Label4: TLabel
              Left = 16
              Top = 8
              Width = 78
              Height = 18
              Caption = 'Password:'
            end
            object txtAuthPass: TEdit
              Left = 16
              Top = 32
              Width = 265
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              PasswordChar = '*'
              TabOrder = 0
            end
          end
        end
        object pLoginStatus: TGroupBox
          AlignWithMargins = True
          Left = 679
          Top = 4
          Width = 269
          Height = 185
          Align = alLeft
          Caption = 'User Login'
          TabOrder = 2
          ExplicitLeft = 676
          ExplicitTop = 1
          ExplicitHeight = 183
          object btnLoginLogout: TButton
            AlignWithMargins = True
            Left = 5
            Top = 23
            Width = 259
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Login'
            TabOrder = 0
            OnClick = btnLoginLogoutClick
            ExplicitLeft = 7
          end
          object pLoginUserInfo: TGroupBox
            AlignWithMargins = True
            Left = 5
            Top = 57
            Width = 259
            Height = 123
            Align = alClient
            Caption = 'User Info'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
            ExplicitHeight = 121
            object Panel4: TPanel
              AlignWithMargins = True
              Left = 95
              Top = 23
              Width = 159
              Height = 95
              Align = alClient
              TabOrder = 0
              ExplicitHeight = 93
              object Label5: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 151
                Height = 18
                Align = alTop
                AutoSize = False
                Caption = 'Username'
                ExplicitLeft = 8
                ExplicitTop = 12
                ExplicitWidth = 201
              end
              object Label6: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 28
                Width = 151
                Height = 18
                Align = alTop
                AutoSize = False
                Caption = 'Full Name'
                ExplicitLeft = 3
                ExplicitTop = 71
                ExplicitWidth = 181
              end
              object Label7: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 52
                Width = 151
                Height = 18
                Align = alTop
                AutoSize = False
                Caption = 'Session ID'
                ExplicitLeft = 3
                ExplicitTop = 95
                ExplicitWidth = 181
              end
            end
            object Panel5: TPanel
              AlignWithMargins = True
              Left = 5
              Top = 23
              Width = 84
              Height = 95
              Align = alLeft
              TabOrder = 1
              ExplicitHeight = 93
              object Image1: TImage
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 76
                Height = 87
                Align = alClient
                ExplicitLeft = 8
                ExplicitHeight = 77
              end
            end
          end
        end
      end
    end
    object tabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 1
      ExplicitWidth = 953
      ExplicitHeight = 431
      object CertPages: TPageControl
        Left = 0
        Top = 0
        Width = 983
        Height = 419
        ActivePage = tabCertsMovies
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitWidth = 953
        ExplicitHeight = 385
        object tabCertsMovies: TTabSheet
          Caption = 'Movie Certifications'
          ExplicitWidth = 945
          ExplicitHeight = 216
          object btnRefreshCertsMovies: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 969
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsMoviesClick
            ExplicitLeft = 6
            ExplicitTop = 11
            ExplicitWidth = 939
          end
          object lstCertsMovies: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 969
            Height = 346
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
            ExplicitLeft = 51
            ExplicitTop = 157
            ExplicitWidth = 939
            ExplicitHeight = 312
          end
        end
        object tabCertsTV: TTabSheet
          Caption = 'TV Certifications'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitWidth = 945
          ExplicitHeight = 352
          object btnRefreshCertsTV: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 969
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsTVClick
            ExplicitLeft = 6
            ExplicitTop = 11
            ExplicitWidth = 939
          end
          object lstCertsTV: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 969
            Height = 346
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
            ExplicitLeft = 6
            ExplicitTop = 40
            ExplicitWidth = 939
            ExplicitHeight = 312
          end
        end
      end
    end
    object tabGenres: TTabSheet
      Caption = 'Genres'
      ImageIndex = 9
      ExplicitWidth = 953
      ExplicitHeight = 431
      object GenrePages: TPageControl
        Left = 0
        Top = 0
        Width = 983
        Height = 419
        ActivePage = TabSheet7
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitWidth = 953
        ExplicitHeight = 385
        object TabSheet7: TTabSheet
          Caption = 'Movie Genres'
          ExplicitWidth = 945
          ExplicitHeight = 352
          object Button2: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 969
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = Button2Click
            ExplicitWidth = 939
          end
          object lstGenreMovies: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 969
            Height = 346
            Align = alClient
            Color = clSilver
            Columns = <
              item
                Caption = 'Genre Name'
                Width = 250
              end
              item
                Caption = 'ID'
                Width = 100
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            ExplicitLeft = 6
            ExplicitTop = 40
            ExplicitWidth = 939
            ExplicitHeight = 312
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'TV Genres'
          ImageIndex = 1
          ExplicitWidth = 945
          ExplicitHeight = 352
          object Button3: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 969
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = Button3Click
            ExplicitWidth = 939
          end
          object lstGenreTV: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 969
            Height = 346
            Align = alClient
            Color = clSilver
            Columns = <
              item
                Caption = 'Genre Name'
                Width = 250
              end
              item
                Caption = 'ID'
                Width = 100
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            ExplicitWidth = 939
            ExplicitHeight = 312
          end
        end
      end
    end
  end
  object TMDB: TTMDBAPI
    AppUserAgent = 
      'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-' +
      'TMDB)'
    Left = 72
    Top = 440
  end
  object MM: TMainMenu
    Left = 8
    Top = 440
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
end
