unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Buttons;

const
  r_count = 59;
  n_count = 39;
  w_count = 39;

type
  vec60i = array[0..r_count] of integer; //receptoriem
  vec40i = array[0..n_count] of integer; //neironiem
  vec40f = array[0..w_count] of Single; //svariem
  strct = array[0..r_count,0..n_count] of integer; //saitem
  TForm1 = class(TForm)
    Button: TButton;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edt1: TEdit;
    Button3: TButton;
    Label2: TLabel;
    edt2: TEdit;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    strngrd3: TStringGrid;
    strngrd4: TStringGrid;
    img1: TImage;
    mmo1: TMemo;
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
    Button4: TButton;
    Button5: TButton;
    //procedure CreateSB(Name: string; nClass, which: Integer);
    procedure NN_Input_X();
    procedure NN_Random_Links();
    procedure NN_Random_W();
    procedure NN_Calculate_Y();
    procedure NN_Calculate_Result();
    procedure NN_Adapt_W();
    procedure NN_Teach();
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
    //procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  x: vec60i; //receptori
  y: vec40i; //neironi
  w: vec40f; //svari
  s: strct; //saites starp neironiem un receptoriem
  r: integer; //rezultats
  teta: real; //teta, lai adaptet svarus
  nClass1, nClass2: Integer;
  TeachTS, btn1pressed : Boolean;

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
    Cells[1,0]:='X';
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=IntToStr(x[i-1]);
    end;
  end
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
    for i:=1 to n_count+1 do
    begin
      Cells[i,0]:='y' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      Cells[0,i]:='x' + IntToStr(i);
    end;
    for i:=1 to r_count+1 do
    begin
      for j:=1 to n_count+1 do
      begin
        Cells[j,i]:=IntToStr(s[i-1,j-1]);
      end;
    end;
  end;
end;

procedure TForm1.NN_Random_W();
var i,j:Integer;
begin
  for j:=0 to n_count do
  begin
    w[j]:=2*Random-1;
  end;
  with strngrd4 do
  begin
    Cells[1,0]:='W';
    for i:=1 to w_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=FloatToStr(w[i-1]);
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
    Cells[1,0]:='Y';
    for i:=1 to n_count+1 do
    begin
      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=IntToStr(y[i-1]);
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
    if (tmp>=0) then
      r:=1
    else
      r:=0;
  end;
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
  Button1.Visible:=True;
  mmo1.Lines[0]:='Info:';
  mmo1.Lines.Add('Neural Network was trained');
  mmo1.Lines.Add('in ' + IntToStr(itterations) + ' itterations');
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  TeachTS:=True;
  NN_Teach();
  Button3.Visible:=True;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/p1.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/p1.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/p2.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/p2.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/p3.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/p3.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/p4.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/p4.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/p5.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/p5.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/r1.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/r1.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/r2.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/r2.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/r3.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/r3.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn9Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/r4.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/r4.bmp');

  NN_Input_X;
  NN_Calculate_Y;
end;

procedure TForm1.btn10Click(Sender: TObject);
begin
  if (btn1pressed) then
    img1.Picture.LoadFromFile('apm_izlase/r5.bmp')
  else
    img1.Picture.LoadFromFile('eksamens/r5.bmp');

  NN_Input_X;
  NN_Calculate_Y;
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
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  NN_Random_W;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  NN_Random_Links;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TeachTS:=False;
  NN_Teach();
  Button3.Visible:=True;
end;

end.
