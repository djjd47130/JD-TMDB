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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 961
    Height = 473
    ActivePage = tabSearch
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
          Height = 177
          Align = alLeft
          Caption = 'User Authentication'
          TabOrder = 1
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
            ExplicitLeft = 9
            ExplicitTop = 114
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
          Height = 177
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
            Height = 115
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
              Height = 87
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
              Height = 87
              Align = alLeft
              TabOrder = 1
              ExplicitHeight = 93
              object Image1: TImage
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 76
                Height = 79
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
      object AccountPages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 249
        ActivePage = tabAccountDetails
        Align = alTop
        TabOrder = 0
        object tabAccountDetails: TTabSheet
          Caption = 'Account Details'
        end
        object tabAccountFavorites: TTabSheet
          Caption = 'Favorites'
          ImageIndex = 1
        end
        object tabAccountWatchlists: TTabSheet
          Caption = 'Watchlists'
          ImageIndex = 2
        end
        object tabAccountLists: TTabSheet
          Caption = 'Lists'
          ImageIndex = 3
        end
        object Ratings: TTabSheet
          Caption = 'Ratings'
          ImageIndex = 4
        end
      end
    end
    object tabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 1
      object CertPages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 385
        ActivePage = tabCertsTV
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object tabCertsMovies: TTabSheet
          Caption = 'Movie Certifications'
          ExplicitHeight = 216
          object btnRefreshCertsMovies: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 939
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsMoviesClick
            ExplicitLeft = 6
            ExplicitTop = 11
          end
          object lstCertsMovies: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 939
            Height = 312
            Align = alClient
            Color = clSilver
            Columns = <
              item
                Caption = 'Order'
                Width = 80
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
            StyleElements = []
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            ExplicitLeft = 51
            ExplicitTop = 157
          end
        end
        object tabCertsTV: TTabSheet
          Caption = 'TV Certifications'
          ImageIndex = 1
          ExplicitLeft = 0
          object btnRefreshCertsTV: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 939
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = btnRefreshCertsTVClick
            ExplicitLeft = 6
            ExplicitTop = 11
          end
          object lstCertsTV: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 939
            Height = 312
            Align = alClient
            Color = clSilver
            Columns = <
              item
                Caption = 'Order'
                Width = 80
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
            StyleElements = []
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            ExplicitLeft = 6
            ExplicitTop = 40
          end
        end
      end
    end
    object tabChanges: TTabSheet
      Caption = 'Changes'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitTop = 42
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 249
        ActivePage = TabSheet1
        Align = alTop
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Movie Changes'
          ExplicitLeft = 0
        end
        object TabSheet2: TTabSheet
          Caption = 'Person Changes'
          ImageIndex = 1
        end
        object TabSheet3: TTabSheet
          Caption = 'TV Changes'
          ImageIndex = 2
        end
      end
    end
    object tabCollections: TTabSheet
      Caption = 'Collections'
      ImageIndex = 3
      ExplicitLeft = 8
      ExplicitTop = 42
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 249
        ActivePage = TabSheet4
        Align = alTop
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'Details'
        end
        object TabSheet5: TTabSheet
          Caption = 'Images'
          ImageIndex = 1
        end
        object TabSheet6: TTabSheet
          Caption = 'Translations'
          ImageIndex = 2
        end
      end
    end
    object tabCompanies: TTabSheet
      Caption = 'Companies'
      ImageIndex = 4
    end
    object tabConfiguration: TTabSheet
      Caption = 'Configuration'
      ImageIndex = 5
    end
    object tabCredits: TTabSheet
      Caption = 'Credits'
      ImageIndex = 6
    end
    object tabDiscover: TTabSheet
      Caption = 'Discover'
      ImageIndex = 7
    end
    object tabFind: TTabSheet
      Caption = 'Find'
      ImageIndex = 8
    end
    object tabGenres: TTabSheet
      Caption = 'Genres'
      ImageIndex = 9
      object GenrePages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 385
        ActivePage = TabSheet7
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object TabSheet7: TTabSheet
          Caption = 'Movie Genres'
          object Button2: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 939
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = Button2Click
          end
          object lstGenreMovies: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 939
            Height = 312
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
            StyleElements = []
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            ExplicitLeft = 6
            ExplicitTop = 40
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'TV Genres'
          ImageIndex = 1
          object Button3: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 939
            Height = 28
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = Button3Click
          end
          object lstGenreTV: TListView
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 939
            Height = 312
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
            StyleElements = []
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
          end
        end
      end
    end
    object tabGuestSessions: TTabSheet
      Caption = 'Guest Sessions'
      ImageIndex = 10
    end
    object tabKeywords: TTabSheet
      Caption = 'Keywords'
      ImageIndex = 11
    end
    object tabLists: TTabSheet
      Caption = 'Lists'
      ImageIndex = 12
    end
    object tabMovieLists: TTabSheet
      Caption = 'Movie Lists'
      ImageIndex = 13
    end
    object tabMovies: TTabSheet
      Caption = 'Movies'
      ImageIndex = 14
    end
    object tabNetworks: TTabSheet
      Caption = 'Networks'
      ImageIndex = 15
    end
    object tabPeopleLists: TTabSheet
      Caption = 'People Lists'
      ImageIndex = 16
    end
    object tabPeople: TTabSheet
      Caption = 'People'
      ImageIndex = 17
    end
    object tabReviews: TTabSheet
      Caption = 'Reviews'
      ImageIndex = 18
    end
    object tabSearch: TTabSheet
      Caption = 'Search'
      ImageIndex = 19
      ExplicitLeft = 8
      ExplicitTop = 42
      object SearchPages: TPageControl
        Left = 0
        Top = 0
        Width = 953
        Height = 385
        ActivePage = TabSheet12
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object TabSheet9: TTabSheet
          Caption = 'Search Collection'
        end
        object TabSheet10: TTabSheet
          Caption = 'Search Company'
          ImageIndex = 1
        end
        object TabSheet11: TTabSheet
          Caption = 'Search Keyword'
          ImageIndex = 2
        end
        object TabSheet12: TTabSheet
          Caption = 'Search Movie'
          ImageIndex = 3
          object lstSearchMovies: TListView
            AlignWithMargins = True
            Left = 268
            Top = 3
            Width = 674
            Height = 346
            Align = alClient
            Color = clSilver
            Columns = <
              item
                Caption = 'Movie'
                Width = 220
              end
              item
                Caption = 'ID'
                Width = 80
              end
              item
                Caption = 'Genre'
                Width = 180
              end
              item
                Caption = 'Year'
                Width = 80
              end>
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            StyleElements = []
            GroupView = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            ExplicitLeft = 220
            ExplicitWidth = 722
          end
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 265
            Height = 352
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object Panel7: TPanel
              Left = 0
              Top = 0
              Width = 265
              Height = 57
              Align = alTop
              TabOrder = 0
              object Label8: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 257
                Height = 18
                Align = alTop
                Caption = 'Search Query:'
                ExplicitWidth = 107
              end
              object txtSearchMoviesQuery: TEdit
                AlignWithMargins = True
                Left = 4
                Top = 28
                Width = 257
                Height = 25
                Align = alClient
                TabOrder = 0
                ExplicitLeft = 32
                ExplicitTop = 40
                ExplicitWidth = 121
                ExplicitHeight = 26
              end
            end
            object Panel8: TPanel
              Left = 0
              Top = 57
              Width = 265
              Height = 57
              Align = alTop
              TabOrder = 1
              object Label9: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 257
                Height = 18
                Align = alTop
                Caption = 'Include Adult:'
                ExplicitWidth = 104
              end
              object ComboBox1: TComboBox
                AlignWithMargins = True
                Left = 4
                Top = 28
                Width = 257
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
                ExplicitLeft = 5
              end
            end
            object Button4: TButton
              AlignWithMargins = True
              Left = 3
              Top = 324
              Width = 259
              Height = 25
              Cursor = crHandPoint
              Align = alBottom
              Caption = 'Apply Search -->'
              TabOrder = 2
              ExplicitLeft = 96
              ExplicitTop = 264
              ExplicitWidth = 75
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = 'Search Multi'
          ImageIndex = 4
        end
        object TabSheet14: TTabSheet
          Caption = 'Search Person'
          ImageIndex = 5
        end
        object TabSheet15: TTabSheet
          Caption = 'Search TV'
          ImageIndex = 6
        end
      end
    end
    object tabTrending: TTabSheet
      Caption = 'Trending'
      ImageIndex = 20
    end
    object tabTVSeriesLists: TTabSheet
      Caption = 'TV Series Lists'
      ImageIndex = 21
    end
    object tabTVSeries: TTabSheet
      Caption = 'TV Series'
      ImageIndex = 22
    end
    object tabTVSeasons: TTabSheet
      Caption = 'TV Seasons'
      ImageIndex = 23
    end
    object tabTVEpisodes: TTabSheet
      Caption = 'TV Episodes'
      ImageIndex = 24
    end
    object tabTVEpisodeGroups: TTabSheet
      Caption = 'TV Episode Groups'
      ImageIndex = 25
    end
    object tabWatchProviders: TTabSheet
      Caption = 'Watch Providers'
      ImageIndex = 26
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
      OnClick = Setup1Click
      object AppSetup1: TMenuItem
        Caption = 'Application Setup'
        RadioItem = True
        OnClick = AppSetup1Click
      end
    end
  end
end
