Unit database_unit;

Interface
  type wrec = record
    fname,sname,amats: string;
    alga,stazs:real;
  end;
  Const ppl = 20;
procedure show_database;
procedure show_by_amats(amats:string);
procedure add_person;
procedure del_person(i:integer);
procedure edit_person;
procedure count_by_staz(staz:real);
procedure sortdata;

var
  f:file of wrec;

Implementation
Uses crt;
procedure del_person(i:integer);
var person:wrec;
begin
  if(i>filesize(f))or (i<1)then begin
    writeln('Ieraksts ar numuru ',i,' neeksiste datu baze');
    exit;
  end
  else if(i=filesize(f))then begin
    seek(f,i-1);
    truncate(f);
  end else
  begin
    for i:=i-1 to filesize(f)-2 do
     begin
      seek(f,i+1);
      read(f,person);
      seek(f,i);
      write(f,person);
     end;
    seek(f,filesize(f)-1);
    truncate(f);
  end;
end;

procedure show_database;
var ch:char;
    llim,i:integer;
    person:wrec;
begin
  ch:='0';
  llim:=0;
  while upcase(ch)<>'Q' do begin
    clrscr;
    for i:=llim to llim + ppl -1 do begin
      seek(f,i);
      if(not eof(f)) then begin
        read(f,person);
        writeln(i+1:3,'|',person.fname:15,'|',person.sname:15,'|',person.amats:10,'|',person.alga:10:2,'|',person.stazs:4:2);
      end;
    end;
    gotoXY(1,23);
    writeln('Vadiba ar bultinam uz augsu/leju; Q - izeja #',llim);
    gotoxy(1,1);
    ch:=readkey;
    if((ord(ch)=72 )and (llim>=1))then
      dec(llim);
    if((ord(ch)=80) and (filesize(f)>llim+ppl)) then
      inc(llim);
  end;

end;

procedure add_person;
var person:wrec;
begin
  clrscr;
  writeln('Tulit mes pievienosim jaunu darbinieku datubazei');
  with person do begin
  writeln('Ievadiet darbinieka vardu:');
  readln(fname);
  writeln('Ievadiet darbinieka uzvardu:');
  readln(sname);
  writeln('Ievadiet darbinieka amatu:');
  readln(amats);
  repeat
      writeln('Ievadiet jaunu darbinieka algu:');
     {$I-}
    readln(alga);
    {$I+}
    Until IOResult = 0;
  repeat
      writeln('Ievadiet jaunu darbinieka stazu:');
     {$I-}
    readln(stazs);
    {$I+}
  Until IOResult = 0;
  end;

  seek(f,filesize(f));
  write(f,person);
end;

procedure edit_person;
var person,npers:wrec;
    i:integer;
    ch:char;
begin
  clrscr;
  writeln('Lai redigetu darbinieka datus ievadiet vina ID numuru:');
  readln(i);
  if(i>filesize(f))or (i<1)then begin
    writeln('Darbinieks ar numuru ',i,' neeksiste datu baze');
    exit;
  end;
  seek(f,i-1);
  read(f,person);
  clrscr;
  writeln('Darbinieka vards: ',person.fname);
  writeln('Mainisim? (J - ja, N - cits taustins)');
  while((ch<>'J') and (ch<>'N')) do
  ch:=upcase(readkey);
  if(ch = 'J')then begin
    writeln('Ievadiet jaunu darbinieka vardu:');
    readln(npers.fname);
  end
  else npers.fname := person.fname;
  ch:='Q';
  clrscr;
  writeln('Darbinieka uzvards: ',person.sname);
  writeln('Mainisim? (J - ja, N - cits taustins)');
  while((ch<>'J') and (ch<>'N')) do
  ch:=upcase(readkey);
  if(ch = 'J')then begin
    writeln('Ievadiet jaunu darbinieka uzvardu:');
    readln(npers.sname);
  end
  else npers.sname := person.sname;
  ch:='Q';
  clrscr;
  writeln('Darbinieka amats: ',person.amats);
  writeln('Mainisim? (J - ja, N - cits taustins)');
  while((ch<>'J') and (ch<>'N')) do
  ch:=upcase(readkey);
  if(ch = 'J')then begin
    writeln('Ievadiet jaunu darbinieka amatu:');
    readln(npers.amats);
  end
  else npers.amats := person.amats;
  ch:='Q';
  clrscr;
  writeln('Darbinieka alga: ',person.alga:5:2);
  writeln('Mainisim? (J - ja, N - cits taustins)');
  while((ch<>'J') and (ch<>'N')) do
  ch:=upcase(readkey);
  if(ch = 'J')then begin

    repeat
      writeln('Ievadiet jaunu darbinieka algu:');
     {$I-}
    readln(npers.alga);
    {$I+}
    Until IOResult = 0;
  end
  else npers.alga := person.alga;
  ch:='Q';
  clrscr;
  writeln('Darbinieka stazs: ',person.stazs:3:2);
  writeln('Mainisim? (J - ja, N - cits taustins)');
  while((ch<>'J') and (ch<>'N')) do
  ch:=upcase(readkey);
  if(ch = 'J')then begin
    repeat
      writeln('Ievadiet jaunu darbinieka stazu:');
      {$I-}
      readln(npers.stazs);
      {$I+}
    Until IOResult = 0;
  end
  else npers.stazs := person.stazs;
  ch:='Q';
  clrscr;
  seek(f,i-1);
  write(f,npers);
  clrscr;
  writeln('Dati veiksmigi saglabati');

end;

procedure show_by_amats(amats:string);
var ch:char;
    llim,i,k:integer;
    person:wrec;
begin
  ch:='0';
  llim:=0;
  while upcase(ch)<>'Q' do begin
    clrscr;
    k:=0;
    for i:=llim to llim + ppl - 1 + k do begin
      seek(f,i);
      if(not eof(f)) then begin
        read(f,person);
        if(Person.amats <> amats)then
          inc(k)
        else
        writeln(i+1:3,'|',person.fname:15,'|',person.sname:15,'|',person.amats:10,'|',person.alga:10:2,'|',person.stazs:4:2);
      end;
    end;
    gotoXY(1,23);
    writeln('Vadiba ar bultinam uz augsu/leju; Q - izeja');
    gotoxy(1,1);
    ch:=readkey;
    if((ord(ch)=72 )and (llim>1))then
      dec(llim);
    if((ord(ch)=80) and (filesize(f)>llim+ppl)) then
      inc(llim);
  end;
end;

procedure count_by_staz(staz:real);
var i:integer;
  person:wrec;
begin
  i:=0;
  seek(f,1);
  while(not EoF(f)) do begin
    read(f,person);
    if person.stazs >= staz then
      inc(i);
  end;
  writeln('darbinieku skaits ar stazu >= ',staz:4:2,' ir ',i);
end;

procedure sortdata;
var i,j:integer;
x,y,buf:wrec;
begin
  for i:=0 to filesize(f)-2 do begin
    for J:=i+1 to filesize(f)-1 do begin
      seek(f,i);
      read(f,x);
      seek(f,j);
      read(f,y);
      if((x.sname>y.sname) or ((x.sname=y.sname) and (x.amats>y.amats)))then begin
        buf:=x;
        x:=y;
        seek(f,i);
        write(f,x);
        seek(f,j);
        write(f,buf);
      end;
    end;
  end;
end;
begin
end.
