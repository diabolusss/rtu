unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    btn1: TButton;
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    btn2: TButton;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    Label1: TLabel;
    procedure strngrd1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure GameEnd();
    procedure ComVCom();
    procedure ComRandMove();
    Procedure Delay(mSec:Cardinal);
    procedure btn1Click(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  move_nr: Integer;
  plvspl,comvscom,plvscom: Boolean;
  player_first,finish: Boolean;
  pl1won,pl2won:Boolean;
  ch: Char;

implementation

{$R *.dfm}

procedure TForm1.strngrd1KeyPress(Sender: TObject; var Key: Char);
var ok: Boolean;
begin
  ok:=False;
  with TStringGrid(Sender) do
  begin
    if not (key in ['q','w','e','a','s','d','z','x','c','Q','W','E','A','S','D','Z','X','C']) then
    begin
      key:=#0;
    end
    else
    begin

      if (plvspl) and (move_nr mod 2 = 1)then
        ch:='X'
      else if (plvspl) and (move_nr mod 2 = 0)then
        ch:='O';

      if (plvscom) and (move_nr mod 2 = 1)then
        ch:='X'
      else if (plvscom) and (move_nr mod 2 = 0)then
        ch:='O';
      
      with strngrd1 do
      begin
        if(Key='q') and (strngrd1.Cells[0,0]='') or (Key='Q') and (strngrd1.Cells[0,0]='')then
        begin
          strngrd1.Cells[0,0]:=' ' + ch;
          ok:=True;
        end
        else if(Key='w') and (strngrd1.Cells[1,0]='') or (Key='W') and (strngrd1.Cells[1,0]='')then
        begin
          strngrd1.Cells[1,0]:=' ' + ch;
          ok:=True;
        end
        else if(Key='e') and (strngrd1.Cells[2,0]='') or (Key='E') and (strngrd1.Cells[2,0]='')then
        begin
          strngrd1.Cells[2,0]:=' ' + ch;
          ok:=True;
        end
        else if(Key='a') and (strngrd1.Cells[0,1]='') or (Key='A') and (strngrd1.Cells[0,1]='')then
        begin
           strngrd1.Cells[0,1]:=' ' + ch;
           ok:=True;
        end
        else if(Key='s') and (strngrd1.Cells[1,1]='') or (Key='S') and (strngrd1.Cells[1,1]='')then
        begin
          strngrd1.Cells[1,1]:=' ' + ch;
          ok:=True;
        end
        else if(Key='d') and (strngrd1.Cells[2,1]='') or (Key='D') and (strngrd1.Cells[2,1]='')then
        begin
          strngrd1.Cells[2,1]:=' ' + ch;
          ok:=True;
        end
        else if(Key='z')  and (strngrd1.Cells[0,2]='') or (Key='Z') and (strngrd1.Cells[0,2]='')then
        begin
          strngrd1.Cells[0,2]:=' ' + ch;
          ok:=True;
        end
        else if(Key='x') and (strngrd1.Cells[1,2]='') or (Key='X') and (strngrd1.Cells[1,2]='')then
        begin
          strngrd1.Cells[1,2]:=' ' + ch;
          ok:=True;
        end
        else if(Key='c') and (strngrd1.Cells[2,2]='') or (Key='C') and (strngrd1.Cells[2,2]='')then
        begin
          strngrd1.Cells[2,2]:=' ' + ch;
          ok:=True;
        end;
      end;
      GameEnd;

      if(pl1won) or (pl2won) then
        finish:=True;

      if(ok) and (plvscom) and not(finish)then
      begin
        Inc(move_nr);
        ComRandMove;
      end;

      if(ok) and (plvspl)then
        Inc(move_nr);

      GameEnd;
    end;
  end;
end;

procedure TForm1.GameEnd();
var i,j:Integer;
    mdigx, supdigx, horx, verx: Integer;
    mdigo, supdigo, horo, vero: Integer;
    filled: Integer;
begin
  pl1won:=False;
  pl2won:=False;
  filled:=0;
  for i:=0 to 2 do
  begin
    horx:=0;
    horo:=0;
    verx:=0;
    vero:=0;
    for j:=0 to 2 do
    begin
      if not (strngrd1.Cells[i,j]='') then
        Inc(filled);

      if(strngrd1.Cells[i,j]=' X')then
        Inc(verx);
      if(strngrd1.Cells[i,j]=' O')then
        Inc(vero);
      if(strngrd1.Cells[j,i]=' X')then
        Inc(horx);
      if(strngrd1.Cells[j,i]=' O')then
        Inc(horo);

      if(verx=3) or (horx=3)then
      begin
        strngrd1.Enabled:=False;
        edt1.Font.Color:=clGreen;
        edt1.Text:='Player 1 won! Congratulations!';
        pl1won:=True;
      end;
      if(vero=3) or (horo=3)then
      begin
        strngrd1.Enabled:=False;
        edt1.Font.Color:=clRed;
        edt1.Text:='Player 2 won! Congratulations!';
        pl2won:=True;
      end;
    end;
  end;

  mdigx:=0;
  supdigx:=0;
  mdigo:=0;
  supdigo:=0;
  for i:=0 to 2 do
  begin
    if(strngrd1.Cells[i,i]=' X')then
      Inc(mdigx);
    if(strngrd1.Cells[i,i]=' O')then
      Inc(mdigo);
    if(strngrd1.Cells[i,2-i]=' X')then
      Inc(supdigx);
    if(strngrd1.Cells[i,2-i]=' O')then
      Inc(supdigo);
  end;
  edt2.Text:=IntToStr(mdigx);
  edt3.Text:=IntToStr(mdigo);
  edt4.Text:=IntToStr(supdigx);
  edt5.Text:=IntToStr(supdigo);
  if(mdigx=3) or (supdigx=3)then
  begin
    strngrd1.Enabled:=False;
    edt1.Font.Color:=clGreen;
    edt1.Text:='Player 1 won! Congratulations!';
    pl1won:=True;
  end;
  if(mdigo=3) or (supdigo=3)then
  begin
    strngrd1.Enabled:=False;
    edt1.Font.Color:=clRed;
    edt1.Text:='Player 2 won! Congratulations!';
    pl2won:=True;
  end;

  if(filled=9) and not (pl1won) and not (pl2won) then
  begin
    strngrd1.Enabled:=False;
    edt1.Font.Color:=clBlue;
    edt1.Text:='The game is tied!';
    finish:=True;
  end;
end;

procedure TForm1.ComVCom();
var i,j: Integer;
    ch:Char;
begin
  Randomize;

  if (move_nr mod 2 = 1)then
    ch:='X'
  else if (move_nr mod 2 = 0)then
    ch:='O';

  {strngrd1.Cells[1,1]:=' ' + ch;
  Inc(move_nr);}

  while not(finish)do
  begin
    i:=Random(3);
    j:=Random(3);
    while not (strngrd1.Cells[i,j]='')do
    begin
      i:=Random(3);
      j:=Random(3);
    end;

    if (move_nr mod 2 = 1)then
      ch:='X'
    else if (move_nr mod 2 = 0)then
      ch:='O';
    strngrd1.Cells[i,j]:=' ' + ch;

    Inc(move_nr);
    GameEnd;

    if(pl1won) or (pl2won) then
      finish:=True;

    Delay(1000);
  end;
end;

procedure TForm1.ComRandMove();
var i,j:Integer;
begin
  Randomize;

  i:=Random(3);
  j:=Random(3);
  while not (strngrd1.Cells[i,j]='')do
  begin
    i:=Random(3);
    j:=Random(3);
  end;

  if (move_nr mod 2 = 1)then
    ch:='X'
  else if (move_nr mod 2 = 0)then
    ch:='O';
  strngrd1.Cells[i,j]:=' ' + ch;

  Inc(move_nr);
  GameEnd;
end;

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
begin
  move_nr:=0;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if(rg1.ItemIndex=0)then
    plvspl:=True
  else if(rg1.ItemIndex=1)then
  begin
    if(rg2.ItemIndex=0)then
    begin
      ch:='X';
      player_first:=True;
    end
    else
    begin
      ch:='O';
      player_first:=False;
    end;

    plvscom:=True;
  end  
  else if(rg1.ItemIndex=2)then
    comvscom:=True;

  move_nr:=1;
  strngrd1.Enabled:=True;
  strngrd1.SetFocus;
  rg1.Enabled:=False;
  rg2.Enabled:=False;
  btn1.Enabled:=False;
  edt1.Font.Color:=clBlack;
  edt1.Text:='Game is going';

  if(comvscom)then
  begin
    ComVCom;
  end;

  if(plvscom) and not(player_first)then
  begin
    ComRandMove();
  end;
end;

procedure TForm1.rg1Click(Sender: TObject);
begin
  if(rg1.ItemIndex=1)then
    rg2.Enabled:=True
  else
    rg2.Enabled:=False;
end;

procedure TForm1.btn2Click(Sender: TObject);
var i: Integer;
begin
  for i:=0 to 2 do
    strngrd1.Rows[i].Clear;

  plvspl:=False;
  comvscom:=False;
  plvscom:=False;
  player_first:=False;
  strngrd1.Enabled:=False;
  rg1.Enabled:=True;
  rg1.ItemIndex:=1;
  rg2.Enabled:=True;
  btn1.Enabled:=True;
  pl1won:=False;
  pl2won:=False;
  finish:=False;
  edt1.Font.Color:=clBlack;
  edt1.Text:='Game not started';
  move_nr:=1;
end;

end.
