unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure DrawBezier(n:integer);
    Function fact(n:integer):integer;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const r = 2;
Const pnum=3;

var
  Form1: TForm1;
  B: array [0..pnum-1] of real;
  P: array [0..pnum-1] of record
    x,y:integer;
  end;

implementation

{$R *.dfm}
Function TForm1.fact(n:integer):integer;
var i,temp: integer;
begin
  if ((n=0)  or (n=1))then fact:=1
  else begin
  temp:=1;
  for i:=1 to n do begin
     temp:=temp * i;
  end;
    fact:=temp;
  end;
end;

procedure TForm1.DrawBezier(n:integer);
var x,y,i,j:integer;
    t,xt,yt: real;
begin
  t:=0;
  x:=P[0].x;
  y:=P[0].y;
  for i:=1 to N do
  begin
    t:=t+1/N;
    for j:=0 to pnum-1 do begin
      b[0]:=(fact(pnum-1)/fact(pnum-1 -j));
    end;

    b[0]:=sqr(1-t);
    b[1]:=2*t*(1-t);
    b[2]:=sqr(t);
    xt:=b[0]*P[0].x;
    yt:=b[0]*P[0].y;
    for j:=1 to pnum-1 do
    begin
      xt:= xt + b[j]*P[j].x;
      yt:= yt + b[j]*p[j].y;
    end;
    x:=round(xt);
    y:=round(yt);

    Image1.Canvas.Ellipse(x-r,y-r,x+r,y+r);
  end;
  for i:=0 to pnum-1 do begin
    Image1.Canvas.TextOut(P[i].x,P[i].y,inttostr(i+1));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
 Randomize;
 Form1.RadioGroup1.Items.Clear;
 for i:=0 to pnum-1 do
 begin
   Form1.RadioGroup1.Items.Add(inttostr(i+1)+ '. punkts');
   p[i].x:=random(image1.ClientWidth);
   p[i].y:=random(image1.ClientHeight);
 end;
 Form1.RadioGroup1.ItemIndex:=0;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  p[Form1.RadioGroup1.ItemIndex].x:=x;
  p[Form1.RadioGroup1.ItemIndex].y:=y;
  Form1.Image1.Canvas.Brush.Color:=clWhite;
  Form1.Image1.Canvas.Rectangle(0,0,Form1.Image1.ClientWidth,Form1.Image1.ClientHeight);
  Form1.Image1.Canvas.Brush.Color:=clYellow;
  Form1.DrawBezier(25);
end;

end.
