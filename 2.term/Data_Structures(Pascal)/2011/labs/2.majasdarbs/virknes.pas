program rakstzimju_virnes;
uses Crt;


const  MaxLength = 255;               {uzdod lietot�js}
type  StringPos  = 1 .. MaxLength; {poz�cijas tips}
         StringLen  = 0 .. MaxLength;      {skaita tips}
          String1 = ^StringInstance;
                                                 {virknes r�d�t�ja tips}
           StringInstance =  record          {mode�a tips}
                   strlen: StringLen;     {teko�ais garums}
                   data: array [StringPos]  of  char
           end;
Var C: char;
        a, d: integer;
        cr: boolean;
        b, Flagf: String;
        St, comp: String1;
Label START;

procedure  MakeEmpty (var S: String1);
{Rakstz�mju virkni  S^  padara par tuk�u virkni}
begin
       S^.strlen := 0;
end;

function  Empty (S: String1): boolean;
{P�rbauda, vai rakstz�mju virkne S^ ir tuk�a}
begin
      Empty := S^.strlen = 0
end;


procedure  ReadString1 (var S: String1);
{Ar tastat�ru ievada rakstz�mju virkni S^}
var  pos : StringLen;
begin
      writeln('Ievadiet rakstz�mju virkni vien� ievadrind�');
       MakeEmpty(S);                                                                            {virkne S^ k��st tuk�a}
        pos := 0;
        with  S^   do
               begin
                     repeat                          {virknes S^ ievade, kam�r tiek nospiests tausti�� Enter}
                            pos :=  pos+1;    data[pos] := ReadKey;    write(data[pos])
                     until   (ord(data[pos]) = 13)   or   (pos > MaxLength+1);
                     strlen := pos-1                                                        {tausti�a Enter kodu ignor�}
                end;
  Writeln('Ierakst�ts!');
end;

procedure  WriteString (S: String1);
{Rakstz�mju virkni  S^  izvada displeja ekr�n�}
var  i: StringPos;
begin
      if not Empty(S)   then    with S^  do
      begin
                  for   i := 1   to strlen   do    write(data[i]);                    {virknes S^ teksta izvade}
                   writeln;
                    readln                                              {gaida , kam�r tiek nospiests tausti�� Enter}
              end
 end;

procedure  Create (var S: String1;  var created: boolean);
{Izveido jaunu tuk�u rakstz�mju virkni S^}
begin
      new(S);
      S^.strlen := 0;
      Writeln('Rakstz�mju virkne tika izveidota.');
      created := true
  end;

procedure  Terminate (var S: String1;  var created: boolean);
{Likvid� rakstz�mju virkni S^}
begin
       if  created   then
       begin
         S^.strlen := 0;
         created := false;
         Writeln('Rakstz�mju virkne tika izn�cin�ta.');
       end;
 end;

function  Length1 (S: String1): StringLen;
{Nosaka rakstz�mju virknes S^ teko�o garumu}
begin
       Length1 := S^.strlen;
end;



function  Full (S: String1): boolean;
{P�rbauda, vai  rakstz�mju virkne S^ ir pilna}
begin
       Full := S^.strlen = MaxLength
end;

procedure  Concatenate (var S1: String1;  var S2: String);
{Rakstz�mju virknei S1^ gal� pievieno rakstz�mju virkni S2^}
var  i: StringPos;
       k: StringLen;
begin
      if  S2<>''   then
             begin                                                           {nosaka pievienojamo rakstz�mju skaitu}
                   if   Length1(S1)+length(S2) <= MaxLength   then   k := Length(S2)
                   else    k := MaxLength- Length1(S1);
                    with  S1^  do
                             begin                                                                                    {savirkn��ana}
                                   for  i := 1  to  k  do    data[strlen+i] := S2[i];
                                   strlen := strlen+k
                              end
                 end;
      Writeln('Apvienots!');
end;

procedure  Delete (var S: String1;  pos: StringPos;  len: integer);
{Rakstz�mju virkn� S^, s�kot ar poz�ciju pos, dz�� apak�virkni, kuras garums ir len}
var i: StringLen;
begin
      if  ( len > 0)  and  (Length1(S) >= pos+len-1)  then    with  S^  do
             begin                                                                                              {dz�� apak�virkni}
                   for  i := pos+len  to  strlen  do  data[i-len] := data[i];
                   strlen := strlen-len;
                   Writeln('Nodz�sts!');
               end
end;
procedure  Insert (var S1: String1;  S2: String;  pos: StringPos);
{Rakstz�mju virkn� S1^, s�kot ar poz�ciju pos, iestarpina rakstz�mju virkni S2^}
var  len1, len2, len: StringLen;
       i: StringPos;
