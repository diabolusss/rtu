program rakstzimju_virnes;
uses Crt;


const  MaxLength = 255;               {uzdod lietotajs}
type  StringPos  = 1 .. MaxLength; {pozicijas tips}
         StringLen  = 0 .. MaxLength;      {skaita tips}
          String1 = ^StringInstance;
                                                 {virknes raditaja tips}
           StringInstance =  record          {modeïa tips}
                   strlen: StringLen;     {tekosais garums}
                   data: array [StringPos]  of  char
           end;
Var C: char;
        a, d: integer;
        cr: boolean;
        b, Flagf: String;
        St, comp: String1;
Label START;

procedure  MakeEmpty (var S: String1);
{Rakstzimju virkni  S^  padara par tukshu virkni}
begin
       S^.strlen := 0;
end;

function  Empty (S: String1): boolean;
{Parbauda, vai rakstzimju virkne S^ ir tuksha}
begin
      Empty := S^.strlen = 0
end;


procedure  ReadString1 (var S: String1);
{Ar tastaturu ievada rakstzimju virkni S^}
var  pos : StringLen;
begin
      writeln('Ievadiet rakstzimju virkni vienaa ievadrindaa');
       MakeEmpty(S);                  {virkne S^ klust tuksha}
        pos := 0;
        with  S^   do
               begin
                     repeat         {virknes S^ ievade, kamer tiek nospiests taustins Enter}
                            pos :=  pos+1;    data[pos] := ReadKey;    write(data[pos])
                     until   (ord(data[pos]) = 13)   or   (pos > MaxLength+1);
                     strlen := pos-1              {taustina Enter kodu ignore}
                end;
  Writeln('Ierakstits!');
end;

procedure  WriteString (S: String1);
{Rakstzimju virkni  S^  izvada displeja ekranaa}
var  i: StringPos;
begin
      if not Empty(S)   then    with S^  do
      begin
                  for   i := 1   to strlen   do    write(data[i]);     {virknes S^ teksta izvade}
                   writeln;
                    readln      {gaida , kamer tiek nospiests taustins Enter}
              end
 end;

procedure  Create (var S: String1;  var created: boolean);
{Izveido jaunu tuksu rakstzimju virkni S^}
begin
      new(S);
      S^.strlen := 0;
      Writeln('Rakstzimju virkne tika izveidota.');
      created := true
  end;

procedure  Terminate (var S: String1;  var created: boolean);
{Likvidee rakstzimju virkni S^}
begin
       if  created   then
       begin
         S^.strlen := 0;
         created := false;
         Writeln('Rakstzimju virkne tika iznicinata.');
       end;
 end;

function  Length1 (S: String1): StringLen;
{Nosaka rakstzimju virknes S^ tekoso garumu}
begin
       Length1 := S^.strlen;
end;



function  Full (S: String1): boolean;
{Parbauda, vai  rakstzimju virkne S^ ir pilna}
begin
       Full := S^.strlen = MaxLength
end;

procedure  Concatenate (var S1: String1;  var S2: String);
{Rakstzîmju virknei S1^ galaa pievieno rakstzimju virkni S2^}
var  i: StringPos;
       k: StringLen;
begin
      if  S2<>''   then
             begin        {nosaka pievienojamo rakstzimju skaitu}
                   if   Length1(S1)+length(S2) <= MaxLength   then   k := Length(S2)
                   else    k := MaxLength- Length1(S1);
                    with  S1^  do
                             begin
                                   for  i := 1  to  k  do    data[strlen+i] := S2[i];
                                   strlen := strlen+k
                              end
                 end;
      Writeln('Apvienots!');
end;

procedure  Delete (var S: String1;  pos: StringPos;  len: integer);
{Rakstzimju virknee S^, sakot ar poziciju pos, dzesh apaksvirkni, kuras garums ir len}
var i: StringLen;
begin
      if  ( len > 0)  and  (Length1(S) >= pos+len-1)  then    with  S^  do
             begin
                   for  i := pos+len  to  strlen  do  data[i-len] := data[i];
                   strlen := strlen-len;
                   Writeln('Nodzeests!');
               end
end;
procedure  Insert (var S1: String1;  S2: String;  pos: StringPos);
{Rakstzimju virknee S1^, sakot ar poziciju pos, iestarpina rakstzimju virkni S2^}
var  len1, len2, len: StringLen;
       i: StringPos;
begin
      len1 := Length1(S1);
      len2 := length(S2);    {fiksee virknu tekosos garumus}
      len := len1+len2;
      if(S2<>'')and(len<=MaxLength)and(pos <=len1+1)  then
        with   S1^  do
        begin              {atbrivo vietu iestarpinamajai virknei S2^}
          for i:=len1 downto pos do data[i+len2] :=  data [i];     {apaksvirkni S2^ izvieto virknee S1^}
            for  i := 1  to  len2   do   data[pos+i-1] :=  S2[i];
              strlen := strlen+len2;
            end;
end;
function  Match (S1: String1; S2:String; pos: StringPos): boolean;
{Parbauda, sakot ar poziciju pos, vai rakstzimju virkne  S1^  satur apaksvirkni  S2^}
var  i, last: integer;
       continue: boolean;
