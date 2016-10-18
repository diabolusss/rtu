unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids;

const
  ObjCount = 200;

type
  TObjekts = record
    x,y: Integer;
    cl: Integer;
    distance: array[1..ObjCount] of Integer;
  end;

  TCenter = record
    index: Integer;
  end;

  TMin = record
    dist,ind: Integer;
  end;
  
  TForm1 = class(TForm)
    img1: TImage;
    btn1: TButton;
    btn2: TButton;
    txt2: TStaticText;
    strngrd1: TStringGrid;
    btn3: TButton;
    strngrd2: TStringGrid;
    edt1: TEdit;
    strngrd3: TStringGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    Procedure Delay(mSec:Cardinal);
    procedure FormCreate(Sender: TObject);
    procedure RandomObjPlacing;
    procedure Draw;
    procedure DistCalc;
    procedure Step;
    procedure RandPlacing2;
    procedure RandPlacing3;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  obj: array[1..ObjCount] of TObjekts;
  centers: array[1..50] of TCenter;
  stepcount: Integer;
  chosenobj: Integer;
  center_count: Integer;
  end1,end2: Boolean;

implementation

{$R *.dfm}

Procedure TForm1.Delay(mSec:Cardinal);
Var TargetTime:Cardinal;
Begin
  TargetTime:=GetTickCount+mSec;
  While TargetTime>GetTickCount Do
  begin
    Application.ProcessMessages;
    Sleep(1);
    If Application.Terminated then Exit;
  end;
End;

procedure TForm1.FormCreate(Sender: TObject);
var i: Integer;
begin
  stepcount := 0;
  end1 := False;
  end2 := False;

  with strngrd1 do
  begin
    for i:=1 to strngrd1.ColCount do
    begin
      Cells[i,0] := 'x' + IntToStr(i);
      Cells[0,i] := 'x' + IntToStr(i);
    end;
  end;

  with strngrd2 do
  begin
    Cells[1,0] := 'X';
    Cells[2,0] := 'Y';
    Cells[3,0] := 'Index';
    for i:=1 to strngrd2.RowCount do
    begin
      Cells[0,i] := 'C' + IntToStr(i);
    end;
  end;

  with strngrd3 do
  begin
    Cells[1,0] := 'Cluster';
    for i:=1 to strngrd3.RowCount do
    begin
      Cells[0,i] := 'x' + IntToStr(i);
    end;
  end;

  RandomObjPlacing;
  //RandPlacing2;
  //RandPlacing3;
  center_count := 1;
  Draw;
  DistCalc;
end;

procedure TForm1.RandomObjPlacing;
var i:integer;
begin
  Randomize;
  for i:=1 to ObjCount do
  begin
    obj[i].x := Round(Random*(img1.Width-1));
    obj[i].y := Round(Random*(img1.Height-1));
    obj[i].cl := -1;
  end;

  chosenobj := 1 + Random(ObjCount);
  obj[chosenobj].cl := 0;
  centers[1].index := chosenobj;
  strngrd2.Cells[1,1] := IntToStr(obj[centers[1].index].x);
  strngrd2.Cells[2,1] := IntToStr(obj[centers[1].index].y);
  strngrd2.Cells[3,1] := IntToStr(centers[1].index);

  for i:=1 to ObjCount do
  begin
    if(obj[i].cl = -1)then
      strngrd3.Cells[1,i] := 'None'
    else
      strngrd3.Cells[1,i] := IntToStr(obj[i].cl + 1);
  end;
end;

procedure TForm1.Draw;
var i :Integer;
begin
  with img1.Canvas do
  begin
    Brush.Color:=clWhite;
    Rectangle(0,0,img1.Width,img1.Height);

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
    Pen.Color := clHighlight;
    for i:=1 to center_count do
    begin
      Ellipse(obj[centers[i].index].x-10,obj[centers[i].index].y-10,obj[centers[i].index].x+10,obj[centers[i].index].y+10);
    end;
    Pen.Color := clBlack;

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
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
var i:Integer;
begin
  for i:=1 to strngrd2.ColCount do
    strngrd2.Cols[i].Clear;

  with strngrd2 do
  begin
    Cells[1,0] := 'X';
    Cells[2,0] := 'Y';
    Cells[3,0] := 'Index';
  end;

  end1 := False;
  end2 := False;
  btn1.Enabled := True;
  btn3.Enabled := True;
  lbl1.Caption := '';
  lbl2.Caption := '';

  stepcount := 0;
  edt1.Text := '0';
  RandomObjPlacing;
  //RandPlacing2;
  //RandPlacing3;
  center_count := 1;
  Draw;
  DistCalc;
