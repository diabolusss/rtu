unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Menus, Math;

const
  ObjCount=3;

type
  TEtalons = record
    x,y: integer;
  end;

  TObjekts = record
    x,y: integer;
  end;

  TKlase = array[1..3] of record
    x,y: Integer;
  end;

  TCross = array[1..4] of record
    x,y: Integer;
  end;

  TForm1 = class(TForm)
    img1: TImage;
    btn1: TButton;
    strngrd1: TStringGrid;
    lbl1: TLabel;
    rg1: TRadioGroup;
    Edit1: TEdit;
    edt1: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    btn2: TButton;
    StringGrid1: TStringGrid;
    strngrd2: TStringGrid;
    lbl7: TLabel;
    edt2: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    edt3: TEdit;
    edt4: TEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    edt9: TEdit;
    lbl16: TLabel;
    edt10: TEdit;
    edt11: TEdit;
    edt12: TEdit;
    edt13: TEdit;
    edt14: TEdit;
    edt15: TEdit;
    procedure SakotnejasVertibas();
    procedure Draw();
    procedure FormCreate(Sender: TObject);
    procedure Etalons();
    procedure fhprepair();
    procedure fhmod1();
    procedure fhmod2();
    procedure hiperpl1();
    procedure hiperpl2();
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure Metode();
    procedure strngrd1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
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
  V:TCross;
  da,db: Real;
  Vx1,Vy1,Vx2,Vy2:Integer;
  aopt,bopt: Integer;
  CoefK,CoefB:Real;
  center_x,center_y: Integer;
  vect_count:Integer;
  myarray: array[1..ObjCount*2] of record
    val: Integer;
    cl: string;
  end;
  myarray2: array[1..ObjCount*2] of record
    val: Real;
    cl: Integer;
  end;
  myarray3: array[1..1001] of record
    gxt,gyt,c1t,c2t,dct:Real;
    Nr_A,Nr_B:Integer;
  end;
  myarray4: array[1..1001] of record
    gxt,gyt,dct:Real;
    NrA,NrB:Integer;
  end;
implementation

