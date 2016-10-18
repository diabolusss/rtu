const  MaxSize = 15;
  type  Count = 0 .. MaxSize;
	          DataType = string;
	          KeyType = integer;
	          Edit = 1 .. 3;
                  NodePointer = ^ Node;
	          StdElement = record                                                                
                data: DataType;
	               key: KeyType
	         end;
	         Node = record                 {saraksta elements}
	               el: StdElement;         {datu ieraksts saraksta elementâ}
	               next: NodePointer;       {nâkamâ elementa râdîtâjs saraksta elementâ}
				   prior:Nodepointer
	        end;
	                  {râdîtâja datutips}
         ListInstance = record                 {vadîbas lauku ieraksts}
	               head: NodePointer;
                current: NodePointer;
	               icurrent: Count;
                n: Count
          end;
          List = ^ ListInstance;               {saraksta râdîtâjs}
var
L:List;
created,found:boolean;
i:Count;
tkey:KeyType;
e:StdElement;
k:Edit;
j:integer;
Label CASEPOINT;
{-------------------------------------------------------------------------}
procedure Create (var L: List; var created: boolean);
{Izveido jaunu tukðu sarakstu L^}
begin
	new (L);   with L^ do
	     begin
		head:= nil;  current:= nil;   icurrent:= 0;   n:= 0
	     end;
	 created:= true
end;
{-------------------------------------------------------------------------}
function Size (L: List): Count;
{Nosaka elementu skaitu sarakstâ L^}
begin
	Size:= L^.n
end;
{-------------------------------------------------------------------------}
function CurPos (L: List): Count;
{Nosaka tekoðâ elementa kârtas numuru sarakstâ L^}
begin
      CurPos:= L^.icurrent
end;
{-------------------------------------------------------------------------}
function Empty (L: List): boolean;
{Pârbauda, vai saraksts L^ ir tukðs}
begin
      Empty:= L^.n = 0
end;
{-------------------------------------------------------------------------}
function Full (L: List): boolean;
{Pârbauda, vai saraksts L^ ir pilns}
begin
      Full:= L^.n = MaxSize
end;
{-------------------------------------------------------------------------}
function First (L: List): boolean;
{Pârbauda, vai pirmais elements ir tekoðais sarakstâ L^}
begin
      First:= L^.icurrent = 1
end;
{-------------------------------------------------------------------------}              
function Last(L:List): boolean;
{Cirkulara saraksta L^ parbauda, vai pedejais elements ir tekosais elements}
begin
       Last:= L^.current = L^.head^.prior
end;

{-------------------------------------------------------------------------}
procedure FindFirst (var L: List);
{Sarakstâ L^ meklç pirmo elementu, kas kïûst par tekoðo elementu}
begin
	if   CurPos(L) > 1  then   with L^ do
	    begin            current:= head;   icurrent:= 1   	  
		end end;
{-------------------------------------------------------------------------}
procedure FindLast (var L: List);
begin
	if  CurPos(L) <> Size(L)  then   with L^ do
	     begin
	           current:= head^.prior; 
	           icurrent:= n
	     end
end;

{-------------------------------------------------------------------------}
procedure FindNext (var L: List);
begin
	if not Empty(L) then   with L^ do
	     begin
	           current:= current^.next;
	           if   icurrent = n   then   icurrent:= 1
		                     else   icurrent:= icurrent + 1;
	     end
end;


{-------------------------------------------------------------------------}
procedure FindPrior (var L: List);
begin
	if not Empty(L) then   with L^ do
	     begin
	           current:= current^.prior;
	           if  icurrent = 1  then  icurrent:= n
		                   else   icurrent:= icurrent – 1;
	    end
end;

{-------------------------------------------------------------------------}
procedure FindKey (var L: List;  tkey: KeyType; var found: boolean);
{Cirkulara saraksta L^ mekle elementu, kura atslegas lauka vertiba ir tkey. Ja meklesana ir sekmiga, samekletais elements klust par tekoso elementu}
var p: NodePointer;    k: Count;
begin
	found:= false;
	if not Empty(L) then   with L^ do
	    begin
	          k:= 1;   p:= head;
	          while  (p^.next <>   head  )  and (p^.el.key <> tkey)  do                                        							{mekle elementu}
		     begin   p:= p^.next;   k:= k + 1     end;
                 if   p^.el^.key = tkey   then
		  begin                                                                                 {sekmiga meklesana}
		        current:= p;  icurrent:= k; found:= true
		  end   end     end;

{-------------------------------------------------------------------------}
procedure Findith(var L: List; i: Count);
{Cirkulara saraksta L^ mekle elementu ar kartas numuru i. Ja meklesana ir sekmiga, samekletais elements klust par tekoso elementu}
var k: Count;
begin
	if  (i <= L^.n)  and  (not Empty(L))  then   with L^ do
	    begin
	          if  i <= (n div 2)   then                                                        {tuvak sakumam}
	               begin   current:= head;
		      for  k:= 1  to  i – 1  do
		           current:= current^.next     end
	          else                                                                              {tuvak saraksta beigam}
		 begin
		       current:=  head^.prior;
		        for  k:= n  downto  i + 1  do
		            current:= current^.prior
		  end;     icurrent:= i      end end;

{-------------------------------------------------------------------------}
procedure Retrieve (L: List; var e: StdElement);        {Tekoðâ elementa izguve sarakstâ L^}
begin
	if not Empty(L) then   with L^ do    e:= current^.el
