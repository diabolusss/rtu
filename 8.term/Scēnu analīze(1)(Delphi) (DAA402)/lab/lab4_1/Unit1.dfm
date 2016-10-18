object Main_menu: TMain_menu
  Left = 240
  Top = 248
  Caption = 'Main_menu'
  ClientHeight = 564
  ClientWidth = 931
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
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
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
  object mouse_pos: TLabel
    Left = 328
    Top = 528
    Width = 54
    Height = 13
    Caption = 'mouse_pos'
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
  object Edit1: TEdit
    Left = 96
    Top = 160
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '-1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 184
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '256'
  end
  object Button3: TButton
    Left = 160
    Top = 186
    Width = 97
    Height = 25
    Caption = 'Normalize Colour'
    TabOrder = 3
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
    TabOrder = 4
  end
  object Button4: TButton
    Left = 182
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Iezimet'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Edit3: TEdit
    Left = 88
    Top = 240
    Width = 97
    Height = 21
    TabOrder = 6
    Text = '10'
  end
  object Button5: TButton
    Left = 45
    Top = 325
    Width = 75
    Height = 25
    Caption = 'Kukainis'
    TabOrder = 7
    OnClick = Button5Click
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 329
    Width = 97
    Height = 17
    Caption = 'Atgrishanos'
    TabOrder = 8
  end
  object Button6: TButton
    Left = 262
    Top = 151
    Width = 65
    Height = 57
    Caption = 'Repaint'
    TabOrder = 9
    OnClick = Button6Click
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
    object Konturuzimeshana1: TMenuItem
      Caption = 'Konturi'
      object Melnbalts1: TMenuItem
        Caption = 'Melnbalts'
        object Roberts1: TMenuItem
          Caption = 'Roberts'
          OnClick = Roberts1Click
        end
        object Previta1: TMenuItem
          Caption = 'Previta'
          OnClick = Previta1Click
        end
        object Sobela1: TMenuItem
          Caption = 'Sobela'
          OnClick = Sobela1Click
        end
        object FreiChena1: TMenuItem
          Caption = 'Frei-Chena'
        end
      end
      object Krasains1: TMenuItem
        Caption = 'Krasains'
        object Roberts2: TMenuItem
          Caption = 'Robertss'
          OnClick = Roberts2Click
        end
        object Previta2: TMenuItem
          Caption = 'Previtas'
          OnClick = Previta2Click
        end
        object Sobela2: TMenuItem
          Caption = 'Sobelas'
          OnClick = Sobela2Click
        end
        object FreiChena2: TMenuItem
          Caption = 'Frei-Chenas'
          OnClick = FreiChena2Click
        end
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
