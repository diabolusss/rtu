object Form2: TForm2
  Left = 192
  Top = 116
  Caption = 'RGB '
  ClientHeight = 487
  ClientWidth = 754
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
    Left = 8
    Top = 16
    Width = 289
    Height = 289
  end
  object Image2: TImage
    Left = 312
    Top = 16
    Width = 289
    Height = 289
  end
  object Label1: TLabel
    Left = 8
    Top = 328
    Width = 20
    Height = 13
    Caption = 'Red'
  end
  object Label2: TLabel
    Left = 8
    Top = 384
    Width = 29
    Height = 13
    Caption = 'Green'
  end
  object Label3: TLabel
    Left = 8
    Top = 440
    Width = 21
    Height = 13
    Caption = 'Blue'
  end
  object TrackBar1: TTrackBar
    Left = 56
    Top = 328
    Width = 473
    Height = 41
    Max = 255
    Min = -255
    TabOrder = 0
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
  object TrackBar2: TTrackBar
    Left = 56
    Top = 384
    Width = 473
    Height = 41
    Max = 255
    Min = -255
    TabOrder = 1
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
  object TrackBar3: TTrackBar
    Left = 56
    Top = 440
    Width = 473
    Height = 41
    Max = 255
    Min = -255
    TabOrder = 2
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
  object Button1: TButton
    Left = 632
    Top = 40
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 632
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 544
    Top = 328
    Width = 57
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 544
    Top = 384
    Width = 57
    Height = 21
    TabOrder = 6
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 544
    Top = 440
    Width = 57
    Height = 21
    TabOrder = 7
    Text = 'Edit3'
  end
end
