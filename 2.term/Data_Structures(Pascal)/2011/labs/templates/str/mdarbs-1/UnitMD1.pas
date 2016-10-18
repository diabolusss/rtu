unit UnitMD1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const maxLength=500;

type
  StringPos=1..MaxLength;
     StringLen=0..MaxLength;
     c=char;
    Strings=^stringInstance;
     StringInstance=record
       strlen:StringLen;
       data:array[stringPos]of c;
     end;
     boo=boolean;
     virknesNo=1..3;

TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox2: TGroupBox;
    Button8: TButton;
    Button9: TButton;
    GroupBox3: TGroupBox;
    Button10: TButton;
    Button11: TButton;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button12: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  created:boo; S:strings;n:virknesNo;
  v: array[virknesNo]of strings;
  cre: array[virknesNo] of boo;
procedure Terminate(var S:strings; var created:boo);
function Length(S:strings):stringLen;
Function Full(S:strings):boo;
Function Empty(S:strings):boo;
procedure Insert(var S1:strings; S2:strings;pos:StringPos);
procedure Append(var S:strings; ch:c);
procedure ReadString(a:string; var S:Strings);
procedure MakeEmpty(var S:strings);
procedure reverse(var S:strings);
procedure create(var s:strings; var created:boo);

implementation

{$R *.dfm}
{===============================================================}
procedure create(var s:strings; var created:boo);
begin
 new(s);
 S^.strlen:=0;
 created:=true;
end;
{================================================================}
procedure Terminate(var S:strings; var created:boo);
{likvidee virkni S^}
begin
 if created then begin
   dispose(S); created:=false; end;
end;
{================================================================}
function Length(S:strings):stringLen;
{nosaka virknes S^ tekoso garumu}
begin
 Length:=S^.StrLen;
end;
{=================================================================}
Function Full(S:strings):boo;
{paarbauda vai virkne S^ ir pilna}
begin
 Full:=S^.Strlen=MaxLength;
end;
{=================================================================}
Function Empty(S:strings):boo;
{paarbauda vai virkne S^ ir tuksha}
begin
 Empty:=S^.StrLen=0;
end;
{=================================================================}
procedure Insert(var S1:strings; S2:strings;pos:StringPos);
{rakstziimju virknee s1^ saakota ar poziiciju pos iestarpina S2^}
var len1,len2,len:stringLen;i:stringPos;
begin
len1:=Length(S1); len2:=Length(S2);
 len:=len1+len2;
    if (not empty(S2)) and (len<=MaxLength) and (pos<=len1+1) then begin
     with S1^ do begin
      for i:=len1 downto pos do data[i+len2]:=data[i];
      for i:=1 to len2 do data[pos+i-1]:=S2^.data[i];
      strlen:=len;
     end;
   form1.Label1.Caption:='Iesprausana veikta sekmiigi ';end
   else application.MessageBox('Iesprausana netikta veikta! Pârbaudiet pozîcijas numuru, vai virknes nav tukðas, vai pârâk garas un meeginiet velreiz!' , 'Error', MB_OK);
end;
{==================================================================}
procedure ReadString(a:string; var S:Strings);
{ar tstatuuru ievada rakstziimju virkni S^}
var ch:array[stringLen]of c;i:integer;
begin
 MakeEmpty(S);
 strpcopy(ch,a);
 i:=0;
 while (Length(S)<MaxLength) and (ch[i]<>'') do begin
   append(S,ch[i]);
   i:=i+1;
 end;
end;
{==================================================================}
procedure MakeEmpty(var S:strings);
begin
 S^.Strlen:=0;
end;
{===================================================================}
procedure Append(var S:strings; ch:c);
{rakstziimju virknes S^ galaa pievieno vienu simbolu}
begin
 if not full(S) then with S^ do begin
   strLen:=strlen+1;
   data[strLen]:=ch;
 end;
end;
{====================================================================}
procedure WriteString(s:strings);
var i:stringPos; k:string;
begin
 form1.Label1.Caption:='';
 if not empty(S) then with S^ do begin
   for i:=1 to strlen do k:=k+data[i];
      form1.Label1.Caption:=k;

 end;
end;

{====================================================================}

procedure reverse(var S:strings);
{rekstziimju virkni S^ apgriezz otraadi}
var i:StringPos; ch:c;
begin
 if Length(S)>1 then with S^ do
   for i:=1 to strLen div 2 do begin
      ch:=data[i];
      data[i]:=data[strlen-i+1];
      data[strlen-i+1]:=ch;
   end;