begin
      len1 := Length1(S1);
      len2 := length(S2);                   {fiks� virk�u teko�os garumus}
      len := len1+len2;
      if(S2<>'')and(len<=MaxLength)and(pos <=len1+1)  then
        with   S1^  do
        begin                                                {atbr�vo vietu iestarpin�majai virknei S2^}
          for i:=len1 downto pos do data[i+len2] :=  data [i];                                            {apak�virkni S2^ izvieto virkn� S1^}
            for  i := 1  to  len2   do   data[pos+i-1] :=  S2[i];
              strlen := strlen+len2;
            end;
end;
function  Match (S1: String1; S2:String; pos: StringPos): boolean;
{P�rbauda, s�kot ar poz�ciju pos, vai rakstz�mju virkne  S1^  satur apak�virkni  S2^}
var  i, last: integer;
       continue: boolean;
begin
      i := 1;
      last := length(S2);                                            {uzdod p�rbaudes diapazonu}
      continue := true;
      Match := false;                                                       {s�kumv�rt�bas}
      if  (S2<>'')  and  (Length1(S1) >= Length(S2)+pos-1)   then
        while    continue  and  (S2[i] = S1^.data[pos])  do     {sakrit�bas p�rbaude}
          if   i = last   then
          begin                                                         { p�rbaude beidzas sekm�gi}
            continue :=false;
            Match :=true;
          end
          else
          begin                                                                           {p�rbaudi turpina}
            i := i+1;
            pos := pos+1;
          end
      else
        Writeln(pos);
end;

function Equal (S1: String1; S2:String): boolean;
{P�rbauda, vai rakstz�mju virknes S1^ un S2^ ir identiskas}
var len1, len2: StringLen;
begin
       len1 := Length1(S1);       len2 := Length(S2);                {fiks� virk�u teko�os garumus}
       Equal := false;                                                                                        {s�kumv�rt�ba}
       if   ( len1 = 0 )  and   ( len2 = 0 )    then   Equal := true   {tuk�as virknes ir identiskas}
       else    if   len1 = len2   then   Equal := Match(S1, S2, 1)             {sakrit�bas p�rbaude}
end;

function  Find (S1: String1; S2: String; pos: StringPos): StringLen;
var  kbegin, kend: integer;
       found: boolean;
begin
       kbegin := pos;       kend := Length1(S1)-length(S2)+1;             {mekl��anas diapazons}
       found := false;                                                                                          {s�kumv�rt�ba}
       while   (not found)  and  (kbegin <= kend)    do                     {apak�virknes mekl��ana}
              if  Match(S1, S2, kbegin)    then found := true          {mekl��ana pabeigta sekm�gi}
              else  kbegin := kbegin+1;                               {uzdod n�kamo mekl��anas poz�ciju}
        if   found   then  Find := kbegin   else   Find :=0                          {mekl��anas rezult�ts}
end;


Begin
  START:
  cr := false;
  new(comp);
  ClrScr;
  Writeln('Laboratorijas darbs nr. 2: "Rakstz�mju virknes" 30. variants');
  Writeln('Izstr�d�ja: Aleksejs Voroncovs. DITF 3. grupa. Apliec�bas numurs 101RDB013');
  Writeln('1 - iveidot rakstz�mju virkni; 2 - izn�cin�t rakstz�mju virkni; 3 - iesparust; 4 - dz�st');
  Writeln('5 - uzrakst�t virkni; 6 - ievad�t no tastat�ras; 7 - Equal; 8 - Concatenate; 9 - Match; [Esc] - iziet');
  Writeln('f - mekl�t');
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
          Writeln('Ievadiet poz�cijas numuru.');
          Readln(a);
          Writeln('Ievadiet apak�virknes saturu.');
          Readln(b);
          comp^.data:=b;
          Insert(St, b, a);
        end else begin
          Flagf := 'not exist';
        end;
      if(C=chr(52))then
        if(cr)then
        begin
          Writeln('Ievadiet poz�ciju, no kuras ir j�dz��');
          Readln(a);
          Writeln('Ievadiet dz��am�s apak�virknes garumu.');
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
          Writeln('Ievadiet sal�dzin�jamo virkni');
          Readln(b);
          comp^.data := b;
          if(Equal(St, b))then
            Writeln('Ir vien�di')
          else
            Writeln('Nav vien�di');
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
          Writeln('Ievadiet apak�virkni.');
          Readln(b);
          Writeln('Ievadiet poz�ciju, no kuras sal�dzin�t.');
          Readln(a);
          comp^.data:=b;
          if(Match(St, b, a))then
            Writeln('T�da apak�virkne eksist�.')
          else
            Writeln('T�da apak�virkne neeksist�.');
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
          Writeln('Ievadiet apak�virkni');
          Readln(b);
          Writeln('Ievadiet poz�ciju, no kuras j�mekl�.');
          Readln(a);
          if(Find(St, b, a)>0)then
            Writeln('Ir, s�kot ar ',Find(St, b, a),' poz�ciju')
          else
            Writeln('Nav t�das apak�virknes.');
        end else begin
          Flagf:='not exist';
        end;
      if(Flagf='not exist')then
        Writeln('Atvainojiet, virkne neeksist�.');
    end;
  Until (C=chr(27));
End.