{$R *.dfm}

 procedure TForm1.Metode();
 begin
   if rg1.ItemIndex=0 then Etalons;
   if rg1.ItemIndex=1 then fhmod1;
   if rg1.ItemIndex=2 then fhmod2;
   if rg1.ItemIndex=3 then hiperpl1;
   if rg1.ItemIndex=4 then hiperpl2;
 end;

 procedure TForm1.SakotnejasVertibas();
 var i: integer;
 begin
   randomize;
   for i:=1 to ObjCount do
   begin
     a[i].x:=10+Random(200);
     a[i].y:=10+Random(200);
     b[i].x:=210+Random(200);
     b[i].y:=210+Random(200);
   end;
 end;

 procedure TForm1.Draw();
 var i: Integer;
 begin
   with img1.Canvas do
   begin
     Brush.Color:=clWhite;
     Rectangle(0,0,img1.Width,img1.Height);
     Brush.Color:=clRed;
     for i:=1 to ObjCount do
     Ellipse(a[i].x-3,a[i].y-3,a[i].x+3,a[i].y+3);
     if rg1.ItemIndex=0 then
     Ellipse(eta.x-5,eta.y-5,eta.x+5,eta.y+5);

     brush.Color:=clGreen;
     for i:=1 to ObjCount do
     Ellipse(b[i].x-3,b[i].y-3,b[i].x+3,b[i].y+3);
     if rg1.ItemIndex=0 then
     Ellipse(etb.x-5,etb.y-5,etb.x+5,etb.y+5);

     brush.Color:=clBlue;
     Ellipse(obj.x-3,obj.y-3,obj.x+3,obj.y+3);

     Brush.Style := bsClear;
     Font.Size := 10;
     TextOut(obj.x, obj.y-20, 'Obj');

     for i:=1 to ObjCount do
     begin
       TextOut(a[i].x, a[i].y-20, 'A'+ IntToStr(i));
       TextOut(b[i].x, b[i].y-20, 'B'+ IntToStr(i));
     end;
     
     if rg1.ItemIndex=0 then
     begin
       TextOut(eta.x, eta.y-20, 'EtA');
       TextOut(etb.x, etb.y-20, 'EtB');
     end;

     if rg1.ItemIndex=3 then
     begin
       Brush.Color:=clBlack;
       MoveTo(a[aopt].x,a[aopt].y);
       LineTo(b[bopt].x,b[bopt].y);
       center_x:=Round((a[aopt].x+b[bopt].x)/2);
       center_y:=Round((a[aopt].y+b[bopt].y)/2);
       Ellipse(center_x-3,center_y-3,center_x+3,center_y+3);
       CoefK:=(b[bopt].y-a[aopt].y)/(b[bopt].x-a[aopt].x);
       CoefK:=-1/CoefK;
       CoefB:=center_y-CoefK*center_x;
       MoveTo(0,Round(CoefB));
       LineTo(ClientWidth,Round(CoefK*ClientWidth+CoefB));
       V[1].x:=0;
       V[1].y:=Round(CoefB);
       V[2].x:=Round(-CoefB/CoefK);
       V[2].y:=0;
       Ellipse(-3,Round(CoefB)-3,3,Round(CoefB)+3);
       Ellipse(Round(-CoefB/CoefK)-3,-3,Round(-CoefB/CoefK)+3,+3);
       Ellipse(img1.Width-3,Round(CoefK*img1.Width+CoefB)-3,img1.Width+3,Round(CoefK*img1.Width+CoefB)+3);
       Ellipse(Round((img1.Height-CoefB)/CoefK)-3,img1.Height-3,Round((img1.Height-CoefB)/CoefK)+3,img1.Height+3);
     end;

     if rg1.ItemIndex=4 then
     begin
       Brush.Color:=clBlack;
       MoveTo(Vx1,Vy1);
       LineTo(Vx2,Vy2);
     end;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  SakotnejasVertibas;
  Draw;
  with strngrd1 do
  begin
    Cells[1,0]:='X';
    Cells[2,0]:='Y';

    for i:=1 to ObjCount do
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

  edt5.Text:=IntToStr(eta.x);
  edt6.Text:=IntToStr(eta.y);
  edt7.Text:=IntToStr(etb.x);
  edt8.Text:=IntToStr(etb.y);

  da:=Round(sqrt(sqr(eta.x-obj.x)+sqr(eta.y-obj.y)));
  db:=Round(sqrt(sqr(etb.x-obj.x)+sqr(etb.y-obj.y)));

  edt3.Text:=FloatToStr(da);
  edt4.Text:=FloatToStr(db);

  if da<db then lbl1.Caption:='Objekts pieder klasei A';
  if da>db then lbl1.Caption:='Objekts pieder klasei B';
  if da=db then lbl1.Caption:='Objekts atrodas uz robezas';
end;

procedure TForm1.fhprepair();
var i,j: Integer;
var temp1: Integer;
var temp2: string;
begin
  for i:=1 to ObjCount do
  begin
    myarray[i].val:=Round(Sqrt(Sqr(a[i].x-obj.x)+Sqr(a[i].y-obj.y)));
    myarray[i].cl:='A'+IntToStr(i);
    myarray[i+3].val:=Round(Sqrt(Sqr(b[i].x-obj.x)+Sqr(b[i].y-obj.y)));
    myarray[i+3].cl:='B'+IntToStr(i);
  end;
  for j:=1 to ObjCount*2-1 do
  begin
    for i:=1 to ObjCount*2-j do
    begin
      if myarray[i].val > myarray[i+1].val then
      begin
        temp1:=myarray[i].val;
        myarray[i].val:=myarray[i+1].val;
        myarray[i+1].val:=temp1;
        temp2:=myarray[i].cl;
        myarray[i].cl:=myarray[i+1].cl;
        myarray[i+1].cl:=temp2;
      end;
    end;
  end;
  with StringGrid1 do
  begin
    Cells[0,0]:='Class';
    Cells[0,1]:='Dist.';
    for i:=1 to ObjCount*2 do
      begin
        Cells[i,0]:=myarray[i].cl;
        Cells[i,1]:=FloatToStr(myarray[i].val);
        Delete(myarray[i].cl,2,1);
      end;
  end;
