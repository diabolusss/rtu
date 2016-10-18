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
procedure FRwRec ( var fff:Myfiletype; FileOpen: boolean);
procedure FClose ( var fff:Myfiletype; var FileOpen: boolean);

implementation
uses CRT;
procedure Fcreate(var fff:Myfiletype; filename:string; var FileOpen: boolean);
var RC, n, i: integer;
    answer : string[1];
    rec :MyRec;
label BUILD;
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
       n:=NumOfRec;

       Rec.Name1:='                                              ';
       Rec.Name2:='                                              ';
       for i:=0 to n do
       begin
        Rec.name1:= chr($61 +i);
        Rec.name2:= chr($30 +i);
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
while (eof(fff)<> TRUE) do
begin
read(fff,rec);
WriteLnRec('Ieraksts #:', i,'     ',rec.name1, '  ', rec.name2);
i:=i+1;
end;
seek(fff,0);
end;

procedure FRwRec( var fff:Myfiletype; FileOpen: boolean);
var Rec:Myrec;
var i: integer;
begin
if (FileOpen=False) then
      begin
        WriteLnText(' Fails nav atverts ; Darbibu nevar izpildiit');
        exit;
      end;
WriteLnTEXT (' Ievadi labojamaa ieraksta numuru ');
{$I-}
readINT(i);

seek(fff,i);
{$I+}
if (ioresult=0)
 then FileOpen:=TRUE
 else begin
          MyFileErr:=5;
          exit;
      end;
      READREC(Rec.name1, Rec.name2);

write(fff, rec);
end;

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