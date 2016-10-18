 Program Darbsarmasiviem;
 uses crt;
 const n=5; m=n*(n+1) div 2;
 type
 Matrix=array[1..n,1..n] of integer;
 Vector=array[1..m] of integer;
 var
 A:Matrix;
 B:Vector;
 tkey: integer;
 i,j,k,X:integer;
 go_on: boolean;

 Procedure AMF(i:integer);
 const lo=1; hi=m; L=2; v=1000;
 var C1, C0:integer;
 begin
 C1:=L;
 C0:=v-L*lo;
 Writeln('addr(A[',i,'])=',C0+C1*i);
 end;

 begin
 clrscr;
 for i:=1 to n do begin
 for j:=1 to n do
 Randomize;
 writeln('Informacija par autoru');
 writeln('DITF');
 writeln('RDB10 1.kurss 1.grupa');
 writeln('Danilova Ksenija');
 writeln('6.variants - Augshejas trissturmatrica 5x5');
 writeln('Matrica uzgemereejas automatiski');
 writeln;
 for i:=1 to n do
     for j:=1 to n do  if i<=j then   A[i,j]:=random(100);
writeln('Matrix A');
  randomize;
  for i:=1 to n do begin
    for j:=1 to n do
      write(A[i,j]:3);
      writeln;
    end;

    end;
    writeln;
 k:=1;
 for i:=1 to n do
 for j:=1 to n do begin
 if i<=j then begin
 B[k]:=A[i,j];
 k:=k+1;
 end;
 end;
 writeln;
 writeln('Vector B');
 for k:=1 to m do
 write(B[k]:3);
 writeln;
 writeln;
 writeln('Searching process:');
 go_on:=false;
 writeln;
 writeln('Enter search key');
 readln(tkey);
 for k:=1 to m do
 if B[k]=tkey then
 begin
 writeln(tkey,' in position',k); go_on:=true;
 end;
 if not go_on then
 writeln('Unsuccesfull search');
 writeln('Adress Maping Function:');
 for k:=1 to m do AMF(k);
 readkey;
end.