end;

procedure TForm1.fhmod1();
var i:Integer;
begin
  fhprepair;
  i:=1;
  while (myarray[i].val=myarray[i+1].val) And (myarray[i].cl<>myarray[i+1].cl) do
  begin
    i:=i+2;
  end;
  if myarray[i].val<myarray[i+1].val then lbl1.Caption:='Objekts pieder klasei ' + myarray[i].cl
  else lbl1.Caption:='Objekts pieder klasei ' + myarray[i+1].cl;
end;

procedure TForm1.fhmod2();
var i,vote_count:Integer;
begin
  vote_count:=0;
  fhprepair;
  if (myarray[1].val=myarray[2].val) And (myarray[1].cl<>myarray[2].cl) then
  begin
  for i:=1 to 3 do
  begin
  if myarray[i].cl='A' then vote_count:=vote_count+1;
  end;
  if vote_count>=2 then lbl1.Caption:='Objekts pieder klasei A'
  else lbl1.Caption:='Objekts pieder klasei B';
  end
  else if myarray[1].val<myarray[2].val then lbl1.Caption:='Objekts pieder klasei ' + myarray[1].cl
  else if myarray[1].val>myarray[2].val then lbl1.Caption:='Objekts pieder klasei ' + myarray[2].cl;
end;

procedure TForm1.hiperpl1();
var temp2,temp8,temp9,k,i,j,lenkis,Position:Integer;
var temp3,temp4,temp5,temp6,temp7,temp1,gx,gy,gxopt,
gyopt,c1,c2,delta_c,Vx1,Vy1,Vx2,Vy2,m:Real;
begin
  Randomize;
  vect_count:=StrToInt(edt2.Text);
  with strngrd2 do
  begin
    Cells[1,0]:='gx';
    Cells[2,0]:='gy';
    Cells[3,0]:='c1';
    Cells[4,0]:='c2';
    Cells[5,0]:='deltaC';
    Cells[6,0]:='Nr_A';
    Cells[7,0]:='Nr_B';
  end;
  for k:=1 to vect_count do
  begin
      lenkis:=Random(180)+90;
      gx:=cos(lenkis*pi/180);
      gy:=sin(lenkis*pi/180);
      for i:=1 to ObjCount do
      begin
        myarray2[i].val:=a[i].x*gx+a[i].y*gy;
        myarray2[i].cl:=i;
        myarray2[i+3].val:=b[i].x*gx+b[i].y*gy;
        myarray2[i+3].cl:=i;
      end;
      for j:=1 to ObjCount-1 do
      begin
        for i:=1 to ObjCount-j do
        begin
          if myarray2[i].val > myarray2[i+1].val then
          begin
            temp1:=myarray2[i].val;
            myarray2[i].val:=myarray2[i+1].val;
            myarray2[i+1].val:=temp1;
            temp2:=myarray2[i].cl;
            myarray2[i].cl:=myarray2[i+1].cl;
            myarray2[i+1].cl:=temp2;
          end;
        end;
      end;
      for j:=1 to ObjCount-1 do
      begin
        for i:=4 to ObjCount*2-j do
        begin
          if myarray2[i].val < myarray2[i+1].val then
          begin
            temp1:=myarray2[i].val;
            myarray2[i].val:=myarray2[i+1].val;
            myarray2[i+1].val:=temp1;
            temp2:=myarray2[i].cl;
            myarray2[i].cl:=myarray2[i+1].cl;
            myarray2[i+1].cl:=temp2;
          end;
        end;
      end;
      with StringGrid1 do
      begin
        Cells[0,0]:='Class';
        Cells[0,1]:='Dist.';
        for i:=1 to ObjCount*2 do
        begin
          Cells[i,0]:=IntToStr(myarray2[i].cl);
          Cells[i,1]:=FloatToStr(myarray2[i].val);
        end;
      end;
      aopt:=myarray2[1].cl;
      bopt:=myarray2[4].cl;
      c1:=myarray2[1].val;
      c2:=myarray2[4].val;
      delta_c:=c1-c2;
      with strngrd2 do
      begin
        myarray3[k].gxt:=gx;
        myarray3[k].gyt:=gy;
        myarray3[k].c1t:=c1;
        myarray3[k].c2t:=c2;
        myarray3[k].dct:=delta_c;
        myarray3[k].Nr_A:=aopt;
        myarray3[k].Nr_B:=bopt;
      end;
  end;
  for j:=1 to vect_count-1 do
  begin
    for i:=1 to vect_count-j do
    begin
      if myarray3[i].dct < myarray3[i+1].dct then
      begin
        temp3:=myarray3[i].gxt;
        myarray3[i].gxt:=myarray3[i+1].gxt;
        myarray3[i+1].gxt:=temp3;
        temp4:=myarray3[i].gyt;
        myarray3[i].gyt:=myarray3[i+1].gyt;
        myarray3[i+1].gyt:=temp4;
        temp5:=myarray3[i].c1t;
        myarray3[i].c1t:=myarray3[i+1].c1t;
        myarray3[i+1].c1t:=temp5;
        temp6:=myarray3[i].c2t;
        myarray3[i].c2t:=myarray3[i+1].c2t;
        myarray3[i+1].c2t:=temp6;
        temp7:=myarray3[i].dct;
        myarray3[i].dct:=myarray3[i+1].dct;
        myarray3[i+1].dct:=temp7;
        temp8:=myarray3[i].Nr_A;
        myarray3[i].Nr_A:=myarray3[i+1].Nr_A;
        myarray3[i+1].Nr_A:=temp8;
        temp9:=myarray3[i].Nr_B;
        myarray3[i].Nr_B:=myarray3[i+1].Nr_B;
        myarray3[i+1].Nr_B:=temp9;
      end;
    end;
  end;
  for k:=1 to vect_count do
  begin
    with strngrd2 do
    begin
      Cells[0,k]:=IntToStr(k);
      Cells[1,k]:=FloatToStr(myarray3[k].gxt);
      Cells[2,k]:=FloatToStr(myarray3[k].gyt);
      Cells[3,k]:=FloatToStr(myarray3[k].c1t);
      Cells[4,k]:=FloatToStr(myarray3[k].c2t);
      Cells[5,k]:=FloatToStr(myarray3[k].dct);
      Cells[6,k]:=IntToStr(myarray3[k].Nr_A);
      Cells[7,k]:=IntToStr(myarray3[k].Nr_B);
    end;
  end;
  with strngrd2 do
  begin
  aopt:=StrToInt(Cells[6,1]);
  bopt:=StrToInt(Cells[7,1]);
  end;
  //CoefK:=(b[bopt].y-a[aopt].y)/(b[bopt].x-a[aopt].x);
  //CoefK:=-1/CoefK;
  //CoefB:=center_y-CoefK*center_x;
  Position:= Round((V[2].x-V[1].x)*(obj.y-V[1].y) - (V[2].y-V[1].y)*(obj.x-V[1].x));
  edt9.Text:=IntToStr(Position);
  if Position<0 then lbl1.Caption:='Objekts pieder klasei A'
  else if Position>0 then lbl1.Caption:='Objekts pieder klasei B'
  else if Position=0 then lbl1.Caption:='Objekts pieder abam klasem';
