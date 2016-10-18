program saraksti21v;
uses CRT;
const MaxSize=100;                     {maksimalais elementu skaits}
type pos=1..MaxSize;                   {elementa pozicijas tips}
     Count=0..MaxSize;                 {elementu skaita tips}
     Edit=1..3;                      {labosanas variantu tips}
     datatype=string[20];            {datu lauka tips}
     keytype=integer;                {atslegas lauka tips}
     StdElement=record               {saraksta elementa tips}
        data:datatype;
        key:keytype;
        end;
     ListInstance=record              {saraksta modela  tips}
        n:Count;
        current:Count;
	el:array [pos] of StdElement;
	end;
     List=^ListInstance;
var izv,atr:boolean;
    oper,elatslega,p:integer;
    elements:StdElement;
    L:List;
    i:pos;
label MENU;

procedure Create(var L:List;var created:boolean);
{Izveido jaunu tuksu sarakstu}
begin
  new(L);
  L^.n:= 0;
  L^.current:= 0;
  created:=true;
end;

procedure Terminate(var L:List;var created:boolean);
{Likvide sarakstu}
begin
 if created then
   begin
   dispose (L);
   created:=false;
   end
end;

function Size(L: List):Count;
{Nosaka elementu skaitu saraksta}
begin
   Size:= L^.n;
end;

function Empty(L: List):boolean;
{Parbauda, vai saraksts ir tukss}
begin
   Empty:= L^.n = 0;
end;

function Full(L: List):boolean;
{Parbauda, vai saraksts ir pilns}
begin
   Full:= L^.n = MaxSize;
end;

function Last(L: List):boolean;
{Parbauda, vai pedejais elementa ir tekosais saraksta}
begin
   Last:= L^.current = L^.n;
end;

procedure FindKey(var L: List;tkey: KeyType;var found: boolean);
{Saraksta mekle elementu, kura atslegas lauka vertiba ir tkey.
 Ja meklesana ir sekmiga, samekletais elements klust par tekoso elementu}
var k:pos;done:boolean;
begin
found:=false;
   if not Empty (L) then with L^ do
     begin
     k:= 1;   done:= false;
      while (not done) and (not found) do       {mekle elementu}
        if  tkey = el [k].key  then
	begin           {sekmiga meklesana}
	current:= k;
	found:=true;
	writeln('elements ar tadu atslegu ir ',el[k].key,'  ',el[k].data);
	end
	else if k=n then done:=true
	else k:=k+1
     end
end;

procedure Find(var L:List;i:pos);
{Saraksta mekle elementu ar kartas numuru i. Ja meklesana ir sekmiga,
 samekletais elements klust par tekoso elementu}
begin
  if (not Empty(L)) and (i<=Size(L)) then
  L^.current:=i
end;

procedure Fill(var L:List;e:StdElement);
var j:integer;
begin
p:=65;
for j:=1 to 10 do
begin
  if  not Full(L)  then   with L^ do
    begin
      if  not Last(L)  then
	     for  p:=n downto current + 1 do
           el[p+1]:=el[p];           {atbrivo vietu elementam}
	  current:=current+1;
	  el[current].data:=chr(p)+chr(p+32);                                             {izvieto elementu}
	  el[current].key:=p-64;
	  inc(p);
      inc(n);
    end;
end;
end;

procedure InsertAfter(var L:List;e:StdElement);
{Saraksta aiz tekosa elementa pievieno jaunu elementu e, kas klust par tekoso elementu}
var k:pos;
begin
  if not Full(L) then with L^ do
   begin
      if  not Last (L)  then
      for  k:=n  downto  current + 1  do
      el [k+1]:= el [k];           {atbrivo vietu elementam}
      current:= current + 1;
      el [current]:= e;
      el[current].data:=chr(p)+chr(p+32);
      el[current].key:=p-64;
      inc(n);inc(p);
   end
end;

