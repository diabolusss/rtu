program indusskij_kod;
Uses Crt;

Type
        Count = 0..15;
        DataType = String[25];
        KeyType = Byte;
        StdElement = Record
          Data: DataType;
          Key: KeyType;
        end;
NodePointer = ^Node;
             Node = record
               El : StdElement;   { Dannije }
             Next : NodePointer;  { Potomok }
             Prio : NodePointer;  { Predok }
                    end;

             List = ^ListInstance;
     ListInstance = record
             Head : NodePointer;
          Current : NodePointer;
         ICurrent : Count;
                N : Count;
                    end;


Var i: integer;
L : List;
Elem : StdElement;
CH, C : char;
SType : String;
Pos,Ith:Count;
tKey:KeyType;
Found, Kaspersky:Boolean;
P, PSlave : NodePointer;



Procedure Create(var L:List);
begin
  New(L);   { videljaem mesto v pamjati }
  L^.Head := nil;    { v pustotu }
  L^.Current := nil; { v pustotu }
  L^.ICurrent := 0;
  L^.N := 0;
  Writeln('Saraksts izveidots!');
end;

Function Empty( L: List) : boolean;
begin
  Empty:=L^.Head=nil;
end;

Function Last( L: List) : boolean;
begin
  if L^.Current^.Next = nil then Last := true
                             else Last := false;
end;

Procedure FindFirst(var L: List);
begin
  if not ( Empty(L) ) then
    begin
      L^.Current := L^.Head;
      L^.ICurrent := 1;
    end;
end;

Procedure Terminate(var L:List);
var P : NodePointer;
begin
  if not ( Empty(L) ) then
   Begin
    FindFirst(L);
    repeat
      P := L^.Current;
      L^.Current:=L^.Current^.Next;
      Dispose(P);
    until L^.Current = nil;
    Dispose(L);
   End;
   Writeln('Saraksts tika nodzests!');
end;

Function Full( L: List) : boolean;
begin
  Full:=L^.n = 15;
end;

Function Size( L: List) : Count;
begin
  Size := L^.N;
end;

Procedure InsertAfter( var L: List; E: StdElement);
var
    P: NodePointer;
