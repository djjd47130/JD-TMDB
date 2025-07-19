inherited frmContentChanges: TfrmContentChanges
  Caption = 'Changes'
  ClientHeight = 499
  ClientWidth = 840
  OnCreate = FormCreate
  ExplicitWidth = 856
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 18
  object Splitter1: TSplitter
    Left = 244
    Top = 0
    Width = 5
    Height = 499
    Beveled = True
    ExplicitLeft = 236
    ExplicitTop = 8
  end
  object lstChangeKeys: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 238
    Height = 493
    Align = alLeft
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Change Key'
        Width = 200
      end>
    HideSelection = False
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    Items.ItemData = {
      056A0200000E00000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
      0014500072006F00640075006300740069006F006E00200043006F006D007000
      61006E0069006500730000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000
      000004430061007300740000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF00
      0000000D520065006C0065006100730065002000440061007400650073000000
      0000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000656006900640065006F
      00730000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000001053007000
      6F006B0065006E0020004C0061006E0067007500610067006500730000000000
      FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000007520075006E00740069006D
      00650000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000D50006C00
      6F00740020004B006500790077006F0072006400730000000000FFFFFFFFFFFF
      FFFF00000000FFFFFFFF000000000649006D00610067006500730000000000FF
      FFFFFFFFFFFFFF00000000FFFFFFFF00000000084F0076006500720076006900
      6500770000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000004430072
      006500770000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000C5400
      720061006E0073006C006100740069006F006E00730000000000FFFFFFFFFFFF
      FFFF00000000FFFFFFFF00000000055400690074006C00650000000000FFFFFF
      FFFFFFFFFF00000000FFFFFFFF0000000006470065006E007200650073000000
      0000FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000075400610067006C0069
      006E006500}
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitLeft = 0
    ExplicitTop = 8
  end
  object pMain: TPanel
    Left = 272
    Top = 0
    Width = 568
    Height = 499
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 283
      Width = 566
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
      ExplicitTop = 318
      ExplicitWidth = 550
    end
    object lstResults: TListView
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 560
      Height = 237
      Align = alTop
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'ID'
          Width = 100
        end
        item
          Caption = 'Action'
          Width = 100
        end
        item
          Caption = 'Timestamp'
          Width = 100
        end
        item
          Caption = 'Country'
          Width = 100
        end
        item
          Caption = 'Language'
          Width = 100
        end>
      HideSelection = False
      HotTrackStyles = [htHandPoint, htUnderlineHot]
      Items.ItemData = {
        05900000000100000000000000FFFFFFFFFFFFFFFF02000000FFFFFFFF000000
        0018360038003700320062003700660035003800330061006300390064003300
        3400320036006300350062003700650038000541006400640065006400000F4F
        421732003000320035002D00300037002D00310032002000310039003A003300
        31003A0030003100200055005400430048DA4E42FFFFFFFF}
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitLeft = 6
      ExplicitTop = 3
      ExplicitWidth = 544
    end
    object pValues: TPanel
      Left = 1
      Top = 288
      Width = 566
      Height = 210
      Align = alBottom
      TabOrder = 1
      object pValue: TPanel
        Left = 1
        Top = 1
        Width = 536
        Height = 208
        Align = alLeft
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object lstValues: TListView
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 528
          Height = 200
          Align = alClient
          BorderStyle = bsNone
          Columns = <
            item
              Caption = 'Name'
              Width = 150
            end
            item
              Caption = 'Value'
              Width = 180
            end
            item
              Caption = 'Original Value'
              Width = 180
            end>
          HideSelection = False
          HotTrackStyles = [htHandPoint, htUnderlineHot]
          Items.ItemData = {
            05510100000500000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
            000970006500720073006F006E005F0069006400073500340032003600360033
            00360018FB4E4200000000FFFFFFFFFFFFFFFF01000000FFFFFFFF0000000009
            6300680061007200610063007400650072000D48006F006D0065006D0020006E
            00610020006D006F0074006F0010FD4E4200000000FFFFFFFFFFFFFFFF010000
            00FFFFFFFF00000000056F00720064006500720001320040D53C4B00000000FF
            FFFFFFFFFFFFFF01000000FFFFFFFF000000000763006100730074005F006900
            6400023100350088CA3C4B00000000FFFFFFFFFFFFFFFF01000000FFFFFFFF00
            000000096300720065006400690074005F006900640018360038003700320062
            0037006600350038003300610063003900640033003400320036006300350062
            0037006500360098F73C4BFFFFFFFFFFFFFFFFFFFF}
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          ExplicitTop = -29
          ExplicitWidth = 224
          ExplicitHeight = 237
        end
      end
    end
  end
end
