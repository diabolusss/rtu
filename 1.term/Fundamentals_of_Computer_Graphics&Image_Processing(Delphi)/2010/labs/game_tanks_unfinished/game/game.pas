unit game;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,StdCtrls,pngimage, Grids, game_fun;

type

 TForm1 = CLASS(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    reDraw: TTimer;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure reDrawTimer(Sender: TObject);

    procedure printBarriers;
	procedure drawBarriers;
	
	procedure onTimer2(Sender: TObject);
	procedure onTimer3(Sender: TObject);
	
	function checkPosition:boolean;

  private
    { Private declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

 END;

var
  Form1: TForm1;  

implementation      {$R *.dfm}
{Form being created, create the png objectand other stuff}
constructor TForm1.Create(AOwner: TComponent);
 BEGIN
  inherited Create(AOwner);
  BorderStyle := bsNone;
  WindowState := wsMaximized;

  //initialise fons
  ground:=tPNGObject.create;

  //initialize barriers
  setBarLength;
  printBarriers;

  //initialise enemy
  hero.body := tpngobject.create;
 END;

{Form being destroyed, destroy the png objects}
destructor tForm1.Destroy;
BEGIN
 inherited Destroy;
 ground.free;
 hero.body.free;

END;

procedure TForm1.FormCreate(Sender: TObject);
  BEGIN
   //get rid of flickering
   Form1.DoubleBuffered := true;

   //set background
   ground.loadFromFile('ground/ground01.png');

   //set hero body [in tank by default]
   //hero state[in tank=true/out of tank=false]
   hero.lastKey:=vk_up;
   hero.bodyPath:='hero_tank1u (copy).png';
   hero.state:=true;

   //hero start coordinates
   hero.x:=200;
   hero.y:=370;
   hero.len:=hero.speed+1;

   //hero speed
   hero.speed:=2;
   
   //start the timer1 [starts the game]
   timer1.Enabled:=true;
   
   //t2:=0;t3:=0;
   //timer2.enabled:=true;
   //timer3.enabled:=true;
  END;

//viss notiekas seit
procedure TForm1.Timer1Timer(Sender: TObject);
var ii:byte;
 BEGIN
 //firstly!!! show background
 //image1.Canvas.Draw(0,0,fons);
 image1.canvas.draw(0,0,ground);
 
 drawBarriers;
 
 if((not checkPosition)) then begin
  if(hero.lastKey=vk_up) then hero.kU:=0;
  if(hero.lastKey=vk_down) then hero.kD:=0;
  if(hero.lastKey=vk_left) then hero.kL:=0;
  if(hero.lastKey=vk_right) then hero.kR:=0;
 end;

 with hero do begin
 
  if(lastKey=vk_up)then ky:=kU;
  if(lastKey=vk_down)then ky:=kD;
  if(lastKey=vk_left)then kx:=kL;
  if(lastKey=vk_right)then kx:=kR;
  //hero movement coordinates
  x:=x+kx*speed;
  y:=y+ky*speed;


  //and then draw obj on image1
  body.LoadFromFile(bodyPath);
  image1.canvas.Draw(x,y,body);
 end;

  image1.canvas.TextOut(hero.x,hero.y,'1');
  image1.canvas.TextOut(hero.x+hero.body.Width,hero.y,'2');
  image1.canvas.TextOut(hero.x+hero.body.Width,hero.y+hero.body.Height,'3');
  image1.canvas.TextOut(hero.x,hero.y+hero.body.Height,'4');
  
  label1.Caption:='('+intToStr(hero.x)+','+intToStr(hero.y)+')';
 END;

//nospiezot pogu; kustibas koeff ;kustiba pa diagonali aizliegta
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 BEGIN
  case key of
  VK_right:begin
    hero.kx:=1;
    hero.ky:=0;

  hero.kR:=1;
    //hero body according to state
    hero.lastKey:=key;
    reDraw.Enabled:=true;
    reDraw.Interval:=1;
  end;
  VK_left:begin
    hero.kx:=-1;
    hero.ky:=0;

  hero.kL:=-1;
    //hero body according to state
    hero.lastKey:=key;
    reDraw.Enabled:=true;
    reDraw.Interval:=1;
  end;
  VK_up:begin
    hero.ky:=-1;
    hero.kx:=0;
  hero.kU:=-1;

    //hero body according to state
    hero.lastKey:=key;
    reDraw.Enabled:=true;
    reDraw.Interval:=1;
  end;
  VK_down:begin
    hero.ky:=1;
    hero.kx:=0;
  hero.kD:=1;
    //hero body according to state
    hero.lastKey:=key;
    reDraw.Enabled:=true;
    reDraw.Interval:=1;
  end;

  //hero goes in/out from tank [o,O]
  word(79):begin
    if hero.state then hero.state:=false
    else hero.state:=true;
    label2.caption:='Hero in tank: '+boolToStr[hero.state];

    reDraw.Enabled:=true;
    reDraw.Interval:=1;
    
  end;
  VK_ESCAPE:close;
  end;
 END;

	//atlaizot pogu speed=0
	procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
	 BEGIN
	  case key of
	   VK_right:hero.kx:=0;
	   VK_left: hero.kx:=0;
	   VK_up:   hero.ky:=0;
	   VK_down: hero.ky:=0;
	  end;
	  case key of
	   VK_right:hero.kR:=0;
	   VK_left: hero.kL:=0;
	   VK_up:   hero.kU:=0;
	   VK_down: hero.kD:=0;
	  end;
	 END;

//redraws hero body
procedure TForm1.reDrawTimer(Sender: TObject);
BEGIN
 reDraw.interval:=0;
 reDraw.Enabled:=false;

 if hero.state then
  case hero.lastKey of
   vk_up:   hero.bodyPath:='hero_tank1u (copy).png';
   vk_left: hero.bodyPath:='hero_tank1l (copy).png';
   vk_right:hero.bodyPath:='hero_tank1r (copy).png';
   vk_down: hero.bodyPath:='hero_tank1d (copy).png';
  end
 else hero.bodyPath:='hero_body1.png';
END;
 
    //print barriers into gridline
    procedure TfORM1.printBarriers;
     var i:integer;
     BEGIN
        StringGrid1.Cells[0,0]:='i';
        StringGrid1.Cells[1,0]:='x';
        StringGrid1.Cells[2,0]:='y'; 
		StringGrid1.Cells[3,0]:='width';
        StringGrid1.Cells[4,0]:='height';
       for i:=0 to cBar do begin
         StringGrid1.Cells[0,i+1]:=IntToStr(i);         
         StringGrid1.Cells[1,i+1]:=IntToStr(barrier[i].x);
		 StringGrid1.Cells[2,i+1]:=IntToStr(barrier[i].y);
		 StringGrid1.Cells[3,i+1]:=IntToStr(barrier[i].width);
		 StringGrid1.Cells[4,i+1]:=IntToStr(barrier[i].height);
       end;
       label4.Caption:='Barrier count: '+intToStr(barrierCount);
     END;

//draws barriers on image
procedure tForm1.drawBarriers;
 var i:integer;
 BEGIN
  image1.canvas.Brush.Color:=clYellow;
  for i:=0 to cBar do with image1.canvas do with barrier[i] do begin
   rectangle(x,y,x+width,y+height);
  end;
  image1.canvas.Brush.Color:=clWhite;
 END;
 
	procedure TfORM1.onTimer2(Sender: TObject);
	 BEGIN
	  //timer2.enabled:=false;
	  inc(t2);
	  label5.caption:=intToStr(t2);
	 END;
	 
procedure TfORM1.onTimer3(Sender: TObject);
 BEGIN
  //timer3.enabled:=false;
  inc(t3);
  label6.caption:=intToStr(t3);
 END;

	function tForm1.checkPosition:boolean;
	 var i,j:integer;ok:boolean;
	 BEGIN
	  
	  
	  for i:=0 to high(barrier) do begin
	   //ok:=false;
	   
	   //move up
	   if (hero.lastKey=VK_up) 
	    and (hero.y>(tBarYA[i].y+tBarYA[i].height)) 
		and ((hero.body.width+hero.x)>tBarYA[i].x) 
		and (hero.x<(tBarYA[i].width+tBarYA[i].x)) 
		then
	     hero.len:=hero.y-(tBarYA[i].y+tBarYA[i].height);
  
	   //down
	   if (hero.lastKey=VK_down)
	   	and ((hero.y+hero.body.height)<(tBarYD[i].y)) 
		and ((hero.body.width+hero.x)>tBarYD[i].x) 
		and (hero.x<(tBarYD[i].width+tBarYD[i].x)) 
		then
 	     hero.len:=tBarYD[i].y-hero.y-hero.body.height;

	   //left		
	   if (hero.lastKey=VK_left)
	   	and ((hero.x)>(tBarXA[i].x+tBarXA[i].width)) 
		and ((hero.body.height+hero.y)>tBarXA[i].y) 
		and (hero.y<(tBarXA[i].height+tBarXA[i].y)) 
		then
 	     hero.len:=hero.x-(tBarXA[i].x+tBarXA[i].width);
		
	   //right
	   if (hero.lastKey=VK_right) 
	   	and ((hero.x+hero.body.width)<(tBarXD[i].x)) 
		and ((hero.body.height+hero.y)>tBarXD[i].y) 
		and (hero.y<(tBarXD[i].height+tBarXD[i].y)) 
		then
 	     hero.len:=tBarXD[i].x-hero.x-hero.body.width;


	   //if ok then break;
	  end;
	  
	  if(hero.len<=hero.speed+1)then begin
	   label6.caption:='crash';
	   checkPosition:=false;
	   //checkPosition:=true;
	  end
	  else begin
	   label6.caption:='waiting';
	   checkPosition:=true;
	  end;
	  label5.caption:=intTostr(hero.len);
	 END;
end.
