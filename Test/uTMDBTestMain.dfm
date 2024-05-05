object frmTMDBTestMain: TfrmTMDBTestMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 483
  ClientWidth = 944
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 161
    Align = alTop
    TabOrder = 0
    object gbAPIAuthMethod: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 341
      Height = 153
      Align = alLeft
      Caption = 'API Authentication'
      TabOrder = 0
      ExplicitHeight = 193
      object gbAPIAuthMethodAPIKey: TPanel
        Left = 2
        Top = 43
        Width = 337
        Height = 53
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = 49
        DesignSize = (
          337
          53)
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 42
          Height = 13
          Caption = 'API Key:'
        end
        object Edit1: TEdit
          Left = 16
          Top = 27
          Width = 297
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          ExplicitWidth = 225
        end
      end
      object gbAPIAuthMethodAccessToken: TPanel
        Tag = 1
        Left = 2
        Top = 96
        Width = 337
        Height = 51
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        ExplicitTop = 102
        DesignSize = (
          337
          51)
        object Label3: TLabel
          Left = 16
          Top = 8
          Width = 117
          Height = 13
          Caption = 'API Read Access Token:'
        end
        object Edit3: TEdit
          Left = 16
          Top = 27
          Width = 297
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          ExplicitWidth = 225
        end
      end
      object Panel2: TPanel
        Left = 2
        Top = 15
        Width = 337
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitLeft = 4
        ExplicitTop = 17
        object RadioButton2: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 94
          Top = 3
          Width = 99
          Height = 22
          Align = alLeft
          Caption = 'Access Token'
          TabOrder = 0
          OnClick = APIAuthMethodRadioClick
          ExplicitLeft = 174
          ExplicitTop = 16
          ExplicitHeight = 17
        end
        object RadioButton1: TRadioButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 85
          Height = 22
          Align = alLeft
          Caption = 'API Key'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = APIAuthMethodRadioClick
          ExplicitLeft = 4
          ExplicitTop = 4
          ExplicitHeight = 26
        end
      end
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 351
      Top = 4
      Width = 354
      Height = 153
      Align = alLeft
      Caption = 'User Authentication'
      TabOrder = 1
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 350
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 23
        ExplicitWidth = 421
        object RadioButton3: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 71
          Top = 3
          Width = 90
          Height = 22
          Align = alLeft
          Caption = 'Normal Auth'
          TabOrder = 0
          OnClick = APIAuthMethodRadioClick
        end
        object RadioButton4: TRadioButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 62
          Height = 22
          Align = alLeft
          Caption = 'Guest'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = APIAuthMethodRadioClick
        end
        object RadioButton5: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 167
          Top = 3
          Width = 74
          Height = 22
          Align = alLeft
          Caption = 'V4 Auth'
          TabOrder = 2
          OnClick = APIAuthMethodRadioClick
        end
        object RadioButton6: TRadioButton
          Tag = 1
          AlignWithMargins = True
          Left = 247
          Top = 3
          Width = 90
          Height = 22
          Align = alLeft
          Caption = 'Credentials'
          TabOrder = 3
          OnClick = APIAuthMethodRadioClick
        end
      end
    end
  end
end
