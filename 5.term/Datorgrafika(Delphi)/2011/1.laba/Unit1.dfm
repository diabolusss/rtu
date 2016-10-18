object Form1: TForm1
  Left = 220
  Top = 625
  Width = 1120
  Height = 525
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
    Left = 24
    Top = 16
    Width = 561
    Height = 369
  end
  object Timer1: TTimer
    Interval = 25
    OnTimer = Timer1Timer
    Left = 608
    Top = 16
  end
end
