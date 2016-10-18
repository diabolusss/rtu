object Form1: TForm1
  Left = 192
  Top = 127
  Width = 694
  Height = 768
  Caption = 'MiniMax'
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
  object Label1: TLabel
    Left = 280
    Top = 664
    Width = 27
    Height = 13
    Caption = 'Centri'
  end
  object Label3: TLabel
    Left = 280
    Top = 688
    Width = 29
    Height = 13
    Caption = 'Skaits'
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 393
    Height = 369
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 385
      Height = 361
      OnClick = Image1Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 184
    Top = 384
    Width = 473
    Height = 257
    ColCount = 10
    RowCount = 10
    TabOrder = 1
    ColWidths = (
      64
      44
      40
      43
      43
      43
      43
      44
      44
      45)
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
      24)
  end
  object Button1: TButton
    Left = 192
    Top = 656
    Width = 75
    Height = 25
    Caption = 'Aprekinat'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 688
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = Button2Click
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 384
    Width = 161
    Height = 257
    ColCount = 3
    RowCount = 10
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 4
    ColWidths = (
      64
      44
      42)
  end
  object Button3: TButton
    Left = 48
    Top = 656
    Width = 75
    Height = 25
    Caption = 'Attelot'
    TabOrder = 5
    OnClick = Button3Click
  end
end
