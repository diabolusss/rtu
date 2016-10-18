object Form1: TForm1
  Left = 195
  Top = 174
  Width = 650
  Height = 556
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 16
    Width = 640
    Height = 490
  end
  object Label1: TLabel
    Left = 0
    Top = 512
    Width = 13
    Height = 13
    Caption = 'x,y'
  end
  object Label3: TLabel
    Left = 0
    Top = 0
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 64
    Top = 0
    Width = 29
    Height = 13
    Caption = 'Points'
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
    Left = 616
    Top = 16
  end
end
