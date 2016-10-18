program lab4;
uses CRT;
const MaxSize = 100;           	        {uzdod lietotajs}
type Position = 1 .. MaxSize;
Count = 0 .. MaxSize;
DataType = string;
KeyType = integer;
Priority= integer; 		{prioritates tips}

StdElement = record
        data: DataType;
        key: KeyType;
        prty: Priority
       end;

PriorityQueueInstance = record
         head, tail, n: Count;
         el: array [Position] of StdElement;
        end;

PriorityQueue = ^PriorityQueueInstance;

var choice:integer;p:PriorityQueue;cr:boolean;
label go;

procedure Create (var PQ: PriorityQueue; var created: boolean);
{Izveido jaunu tuksu prioritates rindu PQ^}
begin
      new (PQ);
      PQ^.head:= 0;   PQ^.tail:= 0;   PQ^.n:= 0;
      created:= true;
end;

procedure Terminate (var PQ: PriorityQueue; var created:boolean);
{Likvide prioritates rindu PQ^}
begin
       if  created  then
            begin
	         dispose (PQ);  created:= false
           end
end;

function Size (PQ: PriorityQueue): Count;
{Nosaka elementu skaitu prioritates rinda PQ^}
Begin  	Size:= PQ^.n      end;

function Empty (PQ: PriorityQueue): boolean;
{Parbauda, vai rinda PQ^ ir tuksa}
begin
	Empty:= PQ^.n = 0                                      {Q^.head = 0}
end;

function Full (PQ: PriorityQueue): boolean;
{Parbauda, vai rinda Q^ ir pilna}
begin
	Full:= PQ^.n = MaxSize
end;

procedure Enqueue (var PQ: PriorityQueue; e: StdElement);
{Prioritates rinda  PQ^ izvieto jaunu elementu e}
var i, k: Position;
begin
if  not Full(PQ)  then   with PQ^ do
  begin
  if   Empty(PQ)   then                          {prioritates rinda ir tuksa}
begin
head:= 1;   el[head]:= e;   tail:= head
end else                  {elementam  mekle vietu}
for i:= n  downto  1  do
if   el[i].prty > e.prty   then
   begin                     {izvieto aiz i-ta elementa}
     for k:= n  downto  i + 1  do
      el[k+1]:= el[k];
      el[i+1]:= e;   break
       end;
    if   i = n  then   tail:= tail +1;
       n:= n +1
end;end;

procedure Serve (var PQ: PriorityQueue; var e: StdElement);
{No prioritates rindas  PQ^ nolasa elementu e}
var i: Position;
begin
   if  not Empty(PQ)  then   with PQ^ do
     begin
      e:= el[head];                             {nolasa elementu}
      for i:= 2 to n do el[i-1]:= el[i];       {nolasito elementu dzes}
      n:= n -1;tail:= n;
      if tail = 0 then head:= 0
      end
end;

procedure ShowQueue(var Q:Queue);
var
  i:integer;
begin
 Writeln('NPK':5,'  |  ','DATA':20,'  |  ','ATSLEGA':8);
  for i:=1 to Size(Q) do begin
    writeln(i:5,'  |  ',Q^.el[i].data:20,'  |  ',Q^.el[i].key:8);{writeln(i:5,'  |  ',Q^.el[i].data:20,'  |  ',Q^.el[i].key:8);}
  end;
end;

begin
cr:=false;
go:
clrscr;
Writeln('1 - Izveidot jaunu prioritates rindu (Create)');
Writeln('2 - Izdzest prioritates rindu prioritates rindu (Terminate)');
Writeln('3 - Noteikt Elementu skaitu prioritates rinda (Size)');
Writeln('4 - Notiekt vai prioritates rinda ir tuksa (Empty)');
Writeln('5 - Notiekt vai prioritates rinda ir pilna (Full)');
Writeln('6 - Uzdevuma operaciju seciga izpilde (1,7,5,7,3,7)');
Writeln('0 - Iziet no programmas');

{$I-}readln(Choice);{$I+}
if (choice<0) or (choice>5) or (IOresult<>0) then
begin writeln('Nepareizi ievadita operacija');readln;goto go;end;
case choice of

1: begin
   writeln;
   Create(P,cr);
   Writeln('Jauna prioritates rinda izveidota');
   readln;
   goto go;
   end;

2: begin
   writeln;
   if cr=false then
   begin writeln('Prioritates rinda nav izveidota');readln;goto go;end;
   Terminate(P,cr);
   Writeln('Prioritates rinda tika izdzesta');
   readln;
   goto go;
   end;

3: begin
   writeln;
   if cr=false then
   begin writeln('Prioritates rinda nav izveidota');readln;goto go;end;
   Writeln('Prioritates rinda ir ',Size(P),' elementu');
   readln;
   goto go;
   end;

4: begin
   writeln;
   if cr=false then
   begin writeln('Prioritates rinda nav izveidota');readln;goto go;end;
   if Empty(P)=true then
   Begin writeln('Prioritates rinda ir tuksa');readln;goto go;end else
   begin  writeln('Prioritates rinda nav tuksa');readln;goto go;end;
   end;

5: begin
   writeln;
   if cr=false then
   begin writeln('Prioritates rinda nav izveidota');readln;goto go;end;
   if Full(P)=true then
   Begin writeln('Prioritates rinda ir pilna');readln;goto go;end else
   begin  writeln('Prioritates rinda nav pilna');readln;goto go;end;
   end;
end;end.