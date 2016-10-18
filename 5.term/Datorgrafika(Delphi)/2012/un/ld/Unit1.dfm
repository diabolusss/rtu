object Form1: TForm1
  Left = 256
  Top = 353
  Width = 870
  Height = 592
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
  object Label1: TLabel
    Left = 600
    Top = 80
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 744
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 744
    Top = 64
    Width = 75
    Height = 25
    Caption = 'RGB'
    TabOrder = 1
    OnClick = Button2Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 16
    Width = 553
    Height = 473
    ActivePage = TabSheet4
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Original'
      object Image1: TImage
        Left = 0
        Top = 4
        Width = 545
        Height = 445
        OnMouseMove = Image1MouseMove
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'RGB'
      ImageIndex = 1
      object Image2: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Invert'
      ImageIndex = 2
      object Image3: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Cmy'
      ImageIndex = 3
      object Image4: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'cMy'
      ImageIndex = 4
      object Image5: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'cmY'
      ImageIndex = 5
      object Image6: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Cmyk'
      ImageIndex = 6
      object Image7: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'cMyk'
      ImageIndex = 7
      object Image8: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'cmYk'
      ImageIndex = 8
      object Image9: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'cmyK'
      ImageIndex = 9
      object Image10: TImage
        Left = 8
        Top = 0
        Width = 545
        Height = 449
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Hsv'
      ImageIndex = 10
      object Image11: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 441
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'hSv'
      ImageIndex = 11
      object Image12: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 441
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'hsV'
      ImageIndex = 12
      object Image13: TImage
        Left = 0
        Top = 0
        Width = 545
        Height = 441
      end
    end
  end
  object Button3: TButton
    Left = 744
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Invertet'
    TabOrder = 3
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 592
    Top = 136
    Width = 97
    Height = 17
    Caption = 'RED'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 592
    Top = 160
    Width = 97
    Height = 17
    Caption = 'GREEN'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object CheckBox3: TCheckBox
    Left = 592
    Top = 184
    Width = 97
    Height = 17
    Caption = 'BLUE'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 592
    Top = 208
    Width = 97
    Height = 17
    Caption = 'Invert'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object Button4: TButton
    Left = 760
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 736
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 9
    OnClick = Button5Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 600
    Top = 40
  end
end
