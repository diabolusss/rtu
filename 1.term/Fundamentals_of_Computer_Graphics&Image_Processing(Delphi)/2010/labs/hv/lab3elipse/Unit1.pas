unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
procedure elipse(xc,yc,rx,ry:integer);
procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure Tform1.elipse(xc,yc,rx,ry:integer);
var x,y:integer;    p:real;
BEGIN
x:=0;
y:=ry;
   Image1.Canvas.Pixels[xc+x,yc+y]:=clRed;
   Image1.Canvas.Pixels[xc+x,yc-y]:=clRed;
   Image1.Canvas.Pixels[xc-x,yc-y]:=clRed;
   Image1.Canvas.Pixels[xc-x,yc+y]:=clRed;
 //1posms 1 solis
 p:=sqr(ry)-sqr(rx)*ry-1/4*sqr(rx);
 while sqr(ry)*x<sqr(rx)*y do
  begin
    if p<0 then
     begin
      inc(x);
      p:=p+2*sqr(ry)*x+sqr(ry);
     end
    else
     begin
      inc(x); dec(y);
      p:=p+2*sqr(ry)*x+sqr(ry)-2*sqr(rx)*y;
     end;
   Image1.Canvas.Pixels[xc+x,yc+y]:=clGreen;
   Image1.Canvas.Pixels[xc+x,yc-y]:=clRed;
   Image1.Canvas.Pixels[xc-x,yc-y]:=clYellow;
   Image1.Canvas.Pixels[xc-x,yc+y]:=RGB(24,10,23);
  end;
  //2posms
  p:=sqr(ry)*sqr(x+0.5)+sqr(rx)*sqr(y-1)-sqr(rx)*sqr(ry);
 while y>0 do
  begin
    if p<0 then
     begin
      inc(x);dec(y);
      p:=p-2*sqr(rx)*y+2*sqr(ry)*x+sqr(rx);
     end
    else
     begin
      dec(y);
      p:=p-2*sqr(rx)*y+sqr(rx);
     end;
   Image1.Canvas.Pixels[xc+x,yc+y]:=clBlue;
   Image1.Canvas.Pixels[xc+x,yc-y]:=clRed;
   Image1.Canvas.Pixels[xc-x,yc-y]:=clBlack;
   Image1.Canvas.Pixels[xc-x,yc+y]:=clRed;
  end;

END;


procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
elipse(x,y,strtoint(edit1.Text),strtoint(edit2.Text));
end;

end.
