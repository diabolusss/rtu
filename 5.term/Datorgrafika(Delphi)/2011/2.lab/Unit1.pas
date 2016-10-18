unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

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
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure renderships;
    procedure renderbullet;
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  score: integer = 0;

  ship:TShip;
  bullet: TObjekts;
  enemy: TObjekts;
  d: integer = 1;
  t: integer = 0;

implementation

{$R *.dfm}

  constructor TObjekts.Create(a,b,c:integer;
                          fname: String);
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
   Image.Canvas.Draw(x-bmp.Width div 2,
                     y-bmp.Height div 2,
                     bmp);
 end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  ship:=TShip.Create();
  enemy:=TObjekts.Create(Image1.Width,
          Image1.Height div 2, 7,
          'spaceship2.bmp');
  bullet:=TObjekts.Create(0,0,10,
            'bullet.bmp');
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ship.y:=Y;
  if bullet.exists = false then
    begin
      bullet.x:=ship.x;
      bullet.y:=ship.y;
    end;
end;

function CheckCollision(o1,o2:TObjekts): boolean;
begin
  Result:=False;
  if (abs(o1.x-o2.x)<(
    (o1.bmp.Width+o2.bmp.Width) div 2))
    and (abs(o1.y-o2.y)<(
    (o1.bmp.Height+o2.bmp.Height) div 2))
  then
  Result:=True;
end;

procedure TForm1.renderships();
begin
  Image1.Canvas.Rectangle(0,0,
      image1.Width,Image1.Height);
  ship.Draw(Image1);
  enemy.Draw(Image1);


  if not enemy.exists then
    begin
      enemy.x:=Image1.Width;
      enemy.y:=random(Image1.Height);
      enemy.exists:=true;
    end;

  enemy.x:=enemy.x-enemy.speed;

  //nejausha parviet.
  inc(t);
  if (t>(5+random(10))) then
    begin
      t:=0;
      d:=-d;
    end;

  if (d<0) then dec(enemy.y,enemy.speed)
    else inc(enemy.y,enemy.speed);

  if enemy.y<0 then enemy.y:=0;
  if enemy.y>Image1.Height then
    enemy.y:=Image1.Height;

  //dzivibas zaud.
  if CheckCollision(ship,enemy)
    or (enemy.x<=0) then
      begin
        dec(ship.lives);
        enemy.exists:=false;
        if ship.lives=0 then
          begin
            //zaud.
            ship.Destroy;
            enemy.Destroy;
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
begin
  //parzimeshana
  if bullet.visible then bullet.Draw(Image1);
  if bullet.exists then
    begin
      bullet.visible:=true;
      bullet.x:=bullet.x+bullet.speed;

      if CheckCollision(bullet,enemy) then
        begin
          bullet.visible:=false;
          bullet.exists:=false;
          //palielinat noshauto ien. skaitu
          enemy.exists:=false;
        end;

      if bullet.x>Image1.Width then
        begin
          bullet.visible:=false;
          bullet.exists:=false;
        end;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  renderbullet;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  bullet.exists:=true;
end;

end.



