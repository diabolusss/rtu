unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids;

const
  ObjCount = 50;

type
  TObjekts = record
    x,y: Integer;
    cl: Integer;
    distance: Integer;
    inCircle: Boolean;
  end;

  TCenter = record
    x,y: Integer;
  end;
  
  TForm1 = class(TForm)
    img1: TImage;
    edt1: TEdit;
    btn1: TButton;
    btn2: TButton;
    edt2: TEdit;
    txt1: TStaticText;
    txt2: TStaticText;
    strngrd1: TStringGrid;
    btn3: TButton;
    rb1: TRadioButton;
    rb2: TRadioButton;
    Label1: TLabel;
    strngrd2: TStringGrid;
    procedure Draw();
    procedure RandomPosition();
    procedure CountAndRenewDistance();
    procedure NewCenter();
    function Check():Boolean;
    procedure Draw2(i:Integer);
    procedure Step();
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  obj: array[1..100] of TObjekts;
  centers: array[0..1000] of TCenter;
  r: Integer;
  stepcount, stepcount_global: Integer;
  chosenobj, objcount_incircle, temp: Integer;
  newcenter_x, newcenter_y: Integer;
  prevcenter_x, prevcenter_y: Integer;
  cluster: Integer;
  en: Boolean;

implementation

{$R *.dfm}

procedure TForm1.Draw();
var i: Integer;
begin
  with img1.Canvas do
  begin
    if(rb1.Checked)then
    begin
      Brush.Color:=clWhite;
      Rectangle(0,0,img1.Width,img1.Height);
    end;

    for i:=1 to ObjCount do
    begin
      if(obj[i].cl=0) then
        Brush.Color:=clRed
      else if(obj[i].cl=1) then
        Brush.Color:=clBlue
      else if(obj[i].cl=2) then
        Brush.Color:=clGreen
      else if(obj[i].cl=3) then
        Brush.Color:=clYellow
      else if(obj[i].cl=4) then
        Brush.Color:=clPurple
      else if(obj[i].cl=5) then
        Brush.Color:=clLime
      else if(obj[i].cl=6) then
        Brush.Color:=clSilver
      else if(obj[i].cl=7) then
        Brush.Color:=clSkyBlue
      else if(obj[i].cl=8) then
        Brush.Color:=clFuchsia
      else if(obj[i].cl=9) then
        Brush.Color:=clTeal
      else if(obj[i].cl=10) then
        Brush.Color:=clMaroon
      else if(obj[i].cl=11) then
        Brush.Color:=clGray
      else if(obj[i].cl=12) then
        Brush.Color:=clAqua
      else if(obj[i].cl=13) then
        Brush.Color:=clOlive
      else if(obj[i].cl=14) then
        Brush.Color:=clNavy
      else if(obj[i].cl=15) then
        Brush.Color:=clMoneyGreen
      else if(obj[i].cl=16) then
        Brush.Color:=clMedGray
      else if(obj[i].cl=17) then
        Brush.Color:=clHotLight
      else if(obj[i].cl=18) then
        Brush.Color:=clMenuHighlight
      else
        Brush.Color:=clBlack;
      Ellipse(obj[i].x-3,obj[i].y-3,obj[i].x+3,obj[i].y+3);
    end;

    Brush.Style := bsClear;
    Font.Size := 10;
    for i:=1 to ObjCount do
    begin
      if(obj[i].cl=0) then
        Font.Color:=clRed
      else if(obj[i].cl=1) then
        Font.Color:=clBlue
      else if(obj[i].cl=2) then
        Font.Color:=clGreen
      else if(obj[i].cl=3) then
        Font.Color:=clYellow
      else if(obj[i].cl=4) then
        Font.Color:=clPurple
      else if(obj[i].cl=5) then
        Font.Color:=clLime
      else if(obj[i].cl=6) then
        Font.Color:=clSilver
      else if(obj[i].cl=7) then
        Font.Color:=clSkyBlue
      else if(obj[i].cl=8) then
        Font.Color:=clFuchsia
      else if(obj[i].cl=9) then
        Font.Color:=clTeal
      else if(obj[i].cl=10) then
        Font.Color:=clMaroon
      else if(obj[i].cl=11) then
        Font.Color:=clGray
      else if(obj[i].cl=12) then
        Font.Color:=clAqua
      else if(obj[i].cl=13) then
        Font.Color:=clOlive
      else if(obj[i].cl=14) then
        Font.Color:=clNavy
      else if(obj[i].cl=15) then
        Font.Color:=clMoneyGreen
      else if(obj[i].cl=16) then
        Font.Color:=clMedGray
      else if(obj[i].cl=17) then
        Font.Color:=clHotLight
      else if(obj[i].cl=18) then
        Font.Color:=clMenuHighlight
      else
        Font.Color:=clBlack;
        
      TextOut(obj[i].x, obj[i].y-20, IntToStr(i));
    end;

    Brush.Style:=bsClear;
    if(stepcount=0)then
      Ellipse(obj[chosenobj].x-r,obj[chosenobj].y-r,obj[chosenobj].x+r,obj[chosenobj].y+r)
    else
    begin
      Ellipse(newcenter_x-r,newcenter_y-r,newcenter_x+r,newcenter_y+r);
    end;
  end;
