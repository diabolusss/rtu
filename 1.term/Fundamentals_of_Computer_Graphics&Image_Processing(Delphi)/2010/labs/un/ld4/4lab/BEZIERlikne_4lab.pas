unit BEZIERlikne_4lab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure bezier(n:integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  B:array[0..2] of real;
  P:array[0..2] of record
   x,y: integer;
  end;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;

begin
 Randomize;
 for i:=0 to 2 do
  begin
   p[i].x:=random(Image1.Width);
   p[i].y:=random(Image1.Height);
  end;
end;
procedure tform1.bezier(n:integer);
var x,y,i: integer; t:real;
 begin
  t:=0;
  x:=p[0].x;
  y:=p[0].y;
  for i:=1 to N do
   begin
     t:=t+1/n;
     B[0]:=sqr(1-t);
     B[1]:=2*t*(1-t);
     B[2]:=t*t;

     image1.Canvas.MoveTo(x,y);
     x:=round((b[0]*p[0].x+b[1]*p[1].x+b[2]*p[2].x));
     y:=round((b[0]*p[0].y+b[1]*p[1].y+b[2]*p[2].y));
     image1.Canvas.lineto(x,y);

     image1.canvas.Brush.Color:=clYellow;
     Image1.Canvas.Ellipse(x-2,y-2,x+2,y+2);

   end;
   for i:=0 to 2 do
    begin
     image1.canvas.Brush.Color:=clRed;
     image1.Canvas.textout(p[i].x,p[i].y,inttostr(i));
    end;
 end;
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 p[radiogroup1.ItemIndex].x:=x;
 p[radiogroup1.ItemIndex].y:=y;

 image1.canvas.Brush.Color:=clwhite;
 image1.Canvas.Rectangle(0,0,image1.width,image1.height);
 bezier(50);
end;

end.
