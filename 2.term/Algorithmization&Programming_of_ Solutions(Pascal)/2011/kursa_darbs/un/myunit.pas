unit MyUnit;

interface

uses CRT, DOS;

procedure ShowCursor;
procedure HideCursor;
function StrCmp( S1, S2 : String ) : Integer;
procedure InputData( var S : String; Mode : Integer; Size : Byte; Hint, AfterHint : String );

implementation

procedure ShowCursor;
var
  regs : registers;
begin
  regs.ax := $0100;
  regs.cx := $0506;
  intr($10, regs);
end;

procedure HideCursor;
var
  regs : registers;
begin
  regs.ax := $0100;
  regs.cx := $2607;
  intr($10, regs);
end;

function StrCmp( S1, S2 : String ) : Integer;
         {1=>S1>S2 0=>S1=S2 -1=>S1<S2  }
Var I : Integer;
begin
  For I:=1 to length(S1) do
    S1[I]:=Upcase(S1[I]);
  For I:=1 to length(S2) do
    S2[I]:=Upcase(S2[I]);
  If S1>S2 then StrCmp:=1
  Else
    If S1=S2 then StrCmp:=0
    Else          StrCmp:=-1;
end;

procedure InputData( var S : String; Mode : Integer; Size : Byte; Hint, AfterHint : String );
{nodrosina datu ievadi un aizsardzibu pret kludam}
{Mode = 1 - burti
        2 - cipari
        3 - datums}
var
  I : Integer;
  Ch : Char;
  X, Y :Integer;
begin
  S:='';
  For I:=1 to Size do S:=S+' ';
  Write(Hint+' ');
  X:=WhereX;   Y:=WhereY;
  GotoXY(X+Size+1, Y );    Write(AfterHint);
 
  
  GotoXY(X,Y);             Write(S);
  GotoXY(X,Y);
  ShowCursor;
  I:=0;
  Case Mode of
   1,2: begin
          Repeat
            If Mode=1 then
               Repeat
                 Ch:=ReadKey;
               Until( Ch in ['A'..'Z', 'a'..'z', #13, #8] )
            Else
               Repeat
                 Ch:=ReadKey;
               Until( Ch in ['0'..'9', #13, #8, '.'] );
            Case Ch of
              #8: begin
                    If I<1 then Write(#7)
                    Else
                     begin
                       Dec(I);
                       GotoXY( WhereX-1, WhereY );
                       Write(' ');
                       GotoXY( WhereX-1, WhereY );
                     end;
                   end;
              #13: begin
                     {nothing}
                   end;
              Else
                  begin
                    If I>=Size then Write(#7)
                    Else
                    begin
                      Inc(I);
                      Write( Ch );
                      S[I]:=Ch;
                    end;
                  end;
            end;{case}
          Until( Ch =#13 );
        end;{ of Mode=1,2}
     3: begin
          Repeat
            Repeat
              Ch:=ReadKey;
            Until( Ch in ['0'..'9', #13, #8] );
            Case Ch of
              #8: begin
                    If I<1 then Write(#7)
                    Else
                     begin
                       Dec(I);
                       GotoXY( WhereX-1, WhereY );
                       Write(' ');
                       GotoXY( WhereX-1, WhereY );
                     end;
                    If (I=2) or (I=5) then
                     begin
                       Dec(I);
                       GotoXY( WhereX-1, WhereY );
                       Write(' ');
                       GotoXY( WhereX-1, WhereY );
                     end;
                   end;
              #13: begin
                     {nothing}
                   end;
              Else
                  begin
                    If I>=Size then Write(#7)
                    Else
                    begin
                      Inc(I);
                      Write( Ch );
                      S[I]:=Ch;
                    end;
                    If (I=2) or (I=5) then
                     begin
                      Inc(I);
                      Write( '.' );
                      S[I]:='.';
                     end;
                  end;
            end;{case}
          Until( Ch =#13 );
        end;{ of Mode=3}
   end;{ of All Mode}
  s:=copy(s,1,i);
  TextColor(white);
  TextBackground(black);
end;


begin

end.