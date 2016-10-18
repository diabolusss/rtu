unit funcs;

interface

const MaxSize = 50;

type DataType = string[40];
     KeyType = word;
     Count = 0..MaxSize;
     StdElement = record
                   Data:DataType;
                   Key:KeyType;
                  end;
     SNodePointer = ^SNode;
     SNode = record
              el:StdElement;
              next:SNodePointer;
             end;
     Stack = ^StackInstance;
     StackInstance = record
                      STop:SNodePointer;
                      SEnd:SNodePointer;
                      n:Count;
                     end;
var
 S:Stack;

Procedure Create(var S:Stack; var Created:boolean);
Procedure Terminate(var S:Stack; var Created:boolean);
Function  Empty(S:Stack):boolean;
Function  Full(S:Stack):boolean;
Function  Size(S:Stack):Count;
Procedure Push(var S:Stack; el:StdElement);
Procedure Pop(var S:stack; var el:StdElement);

implementation

Procedure Create(var S:Stack; var Created:boolean);
 { Atbrivo atmina vietu jaunam stekam un izveido to. }
begin
 new(S);
 S^.STop:=nil; {Augsas raditajs norada uz neko}
 S^.SEnd:=nil; {Apaksas raditajs norada uz neko}
 S^.n:=0; {Steka garums=0}
 Created:=TRUE; {Izveidots}
end;

Procedure Terminate(var S:Stack; var Created:boolean);
 { Iznicina steku. }
var p:SNodePointer;
begin
 if NOT Empty(S) then {ja nav tukss}
  while S^.SEnd<>nil do begin {kamer apaksas raditajs uz kaut ko norada}
   p:=S^.SEnd; {p=apaksas raditajs}
   S^.SEnd:=S^.SEnd^.Next; {apaksas raditajs paiet par vienu uz augsu}
   dispose(p); {iznicina p}
  end;
 dispose(S); {iznicina steku}
 Created:=FALSE; {nav izveidots}
end;

Function Empty(S:Stack):boolean;
 { Nosaka, vai steks ir tukss. }
begin
 Empty:=S^.STop=nil; {tukss ir tad, ja augsas raditajs norada uz neko}
end;

Function Full(S:Stack):boolean;
 { Nosaka, vai steks ir pilns. }
begin
 Full:=S^.n=MaxSize; {pilns ir, kad steka garums = maksimalais garums}
end;

Function Size(S:Stack):Count;
 { Nosaka steka garumu. }
begin
 Size:=S^.n;
end;

Procedure Push(var S:Stack; el:StdElement);
 { Pievieno jaunu elementu steka beigas. }
var p:SNodePointer;
begin
 if NOT Full(S) then begin {ja nav pilns}
  new(p);
  p^.el:=el; {p datu lauks klust vienads ar el}
  p^.next:=nil; {nakosais aiz p ir nekas}
  if Empty(S) then {ja tukss}
   S^.SEnd:=p {apaksas raditajs norada uz p}
  else
   S^.STop^.next:=p; {augsas raditaja nakosais norada uz p}
  S^.STop:=p; {augsas raditajs ir p}
  inc(S^.n); {pagarina steka garumu}
 end;
end;

Procedure Pop(var S:stack; var el:StdElement);
 { Nolasa un iznicina pedejo steka elementu. }
var p:SNodePointer;
begin
 if NOT Empty(S) then begin {ja nav tukss}
  p:=S^.STop; {p ir augsas raditajs}
  el:=p^.el; {el ir p elementa datu lauks}
  if S^.n=1 then begin {ja steka garums ir 1}
   S^.STop:=nil; {augsas raditajs norada uz neko}
   S^.SEnd:=nil; {apaksas raditajs norada uz neko}
  end else begin
   S^.STop:=S^.SEnd; {augsas raditajs norada uz apaksas raditaju (uz apaksu)}
   while S^.STop^.next<>p do {kamer augsas raditajs nav p}
    S^.STop:=S^.STop^.next; {augsas raditajs pavirzas par vienu uz augsu}
   S^.STop^.next:=nil; {augsas raditaja nakosais norada uz neko}
  end;
  dispose(p); {iznicinam p}
  dec(S^.n); {samazinam steka garumu}
 end;
end;

end.