end;

procedure TForm1.RandomPosition();
var i: Integer;
begin
  Randomize;
  for i:=1 to ObjCount do
  begin
    obj[i].x:=Round(Random*(img1.Width-1));
    obj[i].y:=Round(Random*(img1.Height-1));
    obj[i].cl:=-1;
  end;
  chosenobj:=1 + Random(ObjCount);
end;

procedure TForm1.CountAndRenewDistance();
var i, value_x, value_y: Integer;
begin
  if(stepcount=0)then
  begin
    value_x:=obj[chosenobj].x;
    value_y:=obj[chosenobj].y;
  end
  else
  begin
    value_x:=newcenter_x;
    value_y:=newcenter_y;
  end;

  centers[stepcount_global].x:=value_x;
  centers[stepcount_global].y:=value_y;
  strngrd2.Cells[1,stepcount_global+1]:=IntToStr(value_x);
  strngrd2.Cells[2,stepcount_global+1]:=IntToStr(value_y);

  for i:=1 to ObjCount do
  begin
    if not(i=chosenobj) then
      obj[i].distance:=Round(Sqrt(Sqr(value_x-obj[i].x)+Sqr(value_y-obj[i].y)))
    else
      obj[i].distance:=0;
  end;

  for i:=1 to ObjCount do
  begin
    if (obj[i].distance<r) then
    begin
      obj[i].inCircle:=True;
      if(obj[i].cl=-1)then
        obj[i].cl:=cluster;
    end
    else
       obj[i].inCircle:=False;
  end;

  with strngrd1 do
  begin
    for i:=1 to strngrd1.RowCount do
      strngrd1.Rows[i].Clear;
    for i:=1 to Objcount do
      Cells[0,i]:='Obj' + IntToStr(i);
    for i:=1 to ObjCount do
    begin
      Cells[1,i]:=IntToStr(obj[i].distance);
      if (obj[i].distance<r) then
        Cells[2,i]:='X';
      if (i=chosenobj) and (stepcount=0) then
        Cells[2,i]:='C';
      if (obj[i].cl=-1) then
        Cells[3,i]:='None'
      else
        Cells[3,i]:=IntToStr(obj[i].cl);
    end;
  end;
end;

procedure TForm1.NewCenter();
var i, sum_x, sum_y, count: Integer;
begin
  sum_x:=0;
  sum_y:=0;
  count:=0;
  for i:=1 to ObjCount do
  begin
    if(obj[i].inCircle)then
    begin
      sum_x:=sum_x + obj[i].x;
      sum_y:=sum_y + obj[i].y;
      Inc(count);
    end;
  end;
  prevcenter_x:=newcenter_x;
  prevcenter_y:=newcenter_y;
  newcenter_x:=Round(sum_x/count);
  newcenter_y:=Round(sum_y/count);
end;

function TForm1.Check:Boolean;
var i,a : Integer;
begin
  a:=0;
  for i:=1 to ObjCount do
  begin
    if(obj[i].inCircle)then
      Inc(a);
  end;
  if(a=objcount_incircle)then
    Check:=True
  else
  begin
    Check:=False;
    objcount_incircle:=a;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:Integer;
begin
  with strngrd1 do
  begin
    Cells[1,0]:='Dist.to C';
    Cells[2,0]:='Dist.to C < r';
    Cells[3,0]:='Cluster';
  end;
  with strngrd2 do
  begin
    Cells[1,0]:='X';
    Cells[2,0]:='Y';
    for i:=1 to 20 do
    begin
      Cells[0,i]:='C' + IntToStr(i);
    end;
  end;
  r:=StrToInt(edt1.Text);
  stepcount:=0;
  stepcount_global:=0;
  edt2.Text:='Not made yet';
  cluster:=0;
  RandomPosition;
  CountAndRenewDistance;
  Draw;
end;

procedure TForm1.btn2Click(Sender: TObject);
var i:Integer;
begin
  for i:=1 to strngrd2.RowCount do
    strngrd2.Rows[i].Clear;
  for i:=1 to 20 do
    strngrd2.Cells[0,i]:='C' + IntToStr(i);
  img1.Canvas.Brush.Color:=clWhite;
  img1.Canvas.Rectangle(0,0,img1.Width,img1.Height);
  btn1.Enabled:=True;
  btn3.Enabled:=True;
  Label1.Caption:='';
  r:=StrToInt(edt1.Text);
  stepcount:=0;
  stepcount_global:=0;
  edt2.Text:='Not made yet';
  cluster:=0;
  RandomPosition;
  CountAndRenewDistance;
  Draw;
end;

