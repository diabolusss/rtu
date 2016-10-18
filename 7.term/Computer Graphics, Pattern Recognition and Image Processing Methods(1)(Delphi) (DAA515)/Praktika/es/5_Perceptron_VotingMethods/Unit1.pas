unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Buttons, ComCtrls;

const
  r_count = 59;
  n_count = 39;
  w_count = 39;
  perc_count = 10;

type
  vec60i = array[0..r_count] of integer; //receptoriem
  vec40i = array[0..n_count] of integer; //neironiem
  vec40u = array[0..perc_count-1,0..n_count] of Integer; //neironiem vairakiem perceptroniem
  vec40f = array[0..w_count] of Single; //svariem
  vec40w = array[0..perc_count-1,0..w_count] of Single; //svariem vairakiem perceptroniem
  vec10reserr = array[0..perc_count-1] of record
    pr: string;
    rs: Integer;
    er: Integer;
  end;
  strct = array[0..r_count,0..n_count] of integer; //saitem
  TForm1 = class(TForm)
    pgc1: TPageControl;
    Main: TTabSheet;
    Teach_Data: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    img1: TImage;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btn10: TSpeedButton;
    lbl1: TLabel;
    Button: TButton;
    Button1: TButton;
    Button2: TButton;
    edt1: TEdit;
    Button3: TButton;
    edt2: TEdit;
    mmo1: TMemo;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    strngrd3: TStringGrid;
    strngrd4: TStringGrid;
    Button4: TButton;
    Button5: TButton;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    rg1: TRadioGroup;
    btn11: TButton;
    btn12: TButton;
    btn13: TButton;
    btn14: TButton;
    btn15: TButton;
    mmo2: TMemo;
    Button6: TButton;
    strngrd5: TStringGrid;
    strngrd6: TStringGrid;
    strngrd7: TStringGrid;
    strngrd8: TStringGrid;
    strngrd9: TStringGrid;
    lbl8: TLabel;
    lbl9: TLabel;
    mmo3: TMemo;
    mmo4: TMemo;
    mmo5: TMemo;
    mmo6: TMemo;
    mmo7: TMemo;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    edt9: TEdit;
    edt10: TEdit;
    edt11: TEdit;
    edt12: TEdit;
    edt13: TEdit;
    mmo8: TMemo;
    mmo9: TMemo;
    mmo10: TMemo;
    mmo11: TMemo;
    mmo12: TMemo;
    btn16: TSpeedButton;
    btn17: TSpeedButton;
    strngrd10: TStringGrid;
    txt1: TStaticText;
    //procedure CreateSB(Name: string; nClass, which: Integer);
    procedure NN_Input_X();
    procedure NN_Random_Links();
    procedure NN_Random_Links_Multiple();
    procedure NN_Random_W();
    procedure NN_Random_W_Multiple();
    procedure NN_Calculate_Y();
    procedure NN_Calculate_Y_Multiple();
    procedure NN_Calculate_Y_Multiple_Teach(a:Integer);
    procedure NN_Calculate_Result();
    procedure NN_Adapt_W();
    procedure NN_Teach();
    procedure NN_Teach_Multiple();
    procedure ButtonClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btn16Click(Sender: TObject);
    procedure btn17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  x: vec60i; //receptori
  y: vec40i; //neironi
  u: vec40u; //neironi
  w: vec40f; //svari
  v: vec40w; //svari vairakiem perceptroniem
  s,t,q,z,o,ss,tt,qq,zz,oo: strct; //saites starp neironiem un receptoriem
  r: integer; //rezultats
  reserr: vec10reserr; //katra perceptrona numurs, rezultats un kludu skaits
  teta: real; //teta, lai adaptet svarus
  nClass1, nClass2: Integer;
  TeachTS, btn1pressed, Teach_Multiple, CG : Boolean;

implementation

{$R *.dfm}

