unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TObjekts = class
    x,y: integer;
    speed: integer;
    visible: boolean;
    exists: boolean;
    bmp: TBitmap;

    constructor Create(a,b,c:integer;
                       fname:String);
    destructor Destroy(); override;
    public
     procedure Draw(Image: TImage);
  end;

  TShip = class(TObjekts)
    lives: integer;

    constructor Create();
    destructor Destroy(); override;
  end;

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure renderships;
    procedure renderbullet;
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
	
	procedure drawEnemy;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  score: integer = 0; lvl:integer =1;

  ship:TShip;
  bullet: TObjekts;
  enemy:array[0..48] of TObjekts;
  d: integer = 1;
  t: integer = 0;

implementation

{$R *.dfm}

  constructor TObjekts.Create(a,b,c:integer;fname: String);
  begin
    x:=a;
    y:=b;
    speed:=c;
    bmp:=TBitmap.Create;
    bmp.LoadFromFile(fname);
    bmp.Transparent:=True;
    bmp.TransparentColor:=RGB(255,255,255);
  end;

  destructor TObjekts.Destroy();
  begin
    bmp.Destroy;
  end;

  constructor TShip.Create();
  begin
    inherited Create(20,20,0,'spaceship.bmp');
    lives:=1;
  end;

  destructor TShip.Destroy();
  begin
    inherited Destroy;
  end;

 procedure TObjekts.Draw(Image:TImage);
 begin
   Image.Canvas.Draw(x-bmp.Width div 2, y-bmp.Height div 2,bmp);
 end;
 
procedure TForm1.FormCreate(Sender: TObject);
var i:byte;
begin
  Randomize;
  ship:=TShip.Create();
   for i:=0 to high(enemy) do
  enemy[i]:=TObjekts.Create(Image1.Width, Image1.Height div 2, 1,
          'spaceship2.bmp');
  bullet:=TObjekts.Create(0,0,10,'bullet.bmp');
  
  drawEnemy;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ship.y:=Y;
end;

function CheckCollision(o1,o2:TObjekts): boolean;
begin
  Result:=False;
  if (abs(o1.x-o2.x)<(
    (o1.bmp.Width+o2.bmp.Width) div 2))
    and (abs(o1.y-o2.y)<(
    (o1.bmp.Height+o2.bmp.Height) div 2))
  then
  CheckCollision:=True;
end;

procedure TForm1.drawEnemy;
var i,z:byte;j:integer;
BEGIN
z:=0;j:=1;
for i:=0 to high(enemy) do begin


 if enemy[i].bmp.height*(j+1)>image1.height then begin
  inc(z);
  j:=1;
  end;
  
  enemy[i].x:=image1.width-enemy[i].bmp.width*z;
  enemy[i].y:=enemy[i].bmp.height*j;
 
 inc(j);
 enemy[i].exists:=true;
end;
END;

procedure TForm1.renderships();
var i:byte;
begin
label2.caption:='Lives: '+inttostr(ship.lives);
  Image1.Canvas.Rectangle(0,0,image1.Width,Image1.Height);
  ship.Draw(Image1);
  for i:=0 to high(enemy) do if enemy[i].exists then enemy[i].Draw(Image1);

 

 for i:=0 to high(enemy) do dec(enemy[i].x,enemy[i].speed);
 
  //nejausha parviet.
  inc(t);
  if (t>(5+random(10))) then
    begin
      t:=0;
      d:=-d;
    end;
	
 for i:=0 to high(enemy) do
  if (d<0) then dec(enemy[i].y,enemy[i].speed)
    else inc(enemy[i].y,enemy[i].speed);
	
 for i:=0 to high(enemy) do begin
  if enemy[i].y<0 then enemy[i].y:=0;
  if enemy[i].y>Image1.Height then
    enemy[i].y:=Image1.Height;
end;

  //dzivibas zaud.
  for i:=0 to high(enemy) do
  if ((CheckCollision(ship,enemy[i])
    or (enemy[i].x<=0))and (enemy[i].exists)) then
      begin
        dec(ship.lives);
        enemy[i].exists:=false;
        if ship.lives=0 then
          begin
            //zaud.
            ship.Destroy;
            enemy[i].Destroy;
            bullet.Destroy;
            application.Terminate;
          end;
      end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  renderships();
  
end;

procedure TForm1.renderbullet;
var i:byte;
begin
  //parzimeshana

  if bullet.exists then
    begin
      bullet.Draw(Image1);
      //bullet.x:=bullet.x+bullet.speed;
	  
      for i:=0 to high(enemy) do
      if (CheckCollision(bullet,enemy[i]) and (enemy[i].exists)) then
        begin
		 bullet.exists:=false;
         bullet.visible:=false;
          
          //palielinat noshauto ien. skaitu
          enemy[i].exists:=false;
		  inc(score);
        end;

      if bullet.x>Image1.Width then
        begin
          bullet.visible:=false;
          bullet.exists:=false;
        end;
		if bullet.exists then bullet.x:=bullet.x+bullet.speed;
    end else begin
	  bullet.x:=ship.x;
      bullet.y:=ship.y;
	end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

begin
  renderbullet;
  label1.caption:='SCORE: '+inttostr(score);
  if score=high(enemy)+1 div lvl then begin inc(lvl); drawEnemy;end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  bullet.exists:=true;
end;

end.



