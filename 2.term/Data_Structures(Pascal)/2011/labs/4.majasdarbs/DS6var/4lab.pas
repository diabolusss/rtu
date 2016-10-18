program indusskij_kod;
uses Crt;

const  MaxSize = 500;
type  Count = 0 .. MaxSize;
          DataType = integer;
          KeyType = integer;
          Priority = integer;
          StdElement = record
                data: DataType;
                 key: KeyType
          end;
        NodePointer = ^Node;
	Node = record
                 el: StdElement;
                 prty: Priority;
                 next: NodePointer;
                 prior: NodePointer;
        end;

        PriorityQueueInstance = record
                 head: NodePointer;
                 tail: NodePointer;
                 n: Count
        end;
        PriorityQueue =^PriorityQueueInstance;

Var Q: PriorityQueue;
    created: boolean;
    C: char;

procedure Create (var Q: PriorityQueue; var created: boolean);
{Izveido jaunu tukðu rindu Q^}
begin
	new(Q);
	with Q^ do
	     begin
	           head:= nil;   tail:= nil;   n:=0
	     end;
	created:= true;
        Writeln('Rinda ir izveidota!');
end;

function Empty (Q: PriorityQueue): boolean;
{Pârbauda, vai rinda Q^ ir tukða}
begin
	Empty:= Q^.n = 0;                                      {Q^.head = 0}
end;

procedure Terminate (var Q: PriorityQueue; var created: boolean);          {Likvidç rindu Q^}
var p: NodePointer;
begin
	if  created  then
	     begin
	           if  not Empty(Q) then   with Q^ do
		while  head <> nil  do
		      begin
		            p:= head;
                            head:= head^.next;
		            dispose(p);
		       end;
	            dispose(Q);
                    created:= false;
                    Writeln('Rinda tika nodzeesta!');
	     end;
end;


function Full (Q: PriorityQueue): boolean;
{Pârbauda, vai rinda Q^ ir pilna}
begin
	Full:= Q^.n = MaxSize
end;

function Size (Q: PriorityQueue): Count;
{Nosaka elementu skaitu rindâ Q^}
Begin
  Size:= Q^.n;
end;


procedure Enqueue(var PQ: PriorityQueue; pr: Priority; e: StdElement);
{Prioritâtes rindâ  PQ^ izvieto  jaunu elementu e}
var p, q: NodePointer;
begin
     if  not Full(PQ)  then   with PQ^ do
        begin
             new(p);  p^.el:= e;   p^.prty:= pr;
	 if  Empty(PQ)   then                                             {prioritâtes rinda ir tukða}
	     begin
	           head:= p;   tail:=p;
	            p^.next:= nil;   p^.prior:= nil
	      end
	  else                                                                        {elementam meklç vietu}
	      if  head^.prty < pr  then                                     {izvieto pirms 1.elementa}
	           begin
		p^.next:= head;  p^.prior:= nil;
		 head^.prior:= p;   head:= p
	           end
		   else
            begin                          {izvieto vidusposmâ aiz pirmâ elementa}
		 q:= tail;
		  while (q^.prty < pr)  and  (q^.prior <> nil)  do
		         q:= q^.prior;
                                   p^.next:= q^.next;
		   p^.prior:= q;
		   if   q <> tail   then   q^.next^.prior:= p
			        else   tail:= p;
		    q^.next:= p
	             end;
	       n:= n +1
           end
end;

procedure Serve (var PQ: PriorityQueue; var pr: Priority; var e: StdElement);
{No prioritâtes rindas PQ^ nolasa elementu e}
var p: NodePointer;
begin
     if not Empty(PQ) then   with PQ^ do
	begin
	      p:= head;
                e:= head^.el;   pr:= head^.prty;                                                 {nolasa elementu}
	      if  n = 1  then                                                                {prioritâtes rinda kïûs tukða}
	            begin
		  head:= nil;   tail:= nil
	            end 	       else                                       {prioritâtes rindâ ir vairâki elementi}
	            begin                                                                         {nolasîto elementu dzçð}
		  head^.next^.prior:= nil;
		  head:= head^.next
	            end;
	       dispose (p);
                 n:= n -1
	end
end;

procedure Show(var Q: PriorityQueue);
var nod: NodePointer;
begin
  nod := Q^.head;
  Writeln('Tagad rinda izskatas saadi:');
  while (nod <> nil)do
  begin
    Writeln('Vertiba: ', nod^.el.data,' Atslega: ', nod^.el.key, ' Prioritaate: ', nod^.prty);
    nod := nod^.next;
  end;
