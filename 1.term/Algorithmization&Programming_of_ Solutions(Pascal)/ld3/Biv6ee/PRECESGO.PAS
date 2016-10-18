Program preces;

Uses Crt;
Var N, a,i,j,m,l,k: Integer;

Begin

  ClrScr;
  i:=0;   m:=0;   l:=0;    k:=0;    j:=0;

  Writeln('Vvedite stoimostj tovara');
  Readln(N);
  Writeln('Avtomat prinimaet toljko 100 Ls i 50 Ls');

  While (N>=100) do begin
    N:=N-100;
    i:=i+1;
  End;

  If ((N<100) and (N>=50)) then begin
    N:=N-50;
    j:=j+1;
  End;

  If ((N<50) and (N>0)) then begin
    a:=50-N;
    j:=j+1;
  End;

  Writeln('Powaluista, dajte avtomatu ',i ,' kupjur po 100 Ls i ',j,' kupjur po 50 Ls');

    If N=0 then
      Writeln('Spasibo za pokupku!')
    Else begin
      While (a>=20) do begin
        a:=a-20;
        m:=m+1;
      end;
      If ((a<20) and (a>=10)) then begin
        a:=a-10;
        l:=l+1;
      end;
      If ((a<10) and (a>=5)) then begin
        a:=a-5;
        k:=k+1;
        Writeln('Va6a sda4a: ',m,' kupjur po 20 Ls ',l,' kupjur po 10 Ls ',k,' kupjur po 5 Ls');
     End;
     If a<5 then
     Writeln(a,' Ls vi podarili firme!');
 End;
End.