object Form1: TForm1
  Left = 201
  Top = 156
  Width = 1081
  Height = 649
  Caption = 'Graphic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 393
    Height = 321
    TabOrder = 0
    object Image1: TImage
      Left = 3
      Top = 3
      Width = 382
      Height = 310
      AutoSize = True
    end
  end
  object ScrollBox2: TScrollBox
    Left = 408
    Top = 8
    Width = 649
    Height = 577
    TabOrder = 1
    object Image3: TImage
      Left = 3
      Top = 3
      Width = 638
      Height = 566
      AutoSize = True
      IncrementalDisplay = True
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 336
    Width = 393
    Height = 249
    ActivePage = rgbhsv
    TabOrder = 2
    object rgbhsv: TTabSheet
      Caption = 'RGB/HSV'
      object Label1: TLabel
        Left = 6
        Top = 10
        Width = 17
        Height = 19
        Caption = 'Ar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 166
        Top = 10
        Width = 9
        Height = 19
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 34
        Width = 20
        Height = 19
        Caption = 'Ag'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 166
        Top = 34
        Width = 9
        Height = 19
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 6
        Top = 58
        Width = 20
        Height = 19
        Caption = 'Ab'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 166
        Top = 58
        Width = 9
        Height = 19
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 190
        Top = 10
        Width = 15
        Height = 19
        Caption = 'Br'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 350
        Top = 10
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 190
        Top = 34
        Width = 18
        Height = 19
        Caption = 'Bg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 350
        Top = 34
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 190
        Top = 58
        Width = 18
        Height = 19
        Caption = 'Bb'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 350
        Top = 58
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 46
        Top = 98
        Width = 28
        Height = 19
        Caption = 'Hue'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 206
        Top = 98
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 6
        Top = 122
        Width = 72
        Height = 19
        Caption = 'Saturation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 206
        Top = 122
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 38
        Top = 146
        Width = 39
        Height = 19
        Caption = 'Value'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 206
        Top = 146
        Width = 9
        Height = 19
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 230
        Top = 122
        Width = 16
        Height = 19
        Caption = 'Xs'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 360
        Top = 122
        Width = 9
        Height = 19
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 230
        Top = 146
        Width = 17
        Height = 19
        Caption = 'Xv'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 360
        Top = 146
        Width = 9
        Height = 19
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object ScrollBar4: TScrollBar
        Left = 33
        Top = 13
        Width = 121
        Height = 16
        Max = 255
        PageSize = 0
        Position = 1
        TabOrder = 0
        OnChange = ScrollBar4Change
      end
      object ScrollBar5: TScrollBar
        Left = 33
        Top = 37
        Width = 121
        Height = 16
        Max = 255
        PageSize = 0
        Position = 1
        TabOrder = 1
        OnChange = ScrollBar5Change
      end
      object ScrollBar6: TScrollBar
        Left = 33
        Top = 61
        Width = 121
        Height = 16
        Max = 255
        PageSize = 0
        Position = 1
        TabOrder = 2
        OnChange = ScrollBar6Change
      end
      object ScrollBar1: TScrollBar
        Left = 218
        Top = 13
        Width = 121
        Height = 16
        Max = 255
        Min = -255
        PageSize = 0
        TabOrder = 3
        OnChange = ScrollBar1Change
      end
      object ScrollBar2: TScrollBar
        Left = 218
        Top = 37
        Width = 121
        Height = 16
        Max = 255
        Min = -255
        PageSize = 0
        TabOrder = 4
        OnChange = ScrollBar2Change
      end
      object ScrollBar3: TScrollBar
        Left = 218
        Top = 61
        Width = 121
        Height = 16
        Max = 255
        Min = -255
        PageSize = 0
        TabOrder = 5
        OnChange = ScrollBar3Change
      end
      object ScrollBar7: TScrollBar
        Left = 88
        Top = 100
        Width = 105
        Height = 17
        Max = 360
        PageSize = 0
        TabOrder = 6
        OnChange = ScrollBar7Change
      end
      object ScrollBar8: TScrollBar
        Left = 88
        Top = 124
        Width = 105
        Height = 17
        Max = 255
        Min = -255
        PageSize = 0
        TabOrder = 7
        OnChange = ScrollBar8Change
      end
      object ScrollBar9: TScrollBar
        Left = 88
        Top = 148
        Width = 105
        Height = 17
        Max = 255
        Min = -255
        PageSize = 0
        TabOrder = 8
        OnChange = ScrollBar9Change
      end
      object ScrollBar10: TScrollBar
        Left = 256
        Top = 124
        Width = 97
        Height = 17
        Max = 255
        PageSize = 0
        Position = 1
        TabOrder = 9
        OnChange = ScrollBar10Change
      end
      object ScrollBar11: TScrollBar
        Left = 256
        Top = 148
        Width = 97
        Height = 17
        Max = 255
        PageSize = 0
        Position = 1
        TabOrder = 10
        OnChange = ScrollBar11Change
      end
      object Button4: TButton
        Left = 88
        Top = 180
        Width = 105
        Height = 25
        Caption = 'Reset'
        TabOrder = 11
        OnClick = Button4Click
      end
      object Button1: TButton
        Left = 192
        Top = 180
        Width = 41
        Height = 25
        Caption = 'HSV'
        TabOrder = 12
        Visible = False
        OnClick = Button1Click
      end
    end
    object hist: TTabSheet
      Caption = 'Histogram'
      ImageIndex = 1
      object Image2: TImage
        Left = 64
        Top = 48
        Width = 255
        Height = 100
      end
      object Label23: TLabel
        Left = 80
        Top = 168
        Width = 64
        Height = 16
        Caption = 'V. intervals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 80
        Top = 192
        Width = 64
        Height = 16
        Caption = 'H. intervals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 184
        Top = 168
        Width = 5
        Height = 16
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 184
        Top = 192
        Width = 5
        Height = 16
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 57
        Top = 136
        Width = 6
        Height = 13
        Caption = '0'
        Visible = False
      end
      object Label28: TLabel
        Left = 46
        Top = 40
        Width = 18
        Height = 13
        Caption = '100'
        Visible = False
      end
      object Label29: TLabel
        Left = 326
        Top = 136
        Width = 18
        Height = 13
        Caption = '255'
        Visible = False
      end
      object Edit2: TEdit
        Left = 152
        Top = 168
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit3: TEdit
        Left = 192
        Top = 168
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '255'
      end
      object Edit4: TEdit
        Left = 152
        Top = 192
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object Edit5: TEdit
        Left = 192
        Top = 192
        Width = 33
        Height = 21
        TabOrder = 3
        Text = '100'
      end
      object Button2: TButton
        Left = 144
        Top = 8
        Width = 97
        Height = 25
        Caption = 'Izveidot/Atjaunot'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 232
        Top = 168
        Width = 73
        Height = 25
        Caption = 'V. segments'
        TabOrder = 5
        OnClick = Button3Click
      end
      object Button5: TButton
        Left = 232
        Top = 192
        Width = 73
        Height = 25
        Caption = 'H. segments'
        TabOrder = 6
        OnClick = Button5Click
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 552
    object File1: TMenuItem
      Caption = 'Fails'
      object Open1: TMenuItem
        Caption = 'Atvert'
        OnClick = Open1Click
      end
      object SaveasJPG1: TMenuItem
        Caption = 'Saglabat ka JPG'
        OnClick = SaveasJPG1Click
      end
      object SaveasBMP1: TMenuItem
        Caption = 'Saglabat ka BMP'
        OnClick = SaveasBMP1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Transformacijas'
      object Nobide1: TMenuItem
        Caption = 'Nobide'
        OnClick = Nobide1Click
      end
      object Rotation1: TMenuItem
        Caption = 'Atspogulosana'
        object N90deg1: TMenuItem
          Caption = 'Pec Oy'
          OnClick = N90deg1Click
        end
        object N180deg1: TMenuItem
          Caption = 'Pec Ox'
          OnClick = N180deg1Click
        end
      end
      object Rotesana1: TMenuItem
        Caption = 'Rotesana'
        object N901: TMenuItem
          Caption = '90'
          OnClick = N901Click
        end
        object N1801: TMenuItem
          Caption = '180'
          OnClick = N1801Click
        end
        object N2701: TMenuItem
          Caption = '270'
          OnClick = N2701Click
        end
        object N1: TMenuItem
          Caption = 'N'
          OnClick = N1Click
        end
      end
      object Merogosana1: TMenuItem
        Caption = 'Merogosana'
        object uvkaim1: TMenuItem
          Caption = 'Tuv.kaim.'
          OnClick = uvkaim1Click
        end
        object Bilineara1: TMenuItem
          Caption = 'Bilineara'
          OnClick = Bilineara1Click
        end
        object Bikubiska1: TMenuItem
          Caption = 'Bikubiska'
          OnClick = Bikubiska1Click
        end
      end
    end
    object roksnis1: TMenuItem
      Caption = 'Uzlabosana'
      object roksnis2: TMenuItem
        Caption = 'Troksni'
        OnClick = roksnis2Click
      end
      object Gludinasana1: TMenuItem
        Caption = 'Smooth'
        OnClick = Gludinasana1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 48
    Top = 552
  end
  object OpenDialog1: TOpenDialog
    Left = 16
    Top = 528
  end
end
