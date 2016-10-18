object Form3: TForm3
  Left = 201
  Top = 116
  Caption = 'Comparison of the original image with an image after processing'
  ClientHeight = 361
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 40
    Width = 400
    Height = 300
    Proportional = True
  end
  object Image2: TImage
    Left = 432
    Top = 40
    Width = 400
    Height = 300
    Proportional = True
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 107
    Height = 13
    Caption = 'Image after processing'
  end
  object Label2: TLabel
    Left = 432
    Top = 24
    Width = 66
    Height = 13
    Caption = 'Original image'
  end
end
