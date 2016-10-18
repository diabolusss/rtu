object Form1: TForm1
  Left = 265
  Top = 74
  Width = 966
  Height = 651
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
  object Label1: TLabel
    Left = 32
    Top = 280
    Width = 33
    Height = 13
    Caption = 'Teta ='
  end
  object Label2: TLabel
    Left = 24
    Top = 456
    Width = 34
    Height = 13
    Caption = 'Result:'
  end
  object img1: TImage
    Left = 142
    Top = 209
    Width = 6
    Height = 10
  end
  object btn1: TSpeedButton
    Left = 24
    Top = 144
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn1Click
  end
  object btn2: TSpeedButton
    Left = 24
    Top = 168
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn2Click
  end
  object btn3: TSpeedButton
    Left = 24
    Top = 192
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn3Click
  end
  object btn4: TSpeedButton
    Left = 24
    Top = 216
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn4Click
  end
  object btn5: TSpeedButton
    Left = 24
    Top = 240
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn5Click
  end
  object btn6: TSpeedButton
    Left = 72
    Top = 144
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn6Click
  end
  object btn7: TSpeedButton
    Left = 72
    Top = 168
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn7Click
  end
  object btn8: TSpeedButton
    Left = 72
    Top = 192
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn8Click
  end
  object btn9: TSpeedButton
    Left = 72
    Top = 216
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn9Click
  end
  object btn10: TSpeedButton
    Left = 72
    Top = 240
    Width = 23
    Height = 22
    GroupIndex = 1
    Visible = False
    OnClick = btn10Click
  end
  object lbl1: TLabel
    Left = 120
    Top = 176
    Width = 41
    Height = 26
    Caption = 'Selected'#13#10' picture'
  end
  object Button: TButton
    Left = 32
    Top = 16
    Width = 113
    Height = 33
    Caption = 'Open Training Set (TS)'
    TabOrder = 0
    OnClick = ButtonClick
  end
  object Button1: TButton
    Left = 32
    Top = 56
    Width = 113
    Height = 33
    Caption = 'Open Exam Set (ES)'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 320
    Width = 153
    Height = 33
    Caption = 'Teach Based On Current TS'
    TabOrder = 2
    OnClick = Button2Click
  end
  object edt1: TEdit
    Left = 72
    Top = 280
    Width = 81
    Height = 21
    TabOrder = 3
    Text = '0,1'
  end
  object Button3: TButton
    Left = 56
    Top = 408
    Width = 65
    Height = 25
    Caption = 'Test'
    TabOrder = 4
    Visible = False
    OnClick = Button3Click
  end
  object edt2: TEdit
    Left = 64
    Top = 456
    Width = 105
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object mmo1: TMemo
    Left = 16
    Top = 488
    Width = 153
    Height = 65
    ReadOnly = True
    TabOrder = 6
  end
  object strngrd1: TStringGrid
    Left = 192
    Top = 24
    Width = 81
    Height = 577
    ColCount = 2
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 7
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
  object strngrd2: TStringGrid
    Left = 304
    Top = 24
    Width = 361
    Height = 577
    ColCount = 41
    DefaultColWidth = 30
    RowCount = 61
    TabOrder = 8
  end
  object strngrd3: TStringGrid
    Left = 688
    Top = 24
    Width = 81
    Height = 577
    ColCount = 2
    DefaultColWidth = 30
    RowCount = 41
    TabOrder = 9
  end
  object strngrd4: TStringGrid
    Left = 800
    Top = 24
    Width = 121
    Height = 577
    ColCount = 2
    DefaultColWidth = 50
    RowCount = 41
    TabOrder = 10
  end
  object Button4: TButton
    Left = 16
    Top = 96
    Width = 153
    Height = 33
    Caption = 'Set/Reset weights (W)'
    TabOrder = 11
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 368
    Width = 153
    Height = 25
    Caption = 'Teach Based On Current ES'
    TabOrder = 12
    OnClick = Button5Click
  end
end
