Program DarbsArDatuStrukturam;
Uses CRT;

Const MaxSize=200;
Type
  Position=1..MaxSize;
  Count=0..MaxSize;
  DataType=String;
  KeyType=integer;
  StdElement=record
    data:DataType;
    key:KeyType;
  end;
  Queue=^QueueInstance;
  QueueInstance=record
    head,tail,n:Count;
    el:array[Position]of StdElement;
  end;

var
  NextKey:KeyType;
  created:boolean;

Function Size(var Q:Queue):Count;
begin
  Size:=Q^.n;
end;

function Full(var Q:Queue):boolean;
begin
  if(Size(Q)>=MaxSize)then Full:=True else Full:=False;
end;

function Empty(var Q:Queue):Boolean;
begin
  if(Size(Q)<=0)then Empty:=True else Empty:=False;
end;

procedure Terminate(var Q:Queue);
begin
  Dispose(Q);
  created:=false;
end;

procedure Create(var Q:Queue);
begin
  if(created)then Terminate(Q);
  New(Q);
  Q^.head:=0;
  Q^.tail:=0;
  Q^.n:=0;
  created:=true;
end;

procedure Enqueue(var Q:Queue; e:stdElement);
begin
  if not Full(Q) then with Q^ do begin
    head:=1;
    inc(n);
    tail:=n;
    el[n]:=e;
  end;
end;

procedure Serve(var Q:Queue;var e:stdElement);
var i:Position;
begin
  if not Empty(Q)then with Q^ do begin
    e:=el[1];
    for i:=2 to n do el[i-1]:=el[i];
    dec(n);
    tail:=n;
    if tail=0 then head:=tail;
  end;
end;

procedure MakeSwap(var e1:StdElement; var e2:StdElement);
var
  e:StdElement;
begin
  e:=e1;
  e1:=e2;
  e2:=e;
end;

procedure ASwap(var Q:Queue; ith:Count);
var
  e:StdElement;
begin
  if(not Empty(Q))and(ith<=Size(Q))and(Size(Q)>=2)then with Q^ do MakeSwap(el[head],el[ith]);
end;

procedure ShowHead;
begin
  Writeln('NPK':5,'  |  ','DATA':20,'  |  ','ATSLEGA':8);
end;

procedure ShowElement(i:Integer;e:StdElement);
begin
  writeln(i:5,'  |  ',e.data:20,'  |  ',e.key:8);
end;

procedure ShowQueue(var Q:Queue);
var
  i:integer;
begin
  ShowHead;
  for i:=1 to Size(Q) do begin
    ShowElement(i,q^.el[i]);{writeln(i:5,'  |  ',Q^.el[i].data:20,'  |  ',Q^.el[i].key:8);}
  end;
end;

procedure MainSequence(var Q:Queue);
var
  e:stdElement;
  i,j:integer;
begin
  writeln('   DARBS AR DATU STRUKTURAM   ');
	Writeln('Eriks Krumins         3. grupa');
	writeln('101RDB018              Var. 11');
  writeln;
  writeln('Izpildamas funkcijas: 1,7,4,7,2,7');
  writeln;
  writeln('Lai turpinatu, nospiediet jebkuru taustinu');
  readkey;
  writeln;
  Writeln('1. Rindas no 10 elementiem izveidosana');
  Create(Q);
  for i:=1 to 10 do begin
    e.data:='';
    for j:=1 to random(5)+5 do begin
      e.data:=e.data+Chr(Random(57)+65);
    end;
    e.key:=NextKey;
    Enqueue(Q,e);
    inc(NextKey);
  end;
  writeln('Rinda izveidota');
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
  writeln('2. Datu strukturas izvade uz ekrana'); ShowQueue(Q);
  writeln;
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
  writeln('3. Tris elementu dzesana no DS');
  for i:=1 to 3 do begin
    Serve(Q,e);
  end;
  writeln;
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
  writeln('4. Datu strukturas izvade uz ekrana'); ShowQueue(Q);
  writeln;
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
  writeln('5. Apmainit vietam 1 un i-to rindas elementu');
  i:=0;
  repeat
    Write('i - ');
    {$I-}
    readln(i);
    {$I+}
  until((i>0)and(i<=Size(Q))and(IOresult=0));
  ASwap(Q,i);
  writeln;
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
  writeln('6. Datu strukturas izvade uz ekrana'); ShowQueue(Q);
  writeln('Lai turpinatu, nospiediet jebkuru taustinu'); readkey;
  writeln;
end;

