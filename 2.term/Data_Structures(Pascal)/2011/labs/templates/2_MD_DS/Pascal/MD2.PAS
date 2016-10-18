program MaajasDarbs2;

uses Crt;

const MaxSize=10;

type Position=1..MaxSize;
     Count=0..MaxSize;
     DataType=string;
     KeyType=integer;
     StdElement=record
        data:DataType;
        key:KeyType;
     end;
     QueueInstance=record
        head,tail,n:Count;
        el:array[Position]of StdElement;
     end;
     Queue=^QueueInstance;

var Q:Queue;
    created:boolean;
    izveele:byte;
    ele:StdElement;
    key:KeyType;
    found:boolean;

procedure logs1(x1,y1,x2,y2:integer; color:byte);
 var x,y:integer;
 begin
 TextBackground(color);
 for y:=y1 to y2 do
 for x:=x1 to x2 do begin
                    gotoxy(x,y); write(' ');
                    end;
 end;

procedure logs(x1,y1,x2,y2:integer; color:byte; text:string);
 var x,y:integer;
 begin
 logs1(x1,y1,x2,y2,color);
 TextColor(white);
 for x:=x1 to x2 do begin
                    gotoxy(x,y1); write(chr(205));
                    gotoxy(x,y2); write(chr(205));
                    end;
 for y:=y1 to y2 do begin
                    gotoxy(x1,y); write(chr(186));
                    gotoxy(x2,y); write(chr(186))
                    end;
 gotoxy(x1,y1); write(chr(201));
 gotoxy(x1,y2); write(chr(200));
 gotoxy(x2,y1); write(chr(187));
 gotoxy(x2,y2); write(chr(188));
 gotoxy(x1+2,y1); write(text);
 end;

procedure pazinojums(color:byte; text,text1:string);
 begin
 logs(25,17,70,21,color,text);
 gotoxy(27,19); write(text1);
 ReadKey;
 logs1(25,17,70,21,LightCyan);
 end;

function Empty(Q:Queue):boolean;
 {Paarbauda,vai rinda Q^ ir tuksha}
 begin
 Empty:=Q^.head=0;
 end;

procedure Tabula(Q:Queue);
 var x,y:integer;
     i:Count;
 begin
 TextColor(white);
 logs(25,2,70,15,LightRed,'');
 for x:=26 to 69 do begin
                    gotoxy(x,4); write(chr(196));
                    end;
 for y:=3 to 14 do begin
                   gotoxy(32,y); write(chr(179));
                   gotoxy(50,y); write(chr(179));
                   end;
 gotoxy(28,3); write('Nr.');
 gotoxy(38,3); write('Data');
 gotoxy(58,3); write('Key');
 if not created or Empty(Q) then exit;
 with Q^ do
         for i:=1 to n do begin
                          gotoxy(27,4+i); write(i:2);
                          gotoxy(34,4+i); write(Q^.el[i].data);
                          gotoxy(52,4+i); write(Q^.el[i].key);
                          end;
 end;

procedure Menu;
 const MenuSize=8;
       MenuList:array[1..MenuSize] of string[15]=('Create','Enqueue','Terminate','Size','Empty','Full','Serve','Exit');
 var i,rinda,a:byte;
     cikls,created:boolean;
 begin
 Tabula(Q);
 TextColor(white);
 logs(5,5,20,MenuSize+8,Magenta,'Izveele');
 rinda:=7;
 for i:=1 to MenuSize do begin
                         gotoxy(7,rinda);
                         write(MenuList[i]);
                         rinda:=rinda+1;
                         end;
 rinda:=7;
 cikls:=true;
 gotoxy(7,rinda);
 TextColor(blue);
 write('            ');
 gotoxy(7,rinda);
 write('+',MenuList[1]);
 while cikls do begin
                a:=rinda;
                case ReadKey of
                #0: case ReadKey of
                 #80: if (rinda=6+MenuSize) then rinda:=7 else rinda:=rinda+1;
                 #72: if (rinda=7) then rinda:=6+MenuSize else rinda:=rinda-1;
                 end;
                #13: begin cikls:=false; izveele:=rinda-6; end;
                end;
                gotoxy(7,a);
                TextColor(white);
                write('            ');
                gotoxy(7,a);
                write(MenuList[a-6]);
                gotoxy(7,rinda);
                TextColor(blue);
                write('+',MenuList[rinda-6]);
                end;
 end;

procedure Create(var Q:Queue; var created:boolean);
 {Izveido jaunu tukshu rindu Q^}
 begin
 new(Q);
 Q^.head:=0; Q^.tail:=0; Q^.n:=0;
 created:=true;
 end;

function Full(Q:Queue):boolean;
 {Paarbauda,vai rinda Q^ ir pilna}
 begin
 Full:=Q^.n=MaxSize;
 end;

procedure Terminate(Q:Queue; var created:boolean);
 {Likvidee rindu Q^}
 begin
 if created then begin
                 dispose(Q);
                 created:=false;
                 end;
 end;

