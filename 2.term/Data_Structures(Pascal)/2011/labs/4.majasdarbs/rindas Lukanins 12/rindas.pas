uses crt;
const MaxSize = 500;

type Count = 0 .. MaxSize;
DataType = string;
KeyType = integer;
StdElement = record
  data: DataType;
  key: KeyType
end;

NodePointer = ^Node;
Node = record
  el: StdElement;   
  next: NodePointer
end;

Queue = ^QueueInstance;
QueueInstance = record
  head: NodePointer;
  tail: NodePointer;
  n: Count
end;

var i,k,correct:integer;
    Q:Queue;
	el:StdElement;
	exist:boolean;
	ready,error:integer;
	alfa,chc:string;

	

function Size (var Q: Queue): Count;
{Nosaka elementu skaitu rinda Q^}
begin
  Size:= Q^.n
end;
	
function Empty (Q: Queue): boolean;
{Parbauda, vai rinda Q^ ir tuksa}
begin
  Empty:= Q^.n = 0;                                {Q^.head = nil} 
end;

function Full (Q: Queue): boolean;
{Parbauda, vai rinda Q^ ir pilna}
begin
  Full:= Q^.n = MaxSize
end;
	
procedure Create (var Q: Queue; var created: boolean);
{Izveido jaunu tuksu rindu Q^}
begin
  writeln(' Datu strukturas ievade ar random funkciju palidizibu');
  if created=false then begin
    new(Q);
    with Q^ do begin
      head:= nil;   
	  tail:= nil;   
	  n:=0;
    end;
    created:= true
  end else begin
    writeln('Rinda ir jau izveidota');
  end;
end;

procedure Terminate (var Q: Queue; var created: boolean);         {Likvide rindu Q^}
var p: NodePointer;
begin 
  if created then begin
    if not Empty(Q) then with Q^ do
      while head <> nil do begin
	    p:= head;   
		head:= head^.next;
		dispose (p)
	  end;
	dispose(Q);   
	created:= false
  end else begin
    writeln('Rinda nav izveidota');
  end;
end;

procedure Enqueue (var Q: Queue; e: StdElement; var exist:boolean);
{Rinda Q^ izvieto jaunu elementu e}
var p: NodePointer;
begin
  if exist=true then begin
  if not Full(Q) then with Q^ do begin
    new(p);   
	p^.el:= e;
    if Empty(Q) then begin                       {rinda ir tuksa}
	  head:= p;   
	  tail:= p;  
	  p^.next:= nil
    end else begin                                           {rinda nav tuksa}
	  p^.next:= tail^.next;	                                            {izkarto 2 saites}
	  tail^.next:= p;   
	  tail:=p
    end;
    n:=n+1;
  end;
  end else begin
    writeln('Rinda nav izveidota');
  end;
end;

procedure Serve (var Q: Queue; var e: StdElement);
{No rindas Q^ nolasa elementu e}
var p: NodePointer;
begin
  if not Empty(Q) then with Q^ do begin
    p:= head;  
    e:= head^.el;                            {nolasa elementu}
	head:= head^.next;              {parstata raditaju head}
	if n=1 then tail:= nil;
	dispose (p);                          {dzes nolasito elementu}
    n:= n-1;
  end;
end;

procedure View (var Q:Queue; var e:StdElement; var exist:boolean);
var k:integer;
    p:NodePointer;
begin
  if exist=true then begin
  writeln(' 7. Datu strukturas izvade uz ekrana');
  p:=Q^.head;
  writeln('|  Npk    |  Data   |   Key   |');
  writeln;
  for k:=1 to Q^.n do begin
	writeln('|  ',k:3,'    |',p^.el.data:5,'    |',p^.el.key:5,'    |');
    p:=p^.next;
  end;
  end else begin
    writeln('Rinda nav izveidota');
  end;
end;

procedure FindKey(var Q:Queue; var ready:integer; var exist:boolean);
var m,k,i,d:integer;
    p:NodePointer;
	c:StdElement;
label boom;
label doom;
begin
  if exist=true then begin
  p:=Q^.head;
  for k:=1 to Q^.n do begin
    if ready=p^.el.key then begin
	  c:=Q^.head^.el;
	  Q^.head^.el:=p^.el;
	  m:=1;
	end;
	if m=1 then goto boom;
	p:=p^.next;
  end;
  boom:
  p:=Q^.head^.next;
  for i:=1 to Q^.n-1 do begin
    if ready=p^.el.key then begin
	  p^.el:=c;
	  d:=1;
	end;
	if d=1 then goto doom;
	p:=p^.next;
  end;
  doom:
  end else begin
    writeln('Rinda nav izveidota');
  end;
