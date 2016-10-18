Program Irina_Shchitilina_1_grupa_1_lab_darbs;
uses crt;
const n=10;
      c=10;
type I=1..n; I1=0..n;
     t=integer;
     q=array[I] of t;

var  A : q;
     k : I1;
     X,f : t;
     aizpilde,ch : char;

label KA,MEKLET,BEIGT,FUNKCIJA;

procedure tastatura(var arr : q);
 var i : t;
 begin
   for i:=1 to n do
     begin
       Writeln('Ievadiet masiva ',i, ' elementu');
       Readln(arr[i]);
     end;
 end;
procedure auto(var arr : q);
 var i: t;
 begin
   for i:=1 to n do
    begin
       arr[i]:= random(c);
    end;
 end;
procedure show(arr : q);
 var i : t;
 begin
     Writeln('Masiva elementi:');
     For i:=1 to n do
      begin
       Writeln(i,'. = ',arr[i]);
      end;

 end;
procedure search(arr : q;value : t);
 var k : t;
 begin
     k:=1;
     Repeat
      k:=k+1;
     Until (arr[k] = value) or (k = n);
     Writeln;
     if (arr[k] <> value) then writeln('Masiva elementa ',value, ' nav')
     else Writeln('Elements ',value, ' atrodas masiva ',k,' vieta');
     Writeln;
 end;
procedure AMF(Vlength : t);
 const Lo=1; L=2;
 var Co,C1,i,Hi : t;
 begin
   Writeln('Lo = 1 , Apakseja robezvirsma');
   Hi:=N;
   Writeln('Hi = 10 , Augseja robezvirsma');
   Writeln('L = 2 , Integer');
   C1:=L;
   Writeln('C1 = 2 adresesanas funkcijas konstante');
   Co:=Vlength - Lo*C1;
   Writeln('Co = b - Lo*C1 = ',Vlength,' - ',Lo,'*',C1,' = ',Co);
   Writeln;
   Writeln('addr(A[i]) = Co + 2*i');
   for i:=Lo to Hi do
    begin
     Writeln('addr(A[',i,']) = ',Co+2*i);
    end;
 end;

BEGIN
     clrscr;
     Writeln('DITF 1.kurss 1.grupa');
     Writeln('Irina Scitilina');
     Writeln('101RDB039');
     Writeln('25.variants:');
     Writeln('Izstradat algoritmu un izveidot programmu, kas veido masivu no veseliem elementiem(integer)');
     Writeln(' un izpilda sadu funkciju secibu:');
     Writeln(' 1. Masiva ievade no tastaturas;');
     Writeln(' 2. Masiva elementa un vina vietas(indeksu) meklesana kurs sakrit ar doto atslegu X');
     Writeln('(meklesanas atslegu uzdod lietotajs).Paredzet situaciju kad dotais elements masiva var ari nebut.');
     Writeln('Meklesanas procesu organizet ar:');
     Writeln('a) Lineara meklesana');
     Writeln(' 3. Masiva izvade uz ekrana');
     Writeln(' 4. Noteikt AMF(Address Mapping Function), ja masiva sakumadrese bus b=1000');
     Writeln;
     KA:
     Writeln('Lai ievadit masivu no tastaturas nospiediet 1, ja automatiski nospiediet 2');
     Readln(aizpilde);

     if (aizpilde = '1') then
       begin
          clrscr;
          tastatura(A);
       end
     else if (aizpilde = '2') then
       begin
          clrscr;
          auto(A);
     end
     else
      begin
      clrscr;
      Writeln('Nepareizi!',aizpilde);
      Writeln;
      GOTO KA;
      end;

     show(A);
     MEKLET:
     Writeln;
     Writeln('Ievadiet meklejamu elementu');
     Readln(X);
     search(A,X);

     Writeln('Varbut meklesim citu elementu? Y/N (y)');
     Readln(ch);
     if (ch = 'y') then GOTO MEKLET else GOTO FUNKCIJA;

     FUNKCIJA:
     clrscr;
     Writeln('Ievadiet masiva sakumadresi b (lidz 1000):');
     Readln(f);
     AMF(f);
     BEIGT:
     Readln;

END.