end;

procedure TForm1.hiperpl2();
var i,j,i_opt,n,lenkis,nr_a,nr_b,Position:Integer;
var gx,gy,c1,c2,tmp,tmp2,dc,dc_opt:Real;
begin
  Randomize;
  n:=StrToInt(edt2.Text);
  with strngrd2 do
  begin
    Cells[1,0]:='gx';
    Cells[2,0]:='gy';
    Cells[3,0]:='c1';
    Cells[4,0]:='c2';
    Cells[5,0]:='deltaC';
    Cells[6,0]:='Nr_A';
    Cells[7,0]:='Nr_B';
  end;
  dc_opt:=-9999;
  
  for i:=1 to n do
  begin
    lenkis:=random(180)+90;
    gx:=cos(lenkis*pi/180);
    gy:=sin(lenkis*pi/180);

    c1:=+999999;
    c2:=-999999;
    for j:=1 to 3 do
    begin
      tmp:=a[j].x*gx+a[j].y*gy;
      if tmp<c1 then
      begin
        c1:=tmp;
        nr_a:=j;
      end;

      tmp2:=b[j].x*gx+b[j].y*gy;
      if tmp2>c2 then
      begin
        c2:=tmp2;
        nr_b:=j;
      end;
    end;

    dc:=c1-c2;
    if dc>dc_opt then
    begin
      dc_opt:=dc;
      i_opt:=i;
    end;

    with strngrd2 do
    begin
      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=FloatToStr(gx);
      Cells[2,i]:=FloatToStr(gy);
      Cells[3,i]:=FloatToStr(c1);
      Cells[4,i]:=FloatToStr(c2);
      Cells[5,i]:=FloatToStr(dc);
      Cells[6,i]:=IntToStr(nr_a);
      Cells[7,i]:=IntToStr(nr_b);
    end;
  end;
  edt10.Text:=IntToStr(i_opt);
  edt11.Text:=FloatToStr(dc_opt);
  for i:=1 to n do
  begin
    with strngrd2 do
    begin
      if(StrToInt(Cells[0,i])=i_opt) then
      begin
        gx:=StrToFloat(Cells[1,i]);
        gy:=StrToFloat(Cells[2,i]);
        nr_a:=StrToInt(Cells[6,i]);
        nr_b:=StrToInt(Cells[7,i]);
      end;
    end;
  end;
  Vx1:=Round(500*gy+(a[nr_a].x+b[nr_b].x)/2);
  Vy1:=Round(-500*gx+(a[nr_a].y+b[nr_b].y)/2);
  Vx2:=Round(-500*gy+(a[nr_a].x+b[nr_b].x)/2);
  Vy2:=Round(500*gx+(a[nr_a].y+b[nr_b].y)/2);
  edt12.Text:=FloatToStr(Vx1);
  edt13.Text:=FloatToStr(Vy1);
  edt14.Text:=FloatToStr(Vx2);
  edt15.Text:=FloatToStr(Vy2);
  Position:= Round((Vx2-Vx1)*(obj.y-Vy1) - (Vy2-Vy1)*(obj.x-Vx1));
  edt9.Text:=IntToStr(Position);
  if Position<0 then lbl1.Caption:= 'klase A';
  if Position>0 then lbl1.Caption:= 'klase B';
  if Position=0 then lbl1.Caption:= 'A un B';
