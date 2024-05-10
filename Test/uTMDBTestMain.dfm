object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 588
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
    Height = 541
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
      ExplicitWidth = 953
      ExplicitHeight = 431
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 185
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 953
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
    object tabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 1
      ExplicitWidth = 953
      ExplicitHeight = 431
      object CertPages: TPageControl
        Left = 0
        Top = 0
        Width = 983
        Height = 453
        ActivePage = tabCertsTV
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
            Height = 380
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
            Height = 380
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
        Height = 453
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
            Height = 380
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
            Height = 380
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
    object tabSearch: TTabSheet
      Caption = 'Search'
      ImageIndex = 19
      ExplicitWidth = 953
      ExplicitHeight = 447
      object SearchPages: TPageControl
        Left = 0
        Top = 0
        Width = 983
        Height = 477
        ActivePage = TabSheet12
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitWidth = 953
        ExplicitHeight = 425
        object TabSheet9: TTabSheet
          Caption = 'Search Collections'
          ExplicitWidth = 945
          ExplicitHeight = 352
        end
        object TabSheet10: TTabSheet
          Caption = 'Search Companies'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitWidth = 945
          ExplicitHeight = 392
        end
        object TabSheet11: TTabSheet
          Caption = 'Search Keywords'
          ImageIndex = 2
          ExplicitWidth = 945
          ExplicitHeight = 352
        end
        object TabSheet12: TTabSheet
          Caption = 'Search Movies'
          ImageIndex = 3
          ExplicitWidth = 945
          ExplicitHeight = 352
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 265
            Height = 444
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitLeft = -2
            ExplicitHeight = 396
            object Panel7: TPanel
              Left = 0
              Top = 0
              Width = 265
              Height = 57
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object Label8: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Search Query:'
                ExplicitLeft = 4
                ExplicitTop = 4
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
              BevelOuter = bvNone
              TabOrder = 1
              object Label9: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Include Adult:'
                ExplicitLeft = 4
                ExplicitTop = 4
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
                ExplicitLeft = 5
                ExplicitTop = 25
                ExplicitWidth = 257
              end
            end
            object btnSearchMoviesApply: TButton
              AlignWithMargins = True
              Left = 3
              Top = 416
              Width = 259
              Height = 25
              Cursor = crHandPoint
              Align = alBottom
              Caption = 'Apply Search -->'
              TabOrder = 2
              OnClick = btnSearchMoviesApplyClick
              ExplicitLeft = 96
              ExplicitTop = 264
              ExplicitWidth = 75
            end
            object Panel9: TPanel
              Left = 0
              Top = 114
              Width = 265
              Height = 57
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 3
              ExplicitLeft = 24
              ExplicitTop = 216
              object Label10: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Language:'
                ExplicitLeft = 4
                ExplicitTop = 4
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
                ExplicitLeft = 8
                ExplicitTop = 31
                ExplicitWidth = 257
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
              ExplicitLeft = -3
              ExplicitTop = 234
              object Label11: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Region:'
                ExplicitLeft = 4
                ExplicitTop = 4
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
                ExplicitLeft = 5
                ExplicitTop = 28
                ExplicitWidth = 257
              end
            end
            object Panel13: TPanel
              Left = 0
              Top = 228
              Width = 265
              Height = 57
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 5
              ExplicitLeft = 16
              ExplicitTop = 301
              object Label14: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Primary Release Year:'
                ExplicitLeft = 4
                ExplicitTop = 4
                ExplicitWidth = 169
              end
              object txtSearchMoviesPrimaryReleaseYear: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 27
                Width = 259
                Height = 27
                Align = alClient
                TabOrder = 0
                ExplicitLeft = 4
                ExplicitTop = 28
                ExplicitWidth = 257
                ExplicitHeight = 26
              end
            end
            object Panel14: TPanel
              Left = 0
              Top = 285
              Width = 265
              Height = 57
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 6
              ExplicitLeft = 24
              ExplicitTop = 336
              object Label15: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 259
                Height = 18
                Align = alTop
                Caption = 'Year:'
                ExplicitLeft = 4
                ExplicitTop = 4
                ExplicitWidth = 41
              end
              object txtSearchMoviesYear: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 27
                Width = 259
                Height = 27
                Align = alClient
                TabOrder = 0
                ExplicitLeft = 4
                ExplicitTop = 28
                ExplicitWidth = 257
                ExplicitHeight = 26
              end
            end
          end
          object Panel11: TPanel
            Left = 265
            Top = 0
            Width = 710
            Height = 444
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitLeft = 488
            ExplicitWidth = 457
            ExplicitHeight = 392
            object lstSearchMovies: TListView
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 704
              Height = 406
              Align = alClient
              Color = clSilver
              Columns = <
                item
                  Caption = 'Movie'
                  Width = 250
                end
                item
                  Caption = 'Popularity'
                  Width = 100
                end
                item
                  Caption = 'Genre'
                  Width = 180
                end
                item
                  Caption = 'Released'
                  Width = 120
                end
                item
                  Caption = 'Description'
                  Width = 400
                end>
              HideSelection = False
              HotTrackStyles = [htHandPoint, htUnderlineHot]
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object Panel12: TPanel
              Left = 0
              Top = 412
              Width = 710
              Height = 32
              Align = alBottom
              TabOrder = 1
              ExplicitLeft = 3
              ExplicitTop = 363
              ExplicitWidth = 680
              object lblSearchMoviesResults: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 165
                Height = 24
                Align = alLeft
                AutoSize = False
                Caption = '0 Results'
                Layout = tlCenter
                ExplicitTop = 3
              end
              object lblSearchMoviesPage: TLabel
                AlignWithMargins = True
                Left = 218
                Top = 4
                Width = 119
                Height = 24
                Align = alLeft
                Alignment = taCenter
                AutoSize = False
                Caption = 'Page 1 of 1'
                Layout = tlCenter
                ExplicitTop = 3
              end
              object btnSearchMoviesPagePrev: TButton
                AlignWithMargins = True
                Left = 175
                Top = 4
                Width = 37
                Height = 24
                Cursor = crHandPoint
                Align = alLeft
                Caption = '<'
                TabOrder = 0
                OnClick = btnSearchMoviesPagePrevClick
                ExplicitTop = 3
              end
              object btnSearchMoviesPageNext: TButton
                AlignWithMargins = True
                Left = 343
                Top = 4
                Width = 37
                Height = 24
                Cursor = crHandPoint
                Align = alLeft
                Caption = '>'
                TabOrder = 1
                OnClick = btnSearchMoviesPageNextClick
                ExplicitLeft = 375
                ExplicitTop = 3
              end
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = 'Search Multi'
          ImageIndex = 4
          ExplicitWidth = 945
          ExplicitHeight = 352
        end
        object TabSheet14: TTabSheet
          Caption = 'Search People'
          ImageIndex = 5
          ExplicitWidth = 945
          ExplicitHeight = 352
        end
        object TabSheet15: TTabSheet
          Caption = 'Search TV'
          ImageIndex = 6
          ExplicitWidth = 945
          ExplicitHeight = 352
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
