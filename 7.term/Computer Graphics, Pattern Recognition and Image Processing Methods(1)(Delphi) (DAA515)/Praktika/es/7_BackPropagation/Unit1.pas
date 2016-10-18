unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, Math, ExtCtrls;

const
  layer_count = 3;
  n_count = 60;

type
  TNeuron = record
     value: single;
     error: single;
     outputWeights: array of single;
  end;
  TLayer = record
     layer: array of TNeuron;
     numberOfNeurons: integer;
  end;
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    edt1: TEdit;
    lbl1: TLabel;
    mmo1: TMemo;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb3: TSpeedButton;
    sb4: TSpeedButton;
    sb5: TSpeedButton;
    sb6: TSpeedButton;
    sb7: TSpeedButton;
    sb8: TSpeedButton;
    sb9: TSpeedButton;
    sb10: TSpeedButton;
    strngrd3: TStringGrid;
    strngrd4: TStringGrid;
    strngrd5: TStringGrid;
    strngrd6: TStringGrid;
    edt2: TEdit;
    lbl2: TLabel;
    btn15: TButton;
    txt1: TStaticText;
    txt2: TStaticText;
    edt3: TEdit;
    lbl3: TLabel;
    edt4: TEdit;
    txt3: TStaticText;
    procedure NN_Initialize();
    procedure NN_Random_W();
    procedure NN_Input_X();
    function NN_Activation_Function(input: real):real;
    function NN_Summator(whichLayer, whichNeuron:integer):real;
    procedure NN_Calculate_Neuron_Layer(whichLayer: integer);
    procedure NN_Calculate_Errors();
    procedure NN_Adapt_Weights();
    procedure NN_Teach();
    procedure Load_Images();
    procedure FormCreate(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure sb1Click(Sender: TObject);
    procedure sb2Click(Sender: TObject);
    procedure sb3Click(Sender: TObject);
    procedure sb4Click(Sender: TObject);
    procedure sb5Click(Sender: TObject);
    procedure sb6Click(Sender: TObject);
    procedure sb7Click(Sender: TObject);
    procedure sb8Click(Sender: TObject);
    procedure sb9Click(Sender: TObject);
    procedure sb10Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  NN: array[0..layer_count] of TLayer;
  nClass1, nClass2, currentClass: Integer;
  TS: Boolean;

implementation

{$R *.dfm}

procedure TForm1.NN_Initialize;
var i,j: integer;
begin
  for i:=0 to High(NN) do
  begin
    if i<High(NN) then NN[i].numberOfNeurons:=n_count else NN[i].numberOfNeurons:=1;
    SetLength(NN[i].layer, NN[i].numberOfNeurons);
  end;

  for i:=0 to High(NN) do
  begin
    for j:=0 to NN[i].numberOfNeurons-1 do
    begin
      with NN[i].layer[j] do
      begin
        value:=0;
        if i<High(NN) then setLength(outputWeights, NN[i+1].numberOfNeurons);
      end;
    end;
  end;
end;

procedure TForm1.NN_Random_W();
var i,j,k,m :integer;
begin
  Randomize;
  m:=0;
  for i:=0 to layer_count-1 do
  begin
    m:=m+2;
    for j:=0 to n_count-1 do
    begin
      for k:=0 to NN[i+1].numberOfNeurons-1 do
      begin
        NN[i].layer[j].outputWeights[k]:=1-2*Random;
        TStringGrid(FindComponent('strngrd'+IntToStr(m))).Cells[k+1,j+1]:=FloatToStr(NN[i].layer[j].outputWeights[k]);
      end;
    end;
  end;
end;

procedure TForm1.NN_Input_X();
var sb,i,j:Integer;
begin
  for sb:=1 to nClass1+nClass2 do
  begin
    if (TSpeedButton(FindComponent('sb'+IntToStr(sb))).Down) then
    begin
      if sb<=nClass1 then currentClass:=0 else currentClass:=1;
      for i:=0 to 5 do
      begin
        for j:=0 to 9 do
        begin
          if TSpeedButton(FindComponent('sb'+IntToStr(sb))).Glyph.Canvas.Pixels[i,j]=clBlack then NN[0].layer[i+6*j].value:=1
          else NN[0].layer[i+6*j].value:=0;
        end;
      end;
    end;
  end;

  for i:=0 to n_count-1 do
  begin
    strngrd1.Cells[1,i+1]:=FloatToStr(NN[0].layer[i].value);
  end;
end;

function TForm1.NN_Summator(whichLayer, whichNeuron:integer):real;
var i:Integer;
var sum: Real;
begin
  sum:=0;
  for i:=0 to n_count-1 do
  begin
    sum:=sum + (NN[whichLayer-1].layer[i].value * NN[whichLayer-1].layer[i].outputWeights[whichNeuron]);
  end;
  NN_Summator:=sum;
end;

function TForm1.NN_Activation_Function(input: real):real;
begin
  NN_Activation_Function:=1/(1+Exp(-input));
end;

procedure TForm1.NN_Calculate_Neuron_Layer(whichLayer: integer);
var sum,val : Real;
var i: Integer;
begin
  if(whichLayer=layer_count) then
  begin
    sum:=NN_Summator(whichLayer,0);
    val:=NN_Activation_Function(sum);
    NN[whichLayer].layer[0].value:=val;
  end
  else
  begin
    for i:=0 to n_count-1 do
    begin
      sum:=NN_Summator(whichLayer,i);
      val:=NN_Activation_Function(sum);
      NN[whichLayer].layer[i].value:=val;
    end;
  end;
end;

procedure TForm1.NN_Calculate_Errors();
var i,j,k:Integer;
var temp,err_final,err: Real;
begin
  temp:=NN[layer_count].layer[0].value;
  err_final:=(currentClass-temp)*temp*(1 - temp);
  NN[layer_count].layer[0].error:=err_final;
  edt3.Text:=FloatToStr(err_final);

  for i:=0 to n_count-1 do
  begin
    temp:=err_final * NN[layer_count-1].layer[i].outputWeights[0];
    err:=NN[layer_count-1].layer[i].value * (1 - NN[layer_count-1].layer[i].value) * temp;
    NN[layer_count-1].layer[i].error:=err;
  end;

  temp:=0;
  for i:=layer_count-2 to 1 do
  begin
    for k:=0 to NN[i+1].numberOfNeurons-1 do
    begin
      for j:=0 to n_count-1 do
      begin
        temp:=temp + (NN[i+1].layer[k].error * NN[i].layer[j].outputWeights[k]);
      end;
      err:=NN[i].layer[k].value * (1 - NN[i].layer[k].value) * temp;
      NN[i].layer[k].error:=err;
    end;
  end;
end;

procedure TForm1.NN_Adapt_Weights();
var i,j,k:Integer;
var new_weight,n: Real;
begin
  n:=StrToFloat(edt4.Text);
  for i:=0 to layer_count-1 do
  begin
    for j:=0 to n_count-1 do
    begin
      for k:=0 to NN[i+1].numberOfNeurons-1 do
      begin
        new_weight:=NN[i].layer[j].outputWeights[k] + (n * NN[i].layer[j].value * NN[i+1].layer[k].error);
        NN[i].layer[j].outputWeights[k]:=new_weight;
      end;
    end;
  end;
end;

procedure TForm1.NN_Teach();
var i,j,itterations,error: Integer;
begin
  mmo1.Clear;
  itterations:=0;
  error:=1;
  while (error>0) do
  begin
    inc(itterations);
    error:=0;
    for i:=1 to 10 do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(i))).Down:=True;
      NN_Input_X;
      for j:=1 to layer_count do NN_Calculate_Neuron_Layer(j);
      NN_Calculate_Errors;

      if currentClass=0 then
      begin
        if (NN[3].layer[0].value>0.1) then
        begin
          NN_Adapt_Weights;
          inc(error);
        end;
      end
      else
      begin
        if (NN[3].layer[0].value<0.9) then
        begin
          NN_Adapt_Weights;
          inc(error);
        end;
      end;
    end;
    if(itterations>1000) and (error>0) then error:=0;
  end;
  mmo1.Lines[0]:='Info:';
  mmo1.Lines.Add('Neural Network was trained');
  mmo1.Lines.Add('in ' + IntToStr(itterations) + ' itterations');
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:Integer;
begin
  with strngrd1 do
  begin
    Cells[0,0]:='L0';
    Cells[1,0]:='VAL';
    for i:=1 to 60 do
    begin
      Cells[0,i]:='X' + IntToStr(i);
    end;
  end;

  with strngrd2 do
  begin
    Cells[0,0]:='L0-L1';
    for i:=1 to 60 do
    begin
      Cells[i,0]:='Y' + IntToStr(i);
      Cells[0,i]:='X' + IntToStr(i);
    end;
  end;

  with strngrd3 do
  begin
    Cells[0,0]:='L2';
    Cells[1,0]:='OUT';
    Cells[2,0]:='ERR';
    for i:=1 to 60 do
    begin
      Cells[0,i]:='Y' + IntToStr(i);
    end;
  end;

  with strngrd4 do
  begin
    Cells[0,0]:='L1-L2';
    for i:=1 to 60 do
    begin
      Cells[i,0]:='Z' + IntToStr(i);
      Cells[0,i]:='Y' + IntToStr(i);
    end;
  end;

  with strngrd5 do
  begin
    Cells[0,0]:='L2';
    Cells[1,0]:='OUT';
    Cells[2,0]:='ERR';
    for i:=1 to 60 do
    begin
      Cells[0,i]:='Z' + IntToStr(i);
    end;
  end;

  with strngrd6 do
  begin
    Cells[0,0]:='L2-L3';
    Cells[1,0]:='R';
    for i:=1 to 60 do
    begin
      Cells[0,i]:='Z' + IntToStr(i);
    end;
  end;

  for i:=1 to 10 do TSpeedButton(FindComponent('sb'+IntToStr(i))).Enabled:=False;

  NN_Initialize;
  NN_Random_W;
