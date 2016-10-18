Unit mu;

Interface
Uses crt;
const  MaxLength = 255;               {uzdod lietotājs}
type  StringPos  = 1 .. MaxLength; {pozīcijas tips}
         StringLen  = 0 .. MaxLength;      {skaita tips}
          Str = ^StringInstance;
                                                 {virknes rādītāja tips}
           StringInstance =  record          {modeļa tips}
                   strlen: StringLen;     {tekošais garums}
                   data: array [StringPos]  of  char
             end;                             {virknes teksta lauks}
procedure  Create (var S: Str;  var created: boolean);
procedure  Terminate (var S: Str;  var created: boolean);
function  Length (S: Str): StringLen;
function  Empty (S: Str): boolean;
function  Full (S: Str): boolean;
procedure  Append (var S: Str;  ch: char);
procedure  Concatenate (var S1: Str;  var S2: Str);
procedure  Substring (S1: Str;  var S2: Str;  pos: StringPos;  len:  StringLen);
procedure  Delete (var S: Str;  pos: StringPos;  len: StringLen);
procedure  Insert (var S1: Str;  S2: Str;  pos: StringPos);
function  Match (S1, S2: Str;  pos: StringPos): boolean;
function  Find (S1, S2: Str;  pos: StringPos): StringLen;
procedure  ReadString (var S: Str);
procedure  ReadString1 (var S: Str);
procedure  WriteString (S: Str);
procedure  MakeEmpty (var S: Str);
procedure  Remove (var S: Str;  pos: StringPos;  var ch: char);
procedure  Reverse  (var S: Str);
function Equal (S1, S2: Str): boolean;
function  Polindrome (S: Str): boolean;

Implementation
procedure  Create (var S: Str;  var created: boolean);
{Izveido jaunu tukšu rakstzīmju virkni S^}
begin
      new(S);
      S^.strlen := 0;
      created := true
  end;
procedure  Terminate (var S: Str;  var created: boolean);
{Likvidē rakstzīmju virkni S^}
begin
       if  created   then
             begin   S^.strlen := 0;   created := false   end
 end;
function  Length (S: Str): StringLen;
{Nosaka rakstzīmju virknes S^ tekošo garumu}
begin
       Length := S^.strlen
end;
function  Empty (S: Str): boolean;
{Pārbauda, vai rakstzīmju virkne S^ ir tukša}
begin
      Empty := S^.strlen = 0
                  end;



function  Full (S: Str): boolean;
{Pārbauda, vai  rakstzīmju virkne S^ ir pilna}
begin
       Full := S^.strlen = MaxLength
end;

procedure  Append (var S: Str;  ch: char);
{Rakstzīmju virknei S^ galā pievieno rakstzīmi ch}
begin
      if  not Full(S)   then   with  S^  do
             begin
                   data[strlen+1] := ch;
                    strlen := strlen+1
              end
end;
procedure  Concatenate (var S1: Str;  var S2: Str);
{Rakstzīmju virknei S1^ galā pievieno rakstzīmju virkni S2^}
var  i: StringPos;
       k: StringLen;
begin
      if   not Empty(S2)   then
             begin                                                           {nosaka pievienojamo rakstzīmju skaitu}
                   if   Length(S1)+Length(S2) <= MaxLength   then   k := Length(S2)
                   else    k := MaxLength- Length(S1);
                    with  S1^  do
                             begin                                                                                    {savirknēšana}
                                   for  i := 1  to  k  do    data[strlen+i] := S2^.data[i];
                                   strlen := strlen+k
                              end
                 end
end;
procedure  Substring (S1: Str;  var S2: Str;  pos: StringPos;  len:  StringLen);
                 {No rakstzīmju virknes S1^, sākot ar pozīciju pos,  izdala apakšvirkni S2^,
                   kuras garums ir len}
var  i: StringPos;
begin
      if  ( len > 0)  and  (Length(S1) >= pos+len-1)  then    with  S2^  do
             begin                                                                                    {izveido apakšvirkni S2}
                   for  i := 1  to  len  do   data[i] :=  S1^.data[pos+i-1];
                   strlen := len
             end
