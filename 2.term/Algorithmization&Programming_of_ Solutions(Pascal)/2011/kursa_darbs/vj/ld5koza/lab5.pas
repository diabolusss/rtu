program lab5;
uses lab5un, lab5IO,crt;
var Mydata: Myfiletype;
    MydataOpen : boolean ;
    filename: string[maxLength];
    Oper: char;
label CASEPOINT;
    begin
    MyDataOpen:=False;
CASEPOINT:
    if (MyFileErr<>0) then FError;

    writeln(' Ko darisim ?');
    writeln('1 - veidosim jaunu failu');
    writeln('2 - atversim esosu failu');
    writeln('3 - apskatisim faila saturu');
    writeln('4 - 2vu ierakstu apmaina vietam');
    writeln('5 - aizvert failu ');
    writeln('6 - beigt darbu ');
    Oper:=readkey;
    case (Oper) of
  '1': begin
       write('Ievadi faila vaardu: ');

       repeat readln(filename); until (length(fileName)<maxLength)and(length(fileName)>0);
       FCreate(MyData, filename,MyDataOpen);
     end;

  '2': begin
       write('Ievadi faila vaardu: ');

       repeat readln(filename); until (length(fileName)<maxLength)and(length(fileName)>0);
       FOpenf(MyData, filename, MyDataOpen );
       if(MyDataOpen=true) then writeln('Fails ',filename,' atverts sekmigi')
         else writeln('Failu ',filename,' atvert neizdevaas');
     end;

  '3': begin
       Fview(MyData, MydataOpen);
     end;

  '4': begin if filesize(MyData)>1 then
       FRwReplace(MyData, MyDataOpen);
     end;

  '5': begin
       FClose(MyData, MyDataOpen);
     end;
  '6': begin
       exit;
     end;
 end;

  goto CASEPOINT;


    end.
