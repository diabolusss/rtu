unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons, ImgList;

type
  TForm1 = class(TForm)
    Button_Teach: TButton;
    Button_Exam: TButton;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    y1: TEdit;
    y2: TEdit;
    y3: TEdit;
    y4: TEdit;
    w1: TEdit;
    w2: TEdit;
    w3: TEdit;
    w4: TEdit;
    res: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Panel1: TPanel;
    Image5: TImage;
    Memo2: TMemo;
    Memo3: TMemo;
    Button_Add0: TButton;
    Button_Add1: TButton;
    x1: TEdit;
    x2: TEdit;
    x3: TEdit;
    x4: TEdit;
    ButtonReset: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button_RandomWeights: TButton;
    StringGrid1: TStringGrid;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure DrawLinks();
    procedure NN_Input_X(Str: string);
    procedure NN_Calculate_Y();
    procedure NN_Random_W();
    procedure NN_Adapt_W();
    procedure NN_Calculate_Result();
    procedure NN_Teach();

    procedure Button_TeachClick(Sender: TObject);
    procedure Button_ExamClick(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure Button_Add0Click(Sender: TObject);
    procedure Button_Add1Click(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure Button_RandomWeightsClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  vec4i = array[0..3] of integer;     //receptori un neironi
  vec4f = array[0..3] of Single;      //svari
  structure = array[0..3,0..3] of integer; {saites starp neironiem un receptoriem}

var
  Form1: TForm1;
  x: vec4i;
  y: vec4i;
  w: vec4f;
  s: structure;
  r: integer;
  nClass0: integer =0;
  nClass1: integer =0;
  teta: real = 0.5;

const
  s1: structure = ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1));  // 1 receptor to 1 neuron
  s2: structure = ((1,1,-1,0),(-1,1,0,1),(1,-1,1,0),(1,0,-1,1)); //2 +receptors and 1 -receptor to neuron
  s3: structure = ((-1,1,1,-1),(-1,1,-1,+1),(-1,-1,1,1),(1,-1,-1,1));  // 2 +receptors and 2 -receptors to 1 neuron
  s4: structure = ((1,1,1,1),(1,1,1,1),(1,1,1,1),(1,1,1,1));  // 4 +receptors to 1 neuron



implementation

{$R *.dfm}

procedure TForm1.NN_Input_X(Str: string); //input x from memo lines
var i: integer;
begin
  for i:=0 to 3 do
    x[i]:=StrToInt(Str[i+1]);
end;

Procedure TForm1.NN_Calculate_Y();  //calculate y
var i,j,tmp :integer;
    St: String;
begin

  for j:=0 to 3 do
  begin
    St:='Y'+IntToStr(j+1)+' = X[ i ] '+chr(183)+' S[ i, j ] =';
    tmp:=0;
    for i:=0 to 3 do
      begin
        tmp:=tmp+x[i]*s[i,j];
        St:=St+ ' + '+IntToStr(x[i])+' '+chr(183)+' '+IntToStr(s[i,j]);
      end;
    St:= St+' - '+FloatToStrf(teta,fffixed,8,3);
    if (tmp-teta)>=0 then y[j]:=1 else y[j]:=0;
    St:=St+' => Y'+IntToStr(j+1)+' = '+intToStr(y[j]);
    Memo1.Lines.Add(St);
    TEdit(FindComponent('y'+IntToStr(j+1))).Text:=IntToStr(y[j])
  end;
end;

procedure TForm1.NN_Calculate_Result();
var i: integer;
    tmp: Single;
    Str: string;
begin
  tmp:=0;
  Str:='R = Y[ i ] '+chr(183)+' W[ i ] =';
  for i:=0 to 3 do
    begin
      tmp:=tmp+y[i]*w[i];
      Str:=Str+' + '+IntToStr(y[i])+' '+chr(183)+' ('+FloatToStrf(w[i],fffixed,8,3) + ')' ;
    end;
  if tmp>=0 then r:=1 else r:=0;
  if r=0 then res.Text:='0' else res.text:='1';
  Str:=Str+' = '+ FloatToStrf(tmp,fffixed,8,3)+' => R = '+IntToStr(r);
  Memo1.Lines.Add(Str);
