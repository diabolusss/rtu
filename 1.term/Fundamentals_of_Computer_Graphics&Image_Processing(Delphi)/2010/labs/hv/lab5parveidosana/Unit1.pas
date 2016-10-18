unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids,math;
  
type myrecord=record x,y:integer; end;
type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    RadioGroup1: TRadioGroup;
    Button3: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure fillarray(tnum:integer);
    procedure draw();
    procedure save2table();
    procedure rotate();
    procedure movetopoint(xm,ym:real);
    procedure transform(xm,ym:real);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  p:array of myrecord;  x0,y0,num:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
fillarray(strtoint(edit1.Text));
end;

procedure TForm1.fillarray(tnum:integer);
var i:integer;
  BEGIN num:=tnum;
  setlength(p,num); randomize;
  x0:=form1.image1.Width div 2;  y0:=form1.image1.height div 2;
  Form1.RadioGroup1.Items.Clear;
  for i:=0 to num-1 do
   begin
    p[i].x:=100-random(200); p[i].y:=100-random(200);
    form1.radiogroup1.Items.Add(inttostr(i+1)+'.virsotne');
   end;
    Form1.RadioGroup1.ItemIndex:=0;
    save2table;
    draw;
END;

procedure tform1.save2table();
var i:integer;
 BEGIN
  with stringgrid1 do
   begin
    rowcount:=num+1;
    cells[0,0]:='CP'; cells[1,0]:='x'; cells[2,0]:='y';
    for i:=1 to num do
     begin
      cells[0,i]:=inttostr(i);
      cells[1,i]:=inttostr(p[i-1].x);
      cells[2,i]:=inttostr(p[i-1].y);
     end;
   end;
 END;

procedure TForm1.draw();
var i:integer;
  BEGIN
  with image1.Canvas do
   begin
    moveto(x0,0);            lineto(x0,image1.Height);
    moveto(0,y0);            lineto(image1.width,y0);
    moveto(x0+p[num-1].x,y0-p[num-1].y);
    for i:=0 to num-1 do
     begin
      lineto(x0+p[i].x,y0-p[i].y);
     end;
    for i:=0 to num-1 do
     begin
      image1.canvas.Brush.Color:=clYellow;
      textout(x0+p[i].x,y0-p[i].y,inttostr(i+1));
      image1.canvas.Brush.Color:=clWhite;
     end;
   end;
  END;

procedure tform1.rotate();
var i,xt,yt:integer;a:real;
  BEGIN
    a:=degtorad(strtoint(edit2.Text));
    for i:=0 to num-1 do
      begin
       xt:=round(p[i].x*cos(a)-p[i].y*sin(a));
       yt:=round(p[i].x*sin(a)+p[i].y*cos(a));
         p[i].x:=xt;
         p[i].y:=yt;
      end;
    save2table;
    draw;
  END;

procedure tform1.movetopoint(xm,ym:real);
var i,xt,yt:integer;
  BEGIN
     for i:=0 to num-1 do
      begin
       xt:=round(p[i].x+xm);
       yt:=round(p[i].y+ym);
         p[i].x:=xt;
         p[i].y:=yt;
      end;
    save2table;
    draw;
  END;
procedure tform1.transform(xm,ym:real);
var i,xt,yt:integer;
  BEGIN
     for i:=0 to num-1 do
      begin
       xt:=round(p[i].x*xm);
       yt:=round(p[i].y*ym);
         p[i].x:=xt;
         p[i].y:=yt;
      end;
    save2table;
    draw;
  END;

procedure TForm1.Button1Click(Sender: TObject);
begin
 fillarray(strtoint(edit1.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 rotate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
with image1.canvas do
 begin
  Rectangle(0,0,width,height);
  moveto(x0,0);   lineto(x0,Height);
  moveto(0,y0);   lineto(width,y0);
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var n:integer;
begin
 n:=radiogroup1.itemindex;
 p[n].x:=x-x0;
 p[n].y:=y0-y;
 save2table;
 image1.canvas.Rectangle(0,0,image1.width,image1.height);
 draw;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
movetopoint(strtofloat(edit3.Text),strtofloat(edit4.Text));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
transform(strtofloat(edit3.Text),strtofloat(edit4.Text));
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label3.Caption:=inttostr(x-x0)+', '+inttostr(y-y0);
end;

end.
