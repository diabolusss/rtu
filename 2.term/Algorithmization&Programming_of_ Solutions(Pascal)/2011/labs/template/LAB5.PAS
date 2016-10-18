program lab5;
uses lab5un, lab5IO;
var Mydata: Myfiletype;
    Myrecc : Myrec;
    MydataOpen : boolean ;
var    RC:integer;
    filename: string;
    Oper: integer;
label CASEPOINT;
    begin
    MyDataOpen:=False;
CASEPOINT:
    if (MyFileErr<>0) then FError;

    writeln(' Ko darisim ?');
    writeln('1 - veidosim jaunu failu');
    writeln('2 - atversim esosu failu');
    writeln('3 - apskatisim faila saturu');
    writeln('4 - mainisim failaa viena ieraksta saturu');
    writeln('5 - aizvert failu ');
    writeln('6 - beigt darbu ');
    readln (Oper);
    case (Oper) of
  1: begin
       write('Ievadi faila vaardu ');
       read;
       readln(filename);
       FCreate(MyData, filename,MyDataOpen);
     end;

  2: begin
       write('Ievadi faila vaardu ');
       read;
       readln(filename);
       FOpenf(MyData, filename, MyDataOpen );
       if(MyDataOpen=true) then writeln('Fails ',filename,' atverts sekmigi')
         else writeln('Failu ',filename,' atvert neizdevaas');
     end;

  3: begin
       Fview(MyData, MydataOpen);
     end;

  4: begin
       FRwRec(MyData, MyDataOpen);
     end;

  5: begin
       FClose(MyData, MyDataOpen);
     end;
  6: begin
       exit;
     end;
 end;

  goto CASEPOINT;


    end.