procedure showtask;
begin
  clrscr;
  writeln('11. Uzdevuma izvads');
  writeln;
  writeln('Datu strukturas veids - Vektoriala forma attelota rinda');
  writeln('Izveidot programmu, kura nodrosinatu studentam dotas datu strukturas');
  writeln('DS) apstradi. Programma realizet sekojosas apstrades operacijas:');
  writeln('Create, Terminate, Empty, Full, Size. Uzrakstit programmu, kas veido');
  writeln('DS no desmit elementiem un izpilda pec kartas sadu funkciju secibu');
  writeln('Izpildamas funkcijas - 1,7,4,7,2,7');
  writeln('   1. Datu strukturas ievade ar random funkciju palidzibu;');
  writeln('   2. Apmainit vietam 1 un i-to DS elementu;');
  writeln('   4. Tris elementu dzesana no DS;');
  writeln('   7. Datu strukturas izvade uz ekrana.');
end;

procedure author;
begin
  clrscr;
  writeln('12. Informacija par autoru');
  writeln;
  writeln('   Datorzinatnes un Informacijas tehnologijas fakultate');
  writeln('   RDBL 1. kurss 3. grupa');
  writeln('   Eriks Krumins');
  writeln('   Studenta apl. 101RDB018');
end;

procedure menu(var Q:queue);
var
  sel,i:integer;
  ext:boolean;
  e:StdElement;
  ermes:String;
begin
  ext:=false;
  repeat
    clrscr;
	  ermes:='';
    if (not created)then ermes:='RINDA NAV IZVEIDOTA';
    writeln('   DARBS AR DATU STRUKTURAM   ');
  	Writeln('Eriks Krumins         3. grupa');
  	writeln('101RDB018              Var. 11');
    writeln();
    writeln(ermes);
    writeln();
    writeln('1.  Izveidot rindu                                      Create');
    writeln('2.  Likvidet rindu                                      Terminate');
    writeln('3.  Rindas izvade uz ekrana                             ShowQueue');
    writeln('4.  Jauna elementa pievienosana                         Enqueue');
	  writeln('5.  Parbaudit vai rinda ir tuksa                        Empty');
	  writeln('6.  Parbaudit vai rinda ir pilna                        Full');
    writeln('7.  Panemnt un izvadit uz uz ekrana nakamo elementu     Serve');
    writeln('8.  Izdzest nakamo elementu');
    writeln('9.  Samainit 1 un i elementu vietam                     ASwap');
    writeln('10. Rindas garums                                       Size');
    writeln('11. Uzdevuma izvade');
    writeln('12. Informacija par darba autoru');
    writeln('13. Izeja');
    writeln;
    write('Jusu izvele (piem. "10") - ');
	  {$I-}
      readln(sel);
	  {$I+}
	  if((not(IOresult=0))or((sel<1)or(sel>13)))then begin
      writeln;
      writeln('Nepareizs cipars');
      writeln;
    end else if(not created)and(not((sel=1)or(sel=11)or(sel=12)or(sel=13)))then begin
      writeln;
      writeln('Rinda nav izveidota');
      writeln;
    end else begin
      case sel of
	    1:begin
	      Create(Q);
		    writeln;
	    end;
	    2:begin
	      Terminate(Q);
		    writeln;
	    end;
	    3:begin
	      ShowQueue(Q);
		    writeln;
	    end;
	    4:begin
	      writeln('Jauna elementa:');
        write('      data - ');
        ReadLn(e.data);
        e.key:=NextKey;
        inc(NextKey);
        Enqueue(Q,e);
		    writeln;
	    end;
	    5:begin
	      write('Rinda'); if(empty(Q))then write(' ir ') else write(' nav '); writeln('tuksa');
		    writeln;
	    end;
	    6:begin
	      write('Rinda'); if(full(Q))then write(' ir ') else write(' nav '); writeln('pilna');
        writeln;
	    end;
	    7:begin
	      ShowHead;
        Serve(Q,e);
        ShowElement(0,e);
        writeln;
	    end;
	    8:begin
        Serve(Q,e);
        writeln;
      end;
      9:begin
      Repeat
        write('i - ');
        {$I-}
        readln(i);
	      {$I+};
        Until(IOresult=0)and(i>0)and(i<Size(Q));
        ASwap(Q,i);
        writeln;
      end;
      10:begin
        Writeln('Garums - ',Size(Q));
        writeln;
      end;
	    11:begin
	      showtask;
	    end;
	    12:begin
	      author;
	    end;
	    13:begin
	      ext:=true;
	    end;
	    Else begin
	      ermes:='Nepareiza izvele, drikst izveleties tikai no 1 lidz 16';
	    end;
	    end;
	  end;
    writeln('Lai turpinatu, nospiediet jebkuru taustinu');
    readkey;
	  ermes:='';
  until(ext);
end;

var
  Q:Queue;
begin
  ClrScr;
  randomize;
  NextKey:=0;
  created:=false;
  MainSequence(Q);
  menu(Q);
end.
