Program lalala;
uses crt,funcs;

const
 menu:array[1..5] of string[33]=
 ('1 - Radit steku',
  '2 - Pievienot stekam jaunu elementu',
  '3 - Nolasit no steka pedejo elementu',
  '4 - Iznicinat steku',
  'Esc - Beigt darbu');

var
 k:char;
 a,choose,cur:byte;
 created:boolean;
 el:stdelement;

procedure show_info;
const
 iznakums:array[0..1] of string[3]=('NAV','IR');
begin
 clrscr;
 gotoxy(3,5);
 writeln('Steks ir izveidots= ',iznakums[ord(created)]);
 if created then begin
  gotoxy(3,7);
  writeln('Steks ir tukss= ',iznakums[ord(empty(S))]);
  gotoxy(3,9);
  writeln('Steks ir pilns= ',iznakums[ord(full(S))]);
  gotoxy(3,11);
  writeln('Elementu skaits= ',size(S),'   ');
 end;
end;


procedure push_dialog;
begin
 gotoxy(31,11);
 writeln('Ievadiet jauno elementu:');
 gotoxy(31,12);
 readln(el.data);
 push(S,el);
 clrscr;
end;

{----------------------------------------------------------------------------}

procedure show_element_info;
begin
 gotoxy(31,15);
 writeln('Nolasitais elements:');
 gotoxy(31,16);
 writeln(el.data);
end;

{----------------------------------------------------------------------------}

procedure del_element_info;
begin
 window(30,10,79,23);
 clrscr;
 window(1,1,80,25);
end;

{----------------------------------------------------------------------------}

begin
 textmode(CO80);
 clrscr;

 created:=false;

 show_info;

 choose:=1;
 repeat
 for a:=1 to 5 do begin
  gotoxy(31,2+a);
  if cur=a then Begin
  textBackground(12);
  write(menu[a]);
  TextBackground(0);

  end else
  write(menu[a]);
 end;
  gotoxy(80,23);
  k:=readkey;
  del_element_info;
   gotoxy(31,23);
  case k of
          #80:if Cur < 5 then Cur:=Cur+1
           else Cur:=1;
        #72:if Cur > 1 then Cur:=Cur-1
           else Cur:=5;

  #13:case cur of
   1:if (created) then  write('IEVADES KLUDA!')
     Else create(S,created);
   2: if (NOT created)and(full(S))then
      write('IEVADES KLUDA!') else push_dialog;

   3: if (NOT created)or(empty(S))Then
      write('IEVADES KLUDA!')
      Else
      begin
        pop(S,el);
        show_element_info;
       end;
   4:   if (NOT created) then write('IEVADES KLUDA!') else
begin
        terminate(S,created);
       end;
    5: break;
    End
  end;
  show_info;
 until k=#27;

 if created then terminate(S,created);
end.