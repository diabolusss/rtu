program md1;
uses crt;
const MaxLength=500;
const n=2;

type Position=1..MaxLength;
     StringLen=0..MaxLength;
     StringPos=1..MaxLength;
     MyString=^StringInstance;
     StringInstance=record
            StrLen:StringLen;
            Data:array[Position]of Char;
                   end;

var S:array[1..n]of MyString;
    Created:array[1..n]of boolean;
    Check,Bool:boolean;
    Title:String;
    i,j,TextB,TextC,TextC2,TextC3:Byte;
    Ch,c:Char;
    k:StringPos;k1:StringLen;
    Number : StringPos;


procedure Create(var S:MyString;var Created:boolean);
begin
     New(S);
     S^.strlen:=0;
     created:=true;
end;

procedure Terminate(var S:MyString;var Created:boolean);
begin
  if Created then
    begin
         Dispose(S);
         created:=false;
    end;
end;

function Length(S:MyString):StringLen;
begin
     Length:=S^.strlen;
end;

function Empty(S:MyString):boolean;
begin
     Empty:=S^.strlen=0;
end;

function Full(S:MyString):boolean;
begin
     Full:=S^.strlen=MaxLength;
end;

procedure Append(var S:MyString;c:Char);
begin
     if not Full(S) then with S^ do
        begin
             strlen:=strlen+1;
             data[strlen]:=c;
        end;
end;

procedure Insert(var S1:MyString;S2:MyString;pos:StringPos);
var len1,len2,len:StringLen;
    i:StringPos;
begin
     len1:=Length(S1);len2:=Length(S2);
     len:=len1+len2;
     if (not Empty(S2))and(len<=MaxLength)and(pos<=len1+1)then
     with S1^ do
     begin
          for i:=len1 downto pos do
            data[i+len2]:=data[i];
          for i:=1 to len2 do
            data[pos+i-1]:=S2^.data[i];
          strlen:=strlen+len2;
     end
end;

procedure MakeEmpty(var S:MyString);
begin
     S^.strlen:=0;
end;


procedure ReadString(var S:MyString);
var c:Char;
begin
     WriteLn(' Ievadiet virkni');
     MakeEmpty(S);
     while not EoLn do
     if Length(S)<MaxLength then
        begin
             Read(c);
             Append(S,c);
        end
end;

procedure WriteString(S:MyString);
var i:StringPos;
begin
     if not Empty(S) then with S^ do
        for i:=1 to strlen do
            Write(data[i]);
     WriteLn;
     ReadKey;
end;

procedure Reverse(var S:MyString);
var i:StringPos;
    c:Char;
begin
     if Length(S)>1 then with S^ do
        for i:=1 to (strlen div 2) do
            begin
                 c:=data[i];
                 data[i]:=data[strlen-i+1];
                 data[strlen-i+1]:=c;
            end
end;



procedure Tbg(K,L:Byte);
begin
     TextBackGround(K);
     TextColor(L);
end;

procedure Sign;
begin
     Window(1,25,80,25);
     Tbg(4,0);
     ClrScr;
     Write('                STRING VIRKNE (1.var) --------JURIS AUZINNSS I-DB2       ');
end;

