unit Unit1;
 interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,math;
 type
  TForm1 = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit; Label1: TLabel;
    Edit2: TEdit; Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DrawBezier(n:integer;num:integer;r:integer);
    Function fact(n:integer):extended;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private { Private declarations }
  public  { Public declarations }
  end;

const pnum=200;

var
  Form1: TForm1;
  B: array [0..pnum-1] of extended;
  P: array [0..pnum-1] of record
    x,y:integer;
   end;
  i,z:integer;
 implementation {$R *.dfm}

Function TForm1.fact(n:integer):extended;
 var temp: extended;
 begin
  if n=0 then fact:=1
  else begin temp:=1;
  for i:=1 to n do temp:=temp * i; fact:=temp;
  end;
 end;

procedure TForm1.DrawBezier(n:integer;num:integer;r:integer);
 var x,y,j:integer; t,xt,yt: extended;
 begin
  t:=0; x:=P[0].x; y:=P[0].y;
  for i:=1 to n do
  begin
    t:=t+1/N;
    for j:=0 to num-1 do
     b[j]:=(power(1-t,num-1-j)*power(t,j)*fact(num-1))/(fact(j)*fact(num-1-j));
    xt:=b[0]*P[0].x; yt:=b[0]*P[0].y;
    image1.Canvas.MoveTo(x,y);
    for j:=1 to num-1 do
     begin
      xt:= xt + b[j]*P[j].x; yt:= yt + b[j]*p[j].y;
     end;
    x:=round(xt); y:=round(yt);
    image1.Canvas.LineTo(x,y);
    Image1.Canvas.Ellipse(x-r,y-r,x+r,y+r);
  end;
  for i:=0 to num-1 do Image1.Canvas.TextOut(P[i].x,P[i].y,inttostr(i+1));
  z:=Form1.RadioGroup1.ItemIndex;
 end;

procedure TForm1.FormCreate(Sender: TObject);
 begin
  Randomize;
  for i:=0 to pnum-1 do
   begin
    p[i].x:=random(image1.ClientWidth);
    p[i].y:=random(image1.ClientHeight);
   end;
  Form1.RadioGroup1.Items.Clear;
  for i:=0 to strtoint(edit2.Text)-1 do
   begin
    Form1.RadioGroup1.Items.Add(inttostr(i+1)+ '. punkts');
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
  Form1.DrawBezier(STRtoint(edit1.Text),STRtoint(edit2.Text),strtoint(edit3.text));
  Form1.RadioGroup1.Items.Clear;
  for i:=0 to STRtoint(edit2.Text)-1 do
   begin
    Form1.RadioGroup1.Items.Add(inttostr(i+1)+ '. punkts');
   end;
 Form1.RadioGroup1.ItemIndex:=z;
 end;
end.
