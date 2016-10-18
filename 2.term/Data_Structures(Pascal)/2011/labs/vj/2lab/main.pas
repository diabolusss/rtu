Program lab2;
Uses crt, mu;
Const del=3;
var created,crea2:boolean;
    ch,smb:char;
    S,s1:Str;
    nmb,nmb1:integer;
BEgin

 repeat
   clrscr;
   writeln('c - Izveidot virkni');
   writeln('t - Iznicinat virkni');
   writeln('l - Uzzinat virknes garumu');
   writeln('e - Uzzinat, vai virkne ir tuksa');
   writeln('f - Uzzinat, vai virkne ir pilna');
   writeln('r - Paradit virkni uz ekrana');
   writeln('w - Ievadit virkni');
   writeln('a - Pievienot virknei simbolu');
   writeln('s - Izdalit apaksavirkni');
   writeln('d - Izdest apaksvirkni ar uzdotu garumu');
   writeln('m - Parbaudit, vai apaksvirkne sakrit ar pamatvirkni,');
   writeln('    sakot no uzdotas pozicijas');
   writeln('b - Apgriezt virkni');
   writeln('h - Atrast apaksvirnes poziciju');
   writeln('x - beigt darbu');

   readln(ch);
   Case upcase(ch) of
    'C': begin
      Create(S,created);
      writeln('Jauna virkne izveidota');
      delay(del*1000);
    end;
    'T': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams to iznicinat');
      end
      else begin
        Terminate(S,created);
        writeln('Virkne ir iznicinata');
      end;
      delay(del*1000);
    end;
    'L': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams uzzinat tas garumu');
      end
      else begin
        writeln('Virknes garums ir: ',Length(S));
      end;
      delay(del*1000);
    end;
    'E': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        if (Empty(S)) then
        writeln('Wirkne ir tuksa')
        else
        writeln('Virkne nav tuksa');
      end;
      delay(del*1000);
    end;
    'F': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        if (Full(S)) then
        writeln('Wirkne ir pilna')
        else
        writeln('Virkne nav pilna');
      end;
      delay(del*1000);
    end;
    'R': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        WriteString(s);
      end;
      delay(del*1000);
    end;
    'W': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        ReadString(s);
      end;
      delay(del*1000);
    end;
    'A': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Writeln('Ievadiet simbolu, kuru gribat pievienot');
        readln(smb);
        Append(S,smb);
      end;
      delay(del*1000);
    end;
    'S': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Writeln('Ievadiet poziciju no kuras izdalit apaksvirkni');
        readln(nmb);
        writeln('Ievadiet apaksvirknes garumu');
        readln(nmb1);
        if(nmb1+nmb>Length(S)) then begin
          writeln('Nav iespejams nolasit apaksvirkni ar dotiem parametriem');
        end
        else begin
        Create(S1,crea2);
        Substring(S,S1,nmb,nmb1);
        writeln('Apaksvirkne ir:');
        WriteString(S1);
        Terminate(S1,crea2);
        end;
      end;
      delay(del*1000);
    end;
    'D': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Writeln('Ievadiet poziciju no kuras sak dzest');
        readln(nmb);
        writeln('Ievadiet cik simbolujs jadzes');
        readln(nmb1);
        if(nmb1+nmb>Length(S)+1) then begin
          writeln('Nav iespejams izdest datus ar dotiem parametriem');
        end
        else begin
          Delete(S,nmb,nmb1);
          writeln('OPeracija veiksmigi pabeigta');
        end;
      end;
      delay(del*1000);
    end;
    'M': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Create(S1,crea2);
        ReadString(S1);
        Writeln('Ievadiet poziciju no kuras sakt salidinat');
        readln(nmb);
        if(Match(S,S1,nmb)) then
         writeln('Rezultats ir pozitivs')
        else
          writeln('Rezultats ir negativs');
        Terminate(S1,crea2);
      end;
      delay(del*1000);
    end;
    'B': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Reverse(S);
        writeln('Rinda veiksmigi apgriezta');
      end;
      delay(del*1000);
    end;
    'H': begin
      if not (created) then begin
        writeln('Virkne nav izveidota, nav iepejams stradat ar to');
      end
      else begin
        Create(S1,crea2);
        ReadString(S1);
        Writeln('Ievadiet poziciju no kuras sakt meklet');
        readln(nmb);
        if(Find(S,S1,nmb)>0) then
          writeln('Apaksvirkne atrodas uz ',Find(S,S1,nmb)-1,' pozicijas')
        else
          writeln('Apaksvirkne nav atrasta');
        Terminate(S1,crea2);
      end;
      delay(del*1000);
    end;
   end;
 until upcase(ch)='X';

end.