{procedure TForm1.CreateSB(Name: string; nClass, which: Integer);
var sb: TSpeedButton;
begin
  sb:=TSpeedButton.Create(Form1);
  sb.Name:=Name;
  sb.Width:=23;
  sb.Height:=22;
  sb.Parent:=pnl1;
  sb.GroupIndex:=1;
  sb.AllowAllUp:=False;
  sb.Down:=True;
  if (nClass=0) then
  begin
    sb.Left:=25;
    sb.Top:=which*sb.Height-10;
  end;
  if (nClass=1) then
  begin
    sb.Left:=65;
    sb.Top:=which*sb.Height-10;
  end;
end;}

procedure TForm1.NN_Input_X();
var i,j: Integer;
begin
  for i:=0 to img1.Width-1 do
  begin
    for j:=0 to img1.Height-1 do
    begin
      if(img1.Canvas.Pixels[i,j]=clBlack) then
        x[i+img1.Width*j]:=1
      else
        x[i+img1.Width*j]:=0;
    end;
  end;
    with strngrd1 do
    begin
      for i:=1 to r_count+1 do
      begin
        Cells[1,i]:=IntToStr(x[i-1]);
      end;
    end;
end;

procedure TForm1.NN_Random_Links();
var i,j,tmp1,tmp2,tmp3:Integer;
begin
  for i:=0 to r_count do
  begin
    for j:=0 to n_count do
    begin
      s[i,j]:=0;
    end;
  end;
  for i:=0 to r_count do
  begin
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    s[i,tmp1]:=1;
    s[i,tmp2]:=1;
    s[i,tmp3]:=-1;
  end;
  with strngrd2 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[j,i]:=IntToStr(s[i-1,j-1]);
      end;
    end;
  end;
end;

