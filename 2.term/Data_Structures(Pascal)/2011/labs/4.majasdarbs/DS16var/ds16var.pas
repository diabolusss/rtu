{Valts Grigans 3.grupa 8.variants}
Uses Crt;
const  MaxSize = 500;

type    Count = 0 .. MaxSize;
           DataType = integer;
           KeyType = integer;
           No = 1 ..2;

           StdElement = record
           data: DataType;
           key: KeyType;
        end;

NodePointer = ^Node;
DequeInstance = record
        head: NodePointer;
        tail: NodePointer;
        n: Count;
end;

Node = record
        el: StdElement;
        next: NodePointer;
        prior: NodePointer
end;

Deque = ^DequeInstance;
temp = ^DequeInstance;
var n2,DNo,rand,vidvert,summa,elsk:integer;
SetOfRandom : set of 1..255;

procedure Create (var D: Deque; var created: boolean);
{Izveido jaunu tukÕu Deku D^}
begin
      new (D);
      D^.head:= nil;   D^.tail:= nil;   D^.n:= 0;
      created:= true;
end;
{//////////////////////////////////////}

Function Full(D:Deque):boolean;
begin
  Full:= D^.n = maxsize;
end;

Function Empty(D:Deque):boolean;
begin
  Empty:= D^.n = 0;
end;

function Size (var D: Deque): Count;
{Nosaka elementu skaitu rindƒ Q^}
begin
	Size:= D^.n ;
end;

procedure Enqueue (var D: Deque; e: StdElement; DNo: No);
{Dekƒ  D^  izvieto jaunu elementu e}
var p: NodePointer;
begin
  if  not Full(D)  then   with  D^ do
    begin
      new (p);
      p^.el:= e;
      if   Empty(D)   then                                         {vienalga, kurƒ galƒ izvietot}
      begin
      p^.next:= nil;
      p^.prior:= nil;
      head:= p;
      tail:= p;
      end else
      begin
        case DNo of
          1: begin                                                     {elementu izvieto deka sƒkumƒ}
	    p^.prior:= nil;
            p^.next:= head;
            head^.prior:= p;
            head:=p;
             end;
          2: begin                                                            {elementu izvieto deka galƒ}
	    p^.next:= nil;
            p^.prior:= tail;
            tail^.next:= p;
            tail:= p;
	    end;   end;
end;    inc(n);
     end;   end;


procedure Serve (var D: Deque; var e: StdElement; DNo: No);
{No deka  D^  nolasa  elementu e}
var p: NodePointer;
begin
      if  not Empty(D)  then   with  D^  do
          begin
	   if  n = 1   then                                                            {deks kë×s tukÕs}
	        begin    p:= head;   head:=  nil;  tail:= nil;        end
	    else   case  DNo  of
	        1: begin                                                         {elements tiks nolasŒts deka sƒkumƒ}
		   p:= head;                                                                                  {izkƒrto saites}
                   head^.next^.prior:= nil; head:= head^.next;
                   end;
	         2: begin                                                               {elements tiks nolasŒts deka galƒ}
		   p:= tail;                                                                                      {izkƒrto saites}
                   tail^.prior^.next:= nil; tail:= tail^.prior;
	          end;   end;
	        e:= p^.el;                                                                                    {nolasa elementu}
	       dispose (p);                                                                        {nolasŒto elementu dz‰Õ}
	      n:= n - 1;     end;

end;

procedure Terminate (var D: Deque; var created: boolean);          {Likvid‰ rindu Q^}
var p: NodePointer;
begin
	if  created  then
	     begin
	           if  not Empty(D) then   with D^ do
		while  head <> nil  do
		      begin
		            p:= head;
                            head:= head^.next;
		           dispose (p)
		       end;
	            dispose(D);   created:= false
	     end
end;

{/////////////////////////////////////////////////////////////}
procedure GetElement (var D:Deque; var e: StdElement);
{No deka  D^  nolasa  elementu e}
var p: NodePointer; a:integer;
begin                       {
  for a:=1 to size(D)-1 do
  begin
    p:=D^.head;
    p^.next^.prior:=nil;
    D^.head:=p^.next;          }
    p:=D^.head;
    Repeat
    Writeln(p^.el.key:5,'     ',p^.el.data);
    a:=a+1;
    p:=p^.next;
    Until p=nil;
  {end;}
end;

Procedure ShowDeque(D:Deque; E:StdElement);
begin
         Writeln ('Deka elementi:');
         Writeln (' key:      data:');
           GetElement(D,E);
end;

Procedure deleteelements(D:Deque; E:StdElement);
begin
  GetElement(D,E);
  IF E.data < vidvert then
  Serve(D,E,1);
end;

Procedure GenerateDeque(var D: Deque; n:integer);
var a,b,x:integer;
e:stdelement;
m:array [0..maxsize] of KeyType;
label backtokey;
begin
  randomize;
      Writeln('Dekam pievienotie elementi');
      Writeln (' key:     data:');
  For a:=1 to n  do
  begin
    backtokey:
    {e.key:=random(11);
    m[D^.n]:=e.key; }
    Repeat x:=1+random(250);
    until not (x in SetOfRandom);
    Include(SetOfRandom,x);
    e.key:=x;
    e.data:=({chr(97+random(25))}100+Random(1000));
    Enqueue(D,e,2);
    writeln(e.key:5,'       ',e.data );
    summa:=summa+e.data;
  end;
end;


var MyDeque:Deque;
    created,cr2:boolean;
    ch:byte;
    key1:Keytype;
    data1:DataType;
    Elem,E:StdElement;
    i:count;
    tempDeque:temp;
    j:integer;
    bool:boolean;
label sakums, beigas,enterkey;

begin
  bool:=false;
  sakums:
  clrscr;
  rand:=0;
  Writeln('Valts Grigans 3.grupa 8.variants');
  Writeln;
  Writeln ('1. izveidot Deku Create)');
  Writeln ('2. iznicinat Deku (Terminate)');
  Writeln ('3. parbaudit vai deks ir tukss (Empty)');
  Writeln ('4. pabaudit vai deks ir pilns (Full)');
  Writeln ('5. paradit Deka izmeru (Size)');
  Writeln;
  Writeln ('6. Pievienot dekaa 10 elementus ar random funkcijas palidzibu');
  Writeln ('7. Pievienot 3 jaunus elementus');
  Writeln ('8. Dzest visus elementus, kuri ir mazaki par visu elementu videjo vertibu');
  Writeln;
  TextColor(13);
  Writeln ('9. DATU STRUKTURAS IZVADE EKRANA');
  Writeln;
  TextColor(7);
  Writeln ('10. iziet no programmas');
  Writeln;
  Readln (ch);
  Case ch of
  1: begin
       Create(MyDeque, created);
       If created = true then
       Writeln('Deks ir izveidots') else
       Writeln('Neizdodas izveidot deku');
     end;
  2: begin
      If created = true then
       begin
        Terminate(MyDeque,created);
        Writeln('Deks ir iznicinats');
       end else
        Writeln('Vispirms izveidojiet deku');
     end;
  3: begin
       If created = true then
       begin
         If Empty(MyDeque) then writeln('Deks ir tukss') else
         Writeln('Deks nav tukss'); end
       else Writeln('Vispirms izveidojiet deku');
     end;
  4: begin
       If created = true then
       begin
         If Full(MyDeque) then writeln('Deks ir pilns') else
         Writeln('Deks nav pilns'); end
       else Writeln('Vispirms izveidojiet deku');
     end;
  5: begin
       If created = true then
       begin
          writeln('Deka izmers ir: ',Size(MyDeque))
       end else
       Writeln('Vispirms izveidojiet deku');
     end;
  6: begin
       If created = true then
       begin
       If bool=true then
         Writeln('Jus jau to tikko izdariijaat!') else
       begin
       GenerateDeque(MyDeque,10);
       Writeln('Tika uzgenereti 10 elementi un pievienoti dekam');
       bool:=true;
       end;
       end else Writeln('Vispirms izveidojiet deku');
     end;
  7: begin
       If created = true then
       begin
         Writeln('Ievadiet 3 jaunu elementu atslegas un datus');
         For j:=1 to 3 do
         begin
         enterkey:
         Writeln('Ievadiet ',j,'. elementa atslegu - skiatlis no 1 lidz 255');
         Readln(key1);
         If (key1 in SetOfRandom) then
           begin
           writeln('TADA ATSLEGA JAU EKSISTE');
           writeln;
           goto enterkey;
           end else
           begin
         Writeln('Ievadiet ',j,'. elementa datus - skaitlis (integer)');
         Readln(data1);
             E.Key:=key1;
             E.Data:=data1;
         Enqueue(MyDeque,E,2);
           end; end;
           ShowDeque(MyDeque,E);
       end else Writeln('Vispirms izveidojiet sarakstu');
     end;
  8: begin
       If created = true then
       begin
         If Empty(MyDeque) = false then
         begin
           vidvert:=summa div Size(MyDeque);
           Writeln('Elementu videja vertiba ir ',vidvert);
           Writeln;
           Writeln('Pec dzeshanas palikusie');
          {
           If E.Data < vidvert then
           Serve(MyDeque,E,1);  }
           Terminate(TempDeque,cr2);
           Create(TempDeque,cr2);

           Serve(MyDeque,E,1);
           If E.data > vidvert then
           {Enqueue (TempDeque,E,1);
           ShowDeque(TempDeque,E)  }
           Writeln(E.key,'   ',E.data);

         end else Writeln('Deks ir tukss');
      end else Writeln('Vispirms izveidojiet deku');
     end;
  9: begin
       If created = true then
       begin
         If empty(MyDeque) = false then
         begin
         Writeln ('Deka elementi:');
         Writeln (' key:      data:');
           TempDeque:=MyDeque;
           GetElement(TempDeque,E);
           TempDeque:=MyDeque;
         end else Writeln('Deks ir tukss');
       end else Writeln ('Vispirms izveidojiet deku');
     end;
  10: begin
     goto beigas;
     end;
  end;
  Writeln;
  Writeln ('lai turpinatu nospiediet Enter');
  Readln;
  goto sakums;
readln;
beigas:
end.
