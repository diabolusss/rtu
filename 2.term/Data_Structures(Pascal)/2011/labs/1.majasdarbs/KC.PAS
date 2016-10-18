Program Lab2;
uses CRT;
const ElSk=20;
      InpFileName='MyData.txt';
type MyMas=array[1..ElSk] of integer;
var ms,b: MyMas;
InpFile, OutFile: TEXT;
 i, summa2: integer;
 ch: char; OutfileName: string;
 label TESTING, ENDING;

  procedure BUBLE( var a: MyMas); forward;

  procedure PROCMAS( var a: MyMas; var S2: integer);
  var i,sum: integer;


  begin
  b:=a;
  Buble(b);
  sum:=0;
  sum:=b[1]+b[2];
    S2:=sum;
    if S2<10 then
      BUBLE(a);
  end;

  procedure BUBLE( var a: MyMas);
  var i, j, temp: integer;
  begin
   for i:=1 to ElSk-1 do
    for j:=i+1 to ElSk do
    if a[i]>a[j] then
            begin temp:=a[i];
                  a[i]:=a[j];
                  a[j]:=temp;
            end;
  end;

begin
CLRSCR;
  Assign(InpFile, InpFileName );
  Reset(InpFile);
  writeln('Ievadiet rezultaata faila vaardu...');
  readln(OutFileName);
  OutFileName:=OutFileName + '.txt';
  assign(OutFile, OutFilename);
  rewrite(OutFile);
TESTING: CLRSCR;
  for i:=1 to ElSk do
  Read(InpFile, ms[i]);
  if EOF(InpFile) then goto ENDING;
  writeln('Ievadiitie dati');
  for i:=1 to ElSk do
  begin
  write('         "', i:2,'" ', ms[i]:4, '  ');
  write(Outfile, ms[i]:3);
  end;
   PROCMAS(ms, summa2);
  writeln(Outfile);
  writeln('Divu mazaako masiiva elementu summa ir ', summa2);
  writeln(Outfile, 'Divu mazaako masiiva elementu summa ir ', summa2);
  writeln;
  writeln('REZULTAATA MASIIVS');
  for i:=1 to ElSk do
  begin
  write('         "', i:2,'" ', ms[i]:4, '  ');
  write(Outfile, ms[i]:3);
  end;
  Writeln(Outfile,' ');
  Writeln(Outfile);
  writeln;
  writeln('Ievadiet y vai Y, lai turpinaatu vai ko citu, lai beigtu...');
  readln(Ch);
  if (ch='y') or (ch='Y') then goto TESTING;
 ENDING: close(InpFile); close(OutFile);
 end.