end;
{-------------------------------------------------------------------------}
procedure Update(var L: List; k: Edit; e: StdElement);
{Sarakstâ L^ labo tekoðo elementu atbilstoði laboðanas variantam k}
begin
	if  not Empty(L)  then  with L^ do
	        case  k  of
	  1: current^.el.data:= e.data;
	  2: current^.el.key:= e.key;
	  3: current^.el:= e
	       end   end;
{-------------------------------------------------------------------------}
procedure InsertAfter (var L: List; e: StdElement);
{Cirkulara saraksta L^ aiz tekosa elementa pievieno  jaunu elementu e, kas klust par tekoso elementu}
var p: NodePointer;
begin
	if  not Full(L)  then   with L^ do
	     begin   new(p);   p^.el:= e;
	          if   Empty(L)   then                                   {saraksts ir tukss}
		 begin   head:= p;   p^.next:= p;
		             p^.prior:= p    end
	          else                                                    {saraksts nav tukss}
                         begin                                        {izkarto 4 saites}
		         current^.next^.prior:= p;
		          p^.next:= current^.next; p^prior:= current;
		          current^.next:= p    end;
	          current:= p;  icurrent:= icurrent + 1;
	          n:= n + 1 	   end    end;

{-------------------------------------------------------------------------------}			  
procedure InsertBefore (var L: List; e: StdElement);
{Cirkulara saraksta L^ pirms tekosa elementa pievieno jaunu elementu e, kas klust par tekoso elementu}
begin
	if  not Full(L)  then   with L^ do
	    begin
	          if   not Empty(L)   then
	               begin                                                                        {FindPrior(L)}
		      current:= current^.prior;
		      if   icurrent = 1   then   icurrent:= n   
	                      else   icurrent:= icurrent – 1
		 end;
	        InsertAfter(L, e);
	        if   current^.next = head   then                                                 {Last(L)}
	              begin                                                {pedejais elements klust par pirmo}
		    head:= current;
		    icurrent:= 1                end  	    end     end;

{-------------------------------------------------------------------------}
procedure Delete (var L: List);
{Cirkulara saraksta L^ dzes tekoso elementu, tekosa elementa pectecis klust par tekoso elementu}
var p: NodePointer;
begin
      if not Empty (L)  then   with L^ do
           begin      p:= current;
                 if  n = 1  then                                                                {saraksts klus tukss}
	               begin
	                     head:= nil;   current:= nil; icurrent:= 0;             end
                 else                                                                   {saraksta ir vairaki elementi}
	              begin                                                                                {izkarto 2 saites}
	                    current^.prior^.next:= current^.next;
	                    current^.next^.prior:= current^.prior;
 	                    if current^.next = head  then   icurrent:= 1; 
                                                                                      {Last(L) – dzes pedejo elementu}                                                                                                                                                                                                                                                                                                                                                             	                    current:= current^.next;
	                    if  p = head  then  head:= current;  end;
	          dispose (p);   n:= n – 1         end     end; 


{-------------------------------------------------------------------------}
procedure  Write(L:List);

var  p: NodePointer;
begin
      if   not Empty(L)   then    with L^  do
            begin
            current:= head;  icurrent:= 0;

	          while  icurrent<Size(L)  do
                       begin
           icurrent:= icurrent + 1;
           writeln(current^.el.data);
		     current:= current^.next;
	                     end
end;
              end;
{-------------------------------------------------------------------------}
begin
CASEPOINT:
writeln('menu');
writeln('1 - Create         7  - Last     ');
writeln('2 - Size           8  - FindFirst');
writeln('3 - CurPost        9 - FindLast  ');
writeln('4 - Empty          10  - Insert  ');
writeln('5 - Full           11  - Write   ');
writeln('6  - First         12  - Exit    ');
writeln('ievadi numuru');
readln(j);
case j of
1: begin
   Create(L,created);
   Writeln('Saraksts ir Izveidots');
   Goto CASEPOINT;
   end;
2: begin
   Size(L);
   Writeln('Size = ',Size(L));
   goto CASEPOINT;
   end;
3: begin
   CurPos(L);
   Writeln('Tekosais elements ir ',CurPos(L));
   goto CASEPOINT;
   end;
4: begin
   Empty(L);
   if Empty(L) then
      begin
      writeln('Saraksts ir tuks');
      end
      else
      begin
      writeln('Saraksts nav tuks');
      end;
   goto CASEPOINT;
   end;
5: begin
   Full(L);
   if Full(L) then
      begin
      writeln('Saraksts ir pilns');
      end
      else
      begin
      writeln('Saraksts nav pilns');
      end;
   goto CASEPOINT;
   end;
6: begin
   First(L);
   if First(L) then
      begin
      writeln('Tekosais elements ir pirmais');
      end
      else
      begin
      writeln('Tekosais elements nav pirmais');
      end;
   goto CASEPOINT;
   end;
7: begin
   Last(L);
   if Last(L) then
      begin
      writeln('Tekosais elements ir pedejais');
      end
      else
      begin
      writeln('Tekosais elements nav pedejais');
      end;
   goto CASEPOINT;
   end;
8: begin
   FindFirst(L);
   writeln('Tekosais elements ir pirmais');
   goto CASEPOINT;
   end;
9: begin
   FindLast(L);
   writeln('Tekosais elements ir pedejais');
   goto CASEPOINT;
   end;
10: begin
   writeln('ievadiet elementu');
   read(e.data);
   InsertAfter(L,e);
   goto CASEPOINT;
   end;
11: begin
   Write(L);
   goto CASEPOINT;
   end;
12:begin
   exit;
   end;
end;
end.