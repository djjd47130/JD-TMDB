object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'TMDB API Test'
  ClientHeight = 554
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
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
    object Tabs: TChromeTabs
      Left = 0
      Top = 0
      Width = 757
      Height = 33
      OnActiveTabChanged = TabsActiveTabChanged
      OnButtonCloseTabClick = TabsButtonCloseTabClick
      ActiveTabIndex = -1
      Options.Display.CloseButton.Offsets.Vertical = 7
      Options.Display.CloseButton.Offsets.Horizontal = 2
      Options.Display.CloseButton.Height = 14
      Options.Display.CloseButton.Width = 14
      Options.Display.CloseButton.AutoHide = True
      Options.Display.CloseButton.Visibility = bvActive
      Options.Display.CloseButton.AutoHideWidth = 20
      Options.Display.CloseButton.CrossRadialOffset = 4
      Options.Display.AddButton.Offsets.Vertical = 10
      Options.Display.AddButton.Offsets.Horizontal = 2
      Options.Display.AddButton.Height = 14
      Options.Display.AddButton.Width = 31
      Options.Display.AddButton.ShowPlusSign = False
      Options.Display.AddButton.Visibility = avNone
      Options.Display.AddButton.HorizontalOffsetFloating = -3
      Options.Display.ScrollButtonLeft.Offsets.Vertical = 10
      Options.Display.ScrollButtonLeft.Offsets.Horizontal = 1
      Options.Display.ScrollButtonLeft.Height = 15
      Options.Display.ScrollButtonLeft.Width = 15
      Options.Display.ScrollButtonRight.Offsets.Vertical = 10
      Options.Display.ScrollButtonRight.Offsets.Horizontal = 1
      Options.Display.ScrollButtonRight.Height = 15
      Options.Display.ScrollButtonRight.Width = 15
      Options.Display.TabModifiedGlow.Style = msRightToLeft
      Options.Display.TabModifiedGlow.VerticalOffset = -6
      Options.Display.TabModifiedGlow.Height = 30
      Options.Display.TabModifiedGlow.Width = 100
      Options.Display.TabModifiedGlow.AnimationPeriodMS = 4000
      Options.Display.TabModifiedGlow.EaseType = ttEaseInOutQuad
      Options.Display.TabModifiedGlow.AnimationUpdateMS = 50
      Options.Display.Tabs.SeeThroughTabs = False
      Options.Display.Tabs.TabOverlap = 15
      Options.Display.Tabs.ContentOffsetLeft = 30
      Options.Display.Tabs.ContentOffsetRight = 30
      Options.Display.Tabs.OffsetLeft = 0
      Options.Display.Tabs.OffsetTop = 4
      Options.Display.Tabs.OffsetRight = 0
      Options.Display.Tabs.OffsetBottom = 0
      Options.Display.Tabs.MinWidth = 30
      Options.Display.Tabs.MaxWidth = 250
      Options.Display.Tabs.TabWidthFromContent = True
      Options.Display.Tabs.PinnedWidth = 39
      Options.Display.Tabs.ImageOffsetLeft = 13
      Options.Display.Tabs.TextTrimType = tttFade
      Options.Display.Tabs.Orientation = toTop
      Options.Display.Tabs.BaseLineTabRegionOnly = False
      Options.Display.Tabs.WordWrap = False
      Options.Display.Tabs.TextAlignmentHorizontal = taLeftJustify
      Options.Display.Tabs.TextAlignmentVertical = taVerticalCenter
      Options.Display.Tabs.ShowImages = True
      Options.Display.Tabs.ShowPinnedTabText = False
      Options.Display.TabContainer.TransparentBackground = True
      Options.Display.TabContainer.OverlayButtons = True
      Options.Display.TabContainer.PaddingLeft = 0
      Options.Display.TabContainer.PaddingRight = 0
      Options.Display.TabMouseGlow.Offsets.Vertical = 0
      Options.Display.TabMouseGlow.Offsets.Horizontal = 0
      Options.Display.TabMouseGlow.Height = 200
      Options.Display.TabMouseGlow.Width = 200
      Options.Display.TabMouseGlow.Visible = True
      Options.Display.TabSpinners.Upload.ReverseDirection = True
      Options.Display.TabSpinners.Upload.RenderedAnimationStep = 2
      Options.Display.TabSpinners.Upload.Position.Offsets.Vertical = 0
      Options.Display.TabSpinners.Upload.Position.Offsets.Horizontal = 0
      Options.Display.TabSpinners.Upload.Position.Height = 16
      Options.Display.TabSpinners.Upload.Position.Width = 16
      Options.Display.TabSpinners.Upload.SweepAngle = 135
      Options.Display.TabSpinners.Download.ReverseDirection = False
      Options.Display.TabSpinners.Download.RenderedAnimationStep = 5
      Options.Display.TabSpinners.Download.Position.Offsets.Vertical = 0
      Options.Display.TabSpinners.Download.Position.Offsets.Horizontal = 0
      Options.Display.TabSpinners.Download.Position.Height = 16
      Options.Display.TabSpinners.Download.Position.Width = 16
      Options.Display.TabSpinners.Download.SweepAngle = 135
      Options.Display.TabSpinners.AnimationUpdateMS = 50
      Options.Display.TabSpinners.HideImagesWhenSpinnerVisible = True
      Options.DragDrop.DragType = dtBetweenContainers
      Options.DragDrop.DragOutsideImageAlpha = 220
      Options.DragDrop.DragOutsideDistancePixels = 30
      Options.DragDrop.DragStartPixels = 20
      Options.DragDrop.DragControlImageResizeFactor = 0.500000000000000000
      Options.DragDrop.DragCursor = crDefault
      Options.DragDrop.DragDisplay = ddTabAndControl
      Options.DragDrop.DragFormBorderWidth = 2
      Options.DragDrop.DragFormBorderColor = 8421504
      Options.DragDrop.ContrainDraggedTabWithinContainer = True
      Options.Animation.DefaultMovementAnimationTimeMS = 100
      Options.Animation.DefaultStyleAnimationTimeMS = 300
      Options.Animation.AnimationTimerInterval = 15
      Options.Animation.MinimumTabAnimationWidth = 40
      Options.Animation.DefaultMovementEaseType = ttLinearTween
      Options.Animation.DefaultStyleEaseType = ttLinearTween
      Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType = True
      Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime = True
      Options.Animation.MovementAnimations.TabAdd.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS = 500
      Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType = True
      Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime = True
      Options.Animation.MovementAnimations.TabDelete.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS = 500
      Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType = False
      Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime = False
      Options.Animation.MovementAnimations.TabMove.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabMove.AnimationTimeMS = 500
      Options.Behaviour.BackgroundDblClickMaximiseRestoreForm = True
      Options.Behaviour.BackgroundDragMovesForm = True
      Options.Behaviour.TabSmartDeleteResizing = True
      Options.Behaviour.TabSmartDeleteResizeCancelDelay = 700
      Options.Behaviour.UseBuiltInPopupMenu = True
      Options.Behaviour.TabRightClickSelect = True
      Options.Behaviour.ActivateNewTab = True
      Options.Behaviour.DebugMode = False
      Options.Behaviour.CloseOnWheel = True
      Options.Behaviour.IgnoreDoubleClicksWhileAnimatingMovement = True
      Options.Scrolling.Enabled = True
      Options.Scrolling.ScrollButtons = csbRight
      Options.Scrolling.ScrollStep = 20
      Options.Scrolling.ScrollRepeatDelay = 20
      Options.Scrolling.AutoHideButtons = False
      Options.Scrolling.DragScroll = True
      Options.Scrolling.DragScrollOffset = 50
      Options.Scrolling.MouseWheelScroll = True
      Tabs = <>
      LookAndFeel.TabsContainer.StartColor = 14586466
      LookAndFeel.TabsContainer.StopColor = 13201730
      LookAndFeel.TabsContainer.StartAlpha = 255
      LookAndFeel.TabsContainer.StopAlpha = 255
      LookAndFeel.TabsContainer.OutlineColor = 14520930
      LookAndFeel.TabsContainer.OutlineAlpha = 0
      LookAndFeel.Tabs.BaseLine.Color = 11110509
      LookAndFeel.Tabs.BaseLine.Thickness = 1.000000000000000000
      LookAndFeel.Tabs.BaseLine.Alpha = 255
      LookAndFeel.Tabs.Modified.CentreColor = clWhite
      LookAndFeel.Tabs.Modified.OutsideColor = clWhite
      LookAndFeel.Tabs.Modified.CentreAlpha = 130
      LookAndFeel.Tabs.Modified.OutsideAlpha = 0
      LookAndFeel.Tabs.DefaultFont.Name = 'Segoe UI'
      LookAndFeel.Tabs.DefaultFont.Color = clWhite
      LookAndFeel.Tabs.DefaultFont.Size = 11
      LookAndFeel.Tabs.DefaultFont.Alpha = 255
      LookAndFeel.Tabs.DefaultFont.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.MouseGlow.CentreColor = clWhite
      LookAndFeel.Tabs.MouseGlow.OutsideColor = clWhite
      LookAndFeel.Tabs.MouseGlow.CentreAlpha = 120
      LookAndFeel.Tabs.MouseGlow.OutsideAlpha = 0
      LookAndFeel.Tabs.Spinners.Upload.Color = 12759975
      LookAndFeel.Tabs.Spinners.Upload.Thickness = 2.500000000000000000
      LookAndFeel.Tabs.Spinners.Upload.Alpha = 255
      LookAndFeel.Tabs.Spinners.Download.Color = 14388040
      LookAndFeel.Tabs.Spinners.Download.Thickness = 2.500000000000000000
      LookAndFeel.Tabs.Spinners.Download.Alpha = 255
      LookAndFeel.Tabs.Active.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.Active.Font.Color = clWhite
      LookAndFeel.Tabs.Active.Font.Size = 11
      LookAndFeel.Tabs.Active.Font.Alpha = 100
      LookAndFeel.Tabs.Active.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.Active.Font.UseDefaultFont = True
      LookAndFeel.Tabs.Active.Style.StartColor = clBlack
      LookAndFeel.Tabs.Active.Style.StopColor = 3223857
      LookAndFeel.Tabs.Active.Style.StartAlpha = 255
      LookAndFeel.Tabs.Active.Style.StopAlpha = 255
      LookAndFeel.Tabs.Active.Style.OutlineColor = 5329233
      LookAndFeel.Tabs.Active.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.Active.Style.OutlineAlpha = 255
      LookAndFeel.Tabs.NotActive.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.NotActive.Font.Color = clSilver
      LookAndFeel.Tabs.NotActive.Font.Size = 9
      LookAndFeel.Tabs.NotActive.Font.Alpha = 215
      LookAndFeel.Tabs.NotActive.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.NotActive.Font.UseDefaultFont = True
      LookAndFeel.Tabs.NotActive.Style.StartColor = 15194573
      LookAndFeel.Tabs.NotActive.Style.StopColor = 15194573
      LookAndFeel.Tabs.NotActive.Style.StartAlpha = 0
      LookAndFeel.Tabs.NotActive.Style.StopAlpha = 0
      LookAndFeel.Tabs.NotActive.Style.OutlineColor = 13546390
      LookAndFeel.Tabs.NotActive.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.NotActive.Style.OutlineAlpha = 50
      LookAndFeel.Tabs.Hot.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.Hot.Font.Color = clWhite
      LookAndFeel.Tabs.Hot.Font.Size = 9
      LookAndFeel.Tabs.Hot.Font.Alpha = 215
      LookAndFeel.Tabs.Hot.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.Hot.Font.UseDefaultFont = True
      LookAndFeel.Tabs.Hot.Style.StartColor = clBlack
      LookAndFeel.Tabs.Hot.Style.StopColor = 5329233
      LookAndFeel.Tabs.Hot.Style.StartAlpha = 255
      LookAndFeel.Tabs.Hot.Style.StopAlpha = 255
      LookAndFeel.Tabs.Hot.Style.OutlineColor = 10648687
      LookAndFeel.Tabs.Hot.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.Hot.Style.OutlineAlpha = 235
      LookAndFeel.CloseButton.Cross.Normal.Color = clSilver
      LookAndFeel.CloseButton.Cross.Normal.Thickness = 1.500000000000000000
      LookAndFeel.CloseButton.Cross.Normal.Alpha = 255
      LookAndFeel.CloseButton.Cross.Down.Color = 15461369
      LookAndFeel.CloseButton.Cross.Down.Thickness = 2.000000000000000000
      LookAndFeel.CloseButton.Cross.Down.Alpha = 220
      LookAndFeel.CloseButton.Cross.Hot.Color = clWhite
      LookAndFeel.CloseButton.Cross.Hot.Thickness = 2.000000000000000000
      LookAndFeel.CloseButton.Cross.Hot.Alpha = 220
      LookAndFeel.CloseButton.Circle.Normal.StartColor = clGradientActiveCaption
      LookAndFeel.CloseButton.Circle.Normal.StopColor = clNone
      LookAndFeel.CloseButton.Circle.Normal.StartAlpha = 0
      LookAndFeel.CloseButton.Circle.Normal.StopAlpha = 0
      LookAndFeel.CloseButton.Circle.Normal.OutlineColor = clGray
      LookAndFeel.CloseButton.Circle.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Normal.OutlineAlpha = 0
      LookAndFeel.CloseButton.Circle.Down.StartColor = 3487169
      LookAndFeel.CloseButton.Circle.Down.StopColor = 3487169
      LookAndFeel.CloseButton.Circle.Down.StartAlpha = 255
      LookAndFeel.CloseButton.Circle.Down.StopAlpha = 255
      LookAndFeel.CloseButton.Circle.Down.OutlineColor = clGray
      LookAndFeel.CloseButton.Circle.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Down.OutlineAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.StartColor = 9408475
      LookAndFeel.CloseButton.Circle.Hot.StopColor = 9803748
      LookAndFeel.CloseButton.Circle.Hot.StartAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.StopAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.OutlineColor = 6054595
      LookAndFeel.CloseButton.Circle.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Hot.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Normal.StartColor = 14340292
      LookAndFeel.AddButton.Button.Normal.StopColor = 14340035
      LookAndFeel.AddButton.Button.Normal.StartAlpha = 255
      LookAndFeel.AddButton.Button.Normal.StopAlpha = 255
      LookAndFeel.AddButton.Button.Normal.OutlineColor = 13088421
      LookAndFeel.AddButton.Button.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Normal.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Down.StartColor = 13417645
      LookAndFeel.AddButton.Button.Down.StopColor = 13417644
      LookAndFeel.AddButton.Button.Down.StartAlpha = 255
      LookAndFeel.AddButton.Button.Down.StopAlpha = 255
      LookAndFeel.AddButton.Button.Down.OutlineColor = 10852748
      LookAndFeel.AddButton.Button.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Down.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Hot.StartColor = 15524314
      LookAndFeel.AddButton.Button.Hot.StopColor = 15524314
      LookAndFeel.AddButton.Button.Hot.StartAlpha = 255
      LookAndFeel.AddButton.Button.Hot.StopAlpha = 255
      LookAndFeel.AddButton.Button.Hot.OutlineColor = 14927787
      LookAndFeel.AddButton.Button.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Hot.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Normal.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Normal.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Normal.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Down.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Down.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Down.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Hot.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Hot.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Hot.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.StartColor = 14735310
      LookAndFeel.ScrollButtons.Button.Normal.StopColor = 14274499
      LookAndFeel.ScrollButtons.Button.Normal.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.OutlineColor = 11507842
      LookAndFeel.ScrollButtons.Button.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Normal.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.StartColor = 13417645
      LookAndFeel.ScrollButtons.Button.Down.StopColor = 13417644
      LookAndFeel.ScrollButtons.Button.Down.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.OutlineColor = 10852748
      LookAndFeel.ScrollButtons.Button.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Down.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.StartColor = 15524314
      LookAndFeel.ScrollButtons.Button.Hot.StopColor = 15524313
      LookAndFeel.ScrollButtons.Button.Hot.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.OutlineColor = 14927788
      LookAndFeel.ScrollButtons.Button.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Hot.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Disabled.StartColor = 14340036
      LookAndFeel.ScrollButtons.Button.Disabled.StopColor = 14274499
      LookAndFeel.ScrollButtons.Button.Disabled.StartAlpha = 150
      LookAndFeel.ScrollButtons.Button.Disabled.StopAlpha = 150
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineColor = 11113341
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineAlpha = 100
      LookAndFeel.ScrollButtons.Arrow.Normal.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Normal.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Normal.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Normal.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Down.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Down.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Down.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Down.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Hot.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Hot.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Hot.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Hot.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Disabled.StartColor = clSilver
      LookAndFeel.ScrollButtons.Arrow.Disabled.StopColor = clSilver
      LookAndFeel.ScrollButtons.Arrow.Disabled.StartAlpha = 150
      LookAndFeel.ScrollButtons.Arrow.Disabled.StopAlpha = 150
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineAlpha = 200
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ShowHint = True
      TabOrder = 1
      ExplicitTop = 33
      ExplicitWidth = 971
      ExplicitHeight = 30
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 178
    Width = 971
    Height = 187
    Align = alTop
    TabOrder = 2
    Visible = False
    ExplicitLeft = 56
    ExplicitTop = 371
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
        Top = 43
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
          Width = 42
          Height = 13
          Caption = 'API Key:'
        end
        object txtAPIKey: TEdit
          Left = 16
          Top = 29
          Width = 305
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
      end
      object gbAPIAuthMethodAccessToken: TPanel
        Tag = 1
        Left = 2
        Top = 98
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
          Width = 117
          Height = 13
          Caption = 'API Read Access Token:'
        end
        object txtAccessToken: TEdit
          Left = 16
          Top = 32
          Width = 305
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
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
        Top = 15
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
          Height = 21
          Cursor = crHandPoint
          Align = alTop
          TabOrder = 0
        end
      end
    end
  end
  object pUser: TPanel
    Left = 26
    Top = 312
    Width = 623
    Height = 204
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Visible = False
    object gbUserLogin: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 269
      Height = 196
      Align = alLeft
      Caption = 'User Authentication'
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 20
        Width = 265
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
        Top = 44
        Width = 265
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 259
          Height = 17
          Align = alClient
          Caption = 'Username:'
          Layout = tlCenter
          ExplicitWidth = 80
          ExplicitHeight = 18
        end
        object txtAuthUser: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 26
          Width = 259
          Height = 26
          Align = alBottom
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object pAuthPass: TPanel
        Left = 2
        Top = 99
        Width = 265
        Height = 54
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 247
          Height = 16
          Margins.Right = 15
          Align = alClient
          Caption = 'Password:'
          Layout = tlCenter
          ExplicitWidth = 78
          ExplicitHeight = 18
        end
        object txtAuthPass: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 25
          Width = 259
          Height = 26
          Align = alBottom
          PasswordChar = '*'
          TabOrder = 0
          OnKeyUp = txtAuthPassKeyUp
        end
      end
      object btnLogin: TButton
        AlignWithMargins = True
        Left = 52
        Top = 163
        Width = 165
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
      Left = 279
      Top = 4
      Width = 295
      Height = 196
      Align = alLeft
      Caption = 'User Info'
      TabOrder = 1
      Visible = False
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 143
        Top = 23
        Width = 147
        Height = 134
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblUserName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 141
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
          Width = 141
          Height = 18
          Align = alTop
          AutoSize = False
          Caption = 'Full Name'
          ExplicitLeft = 0
          ExplicitWidth = 154
        end
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 23
        Width = 132
        Height = 134
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object imgUserAvatar: TImage
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 126
          Height = 128
          Align = alClient
          ExplicitWidth = 113
        end
      end
      object btnLogout: TButton
        AlignWithMargins = True
        Left = 52
        Top = 163
        Width = 191
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
  object pContent: TPanel
    Left = 0
    Top = 33
    Width = 971
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 36
  end
  object TMDB: TTMDB
    AuthMethod = amAccessToken
    AppUserAgent = 
      'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-' +
      'TMDB)'
    RateLimiting = True
    RateLimitMsec = 50
    AgreedToWatchProviderAttribution = False
    OnUserAuthRequest = TMDBUserAuthRequest
    Left = 812
    Top = 55
  end
end