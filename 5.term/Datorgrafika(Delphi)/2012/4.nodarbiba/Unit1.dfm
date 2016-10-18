object Form1: TForm1
  Left = 184
  Top = 137
  Caption = 'Image processing'
  ClientHeight = 578
  ClientWidth = 885
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 360
    Top = 8
    Width = 465
    Height = 545
  end
  object Image2: TImage
    Left = 18
    Top = 326
    Width = 256
    Height = 100
    OnMouseMove = Image2MouseMove
  end
  object Label1: TLabel
    Left = 18
    Top = 307
    Width = 35
    Height = 13
    Caption = 'Median'
  end
  object shadows: TLabel
    Left = 21
    Top = 432
    Width = 42
    Height = 13
    Caption = 'shadows'
  end
  object Label2: TLabel
    Left = 120
    Top = 432
    Width = 60
    Height = 13
    Caption = 'Middle tones'
  end
  object Label3: TLabel
    Left = 232
    Top = 432
    Width = 28
    Height = 13
    Caption = 'Lights'
  end
  object Label4: TLabel
    Left = 16
    Top = 456
    Width = 39
    Height = 13
    Caption = 'Intensity'
  end
  object ColorSystems: TRadioGroup
    Left = 16
    Top = 40
    Width = 89
    Height = 105
    Caption = 'Color systems'
    ItemIndex = 0
    Items.Strings = (
      'RGB')
    TabOrder = 0
    OnClick = ColorSystemsClick
  end
  object Chanels: TRadioGroup
    Left = 120
    Top = 40
    Width = 97
    Height = 105
    Caption = 'Chanels'
    ItemIndex = 0
    Items.Strings = (
      'RGB'
      'Red'
      'Green'
      'Blue')
    TabOrder = 1
    OnClick = ChanelsClick
  end
  object Button1: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Inverse'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Grayscale'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 169
    Width = 75
    Height = 25
    Caption = 'Repaint'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 233
    Width = 75
    Height = 21
    TabOrder = 5
    Text = '2'
  end
  object Button4: TButton
    Left = 104
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Scale'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 200
    Top = 232
    Width = 97
    Height = 25
    Caption = 'RGB levels'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Blur: TButton
    Left = 104
    Top = 273
    Width = 81
    Height = 25
    Caption = ' Blur Grayscale'
    TabOrder = 8
    OnClick = BlurClick
  end
  object Button6: TButton
    Left = 200
    Top = 201
    Width = 97
    Height = 25
    Caption = 'Emboss'
    TabOrder = 9
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 232
    Top = 48
    Width = 97
    Height = 25
    Caption = 'Comparison'
    TabOrder = 10
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 200
    Top = 272
    Width = 97
    Height = 25
    Caption = 'Blur color'
    TabOrder = 11
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 112
    Top = 496
    Width = 161
    Height = 25
    Caption = 'Histogram Normalize (Grayscale)'
    TabOrder = 12
    OnClick = Button9Click
  end
  object Edit2: TEdit
    Left = 16
    Top = 496
    Width = 81
    Height = 21
    TabOrder = 13
    Text = '0'
  end
  object Edit3: TEdit
    Left = 16
    Top = 528
    Width = 81
    Height = 21
    TabOrder = 14
    Text = '255'
  end
  object Button10: TButton
    Left = 112
    Top = 528
    Width = 161
    Height = 25
    Caption = 'Histogram Normalize RGB'
    TabOrder = 15
    OnClick = Button10Click
  end
  object MainMenu1: TMainMenu
    Left = 16
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object SaveAs1: TMenuItem
        Caption = 'Save As'
        OnClick = SaveAs1Click
      end
    end
  end
  object Open: TOpenPictureDialog
    Filter = 
      'JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bi' +
      'tmaps (*.bmp)|*.bmp'
    Left = 48
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 
      'JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bi' +
      'tmaps (*.bmp)|*.bmp'
    Left = 80
  end
end
