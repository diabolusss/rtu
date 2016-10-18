Program Virkne;
Uses CRT;

const MaxLen=50;
type  StringPos=1..MaxLen;
	  StringLen=0..MaxLen;
	  Str=^StringInstance;
	  StringInstance=record
		 strlen:StringLen;
		 data:array[StringPos]of char;
	  end;
	  Mtype=1..20;
	  Stype=1..3;

var   m:Mtype;
	  S1,S2,str1,str2,str3:Str;
	  rf,rs:Stype;
	  pos:StringPos;
	  len:StringLen;
	  ok:char;
	  yn,cra,crb,crc:boolean;
	  c1,c2:string[30];
Procedure Create(var S:Str);
Begin
  new(S);
  S^.strlen:=0;
end;

Procedure Terminate(var S:Str);
Begin
  dispose(S);
end;

Function Empty(S:Str):boolean;
Begin
  Empty:=S^.strlen=0;
end;

Function Full(S:Str):boolean;
Begin
  Full:=S^.strlen=MaxLen;
end;

Procedure Append(var S:Str);
var f:char;
Begin
  if not Full(S) then
  with S^ do Begin
			   Window(27,21,49,24);
			   TextBackGround(0); ClrScr;
			   Window(25,20,47,23);
			   TextBackGround(7); ClrScr;
			   TextColor(8);
			   Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
			   Write(' ³  Enter character: ³ ');
			   Write(' ³                   ³ ');
			   Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
			   Window(36,22,40,22);
			   TextColor(0);
			   ReadLn;
			   ReadLn(f);
			   strlen:=strlen+1;
			   data[strlen]:=f;
			 end;
end;

Procedure Concatinate(var S1:str; var S2:Str);
var i,k:StringLen;
Begin
  if not Empty(S2) then Begin
  if S1^.strlen+S2^.strlen<=MaxLen then
  k:=s2^.strlen
  else k:=MaxLen-S1^.strlen;
  with S1^ do Begin
  for i:=1 to k do
  data[strlen+i]:=S2^.data[i];
  strlen:=strlen+k;
  end;
  end;
end;

Procedure Substring(S1:Str; var S2:str; pos:StringPos; len:StringLen);
var k:StringLen;
Begin
  if(len>0)and(S1^.strlen>=pos+len-1)then Begin
  for k:=1 to len do
  S2^.data[k]:=S1^.data[pos+k-1];
  S2^.strlen:=len;
  end;
end;

Procedure Delete(var S:Str; pos:StringPos; len:StringLen);
var k:StringLen;
Begin
  if(len>0)and(S^.strlen>=pos+len-1)then
  with S^ do Begin
  for k:=pos+len to strlen do
  data[k-len]:=data[k];
  strlen:=strlen-len;
  end;
end;

Procedure Insert(var S1:Str; S2:Str; pos:StringPos);
var len1,len2,len:StringLen;
	i:StringPos;
Begin
  len1:=S1^.strlen;
  len2:=S2^.strlen;
  len:=len1+len2;
  if (not Empty(S2))and(len<=MaxLen)and(pos<=len1)then
  with S1^ do Begin
				for i:=len1 downto pos do
				data[i+len2]:=data[i];
				for i:=1 to len2 do
				data[pos+i-1]:=S2^.data[i];
				strlen:=strlen+len2;
			  end;
end;

Function Match(S1,S2:Str; pos:StringPos):boolean;
var i,last:StringPos;
	cont:boolean;
Begin
  i:=1;
  last:=S2^.strlen;
  cont:=true;
  Match:=false;
  if (not Empty(S2))and(S1^.strlen>=S2^.strlen+pos-1) then
  while(cont)and(S2^.data[i]=S1^.data[pos]) do
  if i=last then Begin
				   cont:=false;
				   match:=true;
				 end
  else Begin
		 i:=i+1;
		 pos:=pos+1;
	   end;
end;

Function Find(S1,S2:Str; pos:StringPos):StringLen;
var kbegin,kend:StringPos;
	found:boolean;
Begin
  kbegin:=pos;
  kend:=S1^.strlen-S2^.strlen+1;
  found:=false;
  While (not found)and(kbegin<=kend) do
  if Match(S1,S2,kbegin) then found:=true
  else kbegin:=kbegin+1;
  if found then Find:=kbegin else Find:=0;
end;

Procedure MakeEmpty(var S:Str);
Begin
  if not Empty(S) then S^.strlen:=0;
end;

Procedure ReadString(var S:Str);
var pos:StringPos;
	c:char;