procedure Enqueue(var Q:Queue; e:StdElement);
 {Rindaa Q^ izvieto jaunu elementu e}
 begin
 if not Full(Q) then with Q^ do
 begin
 tail:=tail+1; {jaunaa el.poziicija tail}
 el[tail]:=e; {el.e izvieto rindaa}
 if Empty(Q) then head:=1;
 n:=n+1;
 end;
 end;

function Size(Q:Queue):Count;
 {Nosaka elementu skaitu rindaa Q^}
 begin
 Size:=Q^.n;
 end;

procedure Serve(var Q:Queue; e:StdElement);
 var i:Position;
 begin
 if not Empty(Q) then with Q^ do
 begin
 e:=el[head]; {Nolasa elementu}
 for i:=2 to n do {Nolasiito elementu dzeesh}
  el[i-1]:=el[i];
  n:=n-1; tail:=n;
  if tail=0 then head:=0;
 end;
 end;

procedure CheckKey(var Q:Queue; tkey:KeyType; var found:boolean);
 {Rindaa Q^ meklee elementu, kura atsleegas lauka veertiiba ir tkey}
 var k:position;
 begin
 found:=false;
 if not Empty(Q) then with Q^ do
  for k:=1 to n do
   if el[k].key=tkey then
    begin
    found:=true;
    exit;
    end;
 end;

procedure Izveidot;
 begin
 if (created=false) then begin
                         Create(Q,created);
                         pazinojums(green,'Create','Rinda ir izveidota.');
                         end
    else pazinojums(red,'Uzmaniibu!','Rinda jau eksistee!');
    end;

procedure Pievienot;
 label Atsleega;
 begin
 if created then begin
                 if not Full(Q) then begin
                                     TextColor(15);
                                     logs(25,17,70,21,blue,'Enqueue');
                                     gotoxy(27,19); write('Ievadiet nosaukumu ');
                                     readln(ele.data);
                                     Atsleega:TextColor(15);
                                     logs(25,17,70,21,blue,'Jauns ieraksts');
                                     gotoxy(27,19);
                                     write('Ievadiet atsleegu ');
                                     {$I-}
                                     readln(key);
                                     {$I+}
                                     if(IOResult<>0) then begin
                                             pazinojums(red,'Uzmaniibu!','Nepareizi ievadiiti dati!');
                                                          goto Atsleega;
                                                          end;
                                     CheckKey(Q,key,found);
                                     if not found then begin
                                                       ele.key:=key;
                                                       Enqueue(Q,ele);
                                                       end
                                     else begin
                                          pazinojums(red,'Uzmaniibu!','Shaada atsleega jau eksistee!');
                                          goto Atsleega;
                                          end;
                                    end
                 else pazinojums(red,'Uzmaniibu!','Rinda ir pilna.');
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota.');
 logs1(25,6,70,21,LightCyan);
 end;

procedure Likvideet;
 begin
 if created then begin
                 Terminate(Q,created);
                 pazinojums(green,'Terminate','Rinda ir likvideeta.');
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota!');
 end;

procedure Izmeers;
 begin
 if created then begin
                 TextColor(white);
                 logs(25,17,70,21,green,'Size');
                 gotoxy(27,19);
                 write('Rindaa ir ',Size(Q),' ieraksti/s.');
                 ReadKey;
                 logs1(25,17,70,21,LightCyan);
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota!');
 end;

procedure Tukshs;
 begin
 if created then begin
                 if Empty(Q) then pazinojums(green,'Empty','Rinda ir tuksha.')
                 else pazinojums(green,'Empty','Rinda nav tuksha.');
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota!');
 end;

procedure Pilns;
 begin
 if created then begin
                 if Full(Q) then pazinojums(green,'Full','Rinda ir pilna.')
                 else pazinojums(green,'Full','Rinda nav pilna.');
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota!');
 end;

procedure Nolasiit;
 begin
 if created then begin
                 if not Empty(Q) then begin
                                      TextColor(white);
                                      logs(25,17,70,23,green,'Serve');
                                      gotoxy(27,19); write('Data: ',Q^.el[1].data);
                                      gotoxy(27,21); write('Key: ',Q^.el[1].key);
                                      ReadKey;
                                      logs1(25,17,70,23,LightCyan);
                                      Serve(Q,ele);
                                      end
                 else pazinojums(green,'Serve','Rinda ir tuksha.');
                 end
 else pazinojums(red,'Uzmaniibu!','Rinda nav izveidota!');
 end;


procedure Beigt;
 begin
 Terminate(Q,created);
 Halt(1);
 end;

begin
ClrScr;
logs1(1,1,80,25,lightcyan);
created:=false;
repeat Menu;
case izveele of
1: Izveidot;
2: Pievienot;
3: Likvideet;
4: Izmeers;
5: Tukshs;
6: Pilns;
7: Nolasiit;
8: Beigt;
end;
until False;
end.