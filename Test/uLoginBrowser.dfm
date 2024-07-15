object frmLoginBrowser: TfrmLoginBrowser
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login to TMDB'
  ClientHeight = 496
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edge: TEdgeBrowser
    AlignWithMargins = True
    Left = 20
    Top = 20
    Width = 731
    Height = 456
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 20
    Align = alClient
    TabOrder = 0
    OnNavigationCompleted = EdgeNavigationCompleted
  end
end
