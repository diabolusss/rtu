program saraksti;
uses crt;
const  MaxSize = 100;                             {maksimalais elementu skaits}
type    Position = 1 .. MaxSize;                         {elementa pozicijas tips}
	     Count = 0 .. MaxSize;                                {elementu skaita tips}
          Edit = 1 .. 3;                                           {labosanas variantu tips}
	     DataType = string [20];                                    {datu lauka tips}
	     KeyType = integer;                                     {atslegas lauka tips}
	     StdElement = record                              {saraksta elementa tips}
		   data: DataType;
	 	   key: KeyType; 	     end;
	     ListInstance = record                               {saraksta modela  tips}
		   n:  Count;
		   current: Count;
		   el: array  [Position]  of  StdElement;
	    end;
	    List = ^ ListInstance;
var sozdan,atrasts:boolean;
	id,atslega,ka:integer;
	elem:StdElement;
	L:List;
	i:Position;
label IZVELE,ending;

procedure Create (var L: List; var created: boolean);
{Izveido jaunu tuksu sarakstu L^}
begin
       new(L);
       L^.n:= 0;
       L^.current:= 0;
       created:= true;
end;


procedure Terminate (var L: List; var created: boolean);
{Likvide sarakstu L^}
begin
	if   created   then
	      begin
	            dispose (L);
	            created:= false;
	       end
end;

function Size (L: List): Count;
{Nosaka elementu skaitu saraksta L^}
begin
	Size:= L^.n;
end;

function Empty (L: List): boolean;
{Parbauda, vai saraksts L^ ir tukss}
begin
	Empty:= L^.n = 0;
end;

function Full (L: List): boolean;
{Parbauda, vai saraksts L^ ir pilns}
begin
	Full:= L^.n = MaxSize;
end;

function Last (L: List): boolean;
{Parbauda, vai pedejais elementa ir tekosais saraksta L^}
begin
      Last:= L^.current = L^.n;
end;


procedure FindKey (var L: List;  tkey: KeyType;var found: boolean);
{Saraksta L^ mekle elementu, kura atslegas lauka vertiba ir tkey.
 Ja meklesana ir sekmiga, samekletais elements klust par tekoso elementu}
var k: Position;
      done: boolean;
begin
      found:= false;
      if   not Empty (L)   then  with L^ do
           begin
	 k:= 1;   done:= false;
	 while (not done)  and  (not found) do       {mekle elementu}
	       if  tkey = el [k].key  then
	            begin           {sekmiga meklesana}
	                  current:= k;
					  found:= true;
					  writeln('elements ar tadu atslegu ir ',el[k].key,'  ',el[k].data);
	             end
	         else  if   k = n  then   done:= true
	                                else   k:= k +1
            end
end;

procedure Findith (var L: List; i: Position);
{Saraksta L^ mekle elementu ar kartas numuru i. Ja meklesana ir sekmiga,
 samekletais elements klust par tekoso elementu}
begin
      if  (not Empty(L))  and  (i <= Size (L))  then
			L^. current:= i
end;

procedure Fill(var L:List; e:StdElement);
var j:integer;
begin
ka:=65;
for j:=1 to 10 do
begin
  if  not Full (L)  then   with L^ do
    begin
      if  not Last (L)  then
	     for  ka:= n  downto  current + 1  do
           el [ka+1]:= el [ka];           {atbrivo vietu elementam}
	  current:= current + 1;
	  el[current].data:=chr(ka);            {izvieto elementu}
	  el[current].key:=ka-64;
	  inc(ka);
      inc(n);
    end;
end;
end;

procedure InsertAfter (var L:List; e: StdElement);
{Saraksta L^ aiz tekosa elementa pievieno jaunu elementu e, kas klust par tekoso elementu}
var k: Position;
begin
      if  not Full (L)  then   with L^ do
           begin
	 if  not Last (L)  then
	      for  k:= n  downto  current + 1  do
                            el [k+1]:= el [k];           {atbrivo vietu elementam}
	  current:= current + 1;
	  el [current]:= e;
      el[current].data:=chr(ka);
	  el[current].key:=ka-64;
      inc(n);
	  inc(ka);
          end
end;

procedure Retrieve (L: List; var e: StdElement);
{Tekosa elementa izguve saraksta L^}
begin
      if  not Empty (L)  then  e:= L^.el [L ^. current];
	  {if not Empty(L) then E := L^.Current^.El;}
end;

procedure Show(L:List);
var i:integer;
    e:StdElement;
begin
    if  not Empty (L)  then
         for i:=1 to Size(L) do
           begin
 	      Findith(L,i);
          Retrieve(L,elem);
	      writeln(elem.key:5, '',elem.data:6);
           end;
end;

function Average (L:List; var e:StdElement):real;
var i:integer;
    vid:integer;
