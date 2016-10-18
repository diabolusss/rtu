unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls,Math;

type
  TEtalons = record
    x,y: integer;
  end;

  TObjekts = record
    x,y: integer;
  end;

  TKlase = array[1..3] of record
    x,y: integer;
  end;

  TAttalumi = array [1..6] of record
    d:real;
    klase: integer;
  end;

  TForm1 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    procedure SakotnejasVertibas();
    procedure Draw();
    procedure FormCreate(Sender: TObject);
    procedure Etalons();
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FH();
    procedure Button1Click(Sender: TObject);
   // procedure Sort;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a,b: TKlase;
  obj: TObjekts;
  eta,etb: TEtalons;
  da,db: real;
  att: TAttalumi;

implementation

{$R *.dfm}

procedure TForm1.SakotnejasVertibas();
var i: integer;
begin
  randomize;
  for i:=1 to 3 do
    begin
      a[i].x:=10+Random(200);
      a[i].y:=10+Random(200);
      b[i].x:=210+Random(200);
      b[i].y:=210+Random(200);
    end;
end;

procedure TForm1.Draw();
var i: integer;
begin
  with Image1.Canvas do
    begin
      brush.Color:=clWhite;
      Rectangle(0,0,Image1.Width,
                Image1.Height);

      brush.Color:=clRed;
      for i:=1 to 3 do
      Ellipse(a[i].x-3,a[i].y-3,
              a[i].x+3,a[i].y+3);
      Ellipse(eta.x-5,eta.y-5,
              eta.x+5,eta.y+5);

      brush.Color:=clGreen;
      for i:=1 to 3 do
      Ellipse(b[i].x-3,b[i].y-3,
              b[i].x+3,b[i].y+3);
      Ellipse(etb.x-5,etb.y-5,
              etb.x+5,etb.y+5);

      Brush.Color:=clBlue;
      Ellipse(obj.x-3,obj.y-3,
              obj.x+3,obj.y+3);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  SakotnejasVertibas;
  Draw();

  With StringGrid1 do
    begin
      Cells[1,0]:='X';
      Cells[2,0]:='Y';

      for i:=1 to 3 do
        begin
          Cells[0,i]:='A'+IntToStr(i);
          Cells[1,i]:=IntToStr(a[i].x);
          Cells[2,i]:=IntToStr(a[i].y);

          Cells[0,i+3]:='B'+IntToStr(i);
          Cells[1,i+3]:=IntToStr(b[i].x);
          Cells[2,i+3]:=IntToStr(b[i].y);
        end;
    end;
end;
procedure TForm1.Etalons();
begin
  eta.x:=(a[1].x+a[2].x+a[3].x) div 3;
  eta.y:=(a[1].y+a[2].y+a[3].y) div 3;

  etb.x:=(b[1].x+b[2].x+b[3].x) div 3;
  etb.y:=(b[1].y+b[2].y+b[3].y) div 3;

da:=sqrt(sqr(eta.x-obj.x)+sqr(eta.y-obj.y));
db:=sqrt(sqr(etb.x-obj.x)+sqr(etb.y-obj.y));

if da<db then Label1.Caption:='Klase A';
if da>db then Label1.Caption:='Klase B';
if da=db then Label1.Caption:='Robezha';
end;

procedure TForm1.FH();
var i,tempk: integer;
    swapped:boolean;
    tempd: real;
begin
  for i:=1 to 3 do
    begin
      att[i].d:=sqrt(sqr(a[i].x-obj.x)+sqr(a[i].y-obj.y));
      att[i].klase:=1;
      att[i+3].d:=sqrt(sqr(b[i].x-obj.x)+sqr(b[i].y-obj.y));
      att[i+3].klase:=2;
    end;

    //bubble sort
   repeat
     swapped := false;
     for i := 1 to 6 do
       if att[i-1].d > att[i].d then
       begin
         tempd:=att[i-1].d;
         tempk:=att[i-1].klase;
         att[i-1].d:=att[i].d;
         att[i-1].klase:=att[i].klase;
         att[i].d:=tempd;
         att[i].klase:=tempk;
         swapped := true
       end
   until not swapped;

   if att[1].klase=1 then Label1.Caption:='Klase A';
   if att[1].klase=2 then Label1.Caption:='Klase B';
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  obj.x:=X;
  obj.y:=Y;

  if RadioGroup1.ItemIndex=0 then Etalons;
  if RadioGroup1.ItemIndex=1 then FH;
 //if RadioGroup1.ItemIndex=2 then fhmetodem1;
  Draw;
end;

procedure TForm1.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i: integer;
  begin
  if key=VK_RETURN then
    begin
    for i:=1 to 3 do
        begin
          a[i].x:=StrToInt(StringGrid1.Cells[1,i]);
          a[i].y:=StrToInt(StringGrid1.Cells[2,i]);
          b[i].x:=StrToInt(StringGrid1.Cells[1,i+3]);
          b[i].y:=StrToInt(StringGrid1.Cells[2,i+3]);
        end;
      Draw;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SakotnejasVertibas;
  Draw;
end;

end.
