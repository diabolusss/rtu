unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var //Global variables
  Form1: TForm1;
  vx, vy: integer;
  vxs, vys: integer;
  sm: array [0..19,0..1] of integer;
  mx, my: integer;

  rx, ry, rxs, rys: integer;
  izshauta: boolean;

  Sene: TBitmap; //.bmp
  Monstrs: TBitmap;
  Bomb: TBitmap;
  Hero: TBitmap;
  Background: TBitmap;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  vxs:=0;
  vys:=0;
  vx:=Image1.Width  div 2;
  vy:=Image1.Height div 2;

  randomize;
  for i:=0 to 19 do
  begin
    sm[i,0]:=Random(Image1.Width);
    sm[i,1]:=Random(Image1.Height);
  end;

  mx:=0;
  my:=0;

  izshauta:=False;

  Sene:=TBitmap.Create;
  Sene.PixelFormat:=pf24bit;
  Sene.LoadFromFile('mushroom.bmp');
  Sene.Transparent:=True;
  Sene.TransparentColor:=RGB(128,128,128);

  Monstrs:=TBitmap.Create;
  Monstrs.PixelFormat:=pf24bit;
  Monstrs.LoadFromFile('spaceinvader.bmp');
  Monstrs.Transparent:=True;
  Monstrs.TransparentColor:=RGB(255,255,255);

  Bomb:=TBitmap.Create;
  Bomb.PixelFormat:=pf24bit;
  Bomb.LoadFromFile('Grenade.bmp');
  Bomb.Transparent:=True;
  Bomb.TransparentColor:=RGB(255,255,255);

  Hero:=TBitmap.Create;
  Hero.PixelFormat:=pf24bit;
  Hero.LoadFromFile('Megaman.bmp');
  Hero.Transparent:=True;
  Hero.TransparentColor:=RGB(255,255,255);

  Background:=TBitmap.Create;
  Background.PixelFormat:=pf24bit;
  Background.LoadFromFile('Background.bmp');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RIGHT: begin
                vxs:=1;
              end;
    VK_LEFT:  begin
                vxs:=-1;
              end;
    VK_UP:    begin
                vys:=-1;
              end;
    VK_DOWN:  begin
                vys:=1;
              end;
    VK_SPACE: begin
                izshauta:=True;
                rx:=vx;
                ry:=vy;
                rxs:=5*vxs;
                rys:=5*vys;
              end;

end;

end;
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RIGHT: begin
                vxs:=0;
              end;
    VK_LEFT:  begin
                vxs:=0;
              end;
    VK_UP:    begin
                vys:=0;
              end;
    VK_DOWN:  begin
                vys:=0;
              end;

end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i: integer;
begin
  vx:=vx+2*vxs;
  vy:=vy+2*vys;

    //fons
  {Image1.Canvas.Brush.Color:=clGreen;
  Image1.Canvas.Rectangle(0,0,
                          Image1.Width,
                          Image1.Height);}
  Image1.Canvas.Draw(0,0, Background);

    //senes
  //Image1.Canvas.Brush.Color:=clWhite;
  for i:=0 to 19 do
  begin
    if (abs(vx-sm[i,0])<10)
      and (abs(vy-sm[i,1])<10) then
    begin
      sm[i,0]:=-100;
      sm[i,1]:=-100;
    end;
   { Image1.Canvas.Ellipse(sm[i,0]-3,
                          sm[i,1]-3,
                          sm[i,0]+3,
                          sm[i,1]+3);   }
    Image1.Canvas.Draw(sm[i,0]-Sene.Width  div 2,
                       sm[i,1]-Sene.Height div 2,
                      Sene);
  end;

    //rakete
  if (rx<0) or (ry<0)
    or (rx>Image1.Width) or (ry>Image1.Height) then
    izshauta:=False;
  if izshauta then
  begin
    rx:=rx+rxs;
    ry:=ry+rys;
    Image1.Canvas.Draw(rx-Bomb.Width  div 2,
                       ry-Bomb.Height div 2,
                       Bomb);
  end;

    //varonis
  {Image1.Canvas.Brush.Color:=clYellow;
  Image1.Canvas.Ellipse(vx-15,vy-15,
                        vx+15,vy+15);}
  Image1.Canvas.Draw(vx-Hero.Width  div 2,
                     vy-Hero.Height div 2,
                     Hero);
    //v. deguns
  {Image1.Canvas.Brush.Color:=clRed;
  Image1.Canvas.Ellipse(vx+12*vxs-4,vy+12*vys-4,
                        vx+12*vxs+4,vy+12*vys+4);}

    //monstrs
  if mx<vx then mx:=mx+1;
  if mx>vx then mx:=mx-1;
  if my<vy then my:=my+1;
  if my>vy then my:=my-1;

  //Image1.Canvas.Rectangle(mx-20,my-20,
  //                        mx+20,my+20);
  Image1.Canvas.Draw(mx-Monstrs.Width  div 2,
                     my-Monstrs.Height div 2,
                     Monstrs);

end;

end.

