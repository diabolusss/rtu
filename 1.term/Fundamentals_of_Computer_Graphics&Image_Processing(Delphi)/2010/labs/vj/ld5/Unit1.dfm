object Form1: TForm1
  Left = 192
  Top = 114
  Width = 975
  Height = 644
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
    Left = 0
    Top = 0
    Width = 601
    Height = 609
  end
  object RadioGroup1: TRadioGroup
    Left = 830
    Top = 0
    Width = 137
    Height = 105
    Caption = 'RadioGroup1'
    TabOrder = 0
  end
  object StringGrid1: TStringGrid
    Left = 600
    Top = 0
    Width = 217
    Height = 121
    ColCount = 3
    TabOrder = 1
    ColWidths = (
      64
      64
      64)
  end
  object Edit1: TEdit
    Left = 608
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 744
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Rotate'
    TabOrder = 3
    OnClick = Button1Click
  end
end
