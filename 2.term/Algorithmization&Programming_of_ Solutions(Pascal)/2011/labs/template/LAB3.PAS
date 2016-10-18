program Lab3;
uses LAB3U;

var
 InputString: STRMod;
 WordOut, WordIn: STRData;
 OutputString: STRMod;
begin
  writeln('Ievadi analizeejamo rindu');
  readln(InputString);
  Writeln(' Analizejam rindu');
  writeln(InputString);
  writeln('ievadi vardu kuru aizvietot');
  readln(WordOut);
  writeln('ievadi vardu ar kuru aizvietot');
  readln(WordIn);
   StrReplace( InputString, WordOut, WordIn, OutputString);
   Writeln( ' Apstradajama un rezultejosaa rinda');
   writeln( InputString );
   writeln( OutputString);
   writeln( 'Ir izslegti ', NumMod, ' varda ', WORDOut,' ieklavumi');
   writeln( ' Nospied ENTER');
   readln;

 end.
{Ievadi analizeejamo rindu
cat dog cat dog elephant
 Analizejam rindu
cat dog cat dog elephat
ievadi vardu kuru aizvietot
cat
ievadi vardu ar kuru aizvietot
ELEPHANT
 Apstradajama un rezultejosaa rinda
cat dog cat dog elephat
ELEPHANT dog ELEPHANT dog elephat
Ir izslegti 2 varda cat ieklavumi
 Nospied ENTER
Ievadi analizeejamo rindu
 a a a a a a a a a a a a a a a a a a a a a a a
 Analizejam rindu
 a a a a a a a a a a a a a a a a a a a a a a a 
ievadi vardu kuru aizvietot
a
ievadi vardu ar kuru aizvietot
The very big ELEPHANT
 Apstradajama un rezultejosaa rinda
 a a a a a a a a a a a a a a a a a a a a a a a 
????
Ir izslegti -1 varda a ieklavumi
 Nospied ENTER}

