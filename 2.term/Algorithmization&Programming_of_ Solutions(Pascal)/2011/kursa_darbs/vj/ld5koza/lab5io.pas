unit lab5IO;
interface
  const maxLength=10;nbsp='    ';
         carName:array[1..20] of string[maxLength]=('Vards1',
                                                    'VardsXY',
                                                    'AaZzY',
                                                    'abcV',
                                                    '2535::::',
                                                    'Porsche 55',
                                                    'Zorsche 91',
                                                    'VW-Dorsche',
                                                    'Morsche 95',
                                                    '10Volkswag',
                                                    'manrs',
                                                    'yxzp',
                                                    'zzpfsa',
                                                    'Vabc',
                                                    'abcdefgh',
                                                    'Cadillac D',
                                                    'Cadillac X',
                                                    'Opel Vivar',
                                                    'Opel Astra',
                                                    'Opel Antar');
  var
  MyFileErr: integer;
  type
  STR39= string[maxLength];


  function FileRewr(filename:string): boolean;
  function NumOfRec: integer;
  procedure WriteLnTEXT( OUTTEXT: string);
  procedure readINT(var i: integer);
  procedure READREC(var STR1, STR2 : STR39);
  procedure WriteLnRec(str1: string; i:integer; str2,str3,str4,str5:string);
  procedure FError ;


implementation
uses CRT;


function FileRewr(filename:string): boolean;
var answer:string;
 begin
      writeln('Fails ',filename,' eksiste vai veidot to no jauna ?');
      writeln(' j/n ');
      read(answer);
      if( (answer='j') or (answer='J')) then
          begin
          writeln(' esoso failu paarrakstam');
          FileRewr:= TRUE;

     exit;
          end
      else
          begin
          writeln('tiek saglabaats esosais fails ');
          FileRewr:= FALSE;
          end;
 end;

 function NumOfRec: integer;
   label INPNUM;
   var n : integer;
   begin
  INPNUM:         writeln('Cik ierakstus gatavot (skaitam 0, 1, 2, 3,.. n)?');
{$I-}
       read(n);
{$I+}
           if(IOResult<>0) then
     begin
          writeln(' Nepareizi ievadiits ierakstu skaits');
          writeln(' Ievadiit vajag no jauna');
          goto INPNUM;
     end;
     NumOfRec:=n;
  end;


  procedure WriteLnTEXT( OUTTEXT: string);
    begin
      writeln( OUTTEXT);
    end;

  procedure readINT(var i: integer);
  begin
  read(i);
  end;


  procedure READREC(var STR1, STR2 : STR39);
  begin
  writeln(' Ievadi labojamaa ieraksta pirmo lauku');
    readln;
   readln(STR1);
   writeln(' Ievadi labojamaa ieraksta otro lauku');
   read;
   readln(STR2);
   end;

     procedure WriteLnRec(str1: string; i:integer; str2,str3,str4,str5:string);
    begin
            writeln(str1, i:3,str2,str3,str4, str5);
    end;


procedure FError ;
begin
   case (MyFileErr) of
1: writeln( ' ######01 lietotaajs neatlauj paarrakstit esoso failu ');
2: writeln( ' ######02 Kluuda ievadotierakstu skaitu veidojamaa failaa');
3: writeln( ' ######03 Neizdodas radiit failu');
4: writeln( ' ######01 Nevar atveert pieprasiito failu');
5: writeln( ' ######04 Nepielaujams labojamaa ieraksta numurs');
   else writeln(' ######55 Faila apstraades kluuda  Nr:', MyFileErr);
   end;
   MyFileErr:=0;
   writeln(' ###### nospied taustinu ');
   readkey;
end;


 begin
 MyFileErr:=0;
 end.


