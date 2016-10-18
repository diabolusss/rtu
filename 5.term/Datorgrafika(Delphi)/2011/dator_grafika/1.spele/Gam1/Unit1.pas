unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
TVaronis = record
x,y: integer;
xs,ys: integer;
dzives: integer;
apeda: integer;
end;

TMonstrs = record
x,y:integer;
dzivs: boolean;
bmp: TBitmap;
end;

TGranata = record
x,y: integer;
xs,ys: integer;
izmesta: boolean;
bmp: TBitmap;
end;

TObjekti = array [0..19] of record
x,y: integer;
apesta: boolean;
laiks: integer;
end;


  TForm1 = class(TForm)

    Image1: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  v: TVaronis;
  m: TMonstrs;
  g: TGranata;
  o: TObjekti;
  laiks,mDelay:byte;



  Monstrs: TBitmap;
  Grenade: TBitmap;
  Background: TBitmap;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  //monster
  m.bmp:=TBitmap.Create;
  m.bmp.PixelFormat:=pf24bit;
  m.bmp.LoadFromFile('Monster.bmp');
  m.bmp.Transparent:=true;
  m.bmp.TransparentColor:=RGB(255,255,255);

  //monstra sak koord;
  m.x:=0+(m.bmp.Width div 2);
  m.y:=0+(m.bmp.Height div 2);
  m.dzivs:=true;

  //granade
  g.bmp:=TBitmap.Create;
  g.bmp.PixelFormat:=pf24bit;
  g.bmp.LoadFromFile('Grenade.bmp');
  g.bmp.Transparent:=true;
  g.bmp.TransparentColor:=RGB(255,255,255);

  //background
  Background:=TBitmap.Create;
  Background.PixelFormat:=pf24bit;
  Background.LoadFromFile('Background.bmp');
  Background.Transparent:=true;
  Background.TransparentColor:=RGB(255,255,255);

  //varona sakum koord
  v.xs:=0;
  v.ys:=0;
  v.x:=Background.Width div 2;
  v.y:=Background.Height div 2;
  v.dzives:=3;

  //aizpildam objektu vertibas
  Randomize;
  for i:=0 to 19 do
    begin
      o[i].x:=Random(background.Width+5);
      o[i].y:=Random(background.Height+5);
      o[i].apesta:=false;
    end;
  
  //iesledzam laika atskaiti
  laiks:=30;
  timer2.Enabled:=true;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RIGHT: begin
                v.xs:=1;
              end;
    VK_LEFT:  begin
                v.xs:=-1;
              end;
    VK_UP:    begin
                v.ys:=-1;
              end;
    VK_DOWN:  begin
                v.ys:=1;
              end;
    VK_SPACE: begin
                g.izmesta:=true;
                g.x:=v.x;
                g.y:=v.y;
                g.xs:=v.xs;
                g.ys:=v.ys;
              end;
      end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RIGHT: begin
                v.xs:=0;
              end;
    VK_LEFT:  begin
                v.xs:=0;
              end;
    VK_UP:    begin
                v.ys:=0;
              end;
    VK_DOWN:  begin
                v.ys:=0;
              end;
  end;
end;

  procedure mMove(var make:boolean);
   BEGIN
    if make then begin
     if m.x<v.x then m.x:=m.x+1;
     if m.x>v.x then m.x:=m.x-1;
     if m.y<v.y then m.y:=m.y+1;
     if m.y>v.y then m.y:=m.y-1;
    end else begin
     if mDelay>0 then dec(mDelay)
     else m.dzivs:=true;
     m.x:=0+m.bmp.Width div 2;
     m.y:=0+m.bmp.Height div 2;
    end;
   END;

