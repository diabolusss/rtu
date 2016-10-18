object Form1: TForm1
  Left = 378
  Top = 220
  Width = 1276
  Height = 637
  Caption = 'Scenu analize programma Mat'#299'ss Eri'#326's'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 328
    Top = 32
    Width = 400
    Height = 400
    Hint = 'Click on image to select object'
    ParentShowHint = False
    Proportional = True
    ShowHint = True
    OnClick = Image1Click
    OnMouseMove = Image1MouseMove
  end
  object Image2: TImage
    Left = 32
    Top = 48
    Width = 256
    Height = 100
    Hint = 'First click on edit then select with mouse'
    ParentShowHint = False
    ShowHint = True
    OnClick = Image2Click
    OnMouseMove = Image2MouseMove
  end
  object Label1: TLabel
    Left = 32
    Top = 168
    Width = 31
    Height = 13
    Caption = 'Levels'
  end
  object Label2: TLabel
    Left = 32
    Top = 190
    Width = 36
    Height = 13
    Caption = 'H_Start'
  end
  object Label3: TLabel
    Left = 31
    Top = 217
    Width = 33
    Height = 13
    Caption = 'H_End'
  end
  object Label6: TLabel
    Left = 32
    Top = 440
    Width = 51
    Height = 13
    Caption = 'Slieksnis T'
  end
  object Label7: TLabel
    Left = 24
    Top = 520
    Width = 78
    Height = 13
    Caption = 'pozicija uz attela'
    OnClick = Label7Click
  end
  object Label8: TLabel
    Left = 24
    Top = 544
    Width = 26
    Height = 13
    Caption = 'pixels'
  end
  object Label9: TLabel
    Left = 176
    Top = 520
    Width = 14
    Height = 13
    Caption = 'obj'
  end
  object Image3: TImage
    Left = 864
    Top = 32
    Width = 400
    Height = 400
  end
  object Label4: TLabel
    Left = 0
    Top = 24
    Width = 24
    Height = 13
    Caption = 'Lab1'
  end
  object Label5: TLabel
    Left = 0
    Top = 288
    Width = 27
    Height = 13
    Caption = 'Lab 2'
  end
  object Label10: TLabel
    Left = 0
    Top = 408
    Width = 27
    Height = 13
    Caption = 'Lab 3'
  end
  object Label11: TLabel
    Left = 168
    Top = 336
    Width = 41
    Height = 13
    Caption = 'Slieksnis'
  end
  object Panel1: TPanel
    Left = 24
    Top = 424
    Width = 265
    Height = 97
    TabOrder = 9
    object Label12: TLabel
      Left = 8
      Top = 56
      Width = 53
      Height = 13
      Caption = 'Fona krasa'
    end
    object Label13: TLabel
      Left = 64
      Top = 72
      Width = 8
      Height = 13
      Caption = 'R'
    end
    object Label14: TLabel
      Left = 128
      Top = 72
      Width = 8
      Height = 13
      Caption = 'G'
    end
    object Label15: TLabel
      Left = 192
      Top = 72
      Width = 7
      Height = 13
      Caption = 'B'
    end
    object Edit4: TEdit
      Left = 80
      Top = 72
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '255'
    end
    object Edit6: TEdit
      Left = 144
      Top = 72
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '255'
    end
    object Edit7: TEdit
      Left = 208
      Top = 72
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '255'
    end
  end
  object Button1: TButton
    Left = 32
    Top = 240
    Width = 105
    Height = 49
    Caption = 'Normalize'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 168
    Width = 105
    Height = 49
    Caption = 'Repaint'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 176
    Top = 240
    Width = 105
    Height = 49
    Caption = 'Normalize RGB'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 74
    Top = 187
    Width = 73
    Height = 21
    TabOrder = 3
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 74
    Top = 214
    Width = 73
    Height = 21
    TabOrder = 4
    Text = '255'
    OnChange = Edit2Change
  end
  object Button4: TButton
    Left = 176
    Top = 432
    Width = 105
    Height = 41
    Caption = 'ObjectDetect'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Edit5: TEdit
    Left = 88
    Top = 440
    Width = 49
    Height = 21
    TabOrder = 6
    Text = '5'
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 304
    Width = 265
    Height = 105
    Caption = 'Kontura izdalisana'
    ItemIndex = 0
    Items.Strings = (
      'Roberts (B '#39'&'#39' W)'
      'Roberts (Color)'
      'Prewitt'
      'Sobel'
      'Frei-Chen')
    TabOrder = 7
  end
  object Button5: TButton
    Left = 184
    Top = 360
    Width = 99
    Height = 41
    Caption = 'GO'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Edit3: TEdit
    Left = 216
    Top = 336
    Width = 57
    Height = 21
    Enabled = False
    TabOrder = 10
    Text = '128'
  end
  object CheckBox1: TCheckBox
    Left = 168
    Top = 312
    Width = 97
    Height = 17
    Caption = 'Lietot slieksni'
    TabOrder = 11
    OnClick = CheckBox1Click
  end
  object Panel3: TPanel
    Left = 688
    Top = 488
    Width = 313
    Height = 57
    Caption = '0'
    TabOrder = 12
  end
  object Panel2: TPanel
    Left = 296
    Top = 472
    Width = 385
    Height = 89
    Align = alCustom
    Alignment = taLeftJustify
    TabOrder = 13
    object Label16: TLabel
      Left = 8
      Top = 0
      Width = 83
      Height = 13
      Caption = 'Kukaina algoritms'
    end
    object Button6: TButton
      Left = 0
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Bug(old)'
      TabOrder = 0
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 112
      Top = 48
      Width = 265
      Height = 33
      Caption = 'Improved bug'
      TabOrder = 1
      OnClick = Button7Click
    end
    object RadioGroup2: TRadioGroup
      Left = 112
      Top = 8
      Width = 265
      Height = 41
      Caption = 'Izvele'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'with step save'
        'without step save')
      TabOrder = 2
    end
  end
  object Button8: TButton
    Left = 1096
    Top = 504
    Width = 75
    Height = 25
    Caption = 'New scene'
    TabOrder = 14
    OnClick = Button8Click
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
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Atteli (*.bmp, *.jpg)|*.bmp;*.jpg'
    Left = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 64
  end
end