end;

procedure  Delete (var S: Str;  pos: StringPos;  len: StringLen);
{Rakstzīmju virknē S^, sākot ar pozīciju pos, dzēš apakšvirkni, kuras garums ir len}
var i: StringLen;
begin
      if  ( len > 0)  and  (Length(S) >= pos+len-1)  then    with  S^  do
             begin                                                                                              {dzēš apakšvirkni}
                   for  i := pos+len  to  strlen  do  data[i-len] := data[i];
                   strlen := strlen-len
               end
end;
procedure  Insert (var S1: Str;  S2: Str;  pos: StringPos);
{Rakstzīmju virknē S1^, sākot ar pozīciju pos, iestarpina rakstzīmju virkni S2^}
var  len1, len2, len: StringLen;
       i: StringPos;
begin
      len1 := Length(S1);       len2 := Length(S2);                   {fiksē virkņu tekošos garumus}
      len := len1+len2;
      if   (not  Empty(S2))  and  ( len <= MaxLength)  and  (pos <=len1+1)  then
             with   S1^  do
                     begin                                                {atbrīvo vietu iestarpināmajai virknei S2^}
                           for  i := len1  downto   pos   do  data[i+len2] :=  data [i];
                                                                                                         {apakšvirkni S2^ izvieto virknē S1^}
                           for  i := 1  to  len2   do   data[pos+i-1] :=  S2^.data[i];
                           strlen := strlen+len2
                     end
end;
function  Match (S1, S2: Str;  pos: StringPos): boolean;
{Pārbauda, sākot ar pozīciju pos, vai rakstzīmju virkne  S1^  satur apakšvirkni  S2^}
var  i, last: StringPos;
       continue: boolean;
begin
      i := 1;        last := Length(S2);                                            {uzdod pārbaudes diapazonu}
      continue := true;       Match := false;                                                       {sākumvērtības}
      if  (not Empty(S2))  and  (Length(S1) >= Length(S2)+pos-1)   then
                while    continue  and  (S2^.data[i] = S1^.data[pos])  do     {sakritības pārbaude}
                         if   i = last   then
                                 begin                                                         { pārbaude beidzas sekmīgi}
                                       continue :=false;       Match :=true
                                  end
                          else
                               begin                                                                           {pārbaudi turpina}
                                     i := i+1;     pos := pos+1
                                end
end;


function  Find (S1, S2: Str;  pos: StringPos): StringLen;
{Lineārās meklēšanas algoritms. Rakstzīmju virknē S1^, sākot ar pozīciju pos, meklē  apakšvirkni S2^. Meklēšanas rezultāts ir tā pozīcija, sākot ar kuru apakšvirkne sameklēta, vai arī 0, ja meklēšana beigusies nesekmīgi}
var  kbegin, kend: StringPos;
       found: boolean;
begin
       kbegin := pos;       kend := Length(S1)-Length(S2)+1;             {meklēšanas diapazons}
       found := false;                                                                                          {sākumvērtība}
       while   (not found)  and  (kbegin <= kend)    do                     {apakšvirknes meklēšana}
              if  Match(S1, S2, kbegin)    then found := true          {meklēšana pabeigta sekmīgi}
              else  kbegin := kbegin+1;                               {uzdod nākamo meklēšanas pozīciju}
        if   found   then  Find := kbegin   else   Find :=0                          {meklēšanas rezultāts}
end;

procedure  ReadString (var S: Str);
{Ar tastatūru ievada rakstzīmju virkni S^}
var  ch : char;
begin
      writeln('Ievadiet rakstzimju virkni viena ievadrinda');
       MakeEmpty(S);                                                                           {virkne S^  kļūst tukša}
       while   not eoln    do              {virknes ievade, kamēr vien nav nospiests taustiņš Enter}
               if  Length(S) < MaxLength   then
                     begin
                            read(ch);                                                              {ievada kārtējo rakstzīmi}
                            Append(S, ch)                     {ievadīto rakstzīmi pievieno virknei  S^  galā}
                      end
