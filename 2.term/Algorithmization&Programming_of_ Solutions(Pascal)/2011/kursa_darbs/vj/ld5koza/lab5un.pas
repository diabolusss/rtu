unit lab5un;
interface
uses LAB5IO;
type MyRec= record
      name1 : STR39;
      name2 : STR39;
      end;
type Myfiletype = file of MyRec;
var MyFileERR :integer;
procedure Fcreate(var fff:Myfiletype; filename:string; var FileOpen: boolean);
procedure Fopenf ( var fff:Myfiletype;filename:string; var FileOpen:boolean);
procedure Fview  ( var fff:Myfiletype; FileOpen: boolean);
procedure FRwReplace ( var fff:Myfiletype; FileOpen: boolean);
procedure FClose ( var fff:Myfiletype; var FileOpen: boolean);

implementation
uses CRT;
procedure Fcreate(var fff:Myfiletype; filename:string; var FileOpen: boolean);
var RC, i: integer;
    rec :MyRec;
begin
assign(fff, filename);
{$I-}
RC:=13;
reset(fff);
{$I+}
RC:=ioresult;
if (RC=0) then
      if (FileRewr(filename) = FALSE) then
          begin
          close(fff);
          FileOpen:=False;
          MyFileErr:=1;
          exit;
          end;

{$I-}
rewrite(fff);
{$I+}
     if(IOResult<>0) then begin
                          MyFileErr:=3;
                          FileOpen:=False;
                          exit;
                          end;
      // n:=NumOfRec;
       randomize;rec.name1:='';rec.name2:='';
       for i:=1 to 10 do with rec do begin
        name1:=carName[i];
        name2:=carName[i+10];
        write(fff,Rec);
       end;
close(fff);
          FileOpen:=False;
end;

procedure FOpenF( var fff:Myfiletype; filename:string; var FileOpen: boolean);
begin
assign(fff, filename);
{$I-}
reset(fff);
{$I+}
if (ioresult=0)
 then FileOpen:=TRUE
 else begin
          FileOpen:=False;
          MyFileErr:=4;
      end;
end;

procedure Fview( var fff:Myfiletype; FileOpen: boolean);
var
i :integer; rec:Myrec;
begin
if (FileOpen=False) then
      begin
        WriteLntext(' Fails nav atverts ; Darbibu nevar izpildiit');
        exit;
      end;
i:=0;
seek(fff,i);
WriteLn('#ID',nbsp,'name1',nbsp,'name2');
while (eof(fff)<> TRUE) do
begin
read(fff,rec);
WriteLn(i,nbsp,rec.name1,nbsp:(maxLength-length(rec.name1)+length(nbsp)),rec.name2);
i:=i+1;
end;
seek(fff,0);
end;

procedure FRwReplace( var fff:Myfiletype; FileOpen: boolean);
var rec1,rec2:Myrec;
    i,j,i1,i2: integer;key1,tKey,nameKey:str39;found1,found2:boolean;key2,mode:char;
BEGIN
 if (FileOpen=False) then begin
        WriteLnText(' Fails nav atverts ; Darbibu nevar izpildiit');
        exit;
        end;
 write('Ievadi pec ka mekleet[visu vardu vai ta daļu]: key1=');
 repeat readln(key1); until length(key1)>0;
 write('Meklet [0]name1 lauka vai [1]name2 lauka? ');
 repeat mode:=readkey; until mode in ['0','1'];
 writeln(mode);
 found1:=false;found2:=false;i:=0;tKey:='';
 seek(fff,i);

   repeat 
    read(fff,rec1); tKey:='';
    case mode of
     '0':nameKey:=rec1.name1;
     '1':nameKey:=rec1.name2;
     end;
    for i1:=1 to length(nameKey) do 
     if i1+length(key1)-1<=length(nameKey) then 
      if (nameKey[i1]=key1[1])and(not found1) then begin
       for j:=i1 to i1+length(key1)-1 do tKey:=tKey+nameKey[j];
       if tKey=key1 then begin 
        found1:=true;
        key2:=nameKey[1];
        rec2:=rec1;
        end;
      end;
    inc(i);
   until (found1)or(eof(fff));
 i1:=i-1;
 i:=i1;
 if found1 then writeln('Found rec1:',nameKey,' at position:',i1,' with key1:',key1)
 else writeln('First string not found. Press any key');

 if (not eof(fff))and(found1) then repeat
   read(fff,rec1);
    case mode of
     '0':nameKey:=rec1.name1;
     '1':nameKey:=rec1.name2;
     end;
   for i2:=1 to length(nameKey) do
    if nameKey[i2]=key2 then found2:=true;
   inc(i);
  until (found2)or(eof(fff));
 if found2 then writeln('Found rec2:',nameKey,' at position:',i,' with key2:',key2)
 else writeln('Second string with key2:',key2,' not found. Press any key');

 if found1 and found2 then begin
  writeln('Record[',i1,']  replaced with record[',i,']');
  seek(fff,i1);write(fff,rec1);
  seek(fff,i);write(fff,rec2);
  end;

END;

procedure FClose( var fff:Myfiletype; var FileOpen: boolean);
begin
if (FileOpen=False) then
      begin
        WriteLnText(' Fails nav atverts ; Darbibu nevar izpildiit');
        exit;
      end;
WriteLnText (' Aizveram failu ');
close(fff);
FileOpen:=False;
end;


begin
     MyFileErr:=0;
end.
