object Form1: TForm1
  Left = 26
  Top = 91
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 652
  ClientWidth = 1338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 1337
    Height = 657
    ActivePage = Main
    TabOrder = 0
    object Main: TTabSheet
      Caption = 'Main'
      object Label1: TLabel
        Left = 32
        Top = 312
        Width = 33
        Height = 13
        Caption = 'Teta ='
      end
      object Label2: TLabel
        Left = 24
        Top = 488
        Width = 34
        Height = 13
        Caption = 'Result:'
      end
      object img1: TImage
        Left = 142
        Top = 241
        Width = 6
        Height = 10
      end
      object btn1: TSpeedButton
        Left = 24
        Top = 176
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn1Click
      end
      object btn2: TSpeedButton
        Left = 24
        Top = 200
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn2Click
      end
      object btn3: TSpeedButton
        Left = 24
        Top = 224
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn3Click
      end
      object btn4: TSpeedButton
        Left = 24
        Top = 248
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn4Click
      end
      object btn5: TSpeedButton
        Left = 24
        Top = 272
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn5Click
      end
      object btn6: TSpeedButton
        Left = 72
        Top = 176
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn6Click
      end
      object btn7: TSpeedButton
        Left = 72
        Top = 200
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn7Click
      end
      object btn8: TSpeedButton
        Left = 72
        Top = 224
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn8Click
      end
      object btn9: TSpeedButton
        Left = 72
        Top = 248
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn9Click
      end
      object btn10: TSpeedButton
        Left = 72
        Top = 272
        Width = 23
        Height = 22
        GroupIndex = 1
        Visible = False
        OnClick = btn10Click
      end
      object lbl1: TLabel
        Left = 120
        Top = 208
        Width = 41
        Height = 26
        Caption = 'Selected'#13#10' picture'
      end
      object lbl2: TLabel
        Left = 1024
        Top = 0
        Width = 124
        Height = 16
        Caption = '1st perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 1024
        Top = 24
        Width = 128
        Height = 16
        Caption = '2nd perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 1024
        Top = 48
        Width = 126
        Height = 16
        Caption = '3rd perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 1024
        Top = 72
        Width = 125
        Height = 16
        Caption = '4th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl6: TLabel
        Left = 1024
        Top = 96
        Width = 125
        Height = 16
        Caption = '5th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 1064
        Top = 288
        Width = 68
        Height = 16
        Caption = 'Final result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl8: TLabel
        Left = 948
        Top = 240
        Width = 4
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 1052
        Top = 264
        Width = 4
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl10: TLabel
        Left = 1024
        Top = 120
        Width = 125
        Height = 16
        Caption = '6th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl11: TLabel
        Left = 1024
        Top = 144
        Width = 125
        Height = 16
        Caption = '7th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl12: TLabel
        Left = 1024
        Top = 168
        Width = 125
        Height = 16
        Caption = '8th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl13: TLabel
        Left = 1024
        Top = 192
        Width = 125
        Height = 16
        Caption = '9th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl14: TLabel
        Left = 1016
        Top = 216
        Width = 132
        Height = 16
        Caption = '10th perceptron result:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btn16: TSpeedButton
        Left = 144
        Top = 24
        Width = 23
        Height = 22
        GroupIndex = 2
        Down = True
        Caption = 'CG'
        OnClick = btn16Click
      end
      object btn17: TSpeedButton
        Left = 144
        Top = 56
        Width = 23
        Height = 22
        GroupIndex = 2
        Caption = 'PR'
        OnClick = btn17Click
      end
      object Button: TButton
        Left = 16
        Top = 16
        Width = 113
        Height = 33
        Caption = 'Open Training Set (TS)'
        TabOrder = 0
        OnClick = ButtonClick
      end
      object Button1: TButton
        Left = 16
        Top = 56
        Width = 113
        Height = 33
        Caption = 'Open Exam Set (ES)'
        Enabled = False
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 16
        Top = 352
        Width = 153
        Height = 33
        Caption = 'Teach Based On Current TS'
        TabOrder = 2
        OnClick = Button2Click
      end
      object edt1: TEdit
        Left = 72
        Top = 312
        Width = 81
        Height = 21
        TabOrder = 3
        Text = '0,1'
      end
      object Button3: TButton
        Left = 56
        Top = 440
        Width = 65
        Height = 25
        Caption = 'Test'
        Enabled = False
        TabOrder = 4
        OnClick = Button3Click
      end
      object edt2: TEdit
        Left = 64
        Top = 488
        Width = 105
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object mmo1: TMemo
        Left = 16
        Top = 520
        Width = 153
        Height = 49
        ReadOnly = True
        TabOrder = 6
      end
      object strngrd1: TStringGrid
        Left = 176
        Top = 12
        Width = 81
        Height = 577
        ColCount = 2
        DefaultColWidth = 30
        RowCount = 61
        TabOrder = 7
        RowHeights = (
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24)
      end
      object strngrd2: TStringGrid
        Left = 256
        Top = 12
        Width = 153
        Height = 577
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 8
        ColWidths = (
          20
          20
          20
          20
          19
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
      object strngrd3: TStringGrid
        Left = 408
        Top = 12
        Width = 153
        Height = 577
        ColCount = 11
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 41
        TabOrder = 9
      end
      object strngrd4: TStringGrid
        Left = 560
        Top = 12
        Width = 377
        Height = 577
        ColCount = 11
        DefaultColWidth = 35
        RowCount = 41
        TabOrder = 10
      end
      object Button4: TButton
        Left = 16
        Top = 136
        Width = 153
        Height = 33
        Caption = 'Set/Reset weights (W)'
        TabOrder = 11
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 16
        Top = 400
        Width = 153
        Height = 25
        Caption = 'Teach Based On Current ES'
        TabOrder = 12
        OnClick = Button5Click
      end
      object edt3: TEdit
        Left = 1160
        Top = 0
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 13
      end
      object edt4: TEdit
        Left = 1160
        Top = 24
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 14
      end
      object edt5: TEdit
        Left = 1160
        Top = 48
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 15
      end
      object edt6: TEdit
        Left = 1160
        Top = 72
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 16
      end
      object edt7: TEdit
        Left = 1160
        Top = 96
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 17
      end
      object edt8: TEdit
        Left = 1136
        Top = 288
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 18
      end
      object rg1: TRadioGroup
        Left = 976
        Top = 320
        Width = 273
        Height = 65
        Caption = 'Method Selection'
        ItemIndex = 0
        Items.Strings = (
          'Vienlidzibas balsosanas algoritms (Fully taught)'
          'Vienlidzibas balsosanas algoritms (Partially taught)'
          'Svertas balsosanas algoritms (Partially taught)')
        TabOrder = 19
      end
      object btn11: TButton
        Left = 1008
        Top = 440
        Width = 193
        Height = 33
        Caption = 'Set/Reset weights for all perceptrons'
        TabOrder = 20
        OnClick = btn11Click
      end
      object btn12: TButton
        Left = 1024
        Top = 488
        Width = 161
        Height = 25
        Caption = 'Teach all perceptrons'
        TabOrder = 21
        OnClick = btn12Click
      end
      object btn13: TButton
        Left = 1024
        Top = 528
        Width = 161
        Height = 25
        Caption = 'Test using selected method'
        TabOrder = 22
        OnClick = btn13Click
      end
      object btn14: TButton
        Left = 16
        Top = 96
        Width = 153
        Height = 25
        Caption = 'Generate random links'
        TabOrder = 23
        OnClick = btn14Click
      end
      object btn15: TButton
        Left = 1000
        Top = 400
        Width = 217
        Height = 25
        Caption = 'Generate random links for all perceptrons'
        TabOrder = 24
        OnClick = btn15Click
      end
      object mmo2: TMemo
        Left = 1008
        Top = 568
        Width = 185
        Height = 49
        TabOrder = 25
      end
      object edt9: TEdit
        Left = 1160
        Top = 120
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 26
      end
      object edt10: TEdit
        Left = 1160
        Top = 144
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 27
      end
      object edt11: TEdit
        Left = 1160
        Top = 168
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 28
      end
      object edt12: TEdit
        Left = 1160
        Top = 192
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 29
      end
      object edt13: TEdit
        Left = 1160
        Top = 216
        Width = 33
        Height = 21
        ReadOnly = True
        TabOrder = 30
      end
      object edt15: TEdit
        Left = 1272
        Top = 488
        Width = 33
        Height = 21
        TabOrder = 31
        Text = '5'
      end
      object txt2: TStaticText
        Left = 1192
        Top = 488
        Width = 75
        Height = 17
        Caption = 'Itteration limit:'
        TabOrder = 32
      end
    end
    object Teach_Data: TTabSheet
      Caption = 'Teach_Data'
      ImageIndex = 1
      object Button6: TButton
        Left = 16
        Top = 8
        Width = 161
        Height = 25
        Caption = 'Show links for all perceptrons'
        Enabled = False
        TabOrder = 0
        OnClick = Button6Click
      end
      object strngrd5: TStringGrid
        Left = 0
        Top = 32
        Width = 129
        Height = 569
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 1
      end
      object strngrd6: TStringGrid
        Left = 136
        Top = 32
        Width = 129
        Height = 569
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 2
        ColWidths = (
          20
          20
          22
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
      object strngrd7: TStringGrid
        Left = 272
        Top = 32
        Width = 129
        Height = 569
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 3
      end
      object strngrd8: TStringGrid
        Left = 408
        Top = 32
        Width = 129
        Height = 569
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 4
        ColWidths = (
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
      object strngrd9: TStringGrid
        Left = 544
        Top = 32
        Width = 129
        Height = 569
        ColCount = 41
        DefaultColWidth = 20
        DefaultRowHeight = 18
        RowCount = 61
        TabOrder = 5
      end
      object mmo3: TMemo
        Left = 680
        Top = 64
        Width = 185
        Height = 89
        TabOrder = 6
      end
      object mmo4: TMemo
        Left = 680
        Top = 160
        Width = 185
        Height = 89
        Lines.Strings = (
          '')
        TabOrder = 7
      end
      object mmo5: TMemo
        Left = 680
        Top = 256
        Width = 185
        Height = 89
        TabOrder = 8
      end
      object mmo6: TMemo
        Left = 680
        Top = 352
        Width = 185
        Height = 89
        TabOrder = 9
      end
      object mmo7: TMemo
        Left = 680
        Top = 440
        Width = 185
        Height = 89
        TabOrder = 10
      end
      object mmo8: TMemo
        Left = 872
        Top = 64
        Width = 185
        Height = 89
        Lines.Strings = (
          '')
        TabOrder = 11
      end
      object mmo9: TMemo
        Left = 872
        Top = 160
        Width = 185
        Height = 89
        TabOrder = 12
      end
      object mmo10: TMemo
        Left = 872
        Top = 256
        Width = 185
        Height = 89
        TabOrder = 13
      end
      object mmo11: TMemo
        Left = 872
        Top = 352
        Width = 185
        Height = 89
        TabOrder = 14
      end
      object mmo12: TMemo
        Left = 872
        Top = 440
        Width = 185
        Height = 89
        TabOrder = 15
      end
      object strngrd10: TStringGrid
        Left = 1080
        Top = 32
        Width = 186
        Height = 281
        ColCount = 3
        DefaultColWidth = 60
        RowCount = 11
        TabOrder = 16
      end
      object txt1: TStaticText
        Left = 1096
        Top = 0
        Width = 157
        Height = 20
        Caption = 'Perceptrons by error count'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object strngrd11: TStringGrid
        Left = 1080
        Top = 328
        Width = 186
        Height = 281
        ColCount = 3
        DefaultColWidth = 60
        RowCount = 11
        TabOrder = 18
      end
      object edt14: TEdit
        Left = 872
        Top = 16
        Width = 49
        Height = 21
        TabOrder = 19
      end
    end
  end
end