end;

procedure TForm1.NN_Random_W(); //randomize weights
var i :integer;
begin
  Randomize;
  for i:=0 to 3 do
  begin
    w[i]:=2*Random -1;
    TEdit(FindComponent('w'+IntToStr(i+1))).Text:=FloatToStrf(w[i],fffixed,8,3);
  end;
end;

procedure TForm1.NN_Adapt_W();
var i: integer;
    Str: String;
begin
  for i:=0 to 3 do
  begin
    Str:='W'+IntToStr(i+1)+' = W[ i ] + Y[ i ] '+chr(183)+' (1 - 2 '+chr(183)+ 'R) = '+FloatToStrf(w[i],fffixed,8,3);
    w[i]:=w[i]+y[i]*(1-2*r);
    Str:=Str+' + '+IntToStr(y[i])+chr(183)+' (1 - 2 '+chr(183)+' '+IntToStr(R)+') = '+FloatToStrf(w[i],fffixed,8,3);
    Memo1.Lines.Add(Str);
    TEdit(FindComponent('w'+IntToStr(i+1))).Text:=FloatToStrf(w[i],fffixed,8,3);
  end;
end;

procedure TForm1.NN_Teach();
var i, j, err, iterations, currentClass: integer;
begin
   Memo1.Clear;
   iterations:=0;
   err:=1;
  while (err > 0) do
  begin
    inc(iterations);
    Memo1.Lines.Add('=====================================================');
    Memo1.Lines.Add('ITERATION: '+IntToStr(Iterations));
    err:=0;
    for i:=1 to nClass0+nClass1 do
    begin
      if i<=nClass0 then
        begin
          currentClass:=0;
          NN_Input_X(Memo2.Lines[i]);
          Memo1.Lines.Add('');
          Memo1.Lines.Add('---------------------------------------------------------------------------------------------');
          Memo1.Lines.Add('CURRENT CLASS = 0. OBJECT: "'+Memo2.Lines[i]+'"');
        end
      else
        begin
          currentClass:=1;
          NN_Input_X(Memo3.Lines[i-nClass0]);
          Memo1.Lines.Add('');
          Memo1.Lines.Add('---------------------------------------------------------------------------------------------');
          Memo1.Lines.Add('CURRENT CLASS = 1. OBJECT: "'+Memo3.Lines[i-nClass0]+'"');
        end;
      NN_Calculate_Y;
      Memo1.Lines.Add('W[ i ] = ('
                        +FloatToStrf(w[0],fffixed,8,3)+'), ('
                        +FloatToStrf(w[1],fffixed,8,3)+'), ('
                        +FloatToStrf(w[2],fffixed,8,3)+'), ('
                        +FloatToStrf(w[3],fffixed,8,3)+')');
      NN_Calculate_Result;
      if not (currentClass=r) then
      begin
        Memo1.Lines.Add('ERROR! RESULT R DOES NOT MATCH CURRENT CLASS!');
        Memo1.Lines.Add('');
        Memo1.Lines.Add('ADAPTING WEIGHTS: ');
        NN_Adapt_W;
        err:=err+1;

      end
      else Memo1.Lines.Add('OK, RESULT R MATCHES CURRENT CLASS.');
    end;
    Memo1.Lines.Add('Total errors: '+IntToStr(err));
    Memo1.Lines.Add('');
    if (iterations>10) and (err <> 0) then err:=0;
  end;
  if (iterations>10) then Memo1.Lines.Add('Failed to Teach!')
    else Memo1.Lines.Add('Taught in '+IntToStr(iterations)+' iterations!')
end;

