unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Image1: TImage;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Brezenhem(x1,y1,x2,y2: integer);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation   {$R *.dfm}
procedure TForm1.Brezenhem(x1,y1,x2,y2: integer);
var x,y,i,dx,dy,xs,ys,p: integer;
begin
 x:=x1;
 y:=y1;
 dx:=abs(x2-x1);
 dy:=abs(y2-y1);
 if x2>x1 then xs:=1 else xs:=-1;
 if y2>y1 then ys:=1 else ys:=-1;
//algoritms
 if dx>dy then
  begin
   //1.solis
   p:=2*dy-dx;
   //2.solis
   for i:=0 to dx do
    begin   //for sakums
     if p<0 then
      begin
       x:=x+xs;
       p:=p+2*dy;
      end
     else
      begin
       x:=x+xs;
       y:=y+ys;
       p:=p+2*dy-2*dx;
      end;
     Image1.Canvas.Pixels[x,y]:=clRed;
     StringGrid1.Cells[0,i+1]:=IntToStr(i+1);
     StringGrid1.Cells[1,i+1]:=IntToStr(x);
     StringGrid1.Cells[2,i+1]:=IntToStr(y);
     StringGrid1.Cells[3,i+1]:=IntToStr(p);
    end;
  end //for beigums
 else
  begin
  //1.solis
  p:=2*dx-dy;
  //2.solis
  for i:=0 to dx do
   begin   //for sakums
    if p<0 then
      begin
      y:=y+ys;
      p:=p+2*dx;
      end
    else
      begin
      x:=x+xs;
      y:=y+ys;
      p:=p+2*dx-2*dy;
      end;
    Image1.Canvas.Pixels[x,y]:=clRed;
    StringGrid1.Cells[0,i+1]:=IntToStr(i+1);
    StringGrid1.Cells[1,i+1]:=IntToStr(x);
    StringGrid1.Cells[2,i+1]:=IntToStr(y);
    StringGrid1.Cells[3,i+1]:=IntToStr(p);
   end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//Brezenhem(20,20,200,150);
Brezenhem(StrToInt(Edit1.Text),
StrToInt(Edit2.Text),
StrToInt(Edit3.Text),
StrToInt(Edit4.Text));
end;
 
end.


