program Lab1;
uses CRT;

  var
InpFile,        {Ievada datu fails}
OutFile   :TEXT;      {rezultatu fails}

 InputString, OutputString : string;
 OutfileName: string;
 CONST
 InpFileName='Lab1Inp.txt';
 label TESTING, ENDING;


begin
  Assign(InpFile, InpFileName );  { Datu ievada fails }
  Reset(InpFile);
  writeln(' ievadi rezultata faila vaardu');
  readln(OutFileName);
  assign(OutFile, OutFilename);   { Rezultatu fails }
  rewrite(OutFile);
TESTING:    CLRSCR;
  while (not EOF (InpFile)) do
  begin
   readln(InpFile, InputString);
   OutputString:=InputString;
   writeln( OutputString);
   OutputString:='Apstraadaatais teksts="' + Outputstring + '"';
   writeln( OutputString);
   Writeln(OutFile, Outputstring);
  end;
  ENDING: close(InpFile); close(OutFile);
  end.
