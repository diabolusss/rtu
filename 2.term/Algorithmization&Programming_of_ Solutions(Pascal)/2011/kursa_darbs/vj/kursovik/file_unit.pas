Unit file_unit;
interface
  function open_file:boolean;
  procedure menu;
  function close_file:boolean;
var fo:boolean;
    search_str:string;
    staz:real;
implementation
Uses crt, database_unit;
function open_file:boolean;
var path:string;
    choice:char;
begin
  clrscr;
  writeln('Laipni ludzam kadru uzskaites sistema');
  writeln('Ludzu ievadiet datu bazes faila nosaukumu');
  readln(path);
  assign(f,path);
  {$I-}
  reset(f);
  {$I+}
  if(IOResult <>0) then begin
    writeln('Neeksiste datu baze ar tadu nosaukumu.');
    writeln('Izveidot? (J - Ja/ N - Ne)');
    choice:=Readkey;
    while (upcase(choice) <> 'J')  and (upcase(choice) <> 'N') do
      choice:= readkey;

    if upcase(choice)='J' then
      rewrite(f)
    else  begin
      writeln('Paldies par darbu.');
      readln;
      halt;
    end;

  end;
  open_file:= true;
end;

procedure menu;
var ch:char;
    i:integer;
begin
  writeln('Navigacija panelis');
  writeln('O - atvert datu bazi');
  writeln('C - aizvert datu bazi');
  writeln('V - apskatit faila saturu');
  writeln('A - pievienot darbinieku');
  writeln('D - dzest darbinieku no bazes');
  writeln('E - rediget informaciju par darbinieku');
  writeln('S - sakartot informaciju pez uzvardiem un amatiem');
  writeln('F - atrast visus uzdota amata darbiniekus');
  writeln('G - Darbinieku skaits ar uzdotu stazu');
  writeln('Q - izeja');
  writeln('Aprekinat darbinieku sakitu, kuru stazs parsniedz uzdotu gadu skaitu');
  ch:=upcase(readkey);
  case ch of
  'O': begin
        clrscr;
        fo:= open_file;
        if fo= true then
          writeln('datubaze veiksmigi atverta');
       end;
  'C': begin
       clrscr;
       if(fo<>true)then begin
         writeln('Datubaze nav atverta. Operacija nav iespejama');
       end
       else begin
       fo:=close_file;
       if(fo=false)then
         writeln('Datubaz veiksmigi aizverta');
       end;
       end;
  'V': begin
       clrscr;
       if(fo<>true)then begin
         writeln('Datubaze nav atverta. Operacija nav iespejama');
       end
       else begin
       show_database;
       clrscr;
       end;
       end;
  'A': begin
       CLRSCR;
       if(fo<>true)then begin
         writeln('Datubaze nav atverta. Operacija nav iespejama');
       end
       else begin
       add_person();
       end;
       end;
  'D': begin
         CLRSCR;
       if(fo<>true)then begin
         writeln('Datubaze nav atverta. Operacija nav iespejama');
       end
       else begin
         writeln('Ievadiet ieraksta numuru:');
         readln(i);
         del_person(i);
       end;
       end;
  'E': begin
       CLRSCR;
       if(fo<>true)then begin
         writeln('Datubaze nav atverta. Operacija nav iespejama');
       end;
       edit_person();
  end;
  'Q': begin
         clrscr;
         if fo= true then begin
           writeln('Nevar beigt darbu jo datu baze nav slegta');
           readkey;
         end
         else begin
           writeln('Paldies par darbu');
           readkey;
           halt;
         end;
  end;
  'F': begin
         clrscr;
         if fo<> true then begin
           writeln('Datubaze nav atverta. Operacija nav iespejama');
           readkey;
         end
         else begin
           writeln('Pec kada amata meklet darbiniekus:');
           readln(search_str);
           show_by_amats(search_str);
         end;
         
  end;
  'G': begin
         clrscr;
         if fo<> true then begin
           writeln('Datubaze nav atverta. Operacija nav iespejama');
           readkey;
         end
         else begin
           repeat
             clrscr;
             writeln('Darbiniekus ar kadu stazu saskaitit:');
             {$I-}
             readln(staz);
             {$I+}
           Until IOResult = 0;
           count_by_staz(staz);
         end;
         
  end;
  'S': begin
         clrscr;
         if fo<> true then begin
           writeln('Datubaze nav atverta. Operacija nav iespejama');
           readkey;
         end
         else begin
           sortdata();
         end;
  end;
  else begin
    clrscr;
    menu;
  end;
  end;
  menu;
end;
function close_file:boolean;
begin
  close(f);
  close_file:= false;
end;

Begin
End.