begin
vid:=0;
for i:=1 to Size(L) do vid:=vid+L^.el[i].key;
Average:=vid/Size(L);
end;

procedure Menu;
begin
  Writeln('1. Saraksta izveidosana.......................Create');
  Writeln('2. Paradit sarakstu uz ekrana.................Show');
  Writeln('3. Izpildit funkcijas peec uzdevemu secibas');
  Writeln('4. Saraksta iznicinasana......................Terminate');
  Writeln('5. Saraksta izmera noteiksana.................Size');
  Writeln('6. Parbaudit vai saraksts ir tukss............Empty');
  Writeln('7. Parbaudit vai saraksts ir pilns............Full');
  Writeln('8. Tekosa elementa satura nolasisana..........Retrieve');
  Writeln('9. Jauna elementa pievienosana................InsertAfter');
  Writeln('10.Iziet......................................Exit');
end;

begin
 clrscr;
  Writeln('Informacija par darba izpilditaju:');
  Writeln('Vards Uzvards:Dmitrijs Dragans, 5.variants');
  Writeln('1.kurss, 6.grupa, Apl.nr 101RDB179');
  Writeln('Darbs ar sarakstiem ');
  Writeln('Saraksta veids - Vektoriala forma attelotais saraksts ');
  writeln;
  writeln('Lai turpinatu, uzpiediet jebkuru pogu');
  readln;
  sozdan:=false;
  clrscr;
IZVELE:
writeln;
  Menu;
writeln;
Writeln('Ludzu izvelejaties proceduru, kuru gribat veikt ar sarakstu: ');
Readln(id);
if ((sozdan = false) and (id <> 1)) then
  begin
    Writeln;
    clrscr;
    Writeln('Nevar veikt sadu operaciju kamer nav izveidots saraksts');
    GOTO IZVELE;
  end
  else
  begin
      case id of
      1 : Begin
            clrscr;
            Create(L,sozdan);
			Fill(L,elem);
            writeln('Saraksts tika izveidots!');
            GOTO IZVELE;
          end;
	  2 : Begin
			clrscr;
			Show(L);
			GOTO IZVELE;
		  end;
      3 : Begin
            clrscr;
			Writeln('1.Saraksta apiesana');
			Show(L);
			writeln;
			writeln('Lai turpinatu, uzpiediet jebkuru pogu');
            readln;
			clrscr;
			Writeln('8.Saraksta elementu videjas vertibas izskaitlosana');writeln;
			writeln('Videja vertiba sarakstaa ir izskaitlota: ',Average(L,elem):4:2);
			writeln;
			writeln('Lai turpinatu, uzpiediet jebkuru pogu');
            readln;
			clrscr;
			Writeln('1.Saraksta apiesana');
			Show(L); writeln;
			writeln('Lai turpinatu, uzpiediet jebkuru pogu');
            readln;
			clrscr;
			Writeln('6.Tris jaunu elementu pievienosana saraksta pec otra elementa');
			i:=2;
			Findith(L,i);
			InsertAfter(L,elem);
			InsertAfter(L,elem);
			InsertAfter(L,elem);
			writeln;
			writeln('Sarakstaa tika pievienoti tris jauni elementi pec otra elementa');
			writeln;
			writeln('Lai turpinatu, uzpiediet jebkuru pogu');
            readln;
			clrscr;
			Writeln('1.Saraksta apiesana');
			Show(L);
			writeln;
			writeln('Lai turpinatu, uzpiediet jebkuru pogu');
			readln;
			clrscr;
			writeln('ievadiet atslegu, pec kuras meklet ');
			read(atslega);
			FindKey(L,atslega,atrasts);	
			writeln;
			GOTO IZVELE;
          end;
      4 : Begin
             clrscr;
            Terminate(L,sozdan);
            writeln('Saraksts tika iznicinats');
            GOTO IZVELE;
          end;
      5 : Begin
            clrscr;
            Writeln(' Sarakstaa ir ',Size(L),' ieraksti');
            GOTO IZVELE;
          end;
      6 : Begin
            clrscr;
            if (Empty(L) = true) then Writeln('Saraksts ir tukss')
            else Writeln('Saraksts nav tukss ');
            GOTO IZVELE;
          end;
      7 : Begin
            clrscr;
            if (Full(L) = true) then Writeln('Saraksts ir pilns')
            else Writeln('Saraksts nav pilns ');
            GOTO IZVELE;
          end;
      8 : Begin
            clrscr;
			Retrieve(L,elem);
	        writeln('Tekosais elements sarakstaa ir ',elem.key, '   ',elem.data);
			GOTO IZVELE;
          end;
      9 : Begin
            clrscr;
			writeln('Aiz tekosa elementa tika pievienots jauns elements');
			InsertAfter(L,elem);
			GOTO IZVELE;
          end;
      10 : Begin
            GOTO ending;
          end;

  end;
  end;
ending:
end.
