object Form1: TForm1
  Left = 65
  Top = 123
  Width = 1221
  Height = 642
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
  object img1: TImage
    Left = 0
    Top = 0
    Width = 745
    Height = 585
    OnMouseDown = img1MouseDown
  end
  object lbl1: TLabel
    Left = 824
    Top = 560
    Width = 5
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 928
    Top = 8
    Width = 13
    Height = 16
    Caption = 'X:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 928
    Top = 32
    Width = 12
    Height = 16
    Caption = 'Y:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 888
    Top = 8
    Width = 35
    Height = 32
    Caption = ' New'#13#10'object'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 840
    Top = 48
    Width = 69
    Height = 16
    Caption = 'Object table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 760
    Top = 560
    Width = 58
    Height = 19
    Caption = 'Result:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl7: TLabel
    Left = 768
    Top = 392
    Width = 81
    Height = 16
    Caption = 'Vector count: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl8: TLabel
    Left = 984
    Top = 200
    Width = 68
    Height = 16
    Caption = 'Dist. to EtA:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl9: TLabel
    Left = 1057
    Top = 200
    Width = 67
    Height = 16
    Caption = 'Dist. to EtB:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl10: TLabel
    Left = 992
    Top = 80
    Width = 22
    Height = 18
    Caption = 'EtA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl11: TLabel
    Left = 992
    Top = 144
    Width = 22
    Height = 18
    Caption = 'EtB'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl12: TLabel
    Left = 1024
    Top = 72
    Width = 13
    Height = 16
    Caption = 'X:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl13: TLabel
    Left = 1024
    Top = 96
    Width = 12
    Height = 16
    Caption = 'Y:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl14: TLabel
    Left = 1024
    Top = 136
    Width = 13
    Height = 16
    Caption = 'X:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl15: TLabel
    Left = 1024
    Top = 160
    Width = 12
    Height = 16
    Caption = 'Y:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl16: TLabel
    Left = 1040
    Top = 264
    Width = 71
    Height = 13
    Caption = 'Position check:'
  end
  object btn1: TButton
    Left = 768
    Top = 8
    Width = 113
    Height = 41
    Caption = 'Randomize'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object strngrd1: TStringGrid
    Left = 768
    Top = 64
    Width = 201
    Height = 185
    ColCount = 3
    RowCount = 7
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 1
    OnSetEditText = strngrd1SetEditText
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24)
  end
  object rg1: TRadioGroup
    Left = 768
    Top = 248
    Width = 257
    Height = 81
    Caption = 'Method choice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Etalona metode'
      'Fiksa-Hodzesa metode (Mod 1)'
      'Fiksa-Hodzesa metode (Mod 2)'
      'Optimala atdalosa hiperplakne'
      'Optimala atdalosa hiperplakne(V2)')
    ParentFont = False
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 944
    Top = 8
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '0'
  end
  object edt1: TEdit
    Left = 944
    Top = 32
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '0'
  end
  object btn2: TButton
    Left = 1022
    Top = 8
    Width = 83
    Height = 49
    Caption = 'Create object'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btn2Click
  end
  object StringGrid1: TStringGrid
    Left = 768
    Top = 336
    Width = 361
    Height = 56
    ColCount = 7
    DefaultColWidth = 50
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object strngrd2: TStringGrid
    Left = 752
    Top = 424
    Width = 377
    Height = 129
    ColCount = 8
    DefaultColWidth = 43
    RowCount = 1001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object edt2: TEdit
    Left = 848
    Top = 392
    Width = 57
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = '4'
  end
  object edt3: TEdit
    Left = 984
    Top = 216
    Width = 73
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object edt4: TEdit
    Left = 1056
    Top = 216
    Width = 73
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
  end
  object edt5: TEdit
    Left = 1040
    Top = 72
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 11
  end
  object edt6: TEdit
    Left = 1040
    Top = 96
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 12
  end
  object edt7: TEdit
    Left = 1040
    Top = 136
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 13
  end
  object edt8: TEdit
    Left = 1040
    Top = 160
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 14
  end
  object edt9: TEdit
    Left = 1040
    Top = 280
    Width = 65
    Height = 21
    TabOrder = 15
  end
  object edt10: TEdit
    Left = 1040
    Top = 304
    Width = 73
    Height = 21
    TabOrder = 16
  end
  object edt11: TEdit
    Left = 1120
    Top = 280
    Width = 65
    Height = 21
    TabOrder = 17
  end
  object edt12: TEdit
    Left = 1120
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 18
    Text = 'edt12'
  end
  object edt13: TEdit
    Left = 1120
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 19
    Text = 'edt13'
  end
  object edt14: TEdit
    Left = 1120
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 20
    Text = 'edt14'
  end
  object edt15: TEdit
    Left = 1120
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 21
    Text = 'edt15'
  end
end