end;
procedure  ReadString1 (var S: Str);
{Ar tastatūru ievada rakstzīmju virkni S^}
var  pos : StringLen;
begin
      writeln('‘Ievadiet rakstzimju virkni viena ievadrinda');
       MakeEmpty(S);                                                                            {virkne S^ kļūst tukša}
        pos := 0;
        with  S^   do
               begin
                     repeat                          {virknes S^ ievade, kamēr tiek nospiests taustiņš Enter}
                            pos :=  pos+1;    data[pos] := ReadKey;    write(data[pos])
                     until   (ord(data[pos]) = 13)   or   (pos > MaxLength+1);
                     strlen := pos-1                                                        {taustiņa Enter kodu ignorē}
                end
end;


procedure  WriteString (S: Str);
{Rakstzīmju virkni  S^  izvada displeja ekrānā}
var  i: StringPos;
begin
      if   not Empty(S)   then    with S^  do
            begin
                  for   i := 1   to strlen   do    write(data[i]);                    {virknes S^ teksta izvade}
                   writeln;
                                             {gaida , kamēr tiek nospiests taustiņš Enter}
              end
 end;
procedure  MakeEmpty (var S: Str);
{Rakstzīmju virkni  S^  padara par tukšu virkni}
begin
       S^.strlen := 0
end;
procedure  Remove (var S: Str;  pos: StringPos;  var ch: char);
{No rakstzīmju virknes S^  pozīcijas pos aizvāc rakstzīmi  ch}
var  i: StringPos;
begin
      if   not Empty(S)   then    with   S^   do
             begin
                   ch := data[pos];                             {dzēšamo rakstzīmi piešķir mainīgajam ch}
                    for  i := pos+1    to   strlen      do            {dzēš virknes rakstzīmi pozīcijā pos}
                           data[i-1] := data[i];
                     strlen := strlen-1
              end
end;
procedure  Reverse  (var S: Str);
{Rakstzīmju virkni  S^  apgriež otrādi (reversē)}
var  i: StringPos;
       ch: char;
begin
      if   Length(S) > 1   then     with   S^  do
             for   i := 1   to    ( strlen div 2 )     do                {no 1.pozīcijas līdz viduspunktam}
                    begin                                                                   {izpilda virknes reversēšanu}
                          ch := data[i];
                          data[i] := data[strlen-i+1];
                          data[strlen-i+1] := ch
                      end
    end;
function Equal (S1, S2: Str): boolean;
{Pārbauda, vai rakstzīmju virknes S1^ un S2^ ir identiskas}
var len1, len2: StringLen;
begin
       len1 := Length(S1);       len2 := Length(S2);                {fiksē virkņu tekošos garumus}
       Equal := false;                                                                                        {sākumvērtība}
       if   ( len1 = 0 )  and   ( len2 = 0 )    then   Equal := true   {tukšas virknes ir identiskas}
       else    if   len1 = len2   then   Equal := Match(S1, S2, 1)             {sakritības pārbaude}
end;

function  Polindrome (S: Str): boolean;
{Pārbauda, vai rakstzīmju virkne S^ ir vienādi lasāma no sākuma un no beigām}
var  P: Str;
begin
       Polindrome := true;                                                                                   {sākumvērtība}
       if   Length(S) > 1   then                                                {ja virknē vairāk kā 1 rakstzīme}
                begin
                      new(P);                       {izveido dinamisku rakstzīmju virknes eksemplāru P^}
                       P^ .data := S^.data;                                                {virkni S^ dublē virknē P^}
                       P^.strlen := S^.strlen;
                       Reverse(P);                                                        {rakstzīmju virkni P^ reversē}
                       Polindrome := Equal(S, P)              {pārbauda, vai abas virknes ir identiskas}
                  end
end;

begin
end.
