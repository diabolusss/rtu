Program preces_cena;
  Var N,C,B,A,S:Integer; 
Begin
  Repeat
    Writeln('Vvedite cenu tovara');
    Readln(N);
  Until(N>0);
  If N<=100 then begin
    Writeln('Vvedite summu, kotoruju daete prodavcu(u vas estj 100 ili 50 Ls)');
    Repeat
      Readln(C);
    Until(((C=50) or (C=100)) and (C>N));
  End
  Else begin
    Writeln('Vvedite summu, kotoruju daete prodavcu(u vas neskoljko 100 i 50)');
    Repeat
      Readln(C);
    Until((C>=N) and (C mod 50 = 0));
  End;
  B:=C-N;
  If (B mod 5 = 0) then
    Writeln('Va6a sda4a - ',B,' Ls')
  Else begin
      A:=B mod 5;
      A:=5-A;
      S:=A+B;
    Writeln('Doplatite, powalujsta ',A,' Ls');    
    Writeln('Va6a sda4a - ',S,' Ls');
  End;
End.