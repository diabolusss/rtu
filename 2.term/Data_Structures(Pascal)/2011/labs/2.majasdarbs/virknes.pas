program rakstzimju_virnes;
uses Crt;


const  MaxLength = 255;               {uzdod lietotâjs}
type  StringPos  = 1 .. MaxLength; {pozîcijas tips}
         StringLen  = 0 .. MaxLength;      {skaita tips}
          String1 = ^StringInstance;
                                                 {virknes râdîtâja tips}
           StringInstance =  record          {modeïa tips}
                   strlen: StringLen;     {tekoðais garums}
                   data: array [StringPos]  of  char
           end;
Var C: char;
        a, d: integer;
        cr: boolean;
        b, Flagf: String;
        St, comp: String1;
Label START;

procedure  MakeEmpty (var S: String1);
{Rakstzîmju virkni  S^  padara par tukðu virkni}
begin
       S^.strlen := 0;
end;

function  Empty (S: String1): boolean;
{Pârbauda, vai rakstzîmju virkne S^ ir tukða}
begin
      Empty := S^.strlen = 0
end;


procedure  ReadString1 (var S: String1);
{Ar tastatûru ievada rakstzîmju virkni S^}
var  pos : StringLen;
begin
      writeln('Ievadiet rakstzîmju virkni vienâ ievadrindâ');
       MakeEmpty(S);                                                                            {virkne S^ kïûst tukða}
        pos := 0;
        with  S^   do
               begin
                     repeat                          {virknes S^ ievade, kamçr tiek nospiests taustiòð Enter}
                            pos :=  pos+1;    data[pos] := ReadKey;    write(data[pos])
                     until   (ord(data[pos]) = 13)   or   (pos > MaxLength+1);
                     strlen := pos-1                                                        {taustiòa Enter kodu ignorç}
                end;
  Writeln('IerakstŒts!');
end;

procedure  WriteString (S: String1);
{Rakstzîmju virkni  S^  izvada displeja ekrânâ}
var  i: StringPos;
begin
      if not Empty(S)   then    with S^  do
      begin
                  for   i := 1   to strlen   do    write(data[i]);                    {virknes S^ teksta izvade}
                   writeln;
                    readln                                              {gaida , kamçr tiek nospiests taustiòð Enter}
              end
 end;

procedure  Create (var S: String1;  var created: boolean);
{Izveido jaunu tukðu rakstzîmju virkni S^}
begin
      new(S);
      S^.strlen := 0;
      Writeln('RakstzŒmju virkne tika izveidota.');
      created := true
  end;

procedure  Terminate (var S: String1;  var created: boolean);
{Likvidç rakstzîmju virkni S^}
begin
       if  created   then
       begin
         S^.strlen := 0;
         created := false;
         Writeln('RakstzŒmju virkne tika iznŒcinƒta.');
       end;
 end;

function  Length1 (S: String1): StringLen;
{Nosaka rakstzîmju virknes S^ tekoðo garumu}
begin
       Length1 := S^.strlen;
end;



function  Full (S: String1): boolean;
{Pârbauda, vai  rakstzîmju virkne S^ ir pilna}
begin
       Full := S^.strlen = MaxLength
end;

procedure  Concatenate (var S1: String1;  var S2: String);
{Rakstzîmju virknei S1^ galâ pievieno rakstzîmju virkni S2^}
var  i: StringPos;
       k: StringLen;
begin
      if  S2<>''   then
             begin                                                           {nosaka pievienojamo rakstzîmju skaitu}
                   if   Length1(S1)+length(S2) <= MaxLength   then   k := Length(S2)
                   else    k := MaxLength- Length1(S1);
                    with  S1^  do
                             begin                                                                                    {savirknçðana}
                                   for  i := 1  to  k  do    data[strlen+i] := S2[i];
                                   strlen := strlen+k
                              end
                 end;
      Writeln('Apvienots!');
end;

procedure  Delete (var S: String1;  pos: StringPos;  len: integer);
{Rakstzîmju virknç S^, sâkot ar pozîciju pos, dzçð apakðvirkni, kuras garums ir len}
var i: StringLen;
begin
      if  ( len > 0)  and  (Length1(S) >= pos+len-1)  then    with  S^  do
             begin                                                                                              {dzçð apakðvirkni}
                   for  i := pos+len  to  strlen  do  data[i-len] := data[i];
                   strlen := strlen-len;
                   Writeln('Nodz‰sts!');
               end
end;
procedure  Insert (var S1: String1;  S2: String;  pos: StringPos);
{Rakstzîmju virknç S1^, sâkot ar pozîciju pos, iestarpina rakstzîmju virkni S2^}
var  len1, len2, len: StringLen;
       i: StringPos;
begin
      len1 := Length1(S1);
      len2 := length(S2);                   {fiksç virkòu tekoðos garumus}
      len := len1+len2;
      if(S2<>'')and(len<=MaxLength)and(pos <=len1+1)  then
        with   S1^  do
        begin                                                {atbrîvo vietu iestarpinâmajai virknei S2^}
          for i:=len1 downto pos do data[i+len2] :=  data [i];                                            {apakðvirkni S2^ izvieto virknç S1^}
            for  i := 1  to  len2   do   data[pos+i-1] :=  S2[i];
              strlen := strlen+len2;
            end;
end;
function  Match (S1: String1; S2:String; pos: StringPos): boolean;
{Pârbauda, sâkot ar pozîciju pos, vai rakstzîmju virkne  S1^  satur apakðvirkni  S2^}
var  i, last: integer;
       continue: boolean;
