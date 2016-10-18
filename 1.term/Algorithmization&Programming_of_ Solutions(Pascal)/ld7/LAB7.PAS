        {   Laboratijas darbs #7  }

{ Funkcijas vertibu atrasana pec izvirzijuma rinda }
{                                -x                   }
{Rekinam funkcijas y= ln(2+x)                     }
{Vertibas diapazona  -1 ... 1 ar soli 0.1            }

Program  RINDA;
var X, S, Y, A : real;
    k : integer;
begin
writeln(' Rekinam funkcijas y=ln(2+x)       ');
writeln(' Vertibas diapazona  -1 ... 1 ar soli 0.1 ');
writeln('  x            Rinda      Standartfunkcija    Loc. skaits rindaa');

   x:= -1.0;
   while x< 1.05 do
   begin
      S:=Ln(2)+0.5*x;
      A:= 0.5*x;
     k:=2;
      while ABS (A)> 0.000001 do
      begin
         A:=-A*x*(k-1)/(k*2);
         S:=S+A;
         k:=k+1;
      End;
      y:=Ln(2+x);
      writeln(x:6:2, S:18:6, Y:18:6, k:12);
      x:=x+0.1;
   End;
End.