end;

procedure TForm1.DistCalc;
var i,j :Integer;
begin
  for i:=1 to ObjCount do
  begin
    for j:=1 to ObjCount do
    begin
      if not(i = j) then
        obj[i].distance[j] := Round(Sqrt(Sqr(obj[i].x-obj[j].x)+Sqr(obj[i].y-obj[j].y)))
      else
        obj[i].distance[j] := 0;
    end;
  end;

  with strngrd1 do
  begin
    for i:=1 to ObjCount do
    begin
      for j:=1 to ObjCount do
      begin
        Cells[j,i] := IntToStr(obj[i].distance[j]);
      end;
    end;
  end;
end;

procedure TForm1.Step;
var i,j,temp,temp_ind,max_index,max_val,center_avr, avr_count : Integer;
    min_dist : array[1..ObjCount] of TMin;
begin
  Inc(stepcount);
  edt1.Text := IntToStr(stepcount);

  temp := 1;
  if(stepcount = 1)then
  begin
    for i:=1 to ObjCount do
    begin
      if not(i = centers[1].index) and (obj[centers[1].index].distance[temp] < obj[centers[1].index].distance[i])then
        temp := i;
    end;
    centers[2].index := temp;
    obj[temp].cl := 1;
    Inc(center_count);
    strngrd2.Cells[1,2] := IntToStr(obj[centers[2].index].x);
    strngrd2.Cells[2,2] := IntToStr(obj[centers[2].index].y);
    strngrd2.Cells[3,2] := IntToStr(centers[2].index);
  end
  else
  begin
    for i:=1 to ObjCount do
    begin
      temp := 9999;
      if(obj[i].cl = -1)then
      begin
        for j:=1 to center_count do
        begin
          if(obj[i].distance[centers[j].index] < temp)then
             temp := obj[i].distance[centers[j].index];
        end;
        min_dist[i].dist := temp;
      end
      else
        min_dist[i].dist := -1;
    end;

    max_index := 0;
    max_val := 0;
    for i:=1 to ObjCount do
    begin
      if(min_dist[i].dist > -1) and(min_dist[i].dist > max_val)then
      begin
        max_val := min_dist[i].dist;
        max_index := i;
      end;
    end;

    center_avr := 0;
    avr_count := 1;
    for i:=1 to center_count-1 do
    begin
        if not(centers[i].index = centers[i+1].index)then
        begin
          center_avr := center_avr + obj[centers[i].index].distance[centers[i+1].index];
          if(stepcount = 2)then
            avr_count := 1
          else
            inc(avr_count);
        end;
    end;

    if not(stepcount = 2)then center_avr := center_avr + obj[centers[1].index].distance[centers[center_count].index];

    edt2.Text := IntToStr(max_val);
    edt3.Text := IntToStr(Round(center_avr/(2*avr_count)));
    edt4.Text := IntToStr(center_avr);
    edt5.Text := IntToStr(avr_count);
    edt6.Text := IntToStr(center_count);

    if(max_val > Round(center_avr/(2*avr_count)))then
    begin
      inc(center_count);
      centers[center_count].index := max_index;
      obj[max_index].cl := stepcount;

      strngrd2.Cells[1,center_count] := IntToStr(obj[centers[center_count].index].x);
      strngrd2.Cells[2,center_count] := IntToStr(obj[centers[center_count].index].y);
      strngrd2.Cells[3,center_count] := IntToStr(centers[center_count].index);
    end
    else
    begin
      btn1.Enabled := False;
      btn3.Enabled := False;
      lbl1.Caption := 'All cluster centers found';
      end1 := True;
    end;
  end;

  if(end1)then
  begin
    
    temp_ind:=0;
    for i:=1 to ObjCount do
    begin
      temp:=9999;
      if(obj[i].cl = -1)then
      begin
        for j:=1 to center_count do
        begin
          if (obj[i].distance[centers[j].index] < temp)then
          begin
            temp:=obj[i].distance[centers[j].index];
            temp_ind:=j;
          end;
        end;
        obj[i].cl := obj[centers[temp_ind].index].cl;
      end;
    end;
    lbl2.Caption := 'All objects clustered';
    end2 := True;
  end;

  for i:=1 to ObjCount do
  begin
    if(obj[i].cl = -1)then
      strngrd3.Cells[1,i] := 'None'
    else
      strngrd3.Cells[1,i] := IntToStr(obj[i].cl + 1);
  end;

  Draw;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  Step;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  while not(end2) do
  begin
    Step;
  end;