procedure TForm1.Timer1Timer(Sender: TObject);
var i: integer;  
begin
  if (v.x+2*v.xs+10<background.Width)and(v.x+2*v.xs-10>0) then v.x:=v.x+2*v.xs;
  if (v.y+2*v.ys+10<background.height)and(v.y+2*v.ys-10>0) then v.y:=v.y+2*v.ys;

  label4.Caption:='('+intToStr(v.x)+','+intToStr(v.y)+')';
  label5.Caption:='Lives left: '+intToStr(v.dzives);
 
  //fons
  Image1.Canvas.Brush.Color:=clGreen;
  Image1.Canvas.Draw(0,0,Background);

  //objekts
  Image1.Canvas.Brush.Color:=clRed;


  for i:=0 to 19 do
    begin
      if (abs(v.x-o[i].x)<10) and (abs(v.y-o[i].y)<10)and(o[i].apesta=false) then
      begin
      o[i].apesta:=true;
      inc(v.apeda);
      label2.Caption:='Apesti:'+inttostr(v.apeda);
      end;
      if o[i].apesta=false then Image1.Canvas.Ellipse(o[i].x-3, o[i].y-3, o[i].x+3, o[i].y+3);
    end;
  
  //Ierocis
  Image1.Canvas.Brush.Color:=clWhite;

  //parbaudam vai gr izmesta
  if (g.x<0) or (g.y<0)  or (g.x>Image1.Width)  or (g.y>Image1.Height)
    then g.izmesta:=false;

  //ja gr izmesta mainam tas koord un zimejam ta kustibu
  if g.izmesta then
    begin
      g.x:=g.x+4*g.xs;
      g.y:=g.y+4*g.ys;
      Image1.Canvas.Draw(g.x-g.bmp.Width div 2,g.y-g.bmp.Height div 2,G.bmp);
      //ja monstrs saskaries ar gr kill him un
      //iznicinam gr
      if (abs(m.x-g.x)<20) and (abs(m.y-g.y)<20) then begin
       m.dzivs:=false;
       g.izmesta:=false;
       mDelay:=255;
      end;
    end;

  //varonis
    Image1.Canvas.Brush.Color:=clYellow;
    Image1.Canvas.Ellipse(v.x-10,v.y-10,v.x+10,v.y+10);

  //deguns
    Image1.Canvas.Brush.Color:=clRed;
    Image1.Canvas.Ellipse(v.x+8*v.xs-3,v.y+8*v.ys-3,v.x+8*v.xs+3,v.y+8*v.ys+3);
  
  //monstra kustiba ja dzivs; seko varonim
    Label3.caption:='Monster reborn after:'+intToStr(mDelay);
    Image1.Canvas.Brush.Color:=TColor($17335C);
    mMove(m.dzivs);
    Image1.Canvas.Draw(m.x-m.bmp.Width div 2,m.y-m.bmp.Height div 2,M.bmp);

  end;

  //pulkstenis, kas ierobezo speles laiku
  procedure TForm1.Timer2Timer(Sender: TObject);
  begin
      //clock
      if laiks>0 then
        begin
          dec(laiks);
          label1.Caption:='Laiks' +inttostr(laiks) ;
        end
        
      //lose
      else begin
       timer1.Interval:=0;
       timer2.Interval:=0;
       MessageDlg('You are running like a lazy monkey!', mtWarning, [mbOk], 0);
       close;
      end;

      if (abs(m.x-v.x)<40) and (abs(m.y-v.y)<40) then
       if (v.dzives=0) then begin
        timer1.Interval:=0;
        timer2.Interval:=0;
        MessageDlg('Oh no! we lost the mango man!', mtWarning, [mbOk], 0);
        close;
       end
       //ja ir vel dzives respawn varonis speles laukuma vidu
       //un monstru sturi
       else
        begin
         v.xs:=0;
         v.ys:=0;
         v.x:=Background.Width div 2;
         v.y:=Background.Height div 2;
         m.x:=m.bmp.Width div 2;
         m.y:=m.bmp.Height div 2;
         dec(v.dzives);
        end;

      //win
      if v.apeda=20 then
       begin
        timer1.Interval:=0;
        timer2.Interval:=0;
        MessageDlg('Cry "HAVOC", and let loose the dogs of war', mtWarning, [mbOk], 0);
        close;
      end;
  end;


end.
