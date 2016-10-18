object Main_menu: TMain_menu
  Left = 266
  Top = 181
  Width = 598
  Height = 580
  Caption = 'Main_menu'
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
  object Label2: TLabel
    Left = 240
    Top = 488
    Width = 67
    Height = 13
    Caption = 'Objektu skaits'
  end
  object Button2: TButton
    Left = 8
    Top = 474
    Width = 89
    Height = 39
    Caption = 'Repaint'
    TabOrder = 0
    OnClick = Button2Click
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 577
    Height = 433
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 569
      Height = 425
      AutoSize = True
      Proportional = True
    end
  end
  object Button1: TButton
    Left = 112
    Top = 480
    Width = 113
    Height = 33
    Caption = 'Segmentet + Kukainis'
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 112
    Top = 456
    Width = 89
    Height = 17
    Caption = 'Atgrieshana'
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 72
    Top = 440
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Atteli (*.bmp, *.jpg)|*.bmp;*.jpg'
    Left = 8
    Top = 440
  end
  object dlgSave1: TSaveDialog
    FileName = 'img'
    Filter = 'Image(*.jpg)|(*.JPG)|Image(*.bmp)|(*.BMP)'
    Title = 'Save Image'
    Left = 40
    Top = 440
  end
end