procedure TForm1.Step();
var i, clustered_obj: Integer;
begin
  inc(stepcount);
  inc(stepcount_global);
  edt2.Text:=IntToStr(stepcount_global);
  clustered_obj:=0;

  if(Check)then
  begin
    stepcount:=0;
    Inc(cluster);
    for i:=1 to ObjCount do
    begin
      if(obj[i].cl=-1)then
      begin
        chosenobj:=i;
        Break;
      end;
    end;
  end;
  
  NewCenter;
  CountAndRenewDistance;

  for i:=1 to ObjCount do
  begin
    if(obj[i].cl=-1)then
    begin
      Inc(clustered_obj);
    end;
  end;
  if(clustered_obj=0)then
  begin
    btn1.Enabled:=False;
    btn3.Enabled:=False;
    Label1.Caption:='All objects clusterd!';
    en:=True;
  end;
  
  Draw;
end;

procedure TForm1.Draw2(i:Integer);
begin
  if(rb1.Checked)then
  begin
    if(cluster=0) then
        img1.Canvas.Pen.Color:=clRed
      else if(cluster=1) then
        img1.Canvas.Pen.Color:=clBlue
      else if(cluster=2) then
        img1.Canvas.Pen.Color:=clGreen
      else if(cluster=3) then
        img1.Canvas.Pen.Color:=clYellow
      else if(cluster=4) then
        img1.Canvas.Pen.Color:=clPurple
      else if(cluster=5) then
        img1.Canvas.Pen.Color:=clLime
      else if(cluster=6) then
        img1.Canvas.Pen.Color:=clSilver
      else if(cluster=7) then
        img1.Canvas.Pen.Color:=clSkyBlue
      else if(cluster=8) then
        img1.Canvas.Pen.Color:=clFuchsia
      else if(cluster=9) then
        img1.Canvas.Pen.Color:=clTeal
      else if(cluster=10) then
        img1.Canvas.Pen.Color:=clMaroon
      else if(cluster=11) then
        img1.Canvas.Pen.Color:=clGray
      else if(cluster=12) then
        img1.Canvas.Pen.Color:=clAqua
      else if(cluster=13) then
        img1.Canvas.Pen.Color:=clOlive
      else if(cluster=14) then
        img1.Canvas.Pen.Color:=clNavy
      else if(cluster=15) then
        img1.Canvas.Pen.Color:=clMoneyGreen
      else if(cluster=16) then
        img1.Canvas.Pen.Color:=clMedGray
      else if(cluster=17) then
        img1.Canvas.Pen.Color:=clHotLight
      else if(cluster=18) then
        img1.Canvas.Pen.Color:=clMenuHighlight
      else
        img1.Canvas.Pen.Color:=clBlack;

    img1.Canvas.LineTo(centers[i].x,centers[i].y);
    img1.Canvas.Pen.Color:=clBlack;
  end
  else
  begin
    if(cluster=0) then
        img1.Canvas.Pen.Color:=clRed
      else if(cluster=1) then
        img1.Canvas.Pen.Color:=clBlue
      else if(cluster=2) then
        img1.Canvas.Pen.Color:=clGreen
      else if(cluster=3) then
        img1.Canvas.Pen.Color:=clYellow
      else if(cluster=4) then
        img1.Canvas.Pen.Color:=clPurple
      else if(cluster=5) then
        img1.Canvas.Pen.Color:=clLime
      else if(cluster=6) then
        img1.Canvas.Pen.Color:=clSilver
      else if(cluster=7) then
        img1.Canvas.Pen.Color:=clSkyBlue
      else if(cluster=8) then
        img1.Canvas.Pen.Color:=clFuchsia
      else if(cluster=9) then
        img1.Canvas.Pen.Color:=clTeal
      else if(cluster=10) then
        img1.Canvas.Pen.Color:=clMaroon
      else if(cluster=11) then
        img1.Canvas.Pen.Color:=clGray
      else if(cluster=12) then
        img1.Canvas.Pen.Color:=clAqua
      else if(cluster=13) then
        img1.Canvas.Pen.Color:=clOlive
      else if(cluster=14) then
        img1.Canvas.Pen.Color:=clNavy
      else if(cluster=15) then
        img1.Canvas.Pen.Color:=clMoneyGreen
      else if(cluster=16) then
        img1.Canvas.Pen.Color:=clMedGray
      else if(cluster=17) then
        img1.Canvas.Pen.Color:=clHotLight
      else if(cluster=18) then
        img1.Canvas.Pen.Color:=clMenuHighlight
      else
        img1.Canvas.Pen.Color:=clBlack;
    img1.Canvas.LineTo(centers[i].x,centers[i].y);
    img1.Canvas.Ellipse(centers[i].x-r,centers[i].y-r,centers[i].x+r,centers[i].y+r);
    img1.Canvas.Pen.Color:=clBlack;
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var i:Integer;
begin
  Step;

  img1.Canvas.MoveTo(centers[0].x,centers[0].y);
  for i:=1 to stepcount_global do
  begin
    Draw2(i);
  end;

end;

procedure TForm1.btn3Click(Sender: TObject);
var i: Integer;
begin
  en:=False;
  while not (en) do
  begin
    Step;
  end;

  img1.Canvas.MoveTo(centers[0].x,centers[0].y);
  for i:=1 to stepcount_global do
  begin
    Draw2(i);
  end;
end;

procedure TForm1.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in['0'..'9', #8]) then
  begin
    key:=#0;
  end;
end;

end.