end;
  
procedure Author;
begin
  writeln;
  writeln(' Datu strukturas ');
  writeln(' Sergejs Lukanins     101RDB031');
  writeln(' 1.kurss 4.grupa      Variants #12');
  writeln;
end;

procedure Menu;
begin
  k:=0;
  repeat
  clrscr;
  Author;
  writeln('1. Izveidot rindu(Create)');
  writeln('2. Dzest rindu(Terminate)');
  writeln('3. Rindas apskatisana');
  writeln('4. Jauna elementa izvietosana(Enqueue)');
  writeln('5. Apmainit 1. elementu ar elementu tkey');
  writeln('6. Tris elementu pievienosana');
  writeln('7. Autors');
  writeln('8. Uzdevums');
  writeln('9. Izeja');
  writeln;
  write('  Jusu izvele - '); readln(chc);
  if chc='1' then begin
    Create(Q,exist);
	for i:=1 to 10 do begin
	  el.data:=chr(random(65)+25)+chr(random(65)+25);
	  el.key:=i-1;
	  Enqueue(Q,el,exist);
    end;
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='2' then begin
    Terminate(Q,exist);
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='3' then begin
	View(Q,el,exist);
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='4' then begin
    Enqueue(Q,el,exist);
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='5' then begin
    FindKey(Q,ready,exist);
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='6' then begin
	for i:=11+k to 13+k do begin
      el.data:=chr(random(65)+25)+chr(random(65)+25);
	  el.key:=i-1;
	  Enqueue(Q,el,exist);
    end;
	k:=k+3;
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='7' then begin
    Author;
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  if chc='8' then begin
    writeln('Izveidot programmu, kura nodrosinatu studentam dotas datu strukturas (DS) apstradi.');
	writeln('Programma realizet sekojosas apstrades operacijas: Create, Terminate, Empty, Full, Size.');
	writeln('Uzrakstit programmu, kas veido DS no desmit elementiem un izpilda pec kartas sadu funkciju secibu: 1,7,6,7,3,7');
	writeln('1. Datu strukturas ievade ar random funkciju palidzibu');
	writeln('7. Datu strukturas izvade uz ekrana');
	writeln('6. Apmainit vietam 1 elementu un elementu ar atsleglauka vertibu tkey');
	writeln('7. Datu strukturas izvade uz ekrana');
	writeln('3. Tris jaunu elementu pievienosana DS');
	writeln('7. Datu strukturas izvade uz ekrana');
	writeln('Nospiediet Enter lai turpinat..');
	readln;
  end;
  until chc='9';
 end;
  
begin
  exist:=false;
  clrscr;
  Author;
  randomize;
  Create(Q,exist);
  for i:=1 to 10 do begin
	el.data:=chr(random(65)+25)+chr(random(65)+25);
	el.key:=i-1;
	Enqueue(Q,el,exist);
  end;
  View(Q,el,exist);
  writeln('Nospiediet Enter lai turpinat..');
  readln;
  clrscr;
  Author;
  repeat
    write(' 6. Pirma elementa apmainisana ar elementu tkey: ');
	readln(alfa);
	val(alfa,ready,error);
	if error<>0 then begin 
	  correct:=0;
	  writeln('Nav tada tkey sarakstaa!');
    end else correct:=1;	
	if (ready>Q^.n-1) or (ready<0) then begin
	  correct:=0;
	  writeln('Nav tada tkey sarakstaa!');
	end else correct:=correct+1;
  until correct=2;
  FindKey(Q,ready,exist);
  View(Q,el,exist);
  writeln('Nospiediet Enter lai turpinat..');
  readln;
  clrscr;
  Author;
  writeln(' Tris elementu pievienosana ');
  for i:=11 to 13 do begin
    el.data:=chr(random(65)+25)+chr(random(65)+25);
	el.key:=i-1;
	Enqueue(Q,el,exist);
  end;
  View(Q,el,exist);
  writeln('Nospiediet Enter lai turpinat..');
  readln;
  clrscr;
  Terminate(Q,exist);
  Menu;
end.
