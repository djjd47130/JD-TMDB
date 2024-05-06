object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 536
  ClientWidth = 961
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MM
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 961
    Height = 473
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
    ExplicitWidth = 892
    object tabSetup: TTabSheet
      Caption = 'SETUP'
      ImageIndex = 27
      ExplicitLeft = 0
      ExplicitTop = 42
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 953
        Height = 185
        Align = alTop
        TabOrder = 0
        object gbAPIAuthMethod: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 357
          Height = 177
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
            ExplicitWidth = 321
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
              Top = 27
              Width = 313
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              ExplicitWidth = 281
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
            ExplicitWidth = 305
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
              ExplicitWidth = 265
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
            ExplicitWidth = 321
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
              ExplicitLeft = 239
              ExplicitTop = 0
              ExplicitHeight = 28
            end
          end
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 367
          Top = 4
          Width = 306
          Height = 177
          Align = alLeft
          Caption = 'User Authentication'
          TabOrder = 1
          ExplicitLeft = 335
          ExplicitHeight = 209
          object Panel3: TPanel
            Left = 2
            Top = 20
            Width = 302
            Height = 28
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitWidth = 318
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
              ExplicitLeft = 303
              ExplicitTop = 0
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
            ExplicitLeft = 0
            ExplicitTop = 50
            ExplicitWidth = 430
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
            object Edit2: TEdit
              Left = 16
              Top = 27
              Width = 265
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              ExplicitWidth = 281
            end
          end
          object pAuthPass: TPanel
            Left = 2
            Top = 101
            Width = 302
            Height = 53
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            Visible = False
            ExplicitWidth = 318
            DesignSize = (
              302
              53)
            object Label4: TLabel
              Left = 16
              Top = 8
              Width = 78
              Height = 18
              Caption = 'Password:'
            end
            object Edit4: TEdit
              Left = 16
              Top = 27
              Width = 265
              Height = 26
              Anchors = [akLeft, akTop, akRight]
              PasswordChar = '*'
              TabOrder = 0
              ExplicitWidth = 281
            end
          end
        end
        object pLoginStatus: TGroupBox
          Left = 676
          Top = 1
          Width = 269
          Height = 183
          Align = alLeft
          Caption = 'User Login'
          TabOrder = 2
          ExplicitLeft = 628
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
            ExplicitLeft = 3
            ExplicitWidth = 191
          end
          object pLoginUserInfo: TGroupBox
            AlignWithMargins = True
            Left = 5
            Top = 57
            Width = 259
            Height = 121
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
            ExplicitLeft = 7
            ExplicitTop = 59
            ExplicitWidth = 191
            object Panel4: TPanel
              AlignWithMargins = True
              Left = 95
              Top = 23
              Width = 159
              Height = 93
              Align = alClient
              TabOrder = 0
              ExplicitLeft = 128
              ExplicitTop = 20
              ExplicitWidth = 113
              ExplicitHeight = 131
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
              Height = 93
              Align = alLeft
              TabOrder = 1
              ExplicitHeight = 85
              object Image1: TImage
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 76
                Height = 85
                Align = alClient
                ExplicitLeft = 8
                ExplicitHeight = 77
              end
            end
          end
        end
      end
    end
    object tabAccount: TTabSheet
      Caption = 'Account'
      ExplicitWidth = 884
      ExplicitHeight = 310
      object AccountPages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 249
        ActivePage = tabAccountDetails
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 884
        object tabAccountDetails: TTabSheet
          Caption = 'Account Details'
          ExplicitWidth = 876
        end
        object tabAccountFavorites: TTabSheet
          Caption = 'Favorites'
          ImageIndex = 1
          ExplicitWidth = 876
        end
        object tabAccountWatchlists: TTabSheet
          Caption = 'Watchlists'
          ImageIndex = 2
          ExplicitWidth = 876
        end
        object tabAccountLists: TTabSheet
          Caption = 'Lists'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitWidth = 876
        end
        object Ratings: TTabSheet
          Caption = 'Ratings'
          ImageIndex = 4
          ExplicitWidth = 876
        end
      end
    end
    object tabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 42
      ExplicitWidth = 884
      object CertPages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 249
        ActivePage = tabCertsTV
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 884
        object tabCertsMovies: TTabSheet
          Caption = 'tabCertsMovies'
          ExplicitWidth = 876
        end
        object tabCertsTV: TTabSheet
          Caption = 'tabCertsTV'
          ImageIndex = 1
          ExplicitWidth = 876
        end
      end
    end
    object tabChanges: TTabSheet
      Caption = 'Changes'
      ImageIndex = 2
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabCollections: TTabSheet
      Caption = 'Collections'
      ImageIndex = 3
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabCompanies: TTabSheet
      Caption = 'Companies'
      ImageIndex = 4
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabConfiguration: TTabSheet
      Caption = 'Configuration'
      ImageIndex = 5
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabCredits: TTabSheet
      Caption = 'Credits'
      ImageIndex = 6
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabDiscover: TTabSheet
      Caption = 'Discover'
      ImageIndex = 7
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabFind: TTabSheet
      Caption = 'Find'
      ImageIndex = 8
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabGenres: TTabSheet
      Caption = 'Genres'
      ImageIndex = 9
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabGuestSessions: TTabSheet
      Caption = 'Guest Sessions'
      ImageIndex = 10
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabKeywords: TTabSheet
      Caption = 'Keywords'
      ImageIndex = 11
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabLists: TTabSheet
      Caption = 'Lists'
      ImageIndex = 12
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabMovieLists: TTabSheet
      Caption = 'Movie Lists'
      ImageIndex = 13
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabMovies: TTabSheet
      Caption = 'Movies'
      ImageIndex = 14
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabNetworks: TTabSheet
      Caption = 'Networks'
      ImageIndex = 15
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabPeopleLists: TTabSheet
      Caption = 'People Lists'
      ImageIndex = 16
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabPeople: TTabSheet
      Caption = 'People'
      ImageIndex = 17
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabReviews: TTabSheet
      Caption = 'Reviews'
      ImageIndex = 18
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabSearch: TTabSheet
      Caption = 'Search'
      ImageIndex = 19
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabTrending: TTabSheet
      Caption = 'Trending'
      ImageIndex = 20
      ExplicitTop = 30
      ExplicitWidth = 884
      ExplicitHeight = 318
    end
    object tabTVSeriesLists: TTabSheet
      Caption = 'TV Series Lists'
      ImageIndex = 21
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabTVSeries: TTabSheet
      Caption = 'TV Series'
      ImageIndex = 22
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabTVSeasons: TTabSheet
      Caption = 'TV Seasons'
      ImageIndex = 23
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabTVEpisodes: TTabSheet
      Caption = 'TV Episodes'
      ImageIndex = 24
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabTVEpisodeGroups: TTabSheet
      Caption = 'TV Episode Groups'
      ImageIndex = 25
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
    object tabWatchProviders: TTabSheet
      Caption = 'Watch Providers'
      ImageIndex = 26
      ExplicitWidth = 884
      ExplicitHeight = 310
    end
  end
  object TMDB: TTMDBAPI
    AppUserAgent = 
      'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-' +
      'TMDB)'
    Left = 80
    Top = 480
  end
  object MM: TMainMenu
    Left = 32
    Top = 480
    object Services1: TMenuItem
      Caption = 'Services'
      OnClick = Services1Click
    end
    object Setup1: TMenuItem
      Caption = 'Setup'
      object AppSetup1: TMenuItem
        Caption = 'App Setup'
        OnClick = AppSetup1Click
      end
    end
  end
end
