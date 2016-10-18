Program pr;
{array processing}
uses crt;
const   n=5; m=n*(n+1);
        type   	 Matrix=array[1..n,1..n] of integer;
	         Vector= array  [1..m]  of  integer;
        var     B: Vector;
		A: Matrix;
		tkey,max: integer;  {search key}
		i,j,k: integer;
		go_on: boolean;

 Procedure AMF(i:integer);
 const lo=1; hi=m; L=2; sakuma=1000;
 var C1,C0:integer;
 begin
 C1:=L;
 C0:=sakuma-L*lo;
 Writeln('addr(A[',i,'])=',C0+C1*i);
 end;

begin
clrscr;
       for i:=1 to n do begin
  	   for j:=1 to n do
		A[i,j]:=0;
A[1,3]:=6;A[2,1]:=2;A[2,5]:=4;A[3,1]:=7;A[3,3]:=6;A[4,3]:=9;A[4,4]:=8;A[5,2]:=3;A[5,5]:=5;

Randomize;
	writeln('Informacija par autoru:');
	writeln('Vards,Uzvards: ');
  Writeln('DITF 1.kurss 1.grupa');
  writeln('24.variants - Retinata matrica');
	writeln('Retinatas matricas nesingularie elementi ir uzdoti manuaali:');
	writeln;
	writeln('Matrix A:');
 	for i:=1 to n do begin
  	   for j:=1 to n do
		write(A[i,j]:3);
		writeln;
		end;
	k:=1;
	for i:=1 to n do
  	   for j:=1 to n do begin
           if A[i,j]<>0 then begin
           B[k]:=A[i,j];
		k:=k+1;
		end;
    end;
    max:=k-1;
	 writeln;
   writeln('Vektoraa ir ',max,' elementi,kuri ir retinatas matricas nesingularie elementi');
         writeln('Vektors B:');
	for k:=1 to max do
    write(B[k]:3);
	writeln;
        writeln;
	writeln('Mekleesanas process:');
	go_on:=false;
        writeln;
	writeln('Ievadiet mekleesanas atsleegu:');
        readln(tkey);
	for k:=1 to m do
	if B[k]=tkey then
        begin
        writeln(tkey,' in position ',k); go_on:=true; end;
	if not go_on then
           writeln(' Neveiksmiiga meklesana');
          Writeln('Adress Maping Function:');
for k:=1 to max do AMF(k);
  end;
	readkey;
end.




