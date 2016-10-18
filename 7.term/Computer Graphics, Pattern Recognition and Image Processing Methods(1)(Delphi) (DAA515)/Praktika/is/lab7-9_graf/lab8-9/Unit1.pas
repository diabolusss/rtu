unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Spin, ExtCtrls, ComCtrls, Math;
const
  M_FACT = 10;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure setpoint;
    function Factorial(n:integer):Extended;
    procedure Bezier;
    procedure Image1Click(Sender: TObject);
    procedure initFactorial;
  private
    { Private declarations }
  public
    x,y: array of array of Integer;
    n,m: Integer;         
    bX,bY: array of array of Single;
  end;

  var
  Form1: TForm1;
  P:array of array of record
    x,y:integer;
  end;
  B1, B2 :array of real;
  punktuSkaits1, punktuSkaits2 :integer;
  redraw:bool;
  factorials:array[0..M_FACT] of Extended;

implementation

{$R *.dfm}   

procedure TForm1.FormCreate(Sender: TObject);
Var i :Integer;
begin
  initFactorial;
  StringGrid1.Cells[0,0] := 'X';
  StringGrid2.Cells[0,0] := 'Y';
  for i:=1 to 4 do
  begin
    StringGrid1.Cells[0,i] := 'n'+IntToStr(i);
    StringGrid2.Cells[0,i] := 'n'+IntToStr(i);
  end;
  StringGrid1.Cells[1,0] := 'm'+IntToStr(1);
  StringGrid2.Cells[1,0] := 'm'+IntToStr(1);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
Var i: Integer;
begin
  StringGrid1.RowCount := SpinEdit1.Value + 1;
  StringGrid2.RowCount := SpinEdit1.Value + 1;
  for i:=1 to SpinEdit1.Value do
  begin
    StringGrid1.Cells[0,i]:='n'+IntToStr(i);
    StringGrid2.Cells[0,i]:='n'+IntToStr(i);
  end;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  StringGrid1.ColCount := SpinEdit2.Value+1;
  StringGrid2.ColCount := SpinEdit2.Value+1;
  StringGrid1.Cells[SpinEdit2.Value,0]:='m'+IntToStr(SpinEdit2.Value);
  StringGrid2.Cells[SpinEdit2.Value,0]:='m'+IntToStr(SpinEdit2.Value);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,j: Integer;
begin
  n := SpinEdit1.Value-1;
  m := SpinEdit2.Value-1;
  SetLength(x, n+1, m+1); 
  SetLength(y, n+1, m+1);

  Randomize;
  for i:=0 to n do
  begin
    for j:=0 to m do
    begin
      x[i,j] := Random(Image1.Width-50)+25; 
      y[i,j] := Random(Image1.Height-50)+25;
      StringGrid1.Cells[j+1, i+1] := IntToStr(x[i,j]);  
      StringGrid2.Cells[j+1, i+1] := IntToStr(y[i,j]);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : Integer;
begin
  punktuSkaits1:=SpinEdit1.Value;
  punktuSkaits2:=SpinEdit2.Value;
  Image1.Picture:=nil;
  setpoint;
  Bezier;
  PageControl1.activepage:=Tabsheet2;
end;

procedure TForm1.setpoint;
var i,j :integer;
begin
  SetLength(P,punktuSkaits1,punktuSkaits2);
  SetLength(B1,punktuSkaits1);
  SetLength(B2,punktuSkaits2);

  for i:=0 to punktuSkaits1-1 do
  for j:=0 to punktuSkaits2-1 do begin
    P[i,j].x:=StrToInt(StringGrid1.Cells[j+1,i+1]);
    P[i,j].y:=StrToInt(StringGrid2.Cells[j+1,i+1]);
  end;

end;


function TForm1.Factorial(n: integer): Extended;
var i:integer;
    F:Extended;
begin
  if n<=M_FACT then
    result:=factorials[n]
  else begin
    F:=1;
    for i:=1 to n do
      F:=F*i;
    result:=F;
  end;
end;

procedure TForm1.Bezier;
var i,j,n,m,xi,yi,iu,iv,pp:integer;
    v,u,stepU,stepV:real;//liknes precizitate [0-1]
    x,y:real;
    points:array of array of array of integer;
begin
  pp:=5;
  stepU:=1/punktuSkaits2/pp;
  stepV:=1/punktuSkaits1/pp;
  iu:=punktuSkaits2*pp+1;
  iv:=punktuSkaits1*pp+1;
  n:=punktuSkaits1-1;
  m:=punktuSkaits2-1;
  SetLength(points,2,iu,iv);

  Image1.Picture:=nil;
  u:=0;
  iu:=0;
  while u<=1 do begin
    v:=0;
    iv:=0;
    while v<=1 do begin
      for i:=0 to n do
        B1[i]:=(Factorial(n))/(Factorial(i)*Factorial(n-i))*Power(1-v,n-i)*Power(v,i);
      for j:=0 to m do
        B2[j]:=(Factorial(m))/(Factorial(j)*Factorial(m-j))*Power(1-u,m-j)*Power(u,j);
      x:=0;
      y:=0;
      for i:=0 to n do            //plakne
        for j:=0 to m do begin
          x:=x+B1[i]*B2[j]*P[i,j].x;
          y:=y+B1[i]*B2[j]*P[i,j].y;
        end;

      xi:=Round(x);
      yi:=Round(y);
      points[0,iu,iv]:=xi;
      points[1,iu,iv]:=yi;
      if v=0 then
        Image1.Canvas.MoveTo(xi,yi)
      else
        Image1.Canvas.LineTo(xi,yi);
      v:=v+stepV;
      inc(iv);
    end;//while
    u:=u+stepU;
    inc(iu);
  end;//while

  for j:=0 to iv-1 do begin
    Image1.Canvas.moveTo(points[0,0,j],points[1,0,j]);
    for i:=1 to iu-1 do
      Image1.Canvas.lineTo(points[0,i,j],points[1,i,j]);

  end;
  for j:=0 to m do
    for i:=0 to n do begin
      Image1.Canvas.TextOut(P[i,j].x,P[i,j].y,'n'+IntToStr(i+1)+';m'+IntToStr(j+1));
      Image1.Canvas.Ellipse(P[i,j].x-3,P[i,j].y-3,P[i,j].x+3,P[i,j].y+3);
    end;

end;

procedure TForm1.Image1Click(Sender: TObject);
begin
   PageControl1.activepage:=Tabsheet1;
end;

procedure TForm1.initFactorial;
var i,j:integer;
    e:extended;
begin
  factorials[0]:=1;
  factorials[1]:=1;
  for i:=2 to M_FACT do begin
    e:=1;
    for j:=2 to i do e:=e*j;
    factorials[i]:=e;
  end;
end;

end.
