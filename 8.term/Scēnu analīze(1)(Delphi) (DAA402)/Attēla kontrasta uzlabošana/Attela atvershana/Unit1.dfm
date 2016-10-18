object Form1: TForm1
  Left = 183
  Top = 126
  Width = 705
  Height = 609
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 40
    Width = 673
    Height = 481
    Proportional = True
  end
  object MainMenu1: TMainMenu
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Atteli (*.bmp, *.jpg)|*.bmp;*.jpg'
    Left = 32
  end
end
