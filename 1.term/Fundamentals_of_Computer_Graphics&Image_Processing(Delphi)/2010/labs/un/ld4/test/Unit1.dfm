object Form1: TForm1
  Left = 182
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 746
  ClientWidth = 941
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
    Width = 689
    Height = 746
    Align = alLeft
    OnMouseDown = Image1MouseDown
  end
  object Label1: TLabel
    Left = 752
    Top = 8
    Width = 9
    Height = 20
    Caption = 'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 752
    Top = 40
    Width = 14
    Height = 13
    Caption = 'CP'
  end
  object Label3: TLabel
    Left = 752
    Top = 72
    Width = 8
    Height = 13
    Caption = 'R'
  end
  object RadioGroup1: TRadioGroup
    Left = 856
    Top = 8
    Width = 81
    Height = 729
    Caption = 'Kontrolpunkti'
    ItemIndex = 0
    Items.Strings = (
      '0. punkts'
      '1. punkts'
      '2. punkts')
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 768
    Top = 8
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '200'
  end
  object Edit2: TEdit
    Left = 768
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 2
    Text = '5'
  end
  object Edit3: TEdit
    Left = 768
    Top = 72
    Width = 81
    Height = 21
    TabOrder = 3
    Text = '2'
  end
end