Begin
  MakeEmpty(S);
  pos:=1;
  with S^ do Begin
			   Repeat
				 c:=ReadKey;
				 data[pos]:=c;
				 Write(data[pos]);
				 pos:=pos+1
			   Until(c=#13)or(pos>MaxLen);
			   strlen:=pos-2;
			 end;
end;

Procedure Remove(var S:str);
var i:StringPos;
	c:char;
Begin
  if not Empty(S) then
  with S^ do Begin
			   c:=data[strlen];
			   strlen:=strlen-1;
			 end;
end;

Procedure Reverse(var S:Str);
var i:StringPos;
	c:char;
Begin
  if S^.strlen>1 then
  with S^ do
  for i:=1 to (strlen div 2) do Begin
  c:=data[i];
  data[i]:=data[strlen-i+1];
  data[strlen-i+1]:=c;
								end;
end;

Function Equal(S1,S2:Str):boolean;
var i,last:StringPos;
	len1,len2:StringLen;
	cont:boolean;
Begin
  len1:=S1^.strlen;
  len2:=S2^.strlen;
  i:=1;
  last:=len1;
  cont:=true;
  Equal:=false;
  if (len1=0)and(len2=0) then Equal:=true
  else if len1=len2 then
  while (cont)and(S1^.data[i]=S2^.data[i]) do
  if i=last then Begin
				   cont:=false;
				   Equal:=true;
				 end
  else i:=i+1;
end;

Function Polindrome(S:Str):boolean;
var P:Str;
	pos:StringPos;
Begin
  Polindrome:=true;
  if S^.strlen>1 then Begin
						new(P);
						P^.strlen:=S^.strlen;
						for pos:=1 to S^.strlen do
						P^.data[pos]:=S^.data[pos];
						Reverse(P);
						if (not Equal(S,P)) then Polindrome:=false;
					  end;
end;

Procedure Menu;
var Oper:array[1..16]of string[20];
	c:char;
Begin

	Window(4,2,21,2);
	TextBackGround(black); ClrScr;
	TextColor(yellow);
        Write('STRING OPERATIONS');

	Window(4,3,21,20);
	TextBackGround(7); ClrScr;
        TextColor(0);
	Oper[1]:=('      Create      ');
        Oper[2]:=('     Terminate    ');
	Oper[3]:=('    ReadString    ');
        Oper[4]:=('     MakeEmpty    ');
	Oper[5]:=('      Append      ');
        Oper[6]:=('      Remove      ');
	Oper[7]:=('      Insert      ');
        Oper[8]:=('      Delete      ');
	Oper[9]:=('    Concatenate   ');
        Oper[10]:=('     Substring    ');
	Oper[11]:=('       Find       ');
        Oper[12]:=('       Match      ');
	Oper[13]:=('       Equal      ');
        Oper[14]:=('     Reverse      ');
	Oper[15]:=('    Polindrome    ');
        Oper[16]:=('       Quit       ');
	for m:=1 to 16 do Begin
						GoToXY(1,1+m);
						Write(Oper[m]);
					  End;
	m:=1;
	TextColor(15);
	TextBackGround(2);
	GoToXY(1,1+m);
	Write(Oper[m]);
	Repeat
	  Repeat c:=ReadKey Until (c=#0)or(c=#13);
	  if c=#0 then
	  Begin
		Repeat c:=ReadKey Until (c=#72)or(c=#80);
		Case c of
			 #72: Begin
					TextColor(0);
					TextBackGround(7);
					GoToXy(1,1+m);
					Write(Oper[m]);
					m:=m-1;
					if m<1 then m:=16;
					TextColor(15);
					TextBackGround(2);
					GoToXy(1,1+m);
					Write(Oper[m]);
				  End;
			 #80: Begin
					TextColor(0);
					TextBackGround(7);
					GoToXy(1,1+m);
					Write(Oper[m]);
					m:=m+1;
					if m>16 then m:=1;
					TextColor(15);
					TextBackGround(2);
					GoToXy(1,1+m);
					Write(Oper[m]);
				  End;
		End;
	  End
	Until c=#13;
End;

Procedure ChooseOne;
Begin
  Window(27,21,57,24);
  TextBackGround(0); ClrScr;
  Window(25,20,55,23);
  TextBackGround(7); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Enter number of string:  ³ ');
  Write(' ³                           ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Window(28,22,45,22);
  TextColor(8);
  Write(' ( 1, 2 or 3 )');
  Window(45,22,50,22);
  TextColor(0);
  Repeat Read(rf) Until (rf=1)or(rf=2)or(rf=3);
end;

Procedure ChooseTwo;
Begin
  Window(27,21,77,24);
  TextBackGround(0); ClrScr;
  Window(25,20,75,23);
  TextBackGround(7); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Enter two numbers of string:                 ³ ');
  Write(' ³                                               ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  TextColor(8);
  GoToXY(5,3); Write('first:');
  GoToXY(24,3); Write('second:');
  Window(57,21,74,21);
  TextColor(8);
  Write('  ( 1, 2 or 3 )');
  Window(37,22,42,22);
  TextColor(0);
  Repeat Read(rf) Until (rf=1)or(rf=2)or(rf=3);
  Write(rf);
  Window(57,22,62,22);
  TextColor(0);
  Repeat Read(rs) Until (rs=1)or(rs=2)or(rs=3);
  Write(rs);
end;

Procedure WriteString(S:Str; rf:Stype);
var pos:StringPos;
Begin
  Window(27,6*rf-3,77,6*rf);
  TextBackGround(0); ClrScr;
  Window(25,6*rf-4,75,6*rf-3);
  TextBackGround(8); ClrScr;
  TextColor(9);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³ String ',rf,':                                     ³');
  Window(59,6*rf-3,73,6*rf-3);
  TextColor(6);
  Write('( Length=',S^.strlen,' )');
  Window(25,6*rf-2,75,6*rf-1);
  TextBackGround(3); ClrScr;
  TextColor(0);
  Write(' ³                                               ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  case rf of
  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
  end;
  if not Empty(S1) then
  Begin
	Window(27,6*rf-2,73,6*rf-2);
	with S1^ do
	for pos:=1 to strlen do Write(data[pos]);
  end;
end;

Procedure ReadPos;
Begin
  Window(27,21,49,24);
  TextBackGround(0); ClrScr;
  Window(25,20,47,23);
  TextBackGround(7); ClrScr;
  TextColor(8);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Enter position:  ³ ');
  Write(' ³                   ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Window(36,22,40,22);
  TextColor(0);
  Read(pos); Write(pos);
end;

Procedure ReadLen;
Begin
  Window(50,21,72,24);
  TextBackGround(0); ClrScr;
  Window(48,20,70,23);
  TextBackGround(7); ClrScr;
  TextColor(8);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³   Enter length:   ³ ');
  Write(' ³                   ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Window(59,22,62,22);
  TextColor(0);
  Read(len); Write(len);
end;

Procedure SayOk;
Begin
  Window(2,22,12,25);
  TextBackGround(4); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Ok?  ³ ');
  Write(' ³ (Y/N) ³ ');
  Write(' ÀÄÄÄÄÄÄÄÙ');
  Repeat ok:=ReadKey Until (ok='y')or(ok='Y')or(ok='n')or(ok='N');

Window(2,22,12,25);
  TextBackGround(Blue); ClrScr;
end;

Procedure OnEmpty;
Begin
  Window(37,21,64,24);
  TextBackGround(0); ClrScr;
  Window(35,20,62,23);
  TextBackGround(4); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Your string is empty  ³ ');
  Write(' ³    ( press any key )   ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  ReadKey;
end;

Procedure YesNo(yn:boolean; c1,c2:string);
Begin
  Window(27,21,77,24);
  TextBackGround(0); ClrScr;
  Window(25,20,75,23);
  TextBackGround(3); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³                                               ³ ');
  Write(' ³                Press any key                  ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Window(28,21,72,21);
  TextColor(1);
  if yn=true then Write(c1,' ',c2) else Write(c1,' not ',c2);
  ReadKey;
end;

Procedure FoundLen;
Begin
  Window(27,21,77,24);
  TextBackGround(0); ClrScr;
  Window(25,20,75,23);
  TextBackGround(3); ClrScr;
  TextColor(14);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³                                               ³ ');
  Write(' ³                Press any key                  ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Window(28,21,72,21);
  TextColor(1);
  if Find(S1,S2,pos)=0 then
  Write(   '          Substring is not found')
  else Write('      Substring is found at position ',Find(S1,S2,pos));
  ReadKey;
End;

Procedure ReadWin(rf:Stype);
Begin
  Window(27,21,77,24);
  TextBackGround(0); ClrScr;
  Window(25,20,75,23);
  TextBackGround(7); ClrScr;
  TextColor(4);
  Write(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ');
  Write(' ³  Enter Your string:                           ³ ');
  Write(' ³                                               ³ ');
  Write(' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  TextColor(0);
  Window(28,22,72,22);
  case rf of
  1: ReadString(str1);
  2: ReadString(str2);
  3: ReadString(str3);
  End;
End;

var izeja:boolean;
Begin
  izeja:=false;
  cra:=false; crb:=false; crc:=false;
  Repeat
	TextBackGround(Blue); ClrScr;
        if cra then WriteString(str1,1);
	if crb then WriteString(str2,2);
	if crc then WriteString(str3,3);
	Menu;
	Case m of
		 1: Begin
			  ChooseOne;
			  case rf of
			  1: if not cra then
				 Begin Create(str1); cra:=true end;
			  2: if not crb then
				 Begin Create(str2); crb:=true end;
			  3: if not crc then
				 Begin Create(str3); crc:=true end;
			  end;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		 2: Begin
			  ChooseOne;
			  SayOk;
			  if (ok='y')or(ok='Y') then
			  Begin
				case rf of
				1: if cra then
				   Begin Terminate(str1); cra:=false end;
				2: if crb then
				   Begin Terminate(str2); crb:=false end;
				3: if crc then
				   Begin Terminate(str3); crc:=false end;
				end;
				Window(25,6*rf-4,77,6*rf);
				TextBackGround(blue); ClrScr;
			  End;
			  Window(25,20,77,24);
			  TextBackGround(blue); ClrScr;
			End;
		 3: Begin
			  ChooseOne;
			  ReadWin(rf);
			  Window(25,20,77,24);
			  TextBackGround(blue); ClrScr;
			End;
		 4: Begin
			  ChooseOne;
			  SayOk;
			  if(ok='y')or(ok='Y') then
			  case rf of
			  1: MakeEmpty(str1);
			  2: MakeEmpty(str2);
			  3: MakeEmpty(str3);
			  end;
			  Window(25,20,77,24);
			  TextBackGround(blue); ClrScr;
			End;
		 5: Begin
			  ChooseOne;
			  case rf of
			  1: Append(str1);
			  2: Append(str2);
			  3: Append(str3);
			  end;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		 6: Begin
			  ChooseOne;
			  SayOk;
			  if(ok='y')or(ok='Y') then
			  case rf of
			  1: Remove(str1);
			  2: Remove(str2);
			  3: Remove(str3);
			  end;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		 7: Begin
			  ChooseTwo;
			  ReadPos;
			  SayOk;
			  if(ok='y')or(ok='Y') then Begin
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  Insert(S1,S2,pos);        End;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		 8: Begin
			  ChooseOne;
			  ReadPos;
			  ReadLen;
			  SayOk;
			  if(ok='y')or(ok='Y') then
			  case rf of
			  1: Delete(str1,pos,len);
			  2: Delete(str2,pos,len);
			  3: Delete(str3,pos,len);
			  end;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		 9: Begin
			  ChooseTwo;
			  SayOk;
			  if(ok='y')or(ok='Y') then Begin
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  Concatinate(S1,S2);       End;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		10: Begin
			  ChooseTwo;
			  ReadPos;
			  ReadLen;
			  SayOk;
			  if(ok='y')or(ok='Y')then Begin
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  Substring(S1,S2,pos,len); End;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		11: Begin
			  ChooseTwo;
			  ReadPos;
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  Find(S1,S2,pos);
			  FoundLen;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		12: Begin
			  c1:='    Your string';
			  c2:='include this substring';
			  ChooseTwo;
			  ReadPos;
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  yn:=Match(S1,S2,pos);
			  YesNo(yn,c1,c2);
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		13: Begin
			  c1:='        Your strings are';
			  c2:='equal';
			  ChooseTwo;
			  case rf of
			  1: S1:=str1; 2: S1:=str2; 3: S1:=str3;
			  end;
			  case rs of
			  1: S2:=str1; 2: S2:=str2; 3: S2:=str3;
			  end;
			  yn:=Equal(S1,S2);
			  YesNo(yn,c1,c2);
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		14: Begin
			  ChooseOne;
			  case rf of
			  1: Reverse(str1);
			  2: Reverse(str2);
			  3: Reverse(str3);
			  end;
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		15: Begin
			  c1:='       Your string is';
			  c2:='polindrome';
			  ChooseOne;
			  case rf of
			  1: yn:=Polindrome(str1);
			  2: yn:=Polindrome(str2);
			  3: yn:=Polindrome(str3);
			  end;
			  YesNo(yn,c1,c2);
			  Window(25,20,77,24);
			  TextBackGround(Blue); ClrScr;
			End;
		16: Izeja:=true;


                    	End;
  Until izeja=true;
  if cra then Terminate(str1);
  if crb then Terminate(str2);
  if crc then Terminate(str3);
End.