procedure TForm1.NN_Random_Links_Multiple();
var i,j,tmp1,tmp2,tmp3:Integer;
begin
  Randomize;
  for i:=0 to r_count do
  begin
    for j:=0 to n_count do
    begin
      s[i,j]:=0;
      t[i,j]:=0;
      q[i,j]:=0;
      z[i,j]:=0;
      o[i,j]:=0;
      ss[i,j]:=0;
      tt[i,j]:=0;
      qq[i,j]:=0;
      zz[i,j]:=0;
      oo[i,j]:=0;
    end;
  end;
  for i:=0 to r_count do
  begin
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    s[i,tmp1]:=1;
    s[i,tmp2]:=1;
    s[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    t[i,tmp1]:=1;
    t[i,tmp2]:=1;
    t[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    q[i,tmp1]:=1;
    q[i,tmp2]:=1;
    q[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    z[i,tmp1]:=1;
    z[i,tmp2]:=1;
    z[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    o[i,tmp1]:=1;
    o[i,tmp2]:=1;
    o[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    ss[i,tmp1]:=1;
    ss[i,tmp2]:=1;
    ss[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    tt[i,tmp1]:=1;
    tt[i,tmp2]:=1;
    tt[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    qq[i,tmp1]:=1;
    qq[i,tmp2]:=1;
    qq[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    zz[i,tmp1]:=1;
    zz[i,tmp2]:=1;
    zz[i,tmp3]:=-1;
    tmp1:=Random(n_count);
    tmp2:=Random(n_count);
    tmp3:=Random(n_count);
    oo[i,tmp1]:=1;
    oo[i,tmp2]:=1;
    oo[i,tmp3]:=-1;
  end;
end;

procedure TForm1.NN_Random_W();
var i,j:Integer;
begin
  Randomize;
  for j:=0 to n_count do
  begin
    w[j]:=2*Random-1;
  end;
  with strngrd4 do
  begin
    for i:=1 to w_count+1 do
    begin
      Cells[1,i]:=FloatToStr(w[i-1]);
    end;
  end;
end;

procedure TForm1.NN_Random_W_Multiple;
var i,j:Integer;
begin
  Randomize;
  for i:=0 to perc_count do
  begin
    for j:=0 to n_count do
    begin
      v[i,j]:=2*Random-1;
    end;
  end;
  with strngrd4 do
  begin
    for i:=1 to perc_count do
    begin
      Cells[i,0]:='perc' + IntToStr(i);
    end;
    for i:=1 to w_count+1 do
    begin
      Cells[0,i]:='w' + IntToStr(i);
    end;
    for i:=1 to perc_count do
    begin
      for j:=1 to w_count+1 do
      begin
        Cells[i,j]:=FloatToStr(v[i-1,j-1]);
      end;
    end;
  end;
end;

procedure TForm1.NN_Calculate_Y();
var i,j,tmp:Integer;
begin
  for j:=0 to n_count do
  begin
    tmp:=0;
    teta := StrToFloat(edt1.Text);
    for i:=0 to r_count do
    begin
      tmp:=tmp+x[i]*s[i,j];
      if(tmp-teta>=0) then
        y[j]:=1
      else
        y[j]:=0;
    end;
  end;
    with strngrd3 do
    begin
      for i:=1 to n_count+1 do
      begin
        Cells[1,i]:=IntToStr(y[i-1]);
      end;
    end;
end;

procedure TForm1.NN_Calculate_Y_Multiple();
var i,j, k,tmp, tmplink:Integer;
begin
  tmplink:=0;
  teta := StrToFloat(edt1.Text);
  for k:=0 to perc_count-1 do
  begin
    for j:=0 to n_count do
    begin
      tmp:=0;
      for i:=0 to r_count do
      begin

        if (k=0) then
          tmplink:=s[i,j]
        else if (k=1) then
          tmplink:=t[i,j]
        else if (k=2) then
          tmplink:=q[i,j]
        else if (k=3) then
          tmplink:=z[i,j]
        else if (k=4) then
          tmplink:=o[i,j]
        else if (k=5) then
          tmplink:=ss[i,j]
        else if (k=6) then
          tmplink:=tt[i,j]
        else if (k=7) then
          tmplink:=qq[i,j]
        else if (k=8) then
          tmplink:=zz[i,j]
        else if (k=9) then
          tmplink:=oo[i,j];

        tmp:=tmp+x[i]*tmplink;
        if(tmp-teta>=0) then
          u[k,j]:=1
        else
          u[k,j]:=0;
      end;
    end;
  end;
  with strngrd3 do
  begin
    for k:=1 to perc_count do
    begin
      Cells[k,0]:='perc' + IntToStr(k);
    end;
    for k:=1 to n_count+1 do
    begin
      Cells[0,k]:='y' + IntToStr(k);
    end;
    for k:=0 to perc_count-1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[k+1,j]:=IntToStr(u[k,j-1]);
      end;
    end;
  end;
end;

procedure TForm1.NN_Calculate_Y_Multiple_Teach(a:Integer);
var i,j, tmp, tmplink:Integer;
begin
  tmplink:=0;
  teta := StrToFloat(edt1.Text);
  for j:=0 to n_count do
  begin
    tmp:=0;
    for i:=0 to r_count do
    begin

      if (a=0) then
        tmplink:=s[i,j]
      else if (a=1) then
        tmplink:=t[i,j]
      else if (a=2) then
        tmplink:=q[i,j]
      else if (a=3) then
        tmplink:=z[i,j]
      else if (a=4) then
        tmplink:=o[i,j]
      else if (a=5) then
        tmplink:=ss[i,j]
      else if (a=6) then
        tmplink:=tt[i,j]
      else if (a=7) then
        tmplink:=qq[i,j]
      else if (a=8) then
        tmplink:=zz[i,j]
      else if (a=9) then
        tmplink:=oo[i,j];

      tmp:=tmp+x[i]*tmplink;
      if(tmp-teta>=0) then
        u[a,j]:=1
      else
        u[a,j]:=0;
    end;
  end;
end;

procedure TForm1.NN_Calculate_Result();
var tmp:Single;
var j:Integer;
begin
  tmp:=0;
  for j:=0 to n_count do
  begin
    tmp:=tmp+y[j]*w[j];
  end;
  if (tmp>=0) then
    r:=1
  else
    r:=0;
end;

procedure TForm1.NN_Adapt_W();
var i:Integer;
begin
  for i:=0 to n_count do
  begin
    w[i]:=w[i]+y[i]*(1-2*r);
  end;
end;

procedure TForm1.NN_Teach();
var itterations, error, i:Integer;
var currentClass: integer;
begin
  mmo1.Clear;
  itterations:=0;
  error:=1;
  while (error>0) do
  begin
    inc(itterations);
    error:=0;
    for i:=1 to 10 do
    begin
      if (CG) then
      begin
        if(TeachTS)then
        begin
          if(i<6) then
          begin
            img1.Picture.LoadFromFile('apm_izlase/c'+IntToStr(i)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('apm_izlase/g'+IntToStr(i-5)+'.bmp');
            currentClass:=1;
          end;
        end
        else
        begin
          if(i<6) then
          begin
            img1.Picture.LoadFromFile('eksamens/c'+IntToStr(i)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('eksamens/g'+IntToStr(i-5)+'.bmp');
            currentClass:=1;
          end;
        end;
      end
      else
      begin
        if(TeachTS)then
        begin
          if(i<6) then
          begin
            img1.Picture.LoadFromFile('apm_izlase/p'+IntToStr(i)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('apm_izlase/r'+IntToStr(i-5)+'.bmp');
            currentClass:=1;
          end;
        end
        else
        begin
          if(i<6) then
          begin
            img1.Picture.LoadFromFile('eksamens/p'+IntToStr(i)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('eksamens/r'+IntToStr(i-5)+'.bmp');
            currentClass:=1;
          end;
        end;
      end;
      NN_Input_X;
      NN_Calculate_Y;
      NN_Calculate_Result;
      if not (currentClass=r) then
        begin
          NN_Adapt_W();
          inc(error);
        end;
    end;
  end;
  with strngrd4 do
  begin
    for i:=1 to w_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=FloatToStr(w[i-1]);
    end;
  end;
  Button1.Enabled:=True;
  mmo1.Lines[0]:='Info:';
  mmo1.Lines.Add('Neural Network was trained');
  mmo1.Lines.Add('in ' + IntToStr(itterations) + ' itterations');
end;

procedure TForm1.NN_Teach_Multiple();
var i, j, k, l, itterations, itterations_foreach, error, currentClass: integer;
var tmp: Single;
begin
  teta := StrToFloat(edt1.Text);
  itterations:=0;
  mmo2.Clear;
  mmo3.Clear;
  mmo4.Clear;
  mmo5.Clear;
  mmo6.Clear;
  mmo7.Clear;
  mmo8.Clear;
  mmo9.Clear;
  mmo10.Clear;
  mmo11.Clear;
  mmo12.Clear;
  for i:=0 to perc_count-1 do
  begin
    itterations_foreach:=0;
    error:=1;
    while (error>0) do
    begin
      inc(itterations);
      inc(itterations_foreach);
      error:=0;
      for j:=1 to 10 do
      begin
        if (CG) then
        begin
          if(j<6) then
          begin
            img1.Picture.LoadFromFile('apm_izlase/c'+IntToStr(j)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('apm_izlase/g'+IntToStr(j-5)+'.bmp');
            currentClass:=1;
          end;
        end
        else
        begin
          if(j<6) then
          begin
            img1.Picture.LoadFromFile('apm_izlase/p'+IntToStr(j)+'.bmp');
            currentClass:=0;
          end
          else
          begin
            img1.Picture.LoadFromFile('apm_izlase/r'+IntToStr(j-5)+'.bmp');
            currentClass:=1;
          end;
        end;

        NN_Input_X;

        NN_Calculate_Y_Multiple_Teach(i);

        tmp:=0;
        for k:=0 to n_count do
        begin
          tmp:=tmp+u[i,k]*v[i,k];
          if (tmp>=0) then
            r:=1
          else
            r:=0;
        end;
          
        if not (currentClass=r) then
        begin
          for l:=0 to n_count do
          begin
            v[i,l]:=v[i,l]+u[i,l]*(1-2*r);
          end;
          inc(error);
        end;
      end;

      if(((rg1.ItemIndex=1) or (rg1.ItemIndex=2)) and (itterations_foreach=5)) then
      begin
        reserr[i].er:=error;
        error:=0;
      end;
    end;

    if (i=0) then
    begin
      mmo3.Lines[0]:='Info:';
      mmo3.Lines.Add('1st perceptron was trained');
      mmo3.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if (rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo3.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)');
    end
    else if (i=1) then
    begin
      mmo4.Lines[0]:='Info:';
      mmo4.Lines.Add('2nd perceptron was trained');
      mmo4.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo4.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)');
    end
    else if (i=2) then
    begin
      mmo5.Lines[0]:='Info:';
      mmo5.Lines.Add('3rd perceptron was trained');
      mmo5.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo5.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=3) then
    begin
      mmo6.Lines[0]:='Info:';
      mmo6.Lines.Add('4th perceptron was trained');
      mmo6.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo6.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=4) then
    begin
      mmo7.Lines[0]:='Info:';
      mmo7.Lines.Add('5th perceptron was trained');
      mmo7.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo7.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=5) then
    begin
      mmo8.Lines[0]:='Info:';
      mmo8.Lines.Add('6th perceptron was trained');
      mmo8.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo8.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=6) then
    begin
      mmo9.Lines[0]:='Info:';
      mmo9.Lines.Add('7th perceptron was trained');
      mmo9.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo9.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=7) then
    begin
      mmo10.Lines[0]:='Info:';
      mmo10.Lines.Add('8th perceptron was trained');
      mmo10.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo10.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=8) then
    begin
      mmo11.Lines[0]:='Info:';
      mmo11.Lines.Add('9th perceptron was trained');
      mmo11.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo11.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end
    else if (i=9) then
    begin
      mmo12.Lines[0]:='Info:';
      mmo12.Lines.Add('10th perceptron was trained');
      mmo12.Lines.Add('in ' + IntToStr(itterations_foreach) + ' itterations');
      if(rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
        mmo12.Lines.Add('Finished with ' + IntToStr(reserr[i].er) + ' error(s)')
    end;
  end;

  with strngrd4 do
  begin
    for i:=1 to perc_count do
    begin
      for j:=1 to w_count+1 do
      begin
        Cells[i,j]:=FloatToStr(v[i-1,j-1]);
      end;
    end;
  end;
  
  Button1.Enabled:=True;
  mmo2.Lines[0]:='Info:';
  mmo2.Lines.Add('All perceptrons were trained');
  mmo2.Lines.Add('in ' + IntToStr(itterations) + ' itterations');
end;

procedure TForm1.ButtonClick(Sender: TObject);
begin
  btn1pressed:=True;
  btn1.Visible := True;
  btn2.Visible := True;
  btn3.Visible := True;
  btn4.Visible := True;
  btn5.Visible := True;
  btn6.Visible := True;
  btn7.Visible := True;
  btn8.Visible := True;
  btn9.Visible := True;
  btn10.Visible := True;
  if (CG) then
  begin
    btn1.Glyph.LoadFromFile('apm_izlase/c1.bmp');
    btn2.Glyph.LoadFromFile('apm_izlase/c2.bmp');
    btn3.Glyph.LoadFromFile('apm_izlase/c3.bmp');
    btn4.Glyph.LoadFromFile('apm_izlase/c4.bmp');
    btn5.Glyph.LoadFromFile('apm_izlase/c5.bmp');
    btn6.Glyph.LoadFromFile('apm_izlase/g1.bmp');
    btn7.Glyph.LoadFromFile('apm_izlase/g2.bmp');
    btn8.Glyph.LoadFromFile('apm_izlase/g3.bmp');
    btn9.Glyph.LoadFromFile('apm_izlase/g4.bmp');
    btn10.Glyph.LoadFromFile('apm_izlase/g5.bmp');
  end
  else
  begin
    btn1.Glyph.LoadFromFile('apm_izlase/p1.bmp');
    btn2.Glyph.LoadFromFile('apm_izlase/p2.bmp');
    btn3.Glyph.LoadFromFile('apm_izlase/p3.bmp');
    btn4.Glyph.LoadFromFile('apm_izlase/p4.bmp');
    btn5.Glyph.LoadFromFile('apm_izlase/p5.bmp');
    btn6.Glyph.LoadFromFile('apm_izlase/r1.bmp');
    btn7.Glyph.LoadFromFile('apm_izlase/r2.bmp');
    btn8.Glyph.LoadFromFile('apm_izlase/r3.bmp');
    btn9.Glyph.LoadFromFile('apm_izlase/r4.bmp');
    btn10.Glyph.LoadFromFile('apm_izlase/r5.bmp');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TeachTS:=True;
  NN_Teach();
  Button3.Enabled:=True;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/c1.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/p1.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/c1.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/p1.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/c2.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/p2.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/c2.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/p2.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/c3.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/p3.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/c3.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/p3.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/c4.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/p4.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/c4.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/p4.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/c5.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/p5.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/c5.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/p5.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/g1.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/r1.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/g1.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/r1.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/g2.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/r2.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/g2.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/r2.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/g3.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/r3.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/g3.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/r3.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn9Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/g4.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/r4.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/g4.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/r4.bmp')
  end;

  NN_Input_X;
  if not (Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn10Click(Sender: TObject);
begin
  if (btn1pressed) then
  begin
    if(CG)then
      img1.Picture.LoadFromFile('apm_izlase/g5.bmp')
    else
      img1.Picture.LoadFromFile('apm_izlase/r5.bmp');
  end
  else
  begin
    if(CG)then
      img1.Picture.LoadFromFile('eksamens/g5.bmp')
    else
      img1.Picture.LoadFromFile('eksamens/r5.bmp')
  end;

  NN_Input_X;
  if not(Teach_Multiple) then
    NN_Calculate_Y
  else
    NN_Calculate_Y_Multiple;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  NN_Input_X;
  NN_Calculate_Y;
  NN_Calculate_Result;
  edt2.Text:=IntToStr(r);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  btn1pressed:=False;
  if (CG) then
  begin
    btn1.Glyph.LoadFromFile('eksamens/c1.bmp');
    btn2.Glyph.LoadFromFile('eksamens/c2.bmp');
    btn3.Glyph.LoadFromFile('eksamens/c3.bmp');
    btn4.Glyph.LoadFromFile('eksamens/c4.bmp');
    btn5.Glyph.LoadFromFile('eksamens/c5.bmp');
    btn6.Glyph.LoadFromFile('eksamens/g1.bmp');
    btn7.Glyph.LoadFromFile('eksamens/g2.bmp');
    btn8.Glyph.LoadFromFile('eksamens/g3.bmp');
    btn9.Glyph.LoadFromFile('eksamens/g4.bmp');
    btn10.Glyph.LoadFromFile('eksamens/g5.bmp');
  end
  else
  begin
    btn1.Glyph.LoadFromFile('eksamens/p1.bmp');
    btn2.Glyph.LoadFromFile('eksamens/p2.bmp');
    btn3.Glyph.LoadFromFile('eksamens/p3.bmp');
    btn4.Glyph.LoadFromFile('eksamens/p4.bmp');
    btn5.Glyph.LoadFromFile('eksamens/p5.bmp');
    btn6.Glyph.LoadFromFile('eksamens/r1.bmp');
    btn7.Glyph.LoadFromFile('eksamens/r2.bmp');
    btn8.Glyph.LoadFromFile('eksamens/r3.bmp');
    btn9.Glyph.LoadFromFile('eksamens/r4.bmp');
    btn10.Glyph.LoadFromFile('eksamens/r5.bmp');
  end
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  NN_Random_W;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:Integer;
begin
  CG:=True;
  Teach_Multiple:=False;

  for i:=0 to perc_count-1 do
  begin
    reserr[i].pr:='perc' + IntToStr(i+1);
  end;

  with strngrd1 do
  begin
    Cells[1,0]:='X';
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
    end;
  end;
  with strngrd2 do
  begin
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
  with strngrd3 do
  begin
    Cells[1,0]:='Y';
    for i:=1 to n_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
    end;
  end;
  with strngrd4 do
  begin
    Cells[1,0]:='W';
    for i:=1 to w_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
    end;
  end;
  with strngrd5 do
  begin
    Cells[0,0]:='p1';
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
  with strngrd6 do
  begin
    Cells[0,0]:='p2';
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
  with strngrd7 do
  begin
    Cells[0,0]:='p3';
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
  with strngrd8 do
  begin
    Cells[0,0]:='p4';
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
  with strngrd9 do
  begin
    Cells[0,0]:='p5';
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TeachTS:=False;
  NN_Teach();
  Button3.Enabled:=True;
end;

procedure TForm1.btn11Click(Sender: TObject);
begin
  NN_Random_W_Multiple;
  NN_Calculate_Y_Multiple;
end;

procedure TForm1.btn12Click(Sender: TObject);
begin
  NN_Teach_Multiple;
end;

procedure TForm1.btn13Click(Sender: TObject);
var i, j, k, tempres, res_sum, res, err_all, temp2, temp3 :Integer;
var tmp, res_sum2, z: Single;
var a: array[0..perc_count] of Integer;
var temp1: string;
begin
  for i:=0 to perc_count-1 do
  begin
    tmp:=0;
    for k:=0 to n_count do
    begin
      tmp:=tmp+u[i,k]*v[i,k];
      if (tmp>=0) then
        tempres:=1
      else
        tempres:=0;
    end;
    reserr[i].rs:=tempres;
  end;
  
  edt3.Text:=IntToStr(reserr[0].rs);
  edt4.Text:=IntToStr(reserr[1].rs);
  edt5.Text:=IntToStr(reserr[2].rs);
  edt6.Text:=IntToStr(reserr[3].rs);
  edt7.Text:=IntToStr(reserr[4].rs);
  edt9.Text:=IntToStr(reserr[5].rs);
  edt10.Text:=IntToStr(reserr[6].rs);
  edt11.Text:=IntToStr(reserr[7].rs);
  edt12.Text:=IntToStr(reserr[8].rs);
  edt13.Text:=IntToStr(reserr[9].rs);

  if (rg1.ItemIndex=1) or (rg1.ItemIndex=2) then
  begin
    for j:=0 to perc_count-2 do
    begin
      for i:=0 to perc_count-j-1 do
      begin
        if reserr[i].er > reserr[i+1].er then
        begin
          temp1:=reserr[i].pr;
          reserr[i].pr:=reserr[i+1].pr;
          reserr[i+1].pr:=temp1;
          temp2:=reserr[i].rs;
          reserr[i].rs:=reserr[i+1].rs;
          reserr[i+1].rs:=temp2;
          temp3:=reserr[i].er;
          reserr[i].er:=reserr[i+1].er;
          reserr[i+1].er:=temp3;
        end;
      end;
    end;
    
    with strngrd10 do
    begin
    Cells[1,0]:='Errors';

      for i:=1 to perc_count do
      begin
        Cells[0,i]:=reserr[i-1].pr;
        Cells[1,i]:=IntToStr(reserr[i-1].er);
      end;
    end;
  end;

  if (rg1.ItemIndex=0) then
  begin
    res_sum:=0;
    for i:=0 to perc_count-1 do
    begin
      res_sum:=res_sum+reserr[i].rs;
    end;

    lbl8.Caption:='Sum=' + edt3.Text + '+' + edt4.Text + '+' + edt5.Text + '+' + edt6.Text + '+' + edt7.Text + '+' + edt9.Text + '+' + edt10.Text + '+' + edt11.Text + '+' + edt12.Text + '+' + edt13.Text + '=' + IntToStr(res_sum);

    if(res_sum>=(perc_count/2)) then
    begin
      res:=1;
      lbl9.Caption:=IntToStr(res_sum) + ' > ' + FloatToStr(perc_count/2);
    end
    else
    begin
      res:=0;
      lbl9.Caption:=IntToStr(res_sum) + ' < ' + FloatToStr(perc_count/2);
    end;
  end
  else if (rg1.ItemIndex=1) then
  begin
    res_sum:=0;
    for i:=0 to 4 do
    begin
      res_sum:=res_sum+reserr[i].rs;
    end;

    lbl8.Caption:='Using result of ' + reserr[0].pr + ',' + reserr[1].pr + ',' + reserr[2].pr + ',' + reserr[3].pr + ' and ' + reserr[4].pr;

    if(res_sum>=(5/2)) then
    begin
      res:=1;
      lbl9.Caption:=IntToStr(res_sum) + ' > ' + FloatToStr(5/2);
    end
    else
    begin
      res:=0;
      lbl9.Caption:=IntToStr(res_sum) + ' < ' + FloatToStr(5/2);
    end;
  end
  else
  begin
    err_all:=0;
    for i:=0 to perc_count-1 do
    begin
      a[i]:=(10-reserr[i].er);
      err_all:=err_all+a[i];
    end;

    res_sum2:=0;
    for i:=0 to perc_count-1 do
    begin
      z:=(a[i]/err_all);
      res_sum2:=res_sum2+(reserr[i].rs*z);
    end;

    //lbl8.Caption:='Sum=' + edt3.Text + '+' + edt4.Text + '+' + edt5.Text + '+' + edt6.Text + '+' + edt7.Text + '+' + edt9.Text + '+' + edt10.Text + '+' + edt11.Text + '+' + edt12.Text + '+' + edt13.Text + '=' + IntToStr(res_sum);

    if(res_sum2>=(0.5)) then
    begin
      res:=1;
      lbl9.Caption:=FormatFloat('0.###',res_sum2) + ' > ' + FloatToStr(0.5);
    end
    else
    begin
      res:=0;
      lbl9.Caption:=FormatFloat('0.###',res_sum2) + ' < ' + FloatToStr(0.5);
    end;
  end;
  edt8.Text:=IntToStr(res);
end;

procedure TForm1.btn14Click(Sender: TObject);
begin
  Teach_Multiple:=False;
  NN_Random_Links;
  btn14.Enabled:=False;
  btn15.Enabled:=False;
  rg1.Enabled:=False;
  btn11.Enabled:=False;
  btn12.Enabled:=False;
  btn13.Enabled:=False;
  btn15.Enabled:=False;
end;

procedure TForm1.btn15Click(Sender: TObject);
begin
  Teach_Multiple:=True;
  NN_Random_Links_Multiple;
  btn14.Enabled:=False;
  btn15.Enabled:=False;
  Button2.Enabled:=False;
  Button3.Enabled:=False;
  Button4.Enabled:=False;
  Button5.Enabled:=False;
  Button6.Enabled:=True;
end;

procedure TForm1.Button6Click(Sender: TObject);
var i,j:Integer;
begin
  with strngrd5 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[i,j]:=IntToStr(s[i,j]);
      end;
    end;
  end;
  with strngrd6 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[i,j]:=IntToStr(t[i,j]);
      end;
    end;
  end;
  with strngrd7 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[i,j]:=IntToStr(q[i,j]);
      end;
    end;
  end;
  with strngrd8 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[i,j]:=IntToStr(z[i,j]);
      end;
    end;
  end;
  with strngrd9 do
  begin
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[i,j]:=IntToStr(o[i,j]);
      end;
    end;
  end;
end;

procedure TForm1.btn16Click(Sender: TObject);
begin
  CG:=True;
end;

procedure TForm1.btn17Click(Sender: TObject);
begin
  CG:=False;
end;

end.