end;

procedure Fill(var Q: PriorityQueue; createdD: boolean);
var el: StdElement;
        i: integer;
begin
  if (not createdD)then
    Writeln('Atvainojiet, rinda nav izveidota')
  else
  begin
    for i:=1 to 10 do
    begin
      el.data := Random(10)+1;
      el.key := Q^.n + 1;
      Enqueue(Q, i, el);
    end;
    Show(Q);
  end;
end;

procedure AddThree(var Q: PriorityQueue; createdD: boolean);
var elt: StdElement;
        prt: integer;
        i: integer;
begin
  if (not createdD)then
    Writeln('Piedodiet, rinda nav izveidota....')
  else
  begin
    for i:=1 to 3 do
    begin
      Writeln('Ievadiet skaitli (jauna elementa DATA lauks)');
      Readln(elt.data);
      Writeln('Ievadiet sa elementa prioritaati');
      Readln(prt);
      elt.key := Q^.n + 1;
      Enqueue(Q, prt, elt);
    end;
    Show(Q);
  end;
end;

procedure DelLessThanAverage(var Q: PriorityQueue; createdD: boolean);
var nod, tmp: NodePointer;
        s, n, avg: integer;
        tf: boolean;
        lmnt: StdElement;
begin
  s := 0;
  n := 0;
  if (not createdD)then
    Writeln('Atvainojiet, rinda nav izveidota...((((((((((')
  else
    if (Q^.head = nil)then
      Writeln('diemzeel rindaa nav elementu...')
    else
    begin
      nod := Q^.head;
      while (nod^.next <> nil)do
      begin
        s := s + nod^.el.data;
        inc(n);
        nod := nod^.next;
      end;
      avg := s div n;
      nod := Q^.head;
      Writeln('Elementu videja veertiiba: ', avg);
      while (nod^.next <> nil)do
      begin
        tf := false;
        if (nod^.el.data < avg) then
        begin
          new(tmp);
          tmp := nod;
          if ((nod^.prior <> nil) and (nod^.next <> nil)) then
          begin
            nod^.prior^.next := nod^.next;
            nod^.next^.prior := nod^.prior;
      //      nod := nod^.next;
      //      tf := true;
      //      tmp^.prior^.next := nod;
      //      lmnt.data := nod^.el.data;
      //      lmnt.key := nod^.el.key;
      //      Serve(Q, nod^.prty, lmnt);
          end else
            if ((nod^.prior <> nil) and (nod^.next = nil)) then
            begin
              Q^.tail := nod^.prior;
              nod^.prior^.next := nil;
            end else
              if ((nod^.prior = nil) and (nod^.next <> nil)) then
              begin
                Q^.head := nod^.next;
                nod^.next^.prior := nil;
              end;
          dispose(tmp);
        end;
        if (not tf)then
          nod := nod^.next;
      end;
      Show(Q);
  end;
end;

Begin
  Randomize;
  Writeln('4. laboratorijas darbs. 30. varinats "Saistiitaa forma attelota prioritates rinda"');
  Writeln('darbu izpildiija: Aleksejs Voroncovs, DITF 1.kurss, 3.grupa');

    Writeln('[1] - izveidot rindu');
    Writeln('[2] - rindas ievade ar f-jas RANDOM paliidziibu');
    Writeln('[3] - 3 jaunu elementu pievienosana');
    Writeln('[4] - visu elementu dzesana, kuri ir mazaaki par videjo vertibu');
    Writeln('[5] - Empty; [6] - Full; [7] - Size; [8] - Terminate');
    Writeln('[Esc] - iziet');

  while (C <> chr(27))do
  begin
    if KeyPressed then
    begin
      C := ReadKey;
      case C of
        '1':begin Create(Q, created); end;
        '2':begin Fill(Q, created); end;
        '3':begin AddThree(Q, created); end;
        '4':begin DelLessThanAverage(Q, created); end;
        '5':begin
                if (Empty(Q))then
                  Writeln('Rinda ir tuksa')
                else
                  Writeln('Rinda nav tuksa');
            end;
        '6':begin
                if (Full(Q))then
                  Writeln('Rinda ir pilna')
                else
                  Writeln('Rinda nav pilna');
            end;
        '7':begin
              Writeln('Rindas izmeers ir ',Size(Q));
            end;
        '8':begin Terminate(Q, created); end;
      end; {of case}
    end;
  end;
End.
