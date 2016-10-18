unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  Trecpointer = ^Tpoint;
  Tpoint = record
    x,y:integer;
    next:TRecPointer;
  end;
  TForm1 = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Button1: TButton;
    procedure drawimage();
    procedure FillTable();
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Rotacija();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Point: Tpoint;
  pointer,head:TRecPointer;
  Form1: TForm1;
  x0,y0,pnum:integer;

implementation

procedure TForm1.Filltable();
var i:integer;
begin
  with StringGrid1 do begin
    cells[0,0]:='Virsotne';
    cells[0,1]:='X';
    cells[0,2]:='Y';
    pointer := head;
    i:=0;
    while pointer <> nil do begin
      inc(i);
      Cells[i,0]:=inttostr(i);
      cells[i,1]:=inttostr(pointer.x);
      cells[i,2]:=inttostr(pointer.y);
      pointer:=pointer^.next;
    end;

  end;
end;

procedure TFORM1.drawimage();
begin
  pointer := head;
  while pointer <> nil do begin
    Image1.Canvas.MoveTo(pointer.x+x0,pointer.y+y0);
    if(pointer.next<>nil)then
      Image1.Canvas.lineto(pointer^.next.x+x0,pointer^.next.y+y0)
    else
      Image1.Canvas.lineto(head.x+x0,head.y+y0);
    pointer:=pointer^.next;
  end;
end;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
     cur:TRecPointer;
begin
  pnum:=6;
  Stringgrid1.ColCount:=pnum+1;
  x0:=Image1.Width div 2;
  y0:=Image1.Height div 2;
  head:=nil;
  new(pointer);
  pointer.x:=100-Random(400);
  pointer.y:=100-Random(400);
  pointer.next := head;
  head:=pointer;
  for i:=2 to pnum do begin
    cur:=pointer;
    new(pointer);
    cur.next:=pointer;
    pointer.x:=100-Random(400);
    pointer.y:=100-Random(400);
    pointer.next := nil;
  end;
end;

procedure TForm1.Rotacija();
 var i,xt,yt:integer;
 a:real;
begin
  {a:=degtorad(strtoint(edit1.Text));
  for i:=0 to 2 do
    begin
    xt:=round(p[i].x*cos(a)-p[i].y*sin(a));
    yt:=round(p[i].x*sin(a)+p[i].y*cos(a));
    p[i].x:=xt;
    p[i].y:=yt;
  end;
  FillTable;
  }
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.FillTable();
  Rotacija();
  DrawImage();
end;

end.

