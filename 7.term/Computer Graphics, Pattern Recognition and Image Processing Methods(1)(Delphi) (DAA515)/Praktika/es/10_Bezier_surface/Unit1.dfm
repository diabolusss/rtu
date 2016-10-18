object Form1: TForm1
  Left = 231
  Top = 202
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 622
  ClientWidth = 1316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 8
    Top = 8
    Width = 657
    Height = 601
  end
  object txt2: TStaticText
    Left = 672
    Top = 32
    Width = 25
    Height = 17
    Caption = 'N = '
    TabOrder = 0
  end
  object txt3: TStaticText
    Left = 672
    Top = 304
    Width = 26
    Height = 17
    Caption = 'M = '
    TabOrder = 1
  end
  object strngrd1: TStringGrid
    Left = 672
    Top = 64
    Width = 481
    Height = 233
    TabOrder = 2
  end
  object strngrd2: TStringGrid
    Left = 672
    Top = 336
    Width = 473
    Height = 233
    TabOrder = 3
  end
  object se1: TSpinEdit
    Left = 696
    Top = 32
    Width = 65
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 4
    OnChange = se1Change
  end
  object se2: TSpinEdit
    Left = 696
    Top = 304
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 4
    OnChange = se2Change
  end
  object btn1: TButton
    Left = 784
    Top = 8
    Width = 129
    Height = 25
    Caption = 'Generate random points'
    TabOrder = 6
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 968
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Generate surface'
    TabOrder = 7
    OnClick = btn2Click
  end
end