begin
      i := 1;
      last := length(S2);                                            {uzdod pârbaudes diapazonu}
      continue := true;
      Match := false;                                                       {sâkumvçrtîbas}
      if  (S2<>'')  and  (Length1(S1) >= Length(S2)+pos-1)   then
        while    continue  and  (S2[i] = S1^.data[pos])  do     {sakritîbas pârbaude}
          if   i = last   then
          begin                                                         { pârbaude beidzas sekmîgi}
            continue :=false;
            Match :=true;
          end
          else
          begin                                                                           {pârbaudi turpina}
            i := i+1;
            pos := pos+1;
          end
      else
        Writeln(pos);
end;

function Equal (S1: String1; S2:String): boolean;
{Pârbauda, vai rakstzîmju virknes S1^ un S2^ ir identiskas}
var len1, len2: StringLen;
begin
       len1 := Length1(S1);       len2 := Length(S2);                {fiksç virkòu tekoðos garumus}
       Equal := false;                                                                                        {sâkumvçrtîba}
       if   ( len1 = 0 )  and   ( len2 = 0 )    then   Equal := true   {tukðas virknes ir identiskas}
       else    if   len1 = len2   then   Equal := Match(S1, S2, 1)             {sakritîbas pârbaude}
end;

function  Find (S1: String1; S2: String; pos: StringPos): StringLen;
var  kbegin, kend: integer;
       found: boolean;
begin
       kbegin := pos;       kend := Length1(S1)-length(S2)+1;             {meklçðanas diapazons}
       found := false;                                                                                          {sâkumvçrtîba}
       while   (not found)  and  (kbegin <= kend)    do                     {apakðvirknes meklçðana}
              if  Match(S1, S2, kbegin)    then found := true          {meklçðana pabeigta sekmîgi}
              else  kbegin := kbegin+1;                               {uzdod nâkamo meklçðanas pozîciju}
        if   found   then  Find := kbegin   else   Find :=0                          {meklçðanas rezultâts}
end;


Begin
  START:
  cr := false;
  new(comp);
  ClrScr;
  Writeln('Laboratorijas darbs nr. 2: "RakstzŒmju virknes" 30. variants');
  Writeln('Izstrƒdƒja: Aleksejs Voroncovs. DITF 3. grupa. ApliecŒbas numurs 101RDB013');
  Writeln('1 - iveidot rakstzŒmju virkni; 2 - iznŒcinƒt rakstzŒmju virkni; 3 - iesparust; 4 - dz‰st');
  Writeln('5 - uzrakstŒt virkni; 6 - ievadŒt no tastat×ras; 7 - Equal; 8 - Concatenate; 9 - Match; [Esc] - iziet');
  Writeln('f - mekl‰t');
  Repeat
    Flagf:='';
    if KeyPressed then
    begin
      C:=ReadKey;
      if(C=chr(49))then
        Create(St, cr);
      if(C=chr(50))then
        Terminate(St, cr);
      if(C=chr(51))then
        if(cr)then
        begin
          Writeln('Ievadiet pozŒcijas numuru.');
          Readln(a);
          Writeln('Ievadiet apakÕvirknes saturu.');
          Readln(b);
          comp^.data:=b;
          Insert(St, b, a);
        end else begin
          Flagf := 'not exist';
        end;
      if(C=chr(52))then
        if(cr)then
        begin
          Writeln('Ievadiet pozŒciju, no kuras ir jƒdz‰Õ');
          Readln(a);
          Writeln('Ievadiet dz‰Õamƒs apakÕvirknes garumu.');
          Readln(d);
          Delete(St, a, d);
        end else begin
          Flagf := 'not exist';
        end;
      if(C=chr(53))then
        if(cr)then
        begin
          WriteString(St);
        end else begin
          Flagf := 'not exist';
        end;
      if(C=chr(55))then
        if(cr)then
        begin
          Writeln();
          Writeln('Ievadiet salŒdzinƒjamo virkni');
          Readln(b);
          comp^.data := b;
          if(Equal(St, b))then
            Writeln('Ir vienƒdi')
          else
            Writeln('Nav vienƒdi');
        end else begin
          Flagf := 'not exist';
        end;
      if(C=chr(56))then
        if(cr)then
        begin
          Writeln('Ievadiet pievienojamo virkni.');
          Readln(b);
          comp^.data:=b;
          Concatenate(St, b);
        end else begin
          Flagf:='not exist';
        end;
      if(C=chr(57))then
        if(cr)then
        begin
          Writeln('Ievadiet apakÕvirkni.');
          Readln(b);
          Writeln('Ievadiet pozŒciju, no kuras salŒdzinƒt.');
          Readln(a);
          comp^.data:=b;
          if(Match(St, b, a))then
            Writeln('Tƒda apakÕvirkne eksist‰.')
          else
            Writeln('Tƒda apakÕvirkne neeksist‰.');
        end else begin
          Flagf:='not exist';
        end;
      if(C=chr(54))then
        if(cr)then
        begin
          ReadString1(St);
        end else begin
          Flagf:='not exist';
        end;
      if(C=chr(102))then
        if(cr)then
        begin
          Writeln('Ievadiet apakÕvirkni');
          Readln(b);
          Writeln('Ievadiet pozŒciju, no kuras jƒmekl‰.');
          Readln(a);
          if(Find(St, b, a)>0)then
            Writeln('Ir, sƒkot ar ',Find(St, b, a),' pozŒciju')
          else
            Writeln('Nav tƒdas apakÕvirknes.');
        end else begin
          Flagf:='not exist';
        end;
      if(Flagf='not exist')then
        Writeln('Atvainojiet, virkne neeksist‰.');
    end;
  Until (C=chr(27));
End.
