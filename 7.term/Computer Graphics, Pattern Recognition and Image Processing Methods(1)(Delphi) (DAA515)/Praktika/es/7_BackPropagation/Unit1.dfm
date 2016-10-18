object Form1: TForm1
  Left = 167
  Top = 12
  Width = 1122
  Height = 738
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 296
    Width = 55
    Height = 13
    Caption = 'Test result:'
  end
  object sb1: TSpeedButton
    Left = 24
    Top = 368
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb1Click
  end
  object sb2: TSpeedButton
    Left = 24
    Top = 400
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb2Click
  end
  object sb3: TSpeedButton
    Left = 24
    Top = 432
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb3Click
  end
  object sb4: TSpeedButton
    Left = 24
    Top = 464
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb4Click
  end
  object sb5: TSpeedButton
    Left = 24
    Top = 496
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb5Click
  end
  object sb6: TSpeedButton
    Left = 88
    Top = 368
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb6Click
  end
  object sb7: TSpeedButton
    Left = 88
    Top = 400
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb7Click
  end
  object sb8: TSpeedButton
    Left = 88
    Top = 432
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb8Click
  end
  object sb9: TSpeedButton
    Left = 88
    Top = 464
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb9Click
  end
  object sb10: TSpeedButton
    Left = 88
    Top = 496
    Width = 23
    Height = 22
    GroupIndex = 1
    OnClick = sb10Click
  end
  object lbl2: TLabel
    Left = 1000
    Top = 304
    Width = 98
    Height = 13
    Caption = 'Final neuron output:'
  end
  object lbl3: TLabel
    Left = 1000
    Top = 344
    Width = 90
    Height = 13
    Caption = 'Final neuron error:'
  end
  object btn1: TButton
    Left = 16
    Top = 8
    Width = 113
    Height = 33
    Caption = 'Open Teach Set (TS)'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 16
    Top = 56
    Width = 113
    Height = 33
    Caption = 'Open Exam Set (ES)'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 16
    Top = 160
    Width = 113
    Height = 33
    Caption = 'Teach Network'
    TabOrder = 2
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 16
    Top = 256
    Width = 113
    Height = 33
    Caption = 'Test'
    TabOrder = 3
    OnClick = btn4Click
  end
  object edt1: TEdit
    Left = 16
    Top = 312
    Width = 113
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object mmo1: TMemo
    Left = 8
    Top = 544
    Width = 145
    Height = 89
    ReadOnly = True
    TabOrder = 5
  end
  object strngrd1: TStringGrid
    Left = 160
    Top = 8
    Width = 81
    Height = 633
    ColCount = 2
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 6
  end
  object strngrd2: TStringGrid
    Left = 256
    Top = 8
    Width = 177
    Height = 633
    ColCount = 61
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 7
  end
  object strngrd3: TStringGrid
    Left = 448
    Top = 8
    Width = 129
    Height = 633
    ColCount = 3
    DefaultColWidth = 35
    RowCount = 61
    TabOrder = 8
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object strngrd4: TStringGrid
    Left = 592
    Top = 8
    Width = 161
    Height = 633
    ColCount = 61
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 9
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object strngrd5: TStringGrid
    Left = 768
    Top = 8
    Width = 129
    Height = 633
    ColCount = 3
    DefaultColWidth = 35
    RowCount = 61
    TabOrder = 10
    RowHeights = (
      24
      24
      24
      25
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object strngrd6: TStringGrid
    Left = 912
    Top = 8
    Width = 81
    Height = 633
    ColCount = 2
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 11
  end
  object edt2: TEdit
    Left = 1000
    Top = 320
    Width = 81
    Height = 21
    ReadOnly = True
    TabOrder = 12
  end
  object btn15: TButton
    Left = 16
    Top = 104
    Width = 113
    Height = 33
    Caption = 'Randomize weights'
    TabOrder = 13
    OnClick = btn15Click
  end
  object txt1: TStaticText
    Left = 16
    Top = 344
    Width = 38
    Height = 17
    Caption = 'Class 0'
    TabOrder = 14
  end
  object txt2: TStaticText
    Left = 80
    Top = 344
    Width = 38
    Height = 17
    Caption = 'Class 1'
    TabOrder = 15
  end
  object edt3: TEdit
    Left = 1000
    Top = 360
    Width = 81
    Height = 21
    TabOrder = 16
  end
  object edt4: TEdit
    Left = 16
    Top = 224
    Width = 113
    Height = 21
    TabOrder = 17
    Text = '0,1'
  end
  object txt3: TStaticText
    Left = 16
    Top = 200
    Width = 75
    Height = 17
    Caption = 'Teaching step:'
    TabOrder = 18
  end
end
