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

var
  Form1: TForm1;
  vx,vy: integer;
  vxs,vys: integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  vxs:=0;
  vys:=0;
  vx:=Image1.Width div 2;
  vy:=Image1.Height div 2;

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
  VK_RIGHT: begin
      vxs:=1;
            end;
  VK_LEFT: begin
      vxs:=-1;
             end;
  VK_UP: begin
      vxs:=-1;
            end;
  VK_DOWN: begin
      vxs:=+1;
            end;
end;
end;
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
  VK_RIGHT: begin
      vxs:=0;
            end;
  VK_LEFT: begin
      vxs:=0;
             end;
  VK_UP: begin
      vxs:=0;
            end;
  VK_DOWN: begin
      vxs:=0;
            end;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  vx:=vx+vxs;
  vy:=vy+vys;
  Image1.Canvas.Brush.Color:=clGreen;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
          Image1.Canvas.Brush.Color:=clYellow;
     Image1.Canvas.Ellipse(vx-10,vy-10,vx+10,vy+10);
        Image1.Canvas.Brush.Color:=clRed;
     Image1.Canvas.Ellipse(vx+8*vxs-3,vy+8*vys-3,vx+8*vxs+3,vy+8*vys+3);
end;

end.