end;

procedure TForm1.btn15Click(Sender: TObject);
begin
  NN_Random_W;
end;

procedure TForm1.Load_Images();
var i:integer;
begin
  nClass1:=0;
  nClass2:=0;
  if(TS=True)then
  begin
    i:=1;
    while i<=nClass1 + nClass2 do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(i))).Destroy;
      inc(i);
    end;
    
    i:=1;
    while fileexists('apm_izlase/c'+IntTOStr(i)+'.bmp')  do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(i))).Glyph.LoadFromFile('apm_izlase/c'+IntToStr(i)+'.bmp');
      nClass1:=i;
      inc(i);
    end;

    i:=1;
    while fileexists('apm_izlase/g'+IntTOStr(i)+'.bmp')  do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(nClass1+i))).Glyph.LoadFromFile('apm_izlase/g'+IntToStr(i)+'.bmp');
      nClass2:=i;
      inc(i);
    end;
  end
  else
  begin
    i:=1;
    while i<=nClass1 + nClass2 do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(i))).Destroy;
      inc(i);
    end;

    i:=1;
    while fileexists('eksamens/c'+IntTOStr(i)+'.bmp')  do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(i))).Glyph.LoadFromFile('eksamens/c'+IntToStr(i)+'.bmp');
      nClass1:=i;
      inc(i);
    end;

    i:=1;
    while fileexists('eksamens/g'+IntTOStr(i)+'.bmp')  do
    begin
      TSpeedButton(FindComponent('sb'+IntToStr(nClass1+i))).Glyph.LoadFromFile('eksamens/g'+IntToStr(i)+'.bmp');
      nClass2:=i;
      inc(i);
    end;
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var i: Integer;
begin
  TS:=True;
  for i:=1 to 10 do TSpeedButton(FindComponent('sb'+IntToStr(i))).Enabled:=True;
  Load_Images;
end;

procedure TForm1.btn2Click(Sender: TObject);
var i: Integer;
begin
  TS:=False;
  for i:=1 to 10 do TSpeedButton(FindComponent('sb'+IntToStr(i))).Enabled:=True;
  Load_Images;
end;

procedure TForm1.sb1Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb2Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb3Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb4Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb5Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb6Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb7Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb8Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb9Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.sb10Click(Sender: TObject);
begin
  NN_Input_X;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  NN_Teach();
end;

procedure TForm1.btn4Click(Sender: TObject);
var i: Integer;
begin
  NN_Calculate_Neuron_Layer(1);

  for i:=0 to n_count-1 do
  begin
    strngrd3.Cells[1,i+1]:=FloatToStr(NN[1].layer[i].value);
  end;

  NN_Calculate_Neuron_Layer(2);

  for i:=0 to n_count-1 do
  begin
    strngrd5.Cells[1,i+1]:=FloatToStr(NN[2].layer[i].value);
  end;

  NN_Calculate_Neuron_Layer(3);

  edt2.Text:=FloatToStr(NN[3].layer[0].value);
end;

end.
