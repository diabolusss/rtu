object Form1: TForm1
  Left = 517
  Top = 278
  Width = 806
  Height = 585
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 457
    Height = 449
    OnMouseDown = Image1MouseDown
  end
  object Label1: TLabel
    Left = 208
    Top = 464
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object StringGrid1: TStringGrid
    Left = 472
    Top = 40
    Width = 201
    Height = 185
    ColCount = 3
    RowCount = 7
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnKeyDown = StringGrid1KeyDown
  end
  object Button1: TButton
    Left = 528
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Random'
    TabOrder = 1
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 472
    Top = 232
    Width = 185
    Height = 105
    Caption = 'Metode'
    ItemIndex = 0
    Items.Strings = (
      'Etalona metode'
      'Fiksa-Hodzesa metode')
    TabOrder = 2
  end
end