procedure Border;
begin
     Tbg(4,15);
     Window(1,1,80,25);
     ClrScr;
     Write(#201);
     for i:=1 to 26 do
         Write(#205);
     Write(' O P E R A A C I J A S ');
     for i:=1 to 29 do
         Write(#205);
     Write(#187);

     for i:=2 to 7 do
     begin
     GoToXY(1,i);
     Write(#186);
     end;

     GoToXY(1,8);
     Write(#204);

     for i:=2 to 28 do
     begin
     GoToXY(i,8);
     Write(#205);
     end;
     Write(' OPERAACIJAS  IZPILDE ');

     for i:=51 to 79 do
     begin
     GotoXY(i,8);
     Write(#205);
     end;

     for i:=2 to 7 do
     begin
     GoToXY(80,i);
     Write(#186);
     end;

     GoToXY(80,8);
     Write(#185);

     for i:=9 to 15 do
     begin
     GoToXY(1,i);
     Write(#186);
     end;

     for i:=9 to 15 do
     begin
     GoToXY(80,i);
     Write(#186);
     end;

     GoToXY(80,16);
     Write(#185);
     GoToXY(1,16);
     Write(#204);

     for i:=2 to 23 do
     begin
     GoToXY(i,16);
     Write(#205);
     end;
     Write(' Opearaacijas izpildes rezultaats ');
     for i:=58 to 79 do
     begin
     GoToXY(i,16);
     Write(#205);
     end;

     for i:=17 to 23 do
     begin
     GoToXY(1,i);
     Write(#186);
     end;
     for i:=17 to 23 do
     begin
     GoToXY(80,i);
     Write(#186);
     end;

     For i:=2 to 79 do
     begin
     GoToXY(i,24);
     Write(#205);
     end;

     GoToXY(1,24);
     Write(#200);
     GoToXY(80,24);
     Write(#188);
end;

procedure InitOper;
begin
     Tbg(1,15);
     Window(2,9,79,15);
     ClrScr;
     GoToXY(1,1);
end;

procedure InitRes;
begin
     Tbg(1,15);
     Window(2,17,79,23);
     ClrScr;
     GoToXY(1,1);
end;

procedure InitProc;
begin
     Tbg(1,4);
     Window(2,2,79,7);
     ClrScr;

     TextB:=1;
     TextC:=15;
     TextC2:=15;
     TextC3:=55;
     GoToXY(4,1);
     Tbg(TextB,TextC2);Write(' Create ');Tbg(TextB,TextC);Write('      Alt+C ');
     GoToXY(4,2);
     Tbg(TextB,TextC2);Write(' Terminate ');Tbg(TextB,TextC);Write('   Alt+T');
     GoToXY(4,3);
     Tbg(TextB,TextC2);Write(' Length ');Tbg(TextB,TextC);Write('      Alt+L');
     GoToXY(4,4);
     Tbg(TextB,TextC2);Write(' Empty ');Tbg(TextB,TextC);Write('       Alt+E');
     GoToXY(4,5);
     Tbg(TextB,TextC2);Write(' Full ');Tbg(TextB,TextC);Write('        Alt+F');
     GoToXY(55,1);
     Tbg(TextB,TextC2);Write(' ReadString ');Tbg(TextB,TextC);Write('  Alt+R');
     GoToXY(55,2);
     Tbg(TextB,TextC2);Write(' WriteString ');Tbg(TextB,TextC);Write(' Alt+W ');
     GoToXY(55,4);
     Tbg(TextB,TextC3);Write(' Insert ');Tbg(TextB,TextC3);Write('      Alt+I ');
     GoToXY(55,3);
     Tbg(TextB,TextC2);Write(' MakeEmpty ');Tbg(TextB,TextC);Write('   Alt+K ');
     GoToXY(55,5);
     Tbg(TextB,TextC3);Write(' Reverse ');Tbg(TextB,TextC3);Write('     Alt+S ');
     GoToXY(32,4);
     Tbg(TextB,TextC2);Write(' Exit ');Tbg(TextB,TextC);Write('   Alt+X ');

end;


begin
     Check:=False;
     Tbg(0,0);
     ClrScr;
     Border;
     Sign;
     InitOper;
     InitProc;
     InitRes;
     While (Check=False) do
     begin
          Ch:=ReadKey;
          InitOper;InitRes;
          Case Ch of
   {*************Exit*****************}
   #45: Check:=True;
   {***********Create*****************}
   #46: begin
             InitOper;Write(' Kuru virkni izveidot? (1 - ',n,'): ');
             ReadLn(i);
             Create(S[i],Created[i]);
             if Created[i] then
                begin
                     InitRes;WriteLn(i,'. virkne ir izveidota ')
                end
             else
                 begin
                      InitRes;WriteLn(i,' string isn''t created ')
                 end
        end;
   {*********Terminate***************}
   #20: begin
             InitOper;Write(' Kuru virkni likvideet? (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
                begin
                     Terminate(S[i],created[i]);InitRes;WriteLn(i,'. virkne ir likvideeta ')
                end
             else
             begin
                  InitRes;WriteLn(i,'. virkne ir likvideeta ')
             end
        end;
   {***********Length*****************}
   #38: begin
             InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
                begin
                     InitRes;WriteLn(i,'. virknes garums ir ',Length(S[i]))
                end
             else
             begin
                  InitRes;WriteLn(i,'. virkne nav izveidota ')
             end
        end;
   {***********Empty*****************}
   #18: begin
             InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
             begin
                  if Empty(S[i]) then
                     begin
                          InitRes;WriteLn(i,'. virkne ir tuksa ')
                     end
                  else
                      begin
                           InitRes;WriteLn(i,'. virkne nav tuksa ')
                  end
             end
             else
             begin
                  InitRes;WriteLn(i,'. virkne nav izveidota ')
             end
        end;
   {***********Full*****************}
   #33: begin
             InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
                begin
                    if Full(S[i]) then
                       begin
                            InitRes;WriteLn(i,'. virkne ir pilna ')
                       end
                    else
                        begin
                             InitRes;WriteLn(i,'. virkne nav pilna ')
                        end
                end
             else
                 begin
                      InitRes;WriteLn(i,'. virkne nav izveidoa ')
                 end
        end;

   {***********ReadString*****************}
   #19: begin
             InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
                begin
                     InitOper;ReadString(S[i]);ReadLn;InitRes;
                end
             else
             begin
                  InitRes;WriteLn(i,'. virkne nav izveidota ')
             end
        end;
   {***********WriteString*****************}
   #17: begin
             InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
             ReadLn(i);
             if Created[i] then
                begin
                     if not Empty(S[i]) then
                        begin
                             InitRes;Write(' Ievadiitaa virkne : ');WriteString(S[i]);InitRes
                        end
                     else
                         begin
                              InitRes;WriteLn(i,'. virkne ir tuksa ')
                         end
                end
             else
                 begin
                      InitRes;WriteLn(i,'. virkne nav izveidota ')
                 end
        end;


   {************Insert*****************}
   #23: begin
             InitOper;WriteLn(' Ievadiet virknu numurus (1 - ',n,') ');
             Write(' Virknes numurs: ');
             ReadLn(i);
             Write( ' Apaksvirknes numurs: ');
             ReadLn(j);
             if (Created[i]) and (Created[j]) then
                begin
                     if Empty(S[i]) then
                        begin
                             InitRes;WriteLn(i,'. Virkne ir tuksa ')
                        end
                     else
                         begin
                              InitOper;WriteLn(' Ievadiet poziiciju ');Read(k);
                              Insert(S[i],S[j],k);InitRes;
                         end
                end
             else
                 begin
                      InitRes;WriteLn(i,'. vai ',j,'. virkne nav izveidota')
                end
        end;


  {*********MakeEmpty***************}
  #37: begin
            InitOper;Write(' Ievadiet virknes numuru (1 - ',n,'): ');
            ReadLn(i);
            if Created[i] then
               begin
                    MakeEmpty(S[i]);InitRes;WriteLn(i,'. virkne ir tuksa ')
               end
           else
               begin
                    InitRes;WriteLn(i,'. virkne nav izveidota ')
               end
        end;

  {*********Reverse***************}
  #31: begin
            InitOper;Write(' Enter the number of string (1 - ',n,'): ');
            ReadLn(i);
            if Created[i] then
               begin
                    Reverse(S[i]);InitRes;WriteLn(i,'. virkne ir "apgriezta otraadi" ')
               end
            else
                begin
                     InitRes;WriteLn(i,'. virkne nav izveidota ')
                end
        end;

   end;
end;
Halt;
end.