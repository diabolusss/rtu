program steks;
uses crt;
const MaxSize=20;
type Count=0..MaxSize;
DataType=string[30];
KeyType=integer;

StdElement=record
            Data:DataType;
            Key:KeyType
           end;

NodePointer=^Node;
Node=record
      el:StdElement;
      Next:NodePointer;
     end;

Stack=^StackInstance;
StackInstance=record
               top:NodePointer;
               n:Count
               end;

var ievads,i,j:integer;
S1,S2:Stack;
Elem:StdElement;
tKey:KeyType;
created:boolean;

function Empty(S:Stack):boolean;
{Paarbauda, vai steks S^ ir tukss}
begin
Empty:=S^.top=nil     {Empty:=S^.n=0}
end;


Procedure Create(var S:stack; var created:boolean);
{izveido jaunu tuksu steku S^}
begin
new(S);
S^.top:=nil;
S^.n:=0;
created:=true
end;


Procedure Terminate(var S:stack; var created:boolean);
{Likvide steku S^}
var p:NodePointer;
begin
     if created then with S^ do
        begin
          if not Empty(S) then
             while top<>nil do
                   begin
                       p:=top; top:=top^.next;
                       dispose(p)
                     end;
                   dispose(S);
                   created:=false
                 end
              end;


function Size(S:Stack):Count;
{Nosaka elementu skaitu stekaa S^}
begin
Size:=S^.n
end;


function Full(S:Stack):boolean;
{Paarbauda, vai steks S^ ir pilns}
begin
Full:=S^.n=MaxSize
end;


procedure Push(var S:Stack; e :StdElement);
{Stekaa S^ izveido jaunu elementu e}
var p:NodePointer;
begin
if not Full(S) then with S^ do
  begin
   new(p);
   p^.el:=e;
    if Empty(S) then {steks ir tukss}
     begin
      top:=p;
      p^.next:=nil
     end
     else             {steks nav tukss}
      begin  {izkaarto 2 saites}
       p^.next:=top;
       top:=p
      end;
    n:=n+1
  end
end;


procedure Pop(var S:Stack; var e:StdElement);
{No Steka S^ nolasa elementu e}
var p:NodePointer;
begin
if not Empty(S) then with S^ do
 begin
 e:=top^.el;     {nolasa elementu}
 p:=top;
 top:=top^.next;  {nolasito elementu stekaa dzees}
 Dispose(p);
 n:=n-1
 end
end;



Procedure StackView(var S:Stack; var S2: stack);
{Steka izvade uz ekrana}
Var i:Count; E:StdElement;t: integer;
Begin
  For i:=1 to Size(S) do
   Begin
    Pop(S,e);
    Write(E.Data); For t:=Length(E.data) to 25 do Write(' '); Write(E.Key); writeln;
    Push(S2,e);
   End;
End;


Procedure Exchange(var S:Stack;var S2:Stack);
Var i: integer;E,El: StdElement;
Begin
 For i:=1 to Size(S2) do
  Begin
   Pop(S2,e);
   El.data:=e.data; El.key:=e.key;
   Push(S,e);
  End;
End;

procedure BTop(var S:stack; tkey:KeyType);
{Apmaina vietam 1 elementu un un elementu ar atsleglauka vertibu tkey}
var p,q:NodePointer;
begin
if not Empty(S) then
 with S^ do
  Begin
   p:=top; q:=nil;
    while (p^.el.key<>tkey) and (p<>nil) do
     begin
       q:=p;{priekstecis}
       p:=p^.next;
     end;
     if p<>nil then
      begin
       elem:=top^.el; top^.el:=p^.el; p^.el:=elem;
      end;
   end;
end;

Procedure uzd;
begin
writeln('Jekaterina Piskunova, 6.grupa,  apl.num.:101RDB156');
writeln('18.variants - Saistita forma attelotais steks');
writeln;
writeln('1 - Create(Izveidot jaunu steku)');
writeln;
writeln('2 - Terminate(Izdzest steku)');
writeln;
writeln('3 - Uzdevuma operaciju izpilde pec secibas(1,7,3,7,6,7)');
writeln;
writeln('4 - Iziet no programas');
writeln;
end;

Begin
     ClrScr;
     Uzd;
     Repeat
     Readln(ievads);
     Case ievads of

1:begin
  Create(S1,created);
  Create(S2,created);
  Writeln('Steks tiek izveidots');
  end;

2:If created=true then
    Begin
     Terminate(S1,created);
     Terminate(S2,created);
     Writeln('Steks tika dzests');
    end
     else
      writeln('Steks nav izveidots,nav ko dzest');

3:If created=true then
      Begin
      {10 elementu izveidosana ar Random izmantosanu}
       ClrScr;
       Writeln;
       Writeln('Nospiediet Enter, lai pievienotu stekam 10 elementus');
       readln;
       clrscr;
         if Size(S1)=MaxSize then
         writeln('Nevar pievienot jaunus elementus,jo steks ir pilns')
         else
          begin
           Randomize;
           For i:=1 to 10 do
            begin
             elem.Data:=' ';
             For j:=1 to (Random(12)+1) do
             elem.Data:=elem.Data+'da';
             elem.Key:=i;
             Push(S1,elem);
          end;
          writeln;
          StackView(S1,S2);
          Exchange(S1,S2);
          writeln;
          writeln;
          writeln;

          {3 jaunu elementu pievienosana stekam}
          writeln('Nospiediet Enter, lai pievienotu 3 jaunus elementus');
          writeln;
          readln;
          clrscr;
          if Size(S1)=MaxSize then
            writeln('Nevar pievienot elementus, jo steks ir pilns')
          else begin
            randomize;
            for i:=1 to 3 do begin
              elem.Data:=' ';
              For j:=1 to (Random(8)+1) do
                elem.data:=elem.Data+'net';
              elem.Key:=10+i;
              Push(S1,elem);
            end;
             StackView(S1,S2);
             Exchange(S1,S2);
          end;
          writeln;
          writeln;
          writeln;

          {Elementu apmaina}
          writeln('Nospiediet Enter, lai apmainitu vietam 1. elementu un elementu ar atsleglauka vertibu tkey');
          Readln;
          ClrScr;
          writeln;
          writeln;
          writeln;
          Write('Ievadiet elementa atslegu(tkey), ar kuru mainit pirmo:');
          readln(tkey);
          writeln;
          writeln;
          BTop(S1,tkey);
          StackView(S1,S2);
          writeln;
          writeln;

          {Steka izvade uz ekrana}
          Writeln('Nospiediet Enter, lai paraditu informaciju');
          Readln;
          Terminate(S1,created);
          Terminate(S2,created);
          ClrScr;
          Uzd;
          Writeln;
       end;
       end
     else writeln('Steks nav izveidots');
   end;
  until (ievads=4);
end.
