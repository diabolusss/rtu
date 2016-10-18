unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Math;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Button2: TButton;
    StringGrid2: TStringGrid;
    Button3: TButton;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mas :Array [0..8] of Tpoint;
  c :Array [0..8] of Integer;
  i :Integer;

implementation

{$R *.dfm}

procedure TForm1.Image1Click(Sender: TObject);
var
pos2: TPoint;
j,k :Integer;
begin
  GetCursorPos(pos2);
  pos2:=ScreenToClient(pos2);
  if i < 9 then
  begin
    Image1.Canvas.Rectangle(pos2.X-1, pos2.Y-1, pos2.X+1, pos2.Y+1);

  with Form1.Image1.Canvas do begin

    Font.Name := 'Tahoma';
    Font.Size := 8;
    Brush.Style := bsClear;
    TextOut(pos2.X-5, pos2.Y-15, 'p'+IntToStr(i+1));
  end;

    mas[i].X:=pos2.X;
    mas[i].Y:=pos2.Y;
    StringGrid2.Cells[1,i+1]:=IntToStr(pos2.X);
    StringGrid2.Cells[2,i+1]:=IntToStr(pos2.Y);

    Image1.Refresh;
    i:=i+1;
  end;

  if i=9 then
  begin
    for k:=1 to 9 do
    for j:=1 to 9 do
    begin
      StringGrid1.Cells[j,k]:=FloatToStrf((sqrt(sqr(abs(mas[k-1].X-mas[j-1].X))+sqr(abs(mas[k-1].Y-mas[j-1].Y)))),ffFixed, 4,2);
    end;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
Var j :Integer;
begin
  Randomize;
  i:=0;
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  Image1.Picture.Bitmap.Width:=385;
  Image1.Picture.Bitmap.Height:=361;
  Image1.Canvas.Pen.Color:= clBlack;
  Image1.Canvas.Brush.Color:= clBlack;

  for j:=1 to 9 do
  begin
    StringGrid1.Cells[0,j]:='p'+IntToStr(j);
    StringGrid1.Cells[j,0]:='p'+IntToStr(j);
    StringGrid2.Cells[0,j]:='p'+IntToStr(j);
  end;

    StringGrid2.Cells[1,0]:='x';
    StringGrid2.Cells[2,0]:='y';

end;

procedure TForm1.Button1Click(Sender: TObject);
Var j, k, y, x, z, num, centrSk, ind, chk :Integer;
    temp, tmin, maxx, summa: Double;
    minn :Array [0..8,0..8] of Double;
    mind :Array [0..8] of Double;
begin
if i=9 then begin
   button3.Click;
  num:=Random(9);
  ind:=0;
 for x:=0 to 8 do
 for j:=0 to 8 do
 begin
   minn[j,x]:=999;
   mind[x]:=0;
 end;

  c[0]:=num;

  temp:=0;

  for k:=1 to 9 do
  begin
    if Round(StrtoFloat(StringGrid1.Cells[k,num+1])) > temp then
    begin
      temp:=StrToFloat(StringGrid1.Cells[k,num+1]);
      c[1]:=k-1;
      j:=k;
    end;
  end;

  centrSk:=2;

  while ind<1 do
  begin

  for x:=0 to 8 do
  for j:=0 to 8 do
  begin
    minn[j,x]:=999;
    mind[x]:=0;
  end;

  for y:=0 to centrSk-1 do
  begin
    for x:=0 to 8 do
      begin
        chk:=0;
        for j:=0 to centrSk-1 do
        begin
          if x=c[j] then chk:=1;
        end;
        if chk=1 then minn[x,y]:=999 else
        minn[x,y]:=StrToFloat(StringGrid1.Cells[x+1,c[y]+1]);
      end;
  end;

  for x:=0 to 8 do
  begin
    if minn[x,0]<>999 then
    begin
      tmin:=minn[x,0];
      for y:=1 to centrSk-1 do
      begin
        if minn[x,y]<>999 then
        begin
          if minn[x,y] < tmin then tmin:=minn[x,y];
          mind[x]:=tmin;
        end else mind[x]:=0;
      end;
    end else mind[x]:=0;
  end;

    maxx:=mind[0];
    z:=0;
    for j:=1 to 8 do
    begin
       if mind[j] > maxx then
       begin
         maxx:=mind[j];
         z:=j;
       end;
    end;
    summa:=0;

    for y:=1 to centrSk-1 do
    summa:=summa+(StrToFloat(StringGrid1.Cells[c[y]+1,c[0]+1]));

    if maxx > (1/2)*(1/(centrSk-1))*summa then
    begin
      c[centrSk]:=z;
      centrSk:=centrSk+1;
    end else ind:=1;
  end;    //while ind<1

    label3.Caption:='Klasu skaits: ' +FloatToStr(centrSk);
    label1.Caption:='';
    for x:=1 to centrSk do label1.caption:=label1.caption+'C'+IntToStr(x)+' = p'+IntToStr(c[x-1]+1)+'; ';

    for y:=0 to centrSk-1 do
    image1.Canvas.Ellipse(mas[c[y]].X-15, mas[c[y]].Y-15, mas[c[y]].X+15, mas[c[y]].Y+15);
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
Var k,j :Integer;
begin
  i:=0;
  image1.Canvas.Brush.Color := ClWhite;
  image1.Canvas.FillRect(Canvas.ClipRect);
  for k:=1 to 9 do
    for j:=1 to 9 do
    begin
      StringGrid1.Cells[j,k]:='';
    end;

    label1.caption:='Centri';
    label3.caption:='Skaits';
end;

procedure TForm1.Button3Click(Sender: TObject);
Var j, k : Integer;
begin
  i:=9;
  image1.Canvas.Brush.Color := ClWhite;
  image1.Canvas.FillRect(Canvas.ClipRect);
  for j:=0 to 8 do
  begin
    mas[j].X:=StrToInt(StringGrid2.Cells[1,j+1]);
    mas[j].Y:=StrToInt(StringGrid2.Cells[2,j+1]);
    Image1.Canvas.Rectangle(mas[j].X-1, mas[j].Y-1, mas[j].X+1, mas[j].Y+1);
     with Form1.Image1.Canvas do
     begin
       Font.Name := 'Tahoma';
       Font.Size := 8;
       Brush.Style := bsClear;
       TextOut(mas[j].X-5, mas[j].Y-15, 'p'+IntToStr(j+1));
     end;
  end;
   Image1.Refresh;

    for k:=1 to 9 do
    for j:=1 to 9 do
    begin
      StringGrid1.Cells[j,k]:=FloatToStrf((sqrt(sqr(abs(mas[k-1].X-mas[j-1].X))+sqr(abs(mas[k-1].Y-mas[j-1].Y)))),ffFixed, 4,2);
    end;

end;

end.