begin
  if not Full(L) then  { Esli spisok ne pust }
    begin
      if Empty(L) then  { esli pustoj }
        begin
          new(P);   { pamjat dlja novogo elementa }
          P^.El := E;
          L^.Head := P;
          P^.Next := nil;
          P^.Prio := nil;
          L^.Current := P;
          L^.ICurrent := 1;
          L^.N := 1;
        end
      else  { v spiske uzze est' elementi }
        begin
          IF Not Last(L) Then { esli ne poslednij }
             Begin
              new(P);
              P^.El := E;
              L^.Current^.Next^.Prio := P;
              P^.Next := L^.Current^.Next;
              P^.Prio := L^.Current;
              L^.Current^.Next := P
             End
           Else     { Last Element}
              Begin
                new(P);
                P^.El := E;
                L^.Current^.Next:=P;
                P^.Prio:=L^.Current;
                P^.Next:=nil;  { v pusototu }
              End;
          L^.Current := P;
          L^.ICurrent:=L^.ICurrent+1;  { porjad.nom uvel na 1 }
          L^.N:=L^.N+1; { Chislo elementov uvel na 1 }
        end;
    end;
    Writeln('Ieraksts tika pievienots!');
end;

procedure getCurrent(var L:List);
begin
  Writeln('Tekosais elements ir:');
  Writeln(L^.Current^.El.Data,' ar atsleegu ', L^.Current^.El.Key);
end;

procedure DelLowerThanAverage(var L: List);
var it:integer;
        pp, p1: NodePointer;
        tf : boolean;
        avg : String;
begin
  pp:=L^.Head;
  tf := false;
  while (pp^.Next<>nil)do
  begin
    if (tf)then
    begin
      tf := false;
      if (pp^.El.Data>pp^.Next^.El.Data)then
        avg := pp^.Next^.El.Data
      else
        avg := pp^.El.Data;
    end
    else
    begin
      tf := true;
      if (pp^.El.Data>pp^.Next^.El.Data)then
        avg := pp^.Next^.El.Data
      else
        avg := pp^.El.Data;
    end;
    pp:=pp^.Next;
  end;
  pp:=L^.Head;
  while(pp<>nil)do
  begin
    if(pp^.El.Data<=avg)then
    begin
      p1:=pp;
      if(pp^.Prio <> nil)then
      begin
        if (pp^.Next <> nil)then
          pp^.Prio^.Next := pp^.Next;
      end else
        L^.Head := pp^.Next;
      Dispose(p1);
    end;
    pp:=pp^.Next;
  end;
  Writeln('Visi elementi, kas ir mazaki par videjo, tika nodzesti');
end;

Procedure FindKey(var L:List;Tkey:KeyType;var Found:boolean);
var P:NodePointer;
    K:Count;
begin
   Found:=false;    { poka escho ne naschli }
   if not Empty(L) then with L^ do { esli spisok ne pust }
   begin
     P:=Head;K:=1;  { P - pervij element }
        { poka ne dostigli konca ili ne naschli }
       while (P^.Next<>nil) and (P^.El.Key<>Tkey) do
        begin
          P:=P^.Next;inc(K); { perehodim na sled element }
        end;
       if P^.El.Key = Tkey then { esli naschli element }
         begin
                 {to on stanovitsja tekuchem }
          Current:=P; ICurrent:=K; Found:=True;
         end;
   end;
end;



begin
  Writeln('Programmu izstraadaaja students Aleksejs Voroncovs apl. nr. 101RDB013');
  Writeln('Izvelieties proceduuru:');
  Writeln('1 - Create; 2 - Terminate; 3 - Empty; 4 - Full; 5 - Size');
  Writeln('6 - pievinot jaunu; 7 - nolasiit tekoso; 8 - dzest sesto pec kartas');
  Writeln('9 - Visu elementu dzesana, kuri ir mazaki par vid. vertibu; 0 - meklesana');
  Writeln('i - izvadit visu sarakstu uz ekrana; Esc - iziet');
  Repeat
    if KeyPressed then
    begin
      C := ReadKey;
      if(C = chr(49))then
        Create(L);
      if(C = chr(50))then
        Terminate(L);
      if(C = chr(51))then
        if(Empty(L))then
          Writeln('Tukss saraksts')
        else
          Writeln('Saraksts nav tukss');
      if(C = chr(52))then
        if(Full(L))then
          Writeln('Saraksts ir pilns')
        else
          Writeln('Saraksts nav pilns');
      if(C = chr(53))then
        Writeln('Saraksta izmers ir ',Size(L));
      if(C = chr(54))then
      begin
        Writeln('Ievadiet datus');
        Readln(Elem.Data);
        Writeln('Ievadiet atslegu');
        Readln(Elem.Key);
        InsertAfter(L, Elem);
      end;
      if(C = chr(55))then
        getCurrent(L);
      if(C = chr(56))then
      begin
        P := L^.Head;
        Kaspersky := false;
        for i:=1 to 5 do
          if (P^.Next<>nil)then
            P := P^.Next
          else
            Kaspersky := true;
        PSlave := P;
        if not Kaspersky then
        begin
          P^.Prio^.Next := P^.Next;
          Dispose(PSlave);
          Writeln('Sestais ieraksts tika nodzests!');
        end else
         Writeln('Atvainojiet, sarakstaa ir paaraak maz elementu.(((');
      end;
      if(C = chr(48))then
      begin
        Writeln('Ievadiet atsleegu');
        Readln(tKey);
        FindKey(L, tKey, Found);
        if(Found)then
          Writeln('Ieraksts ir atrasts, tagad vins ir tekosais')
        else
          Writeln('Ieraksts netika atrasts');
      end;
      if(C = chr(57))then
        DelLowerThanAverage(L);
      if (C = chr(105))then
      begin
        P := L^.Head;
        while(P <> nil)do
        begin
          Writeln(P^.El.Data,' ar atslegu ',P^.El.Key);
          P := P^.Next;
        end;
      end;
    end;
  Until (C = chr(27));
end.
