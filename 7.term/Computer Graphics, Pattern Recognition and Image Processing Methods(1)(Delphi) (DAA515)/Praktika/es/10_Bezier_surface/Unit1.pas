unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls, ExtCtrls, Grids, Spin;

type

  TForm1 = class(TForm)
    Image: TImage;
    txt2: TStaticText;
    txt3: TStaticText;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    se1: TSpinEdit;
    se2: TSpinEdit;
    btn1: TButton;
    btn2: TButton;
    function Fact(n: Integer): LongInt;
    procedure FormCreate(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure se2Change(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure Points;
    procedure BezierPlain;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  x, y: array of array of Integer;
  n, m: Integer;
  bX, bY: array of array of Single;
  L, K: array of Real;
  ps1, ps2: Integer;
  P:array of array of record
    x,y:integer;
  end;
  
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i:Integer;
begin
  with Image.Canvas do
  begin
    Brush.Color := clWhite;
    Rectangle(0,0, Image.Width, Image.Height);
  end;
  
  strngrd1.Cells[0,0] := 'X';
  strngrd2.Cells[0,0] := 'Y';

	for i:=1 to 4 do
  begin
    strngrd1.Cells[0,i] := 'n'+IntToStr(i);
    strngrd2.Cells[0,i] := 'n'+IntToStr(i);
    strngrd1.Cells[i,0] := 'm'+IntToStr(i);
    strngrd2.Cells[i,0] := 'm'+IntToStr(i);
  end;

  btn2.Enabled := False;
end;

procedure TForm1.se1Change(Sender: TObject);
var i: Integer;
begin
  if(se1.Value = 0)then
    se1.Value := 1;

  strngrd1.RowCount := se1.Value + 1;
  strngrd2.RowCount := se1.Value + 1;
  for i:=1 to se1.Value do
  begin
    strngrd1.Cells[0,i]:='n' + IntToStr(i);
    strngrd2.Cells[0,i]:='n' + IntToStr(i);
  end;

  btn2.Enabled := False;
end;

procedure TForm1.se2Change(Sender: TObject);
begin
  if(se2.Value = 0)then
    se2.Value := 1;

  strngrd1.ColCount := se2.Value + 1;
  strngrd2.ColCount := se2.Value + 1;
  strngrd1.Cells[se2.Value,0]:='m' + IntToStr(se2.Value);
  strngrd2.Cells[se2.Value,0]:='m' + IntToStr(se2.Value);

  btn2.Enabled := False;
end;

function TForm1.fact(n : Integer) : LongInt;
begin
  if n <= 1 then
    fact := 1
  else
    fact := n * fact(n - 1);
end;

procedure TForm1.btn1Click(Sender: TObject);
var i,j: Integer;
begin
  Randomize;
  n := se1.Value - 1;
  m := se2.Value - 1;
  SetLength(x, n + 1, m + 1);
  SetLength(y, n + 1, m + 1);

  for i:=0 to n do
  begin
    for j:=0 to m do
    begin
      x[i,j] := 20 + Random(Image.Width - 50);
      y[i,j] := 20 + Random(Image.Height - 50);
      strngrd1.Cells[j + 1, i + 1] := IntToStr(x[i,j]);
      strngrd2.Cells[j + 1, i + 1] := IntToStr(y[i,j]);
    end;
  end;

  btn2.Enabled := True;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  ps1 := se1.Value;
  ps2 := se2.Value;
  Image.Picture := nil;
  Points;
  BezierPlain;
end;

procedure TForm1.Points();
var i,j: Integer;
begin
  SetLength(P, ps1, ps2);
  SetLength(L, ps1);
  SetLength(K, ps2);
  for i := 0 to ps1 - 1 do
  begin
    for j := 0 to ps2 - 1 do
    begin
      P[i,j].x := StrToInt(strngrd1.Cells[j + 1,i + 1]);
      P[i,j].y := StrToInt(strngrd2.Cells[j + 1,i + 1]);
    end;
  end;
end;

procedure TForm1.BezierPlain();
var pts :array of array of array of Integer;
    i, j, n, m, xi, yi, iu, iv, pp: Integer;
    v , u, stepU, stepV: Real;
    x, y : Real;
begin
  pp := 5;
  stepV := 1 / ps1 / pp;
  stepU := 1 / ps2 / pp;
  iv := ps1 * pp + 1;
  iu := ps2 * pp + 1;
  
  n := ps1 - 1;
  m := ps2 - 1;
  SetLength(pts, 2, iu, iv);

  Image.Picture := nil;
  Image.Canvas.Pen.Color := clGreen;
  u := 0;
  iu := 0;
  while (u <= 1) do
  begin

    v := 0;
    iv := 0;
    while (v <= 1) do
    begin

      for i:=0 to n do
        L[i]:=(Fact(n))/(Fact(i)*Fact(n-i)) * Power(1-v, n-i) * Power(v, i);

      for j:=0 to m do
        K[j]:=(Fact(m))/(Fact(j)*Fact(m-j)) * Power(1-u, m-j) * Power(u, j);

      x:=0;
      y:=0;
      for i:=0 to n do
      begin
        for j:=0 to m do
        begin
          x := x + L[i] * K[j] * P[i,j].x;
          y := y + L[i] * K[j] * P[i,j].y;
        end;
      end;

      xi := Round(x);
      yi := Round(y);
      pts[0, iu, iv] := xi;
      pts[1, iu, iv] := yi;

      if v = 0 then
        Image.Canvas.MoveTo(xi,yi)
      else
        Image.Canvas.LineTo(xi,yi);

      v := v+stepV;
      Inc(iv);
    end;

    u := u + stepU;
    Inc(iu);
  end;
  for j:=0 to iv - 1 do
  begin
    Image.Canvas.MoveTo(pts[0,0,j], pts[1,0,j]);
    for i:=1 to iu - 1 do
    begin
      Image.Canvas.LineTo(pts[0,i,j], pts[1,i,j]);
    end;
  end;

  for j:=0 to m do
  begin
    for i:=0 to n do
    begin
      Image.Canvas.Brush.Color := clRed;
      Image.Canvas.Ellipse(P[i,j].x-3, P[i,j].y-3, P[i,j].x+3, P[i,j].y+3);
      Image.Canvas.Brush.Color := clWhite;
      Image.Canvas.TextOut(P[i,j].x + 2, P[i,j].y - 18, 'N' + IntToStr(i+1) + ', M' + IntToStr(j+1));
    end;
  end;
end;

end.
