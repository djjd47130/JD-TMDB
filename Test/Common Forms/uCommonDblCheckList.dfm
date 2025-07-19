object frmCommonDblCheckList: TfrmCommonDblCheckList
  Left = 0
  Top = 0
  Width = 257
  Height = 310
  TabOrder = 0
  object TV: TVirtualStringTree
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 251
    Height = 262
    Align = alTop
    DefaultNodeHeight = 17
    Header.AutoSizeIndex = 0
    Header.Height = 13
    Header.MainColumn = -1
    RootNodeCount = 5
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.SelectionOptions = [toFullRowSelect, toSelectNextNodeOnRemoval]
    OnGetText = TVGetText
    OnPaintText = TVPaintText
    OnInitNode = TVInitNode
    OnMouseDown = TVMouseDown
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <>
  end
end