end;

procedure TForm1.img1MouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
  obj.x:=X;
  obj.y:=Y;
  Edit1.Text:=IntToStr(X);
  edt1.Text:=IntToStr(Y);
  Metode;
  Draw;
end;

procedure TForm1.btn1Click(Sender: TObject);
 var i: integer;
 begin
 SakotnejasVertibas;
 Draw;
  with strngrd1 do
  begin
    Cells[1,0]:='X';
    Cells[2,0]:='Y';

    for i:=1 to ObjCount do
      begin
        Cells[0,i]:='A'+IntToStr(i);
        Cells[1,i]:=IntToStr(a[i].x);
        Cells[2,i]:=IntToStr(a[i].y);

        Cells[0,i+3]:='B'+IntToStr(i);
        Cells[1,i+3]:=IntToStr(b[i].x);
        Cells[2,i+3]:=IntToStr(b[i].y);
      end;
  end;
  Metode;
 end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  obj.x:=StrToInt(Edit1.Text);
  obj.y:=StrToInt(edt1.Text);
  Metode;
  Draw;
end;

procedure TForm1.strngrd1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
 var i:integer;
begin
    with strngrd1 do
    begin
      for i:=1 to ObjCount do
      begin
        if (Cells[1,i]='') or (Cells[2,i]='') or (Cells[1,i+3]='') or (Cells[2,i+3]='') then
        else
        begin
          a[i].x:=StrToInt(Cells[1,i]);
          a[i].y:=StrToInt(Cells[2,i]);
          b[i].x:=StrToInt(Cells[1,i+3]);
          b[i].y:=StrToInt(Cells[2,i+3]);
        end;
      end;
    end;
    Metode;
    Draw;
end;

end.
