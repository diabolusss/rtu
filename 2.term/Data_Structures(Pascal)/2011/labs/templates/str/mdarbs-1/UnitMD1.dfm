object Form1: TForm1
  Left = 191
  Top = 119
  Width = 498
  Height = 367
  Caption = 'MD1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 137
    Height = 153
    Caption = 'Apkalpo?anas oper?cijas'
    Font.Charset = BALTIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 24
      Width = 105
      Height = 17
      Caption = 'Create'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Terminate'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 72
      Width = 105
      Height = 17
      Caption = 'Length'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 16
      Top = 96
      Width = 105
      Height = 17
      Caption = 'Full'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 16
      Top = 120
      Width = 105
      Height = 17
      Caption = 'Empty'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 16
    Width = 137
    Height = 129
    Caption = 'Pamatoper?cijas'
    Font.Charset = BALTIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Button8: TButton
      Left = 16
      Top = 80
      Width = 105
      Height = 17
      Caption = 'ReadString'
      TabOrder = 0
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 16
      Top = 104
      Width = 105
      Height = 17
      Caption = 'WriteString'
      TabOrder = 1
      OnClick = Button9Click
    end
    object Button6: TButton
      Left = 16
      Top = 24
      Width = 105
      Height = 17
      Caption = 'Find'
      TabOrder = 2
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 16
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Delete'
      TabOrder = 3
      OnClick = Button7Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 176
    Top = 152
    Width = 137
    Height = 81
    Caption = 'Papildoper?cijas'
    Font.Charset = BALTIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Button10: TButton
      Left = 16
      Top = 24
      Width = 105
      Height = 17
      Caption = 'MakeEmpty'
      TabOrder = 0
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 16
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Reverse'
      TabOrder = 1
      OnClick = Button11Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 16
    Top = 248
    Width = 449
    Height = 65
    Caption = 'Informaacija par virkni'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 3
      Height = 13
    end
  end
  object GroupBox5: TGroupBox
    Left = 328
    Top = 16
    Width = 113
    Height = 73
    Caption = 'Virk?u izv?la'
    Font.Charset = BALTIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object RadioButton1: TRadioButton
      Left = 8
      Top = 24
      Width = 73
      Height = 17
      Caption = '1. Virkne'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 48
      Width = 65
      Height = 17
      Caption = '2. Virkne'
      TabOrder = 1
      OnClick = RadioButton2Click
    end
  end
  object Button12: TButton
    Left = 328
    Top = 120
    Width = 105
    Height = 25
    Caption = 'END'
    TabOrder = 5
    OnClick = Button12Click
  end
end