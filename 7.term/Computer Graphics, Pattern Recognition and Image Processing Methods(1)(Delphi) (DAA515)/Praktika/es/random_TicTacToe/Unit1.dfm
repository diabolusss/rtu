object Form1: TForm1
  Left = 362
  Top = 64
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 613
  ClientWidth = 915
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
    Left = 760
    Top = 256
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object strngrd1: TStringGrid
    Left = 8
    Top = 0
    Width = 609
    Height = 609
    ColCount = 3
    DefaultColWidth = 200
    DefaultRowHeight = 200
    Enabled = False
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -160
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = strngrd1KeyPress
  end
  object btn1: TButton
    Left = 688
    Top = 184
    Width = 121
    Height = 49
    Caption = 'Start the game'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btn1Click
  end
  object rg1: TRadioGroup
    Left = 672
    Top = 0
    Width = 153
    Height = 105
    Caption = 'Choose game mode'
    ItemIndex = 1
    Items.Strings = (
      'Player vs Player'
      'Player vs Computer'
      'Computer vs Computer')
    TabOrder = 2
    OnClick = rg1Click
  end
  object rg2: TRadioGroup
    Left = 656
    Top = 112
    Width = 185
    Height = 65
    Caption = 'Choose who goes first'
    ItemIndex = 0
    Items.Strings = (
      'Player goes first'
      'Computer goes first')
    TabOrder = 3
  end
  object btn2: TButton
    Left = 688
    Top = 280
    Width = 121
    Height = 49
    Caption = 'Reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btn2Click
  end
  object edt1: TEdit
    Left = 616
    Top = 240
    Width = 297
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'Game not started'
  end
  object edt2: TEdit
    Left = 688
    Top = 344
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'edt2'
  end
  object edt3: TEdit
    Left = 688
    Top = 368
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'edt3'
  end
  object edt4: TEdit
    Left = 688
    Top = 392
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'edt4'
  end
  object edt5: TEdit
    Left = 688
    Top = 416
    Width = 121
    Height = 21
    TabOrder = 9
    Text = 'edt5'
  end
end
