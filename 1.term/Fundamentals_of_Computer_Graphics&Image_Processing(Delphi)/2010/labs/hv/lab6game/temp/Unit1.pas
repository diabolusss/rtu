unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure gameover;
    procedure recordxy;
    procedure nextlvl;
    procedure xball(x,y:integer);
    procedure xballrepaint;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const maxX=640;maxY=480;num=1;
var
  Form1: TForm1;
  x,y,sk:integer;//hero position
  xs,ys,ix,iy,r,xx,yy:integer;//move direction
  mx,my:integer;//monster position
  speed,lvl,raz:integer;
  s:array[0..num] of
    record
     x,y:integer;
    end;
  fons:Tbitmap;
  heart:tbitmap;
  monster:tbitmap;
  pause,ok:boolean;


implementation

{$R *.dfm}
procedure tform1.recordxy;
var i:integer;
 BEGIN
  Randomize;
  for i:=0 to num do
  begin
   s[i].x:=random(640);
   s[i].y:=random(480);
  end;
 END;


procedure TForm1.FormCreate(Sender: TObject);
begin
 fons :=tbitmap.create; 
 fons.Width:=maxx;
 fons.Height:=maxy;
 fons.pixelformat:=pf24bit;
 fons.LoadFromFile('bkground.bmp');
 
 heart :=tbitmap.create;
 heart.pixelformat:=pf24bit;
 heart.LoadFromFile('coin.bmp');
 heart.transparent:=true;
 heart.TransparentColor:=clwhite;
 heart.Transparentmode:=tmauto;
 
 monster :=tbitmap.create;
 monster.pixelformat:=pf24bit;
 monster.LoadFromFile('monster1.bmp');
 monster.transparent:=true;
 monster.TransparentColor:=clwhite;
 monster.Transparentmode:=tmauto;

 x:=320;y:=240;
 xs:=0;ys:=0;
 mx:=0;my:=0;sk:=0;
 recordxy;
 speed:=1;
 lvl:=1;
 pause:=false;
 ok:=true;

 randomize;
 r:=random(40)+10;
 xx:=random(10);yy:=random(maxy);ix:=1;iy:=1;
end;

procedure tform1.xball(x,y:integer);
var tx,ty:integer;
 BEGIN
 tx:=x;ty:=y;
 image1.canvas.Brush.Color:=clblack;
 image1.Canvas.Ellipse(tx+r,ty+r,tx-r,ty-r);
 END;

procedure tform1.xballrepaint;
 BEGIN
    xx:=xx+ix*speed;
    yy:=yy+iy*speed;
    raz:=abs(xx-yy);
    xball(xx,yy);
    raz:=abs(xx-yy);
    If xx+R>maxx then begin
      If iy=1 then begin
        ix:=-1;
        iy:=1;
      end else begin
        ix:=-1;
        iy:=-1;
      end;
    end;
    If yy+R>maxy then begin
      If ix=1 then begin
        ix:=1;
        iy:=-1;
      end else begin
        ix:=-1;
        iy:=-1;
      end;
    end;
    If xx-R<0 then begin
      If iy=1 then begin
        ix:=1;
        iy:=1;
      end else begin
        ix:=1;
        iy:=-1;
      end;
    end;
    If yy-R<0 then begin
      If ix=1 then begin
        ix:=1;
        iy:=1;
      end else begin
        ix:=-1;
        iy:=1;
      end;
    end;
 END;
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
BEGIN
 case key of
 VK_right:xs:=1;
 VK_left: xs:=-1;
 VK_up:   ys:=-1;
 VK_down: ys:=1;
 end;
END;
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
BEGIN
 case key of
 VK_right:xs:=0;
 VK_left: xs:=0;
 VK_up:   ys:=0;
 VK_down: ys:=0;
 end;
END;

procedure tform1.gameover;
   BEGIN
     pause:=true; ok:=false;
     sk:=0;
     image1.canvas.Font.size:=50;
     image1.canvas.TextOut(100,100,'GAME OVER');
     image1.canvas.Font.size:=20;
     image1.canvas.TextOut(150,200,'press Enter to restart');
     if GetAsyncKeyState(13)<>0 then
      BEGIN pause:=false; ok:=true;
       mx:=0;my:=0;
       speed:=1;
       recordxy;
       x:=320;y:=240;
       randomize;
       r:=random(40)+10;
       xx:=random(10);yy:=random(maxy);ix:=1;iy:=1;
      end;
   END;
procedure tform1.nextlvl;
 BEGIN
  pause:=true; ok:=false;
  image1.canvas.Font.size:=50;
  image1.canvas.TextOut(100,100,'Well done');
  image1.canvas.Font.size:=20;
  image1.canvas.TextOut(150,200,'press Enter to proceed');
  if GetAsyncKeyState(13)<>0 then
   begin pause:=false; ok:=true;
       x:=320;y:=240;
       sk:=0;
       recordxy;
       inc(speed);
       mx:=0;my:=0;
       randomize;
       r:=random(40)+10;
       xx:=random(10);yy:=random(maxy);ix:=1;iy:=1;
   end;
 END;
procedure TForm1.Timer1Timer(Sender: TObject);
var i,j:integer;failed,nextlevel:boolean;
BEGIN  j:=0;failed:=false;nextlevel:=false;

 if pause=false then begin
  if (x+3*xs+5<maxx)and(x+3*xs-5>0) then x:=x+3*xs;
  if (y+3*ys+5<maxy)and(y+3*ys-5>0) then y:=y+3*ys;

  if mx>x then mx:=mx-1;
  if mx<x then mx:=mx+1;
  if my>y then my:=my-1;
  if my<y then my:=my+1;
 end;

 if (abs(x-mx)<10)and(abs(y-my)<10) then failed:=true;
 if (abs(x-xx)<r)and(abs(y-yy)<r) then failed:=true;

 if ok and not pause then begin
  image1.Canvas.Rectangle(0,maxy,maxx,maxy+10);
  image1.Canvas.Draw(0,0,fons);

   xballrepaint;
   for i:=0 to num do
    begin
     if (abs(x-s[i].x)<10)and(abs(y-s[i].y)<10) then
      begin
       s[i].x:=10+j;
       s[i].y:=maxy+5;
       inc(sk,10);
      end;
     image1.Canvas.draw(s[i].x-5,s[i].y-5,heart);
     inc(j,10);
    end;

  image1.Canvas.Brush.color:=clred;
  image1.Canvas.Ellipse(x-10,y-10,x+10,y+10);
  image1.Canvas.Brush.color:=clBlack;
  image1.Canvas.Ellipse(x+8*xs-3,y+8*ys-3,x+8*xs+3,y+8*ys+3);
  image1.Canvas.Brush.color:=clyellow;

  image1.Canvas.Ellipse(x+1*xs+5*xs,y+1*ys-4*ys,x+1*xs-5*xs,y+1*ys+3*ys);
  image1.Canvas.Ellipse(x+1*xs-5,y+1*ys+3,x+1*xs+5,y+1*ys-3);
  image1.Canvas.Draw(mx-13,my-13,monster);
 end;
 if failed=true then begin gameover; failed:=false; end;
 if sk=10*(num+1) then nextlevel:=true;
 if nextlevel then begin nextlvl; nextlevel:=false; end;
 label1.Caption:=inttostr(x)+', '+inttostr(y);
 label2.Caption:='Points: '+inttostr(sk);
 label3.caption:='Level '+inttostr(speed);
 image1.Canvas.Brush.color:=clGray;
END;

END.
