program Lab2;
uses CRT;
const ElSk=20; { Elementu skaits masiva}
      InpFileName='MyData.dat';
type MyMas=array[1..ElSk] of integer;  {apkalpojamamasiva tips}
var ms: MyMas;  {Apkalpojamais masivs}
InpFile,        {Ievada datu fails}
OutFile         {rezultatu fails}
 :TEXT;
 i, summa5 : integer;
 ch : char;   OutfileName: string;
 label TESTING, ENDING;

  procedure BUBLE( var a: MyMas) ;forward; { norade uz deklaraciju zemak}

  procedure PROCMAS( var a: MyMas; var S5: integer);
  var  i : integer;

      function SUM5( A:MyMas) :integer;{ iekseja PROCMAS funkcija}
      { nosaka piecu mazako a masiva elementu summu }
      var i, sum : integer;
      begin
      BUBLE(a);  { Kartojam masivu augosa seciba}
      (* Aizkomentets sakartotaa masiva izvads *)
      {                writeln;  writeln( 'Sakartotais masivs peec BUBLE');
                       for i:=1 to ElSk do
                       write('         "', i:2,'" ', a[i]:4, '  '); }
      sum:=0;   {Summejam pirmos piecus (mazakos) sakartota masiva elementus}
      for i:=1 to 5  do
      sum:=sum+a[i];
      SUM5:=sum;
      end;   { SUM5 }

  begin           {Sakas ProcMas izpilde }
  S5:=sum5(a);    { Nosakam piecu mazako masiva elementu summu }
                        (* Aizkomenteets izvada op skanosanai *)
                        {  writeln(' Piecu mazako elementu summa : ',s5);}
  if (S5<=5) then { Ja nepieciesams mainam masiva elementu zimes}
      for i:=1 to ElSk do
        a[i] := -a[i];
  end; {ProcMas }

  procedure BUBLE( var a: MyMas); {masiva a kartosana augosa secibaa}
  var i, j, temp : integer;
  begin
   for i:=1 to ElSk-1 do
    for j:=i+1 to ElSk do
    if a[i]> a[j] then
            begin temp:= a[i];
                  a[i]:=a[j];
                  a[j]:=temp;
            end;
  end; {BUBLE}

begin
  Assign(InpFile, InpFileName );  { Datu ievada fails }
  Reset(InpFile);
  writeln(' ievadi rezultata faila vaardu');
  readln(OutFileName);
  assign(OutFile, OutFilename);   { Rezultatu fails }
  rewrite(OutFile);
TESTING:    CLRSCR;
  for i:=1 to ElSk do
  Read(InpFile, ms[i]);
  if EOF(InpFile) then goto ENDING;
  writeln( 'Ievaditie dati');
  for i:=1 to ElSk do
  begin
  write('         "', i:2,'" ', ms[i]:4, '  ');
  write(Outfile, ms[i]:3);
  end;
   PROCMAS( ms, summa5);
  writeln(Outfile);
  writeln( 'Piecu mazako masiva elementu summa ir ', summa5);
  writeln(Outfile, 'Piecu mazako masiva elementu summa ir ', summa5);
  writeln('REZULTATA MASIVS');
  for i:=1 to ElSk do
  begin
  write('         "', i:2,'" ', ms[i]:4, '  ');
  write(Outfile, ms[i]:3);
  end;
  writeln(' Ievadi y vai Y lai turpinatu vai ko lai beigtu');
  readln(Ch);
  if (ch='Y') or (ch='y') then goto TESTING;
 ENDING: close(InpFile); close(OutFile);
 end.