procedure TForm1.DrawLinks();
var i,j: integer;
begin
  Image1.Picture.Bitmap:=nil;
  Image1.Canvas.Pen.Color:=clRed;
  for i:=0 to 3 do
  begin
    Image2.Canvas.MoveTo(0,12+32*i);
    Image2.Canvas.LineTo(Image1.Width,12+32*i);
    Image3.Canvas.MoveTo(0,12+32*i);
    Image3.Canvas.LineTo(Image1.Width,12+48);
    for j:=0 to 3 do
      begin
        StringGrid1.Cells[0,j+1]:='X'+IntToStr(j+1);
        StringGrid1.Cells[i+1,0]:='Y'+IntToStr(i+1);
        StringGrid1.Cells[i+1,j+1]:=IntToStr(S[j,i]);
        if not (s[i,j]=0) then
          begin
            if s[i,j]<0 then Image1.Canvas.Pen.Color:=clBlue
            else Image1.Canvas.Pen.Color:=clRed;
            Image1.Canvas.MoveTo(0,12+32*i);
            Image1.Canvas.LineTo(Image1.Width,12+32*j);
          end;
      end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
Var i,j:integer;
begin
  s:=s1;
  DrawLinks;
  NN_Random_W;

end;

procedure TForm1.Button_TeachClick(Sender: TObject);
var i: integer;
begin
  If (Memo2.Lines[1]='') or (Memo3.Lines[1]='') then
  Memo1.Lines.Add('Please prepare teaching set correctly!')
  else
  begin
  NN_Teach;
  for i:=0 to 3 do x[i]:=0;
  end;
end;

procedure TForm1.Button_ExamClick(Sender: TObject);
begin
  NN_Calculate_Y;
  NN_Calculate_Result;
  if r=0 then Image5.Picture.Bitmap.LoadFromFile('img/result0.bmp');
  if r=1 then Image5.Picture.Bitmap.LoadFromFile('img/result1.bmp');
end;

procedure TForm1.SpeedButtonClick(Sender: TObject);
begin
   If TSpeedButton(Sender).Down then
    begin
      x[StrToInt(TSpeedButton(Sender).Name[Length(TSpeedButton(Sender).Name)])-1]:=1;
      TEdit(FindComponent('x'+TSpeedButton(Sender).Name[Length(TSpeedButton(Sender).Name)])).Text:='1';
    end
  else
    begin
      x[StrToInt(TSpeedButton(Sender).Name[Length(TSpeedButton(Sender).Name)])-1]:=0;
      TEdit(FindComponent('x'+TSpeedButton(Sender).Name[Length(TSpeedButton(Sender).Name)])).Text:='0';
    end;
end;

procedure TForm1.Button_Add0Click(Sender: TObject);
var i: integer;
begin
  Memo2.Lines.Add(IntToStr(x[0])+IntToStr(x[1])+IntToStr(x[2])+IntToStr(x[3]));
  inc(nClass0);
  for i:=1 to 4  do
    begin
    TSpeedButton(FindComponent('SpeedButton'+IntToStr(i))).Down:=false;
    TEdit(FindComponent('x'+IntToStr(i))).Text:='0';
    x[i-1]:=0;
    end;
end;

procedure TForm1.Button_Add1Click(Sender: TObject);
var i: integer;
begin
  Memo3.Lines.Add(IntToStr(x[0])+IntToStr(x[1])+IntToStr(x[2])+IntToStr(x[3]));
  inc(nClass1);
  for i:=1 to 4  do
    begin
    TSpeedButton(FindComponent('SpeedButton'+IntToStr(i))).Down:=false;
    TEdit(FindComponent('x'+IntToStr(i))).Text:='0';
    x[i-1]:=0;
    end;
end;

procedure TForm1.ButtonResetClick(Sender: TObject);
begin
  Memo2.Clear;
  Memo2.Lines.Add('Class 0. Ball.');
  Memo3.Clear;
  Memo3.Lines.Add('Class 1. Cube.');
  Memo1.Clear;
  nClass0:=0;
  nClass1:=0;
  NN_Random_W;
end;

procedure TForm1.Button_RandomWeightsClick(Sender: TObject);
begin
  NN_Random_W;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
  0:  s:=s1;
  1:  s:=s2;
  2:  s:=s3;
  3:  s:=s4;
  end;
  DrawLinks;
end;

end.
