object Form1: TForm1
  Left = 226
  Top = 179
  Width = 929
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 224
    Width = 449
    Height = 377
  end
  object Label1: TLabel
    Left = 16
    Top = 144
    Width = 13
    Height = 13
    Caption = 'X1'
  end
  object Label2: TLabel
    Left = 176
    Top = 144
    Width = 13
    Height = 13
    Caption = 'Y1'
  end
  object Label3: TLabel
    Left = 16
    Top = 176
    Width = 13
    Height = 13
    Caption = 'X2'
  end
  object Label4: TLabel
    Left = 176
    Top = 176
    Width = 13
    Height = 13
    Caption = 'Y2'
  end
  object Button1: TButton
    Left = 56
    Top = 56
    Width = 105
    Height = 49
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 40
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '20'
  end
  object Edit2: TEdit
    Left = 200
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '20'
  end
  object Edit3: TEdit
    Left = 40
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '200'
  end
  object Edit4: TEdit
    Left = 200
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '150'
  end
  object StringGrid1: TStringGrid
    Left = 584
    Top = 8
    Width = 329
    Height = 281
    RowCount = 11
    TabOrder = 5
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
      24)
  end
end