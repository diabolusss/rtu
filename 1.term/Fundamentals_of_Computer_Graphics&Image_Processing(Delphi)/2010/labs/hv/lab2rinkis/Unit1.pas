unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
      procedure rinkis(xc,yc,r: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Label1.Caption:=IntToStr(x)+', '+IntToStr(y);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //izsaucam proceduru Rinkis(parametri)
     Rinkis(x,y,StrToInt(edit1.Text));
end;
procedure TForm1.Rinkis(xc,yc,r: integer);
var p,x,y: integer;
Begin
 //

 x:=0; y:=r;
 p:=1-r;
   image1.Canvas.Pixels[xc+r,yc]:=clRed;
   image1.Canvas.Pixels[xc-r,yc]:=clRed;
   image1.Canvas.Pixels[xc,yc+r]:=clRed;
   image1.Canvas.Pixels[xc,yc-r]:=clRed;
 while x<y do
  begin
   if p<0 then
    begin
     //x:=x+1;
     inc(x);
     p:=p+2*x;
    end
   else
    begin
     //x:=x+1; y:=y-1;
     inc(x); dec(y);
     p:=p+2*x-2*y+1;
    end;
   image1.Canvas.Pixels[xc+x,yc+y]:=clRed;
   image1.Canvas.Pixels[xc-x,yc-y]:=clRed;
   image1.Canvas.Pixels[xc-x,yc+y]:=clRed;
   image1.Canvas.Pixels[xc+x,yc-y]:=clRed;

   image1.Canvas.Pixels[xc+y,yc-x]:=clRed;
   image1.Canvas.Pixels[xc-y,yc+x]:=clRed;
   image1.Canvas.Pixels[xc-y,yc-x]:=clRed;
   image1.Canvas.Pixels[xc+y,yc+x]:=clRed;
  end;
End;
 end.