begin
      i := 1;
      last := length(S2);  {uzdod parbaudes diapazonu}
      continue := true;
      Match := false;    {sakumvertibas}
      if  (S2<>'')  and  (Length1(S1) >= Length(S2)+pos-1)   then
        while    continue  and  (S2[i] = S1^.data[pos])  do     {sakritibas parbaude}
          if   i = last   then
          begin                { parbaude beidzas sekmigi}
            continue :=false;
            Match :=true;
          end
          else
          begin            {parbaudi turpina}
            i := i+1;
            pos := pos+1;
          end
      else
        Writeln(pos);
end;

function Equal (S1: String1; S2:String): boolean;
{Parbauda, vai rakstzimju virknes S1^ un S2^ ir identiskas}
var len1, len2: StringLen;
begin
       len1 := Length1(S1);       len2 := Length(S2);     {fiksee virknu tekosos garumus}
       Equal := false;                                                                                        {sâkumvçrtîba}
       if   ( len1 = 0 )  and   ( len2 = 0 )    then   Equal := true   {tuksas virknes ir identiskas}
       else    if   len1 = len2   then   Equal := Match(S1, S2, 1)             {sakritibas parbaude}
end;

function  Find (S1: String1; S2: String; pos: StringPos): StringLen;
var  kbegin, kend: integer;
       found: boolean;
begin
       kbegin := pos;       kend := Length1(S1)-length(S2)+1;   {meklesanas diapazons}
       found := false;                                                                                          {sâkumvçrtîba}
       while   (not found)  and  (kbegin <= kend)    do     {apaksvirknes mekleðana}
              if  Match(S1, S2, kbegin)    then found := true          {meklesana pabeigta sekmigi}
              else  kbegin := kbegin+1;                      {uzdod nakamo meklçðanas poziciju}
        if   found   then  Find := kbegin   else   Find :=0    {meklesanas rezultats}
end;


Begin
  START:
  cr := false;
  new(comp);
  ClrScr;
  Writeln('Vards Uzvards:x. DITF 1. grupa. Apl. Nr.101RDB013. 6.variants');
  Writeln('1 - izveidot rakstzimju virkni; 2 - iznicinat rakstzimju virkni; 3 - iespraust; 4 - dzest');
  Writeln('5 - uzrakstit virkni; 6 - ievadit no tastaturas; 7 - Equal; 8 - Concatenate; 9 - Match; f - meklet');
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
          Writeln('Ievadiet pozicijas numuru.');
          Readln(a);
          Writeln('Ievadiet apaksvirknes saturu.');
          Readln(b);
          comp^.data:=b;
          Insert(St, b, a);
        end else begin
          Flagf := 'neeksistee';
        end;
      if(C=chr(52))then
        if(cr)then
        begin
          Writeln('Ievadiet poziciju, no kuras ir jadzesh');
          Readln(a);
          Writeln('Ievadiet dzesamas apaksvirknes garumu.');
          Readln(d);
          Delete(St, a, d);
        end else begin
          Flagf := 'neeksistee';
        end;
      if(C=chr(53))then
        if(cr)then
        begin
          WriteString(St);
        end else begin
          Flagf := 'neeksistee';
        end;
      if(C=chr(55))then
        if(cr)then
        begin
          Writeln();
          Writeln('Ievadiet salidzinajamo virkni');
          Readln(b);
          comp^.data := b;
          if(Equal(St, b))then
            Writeln('Ir vienadi')
          else
            Writeln('Nav vienadi');
        end else begin
          Flagf := 'neeksistee';
        end;
      if(C=chr(56))then
        if(cr)then
        begin
          Writeln('Ievadiet pievienojamo virkni.');
          Readln(b);
          comp^.data:=b;
          Concatenate(St, b);
        end else begin
          Flagf:='neeksistee';
        end;
      if(C=chr(57))then
        if(cr)then
        begin
          Writeln('Ievadiet apaksvirkni.');
          Readln(b);
          Writeln('Ievadiet poziciju, no kuras salidzinat.');
          Readln(a);
          comp^.data:=b;
          if(Match(St, b, a))then
            Writeln('Tada apaksvirkne eksiste.')
          else
            Writeln('Tada apaksvirkne neeksistee.');
        end else begin
          Flagf:='neeksistee';
        end;
      if(C=chr(54))then
        if(cr)then
        begin
          ReadString1(St);
        end else begin
          Flagf:='neeksistee';
        end;
      if(C=chr(102))then
        if(cr)then
        begin
          Writeln('Ievadiet apaksvirkni');
          Readln(b);
          Writeln('Ievadiet poziciju, no kuras jameklee.');
          Readln(a);
          if(Find(St, b, a)>0)then
            Writeln('Ir, sakot ar ',Find(St, b, a),' poziciju')
          else
            Writeln('Nav tadas apaksvirknes.');
        end else begin
          Flagf:='neeksistee';
        end;
      if(Flagf='neeksistee')then
        Writeln('Atvainojiet, virkne neeksistee.');
    end;
  Until (C=chr(27));
End.
