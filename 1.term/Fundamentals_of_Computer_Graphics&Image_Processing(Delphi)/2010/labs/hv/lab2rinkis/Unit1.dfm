object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
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
    Left = 32
    Top = 40
    Width = 793
    Height = 545
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
  end
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 13
    Height = 13
    Caption = 'x,y'
  end
  object Edit1: TEdit
    Left = 392
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 0
    Text = '50'
  end
end