procedure Retrieve(L:List;var e:StdElement);
{Tekosa elementa izguve saraksta}
begin
  if  not Empty (L)  then  e:=L^.el [L^.current];
end;

procedure RetrieveAll(L:List);var i:integer;e:StdElement;
begin
if not Empty(L)  then
   for i:=1 to Size(L) do
     begin
     Find(L,i);
     Retrieve(L,elements);
     writeln(elements.key,'   ',elements.data);
     end;
end;

function VidVertiba(L:List; var e:StdElement):real;
var i:integer;summa:integer;
begin
  summa:=0;
  for i:=1 to Size(L) do summa:=summa+L^.el[i].key;
  VidVertiba:=summa/Size(L);
end;

begin
  Writeln('Eduards Sarneckis 21.variants');
  Writeln('DITF 1.kurss 6.grupa apl.nr 101RDB121');
  Writeln('3. majas darbs(Saraksti) - Vektoriala forma attelotais saraksts ');
  Writeln;
  izv:=false;
MENU:
  Writeln('1 - Izveidot tuksu sarakstu');
  Writeln('2 - Aizpildit un izvadit sarakstu');
  Writeln('3 - Funkciju izpildisana pec dota uzdevuma');
  Writeln('4 - Izdzest sarakstu');
  Writeln('5 - Noteikt saraksta izmeru');
  Writeln('6 - Parbaudit vai saraksts ir tukss');
  Writeln('7 - Parbaudit vai saraksts ir pilns');
  Writeln('8 - Tekosa elementa satura nolasisana');
  Writeln('9 - Jauna elementa pievenosana');
  Writeln('0 - Beigt darbu');
writeln;Writeln('Ievadiet operacijas numuru, kuru velaties izpildit: ');
Readln(oper);
if ((izv=false) and (oper<>0)) and (oper<>1) then
  begin
    Writeln;
    clrscr;
    Writeln('Nevar veikt sadu operaciju kamer nav izveidots saraksts');
    goto MENU;
  end
  else
  begin
  case (oper) of

1: Begin clrscr; Create(L,izv);Fill(L,elements);
writeln('Tika izveidots tukss saraksts');goto MENU;end;

2: Begin clrscr;RetrieveAll(L);
goto MENU;end;

3: Begin clrscr;RetrieveAll(L);
writeln('Uzspiediet Enter lai turpinatu darbu');readln;
writeln('videja vertiba sarakstaa ',VidVertiba(L,elements));writeln;
writeln('Uzspiediet Enter lai turpinatu darbu');readln;
clrscr;
i:=2;
Find(L,i);
InsertAfter(L,elements);InsertAfter(L,elements);InsertAfter(L,elements);
RetrieveAll(L);
writeln;
writeln('Saraksts pec tris jaunu elementu ievietosanas pec otra elementa');
writeln;
writeln('Uzspiediet Enter lai turpinatu darbu');
readln;
clrscr;
writeln('ievadiet atslegu, pec kuras meklet ');
read(elatslega);
FindKey(L,elatslega,atr);
writeln;
goto MENU;end;

4: Begin clrscr; Terminate(L,izv);
writeln('Saraksts ir iznicinats');goto MENU;end;

5: Begin clrscr;Writeln(' Saraksta izmers ir ',Size(L),' ieraksti');
goto MENU;end;

6: Begin clrscr;if (Empty(L)=true) then Writeln('Saraksts ir tukss')
else Writeln('Saraksts nav tukss ');goto MENU;end;

7: Begin clrscr;if (Full(L)=true) then Writeln('Saraksts ir pilns')
else Writeln('Saraksts nav pilns ');goto MENU;end;

8: Begin clrscr;Retrieve(L,elements);
writeln('tekosais elements ',elements.key,'   ',elements.data);goto MENU;end;

9: Begin clrscr; writeln('Pievieno elementu aiz tekosa elementa');
InsertAfter(L,elements);goto MENU;end;

0: Begin exit;end;

end;
end;
end.