end;
{====================================================================}
procedure Delete (var S:strings;pos:StringPos;len:StringLen);
var i:stringLen;
begin
if (len>0) and (Length(s)>=(pos+len-1)) then with S^ do
begin 
for i:=(pos + len) to strlen do 
data [i - len] := data [i];
strlen:= strlen - len;
end;
end;
{====================================================================}
function match (s1,s2:strings;pos:stringpos):boolean;
var  i,last:stringpos;
continue:Boolean;
begin
i:=1;last:=Length(s2); continue:=true; match:=false;
if (not empty(s2))and (length(s1)>=length(s2)+pos-1) then
while continue and (s2^.data[i]=s1^.data[pos]) do
     if  i=last then
     begin
       continue :=false;
       match:=true;
     end
     else
     begin
     i:= i+1;pos:=pos+1;
     end;
end;



{======================================================================}
Function Find (s1,s2:strings;pos:stringpos):stringlen;
var kbegin,kend:stringpos; found: boolean;
begin  kbegin:= pos;kend:=length(s1)-length(s2)+1;
found:= false;
while (not found) and (kbegin <=kend) do
if match(s1,s2,kbegin) then found := true else kbegin :=kbegin +1;

if found then find :=kbegin else find :=0;
end;

{=====================================================================}
procedure TForm1.Button1Click(Sender: TObject);
{Izveido jaunu tuksu virkni S^}
begin
 new(S);
 S^.strlen:=0;
 created:=true;
   if (n<>1)and(n<>2) then n:=1;

 application.MessageBox('virkne izveidota veiksmiigi!' , '', MB_OK);
end;
{---------------------------------------------------}
procedure TForm1.Button2Click(Sender: TObject); {terminate}
var pp:virknesNo;
begin
  terminate(s,created);
  form1.Label1.Caption:='';
  cre[n]:=false;v[n]:=nil;

end;
{--------------------------------------------------}
procedure TForm1.Button3Click(Sender: TObject);
var ll:array[StringLen] of c;
begin
if created then begin
   strPcopy(ll,IntToStr(length(s)));
   application.MessageBox(ll , 'Length:', MB_OK)
end else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK)
end;
{--------------------------------------------------}
procedure TForm1.Button4Click(Sender: TObject);
begin
if created then
 if full(s) then
    application.MessageBox('Virkne ir pilna' , 'Full??', MB_OK) else
    application.MessageBox('Virkne nav pilna' , 'Full??', MB_OK)
   else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK)
end;
{---------------------------------------------------}
procedure TForm1.Button5Click(Sender: TObject);
begin
if created then
 if empty(s) then
    application.MessageBox('Virkne ir tuksha' , 'Empty??', MB_OK) else
    application.MessageBox('Virkne nav tuksha' , 'Empty??', MB_OK)
  else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK)
end;

{-----------------------------------------------------}

procedure TForm1.Button8Click(Sender: TObject);
var a:string;
begin
if created then begin
a:=inputbox('ReadString','Ievadi rakstziimju virkni:','');
readString(a,S);
end else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK)

end;
{------------------------------------------------------}
procedure TForm1.Button9Click(Sender: TObject);
begin
if created then
 WriteString(s)
else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK);
end;
{-----------------------------------------------------}
procedure TForm1.Button10Click(Sender: TObject);
begin
if created then MakeEmpty(S) else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK);
end;
{----------------------------------------------------}
procedure TForm1.Button11Click(Sender: TObject);
begin
if created then reverse(S) else
    application.MessageBox('virkne nav izveidota!' , 'Error', MB_OK);
end;

{========================================================}

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
 v[n]:=S;
 cre[n]:=created;
S:=nil; created:=false;
 n:=2;
 if cre[n] then
     begin S:=v[n]; created:=true end;
end;

{=========================================================}

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
 v[n]:=S;
 cre[n]:=created;
 n:=1;
S:=nil; created:=false;
 if cre[n] then
    begin S:=v[n]; created:=true end;
end;


procedure TForm1.Button12Click(Sender: TObject);
begin
form1.Close;

end;
{-----------------}
procedure TForm1.Button6Click(Sender: TObject);  {find}
var a:integer; s2:strings;qq:stringlen;
begin

a:=strToInt(inputbox('Reada pos','ievadi poziiciju:',''));
if n=1 then s2:=v[2] else s2:=v[1];

qq:=find(s,s2,a);

label1.Caption:=intToStr(qq);

end;
{==========================================================}
procedure TForm1.Button7Click(Sender: TObject); {delete}
var a:StringPos; l:stringLen;
begin
a:=strToInt(inputbox('Read pos','ievadi poziiciju:',''));
l:=strToInt(inputbox('Read len','ievadi dzeeshamaas virknes garumu:',''));

Delete(S,a,l);

end;

end.
