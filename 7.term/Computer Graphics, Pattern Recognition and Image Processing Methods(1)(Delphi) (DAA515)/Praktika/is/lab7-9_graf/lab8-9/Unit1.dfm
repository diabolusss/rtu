object Form1: TForm1
  Left = 227
  Top = 168
  Width = 660
  Height = 619
  Caption = 'Bezier liknes'
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
  object PageControl1: TPageControl
    Left = 8
    Top = 16
    Width = 617
    Height = 545
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Punkti'
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 12
        Height = 13
        Caption = 'n='
      end
      object Label2: TLabel
        Left = 104
        Top = 16
        Width = 14
        Height = 13
        Caption = 'm='
      end
      object Button1: TButton
        Left = 304
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Bezier'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 216
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Punkti'
        TabOrder = 1
        OnClick = Button2Click
      end
      object SpinEdit1: TSpinEdit
        Left = 40
        Top = 16
        Width = 49
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 4
        OnChange = SpinEdit1Change
      end
      object SpinEdit2: TSpinEdit
        Left = 128
        Top = 16
        Width = 49
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 1
        OnChange = SpinEdit2Change
      end
      object StringGrid1: TStringGrid
        Left = 16
        Top = 64
        Width = 281
        Height = 417
        ColCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 4
      end
      object StringGrid2: TStringGrid
        Left = 312
        Top = 64
        Width = 281
        Height = 425
        ColCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 5
        ColWidths = (
          64
          64)
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Attels'
      ImageIndex = 1
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 601
        Height = 505
        OnClick = Image1Click
      end
    end
  end
end
