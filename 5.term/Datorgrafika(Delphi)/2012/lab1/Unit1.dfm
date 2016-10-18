object Main_menu: TMain_menu
  Left = 1031
  Top = 293
  Caption = 'Main_menu'
  ClientHeight = 521
  ClientWidth = 914
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
    Left = 334
    Top = 48
    Width = 563
    Height = 433
    Proportional = True
  end
  object Image2: TImage
    Left = 8
    Top = 48
    Width = 256
    Height = 100
    Proportional = True
    OnMouseDown = Image2MouseDown
    OnMouseMove = Image2MouseMove
    OnMouseUp = Image2MouseUp
  end
  object Label1: TLabel
    Left = 24
    Top = 178
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 64
    Top = 160
    Width = 28
    Height = 13
    Caption = 'Hstart'
  end
  object Label3: TLabel
    Left = 64
    Top = 184
    Width = 26
    Height = 13
    Caption = 'Hend'
  end
  object Label4: TLabel
    Left = 16
    Top = 160
    Width = 31
    Height = 13
    Caption = 'Levels'
  end
  object Button1: TButton
    Left = 160
    Top = 154
    Width = 96
    Height = 25
    Caption = 'Normalize Mono'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 154
    Width = 65
    Height = 56
    Caption = 'Repaint'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 96
    Top = 160
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '-1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 184
    Width = 57
    Height = 21
    TabOrder = 3
    Text = '256'
  end
  object Button3: TButton
    Left = 160
    Top = 186
    Width = 97
    Height = 25
    Caption = 'Normalize Colour'
    TabOrder = 4
    OnClick = Button3Click
  end
  object RadioGroup1: TRadioGroup
    Left = 264
    Top = 48
    Width = 65
    Height = 97
    Caption = 'RGB histo'
    ItemIndex = 0
    Items.Strings = (
      'Mono'
      'Red'
      'Green'
      'Blue')
    TabOrder = 5
  end
  object Button4: TButton
    Left = 17
    Top = 211
    Width = 75
    Height = 25
    Caption = 'Roberts'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 17
    Top = 242
    Width = 75
    Height = 25
    Caption = 'Previta'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 17
    Top = 273
    Width = 75
    Height = 25
    Caption = 'Sobela'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 17
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Frei-Chena'
    TabOrder = 9
    OnClick = Button7Click
  end
  object MainMenu1: TMainMenu
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
    Left = 32
  end
  object dlgSave1: TSaveDialog
    FileName = 'img'
    Filter = 'Image(*.jpg)|(*.JPG)|Image(*.bmp)|(*.BMP)'
    Title = 'Save Image'
    Left = 72
  end
end
