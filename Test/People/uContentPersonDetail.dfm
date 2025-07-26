inherited frmContentPersonDetail: TfrmContentPersonDetail
  Caption = 'Person Detail'
  ClientHeight = 542
  ClientWidth = 979
  OnCreate = FormCreate
  ExplicitWidth = 995
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 18
  object Pages: TPageControl
    Left = 0
    Top = 64
    Width = 979
    Height = 478
    ActivePage = TabSheet1
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 0
    Visible = False
    OnChange = PagesChange
    object TabSheet1: TTabSheet
      Caption = 'Detail'
      object Splitter1: TSplitter
        Left = 0
        Top = 302
        Width = 971
        Height = 7
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitTop = 246
        ExplicitWidth = 939
      end
      object txtOverview: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 312
        Width = 965
        Height = 130
        Align = alBottom
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object lstDetail: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 965
        Height = 296
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 600
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnAdvancedCustomDraw = lstDetailAdvancedCustomDraw
        OnAdvancedCustomDrawItem = lstDetailAdvancedCustomDrawItem
        OnAdvancedCustomDrawSubItem = lstDetailAdvancedCustomDrawSubItem
        OnDblClick = lstDetailDblClick
      end
    end
    object tabChanges: TTabSheet
      Caption = 'Changes'
      ImageIndex = 3
    end
    object tabCombinedCredits: TTabSheet
      Caption = 'Combined Credits'
      ImageIndex = 4
    end
    object TabSheet6: TTabSheet
      Caption = 'External IDs'
      ImageIndex = 5
      object lstExternalIDs: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 965
        Height = 439
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 600
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tabImages: TTabSheet
      Caption = 'Images'
      ImageIndex = 6
    end
    object tabMovieCredits: TTabSheet
      Caption = 'Movie Credits'
      ImageIndex = 5
    end
    object tabTVCredits: TTabSheet
      Caption = 'TV Credits'
      ImageIndex = 6
    end
    object tabTranslations: TTabSheet
      Caption = 'Translations'
      ImageIndex = 7
    end
  end
end