end;

procedure TForm1.RandPlacing2;
var i:Integer;
begin
  Randomize;
  for i:=1 to 10 do
  begin
    obj[i].x := 150 + Random(50);
    obj[i].y := 150 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=11 to 20 do
  begin
    obj[i].x := 300 + Random(50);
    obj[i].y := 10 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=21 to 30 do
  begin
    obj[i].x := 450 + Random(50);
    obj[i].y := 150+ Random(50);
    obj[i].cl := -1;
  end;

  for i:=31 to 40 do
  begin
    obj[i].x := 10 + Random(50);
    obj[i].y := 300 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=41 to 50 do
  begin
    obj[i].x := 300 + Random(50);
    obj[i].y := 300 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=51 to 60 do
  begin
    obj[i].x := 600 + Random(50);
    obj[i].y := 300 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=61 to 70 do
  begin
    obj[i].x := 150 + Random(50);
    obj[i].y := 450 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=71 to 80 do
  begin
    obj[i].x := 300 + Random(50);
    obj[i].y := 600 + Random(50);
    obj[i].cl := -1;
  end;

  for i:=81 to 90 do
  begin
    obj[i].x := 450 + Random(50);
    obj[i].y := 450 + Random(50);
    obj[i].cl := -1;
  end;
  
  chosenobj := 1 + Random(50);
  obj[chosenobj].cl := 0;
  centers[1].index := chosenobj;
  strngrd2.Cells[1,1] := IntToStr(obj[centers[1].index].x);
  strngrd2.Cells[2,1] := IntToStr(obj[centers[1].index].y);
  strngrd2.Cells[3,1] := IntToStr(centers[1].index);

  for i:=1 to ObjCount do
  begin
    if(obj[i].cl = -1)then
      strngrd3.Cells[1,i] := 'None'
    else
      strngrd3.Cells[1,i] := IntToStr(obj[i].cl + 1);
  end;
end;

procedure TForm1.RandPlacing3;
var i:Integer;
begin
  obj[1].x := 25;
  obj[1].y := 25;

  obj[2].x := img1.Width-25;
  obj[2].y := 25;

  obj[3].x := Round(img1.Width/2);
  obj[3].y := Round(img1.Height/2);

  obj[4].x := 25;
  obj[4].y := img1.Height-25;

  obj[5].x := img1.Width-25;
  obj[5].y := img1.Height-25;

  obj[1].cl := -1;
  obj[2].cl := -1;
  obj[3].cl := -1;
  obj[4].cl := -1;
  obj[5].cl := -1;

  chosenobj := 1 + Random(5);
  obj[chosenobj].cl := 0;
  centers[1].index := chosenobj;
  strngrd2.Cells[1,1] := IntToStr(obj[centers[1].index].x);
  strngrd2.Cells[2,1] := IntToStr(obj[centers[1].index].y);
  strngrd2.Cells[3,1] := IntToStr(centers[1].index);

  for i:=1 to ObjCount do
  begin
    if(obj[i].cl = -1)then
      strngrd3.Cells[1,i] := 'None'
    else
      strngrd3.Cells[1,i] := IntToStr(obj[i].cl + 1);
  end;
end;

end.
