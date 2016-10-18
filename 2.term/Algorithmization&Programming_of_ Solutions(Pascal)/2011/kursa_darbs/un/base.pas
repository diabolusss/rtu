program Base;
uses CRT, DOS, MyUnit;
  {konstantes izvelnes attelosanai}
const
   Menu : array[0..7] of string[50] = ('1. Apskatit informaciju par masinu       ',
                                       '2. Pievienot jaunu ierakstu par masinu        ',
                                       '3. Nodzet ierakstu par masinu     ',
                                       '4. Rediget ierakstu par masinu      ',
                                       '5. Atrast informaciju par masinu     ',
                                       '6. Nosortet informaciju      ',
                                       '7. Aprekinat videju cenu     ',
                                       '8. Iziet no datu bazes      ');
  MenuCount = 8;  {izvelnes komandu skaits}
  MenuCharCount = 14;  {maksimalais simbolu skaits komanda}
  {konstantes ramisu attelosanai}
  VertFrame = 'º';       {vertikalas stripas kods Alt+186}
  HorzFrame = 'Í';       {horizontalas stripas kods Alt+205}
  SpasFrame = ' ';
  TopRightFrame = '»';   {augsejais labais sturis kods Alt=187}
  BottomRightFrame = '¼';{apaksejais labais sturis kods Alt+188}
  BottomLeftFrame = 'È'; {apaksejais kreisais sturis kods Alt+200}
  TopLeftFrame = 'É';    {augsejais kreisais sturis}
  {konstantes, tipi un mainigie informacijas glabasanai}
  FileName = '../kurs/ITEMS.TXT';
  brid = 'Lai izmantotu sho f-ju jaielagojas ka administrators. Uzspieziet ENTER.';

type
  TItem = record
     Marka : String[15];
     Izl_Gads : Integer;
     Nobr : integer;
     Krasa : String[15];
     Cena : Integer;
  end;

var
  item : array[1..101] of TItem;
  Count : Integer;
  CurCommand : Integer;  {tekosas (iezimetas) komandas numurs}
  Row,Column : Byte;  {kursora koordinates}
  TextC, BackC : Integer;
  admin : boolean;

procedure Load;
Var F : Text;
begin
  Assign( F, FileName );
  {$I-}
  Reset( F );
  {$I+}
  If IOResult<>0 then
   begin
     ReWrite(F);
     Close(F);
     Exit;
   end;
  Count:=0;
  While not SeekEof(F) do
  begin
    Inc( Count );
    Readln(F, item[Count].Marka );
    Readln(F, item[Count].Izl_Gads );
    Readln(F, item[Count].Nobr );
    Readln(F, item[Count].Krasa );
    Readln(F, item[Count].Cena );
  end;
  Close( F );
end;

procedure Save;
Var I : Integer;
    F : Text;
begin
  Assign( F, FileName );
  Rewrite( F );
  For I:=1 to Count do
   begin
     Writeln(F, item[I].Marka );
     Writeln(F, item[I].Izl_Gads );
     Writeln(F, item[I].Nobr );
     Writeln(F, item[I].Krasa );
     Writeln(F, item[I].Cena );
   end;
  Close( F );
end;

procedure Getitem( var Item : Titem);
Var S : String;
    Ch : Char;
    code : Integer;
begin
  Writeln; Writeln;
  InputData( S, 1, 15, 'Ievadiet marku' , '' );
  Item.Marka:=S;
  Writeln; Writeln;
  InputData( S, 2, 6, 'Ievadiet izlaiduma gadu', '' );
  val(s, Item.Izl_Gads, code);
  Writeln; Writeln;
  InputData( S, 1, 15, 'Ievadiet nobraukumu','' );
  val(s, Item.Nobr, code);
  Writeln; Writeln;
  InputData( S, 2, 8, 'Ievadiet krasu','' );
  Item.Krasa:=S;
  Writeln; Writeln;
  InputData( S, 3, 8, 'Ievadiet cenu', '');
  val(s, Item.Cena, code);
end;

procedure View;
var
  I : Integer;
  Ch : Char;
  Rel : Integer;
  Ex : Boolean;
begin
  Rel:=0;
  Repeat
    ClrScr;
    Writeln;
   textcolor(green);
    Gotoxy(1,1);     Write('Marka');
    GotoXY(20,1);    Write('Izl_Gads');
    GotoXY(37,1);    Write('Nobraukums');
    GotoXY(56,1);    Write('Krasa');
    GotoXY(68,1);    Write('Cena');
    textcolor(white);
    for I:=1 to 20 do
    begin
      If I>Count then Break;
      ClrEol;
      GotoXY(1,1+I);      Write( item[I+Rel].Marka );
      GotoXY(20,1+I);     Write( item[I+Rel].Izl_Gads );
      GotoXY(37,1+I);     Write( item[I+Rel].Nobr );
      GotoXY(56,1+I);     Write( item[I+Rel].Krasa );
      GotoXY(68,1+I);     Write( item[I+Rel].Cena );
    end;
	writeln;
	writeln;
	textcolor(7);
	writeln('### Uzspiediet ESC lai atgrieztos');
    Ex:=False;
    Ch:=ReadKey;
    case Ch of
     #72: If Rel>0 then Dec(Rel);
     #80: If Rel<Count-20 then Inc(Rel);
     #27: Ex:=True;
    end;
  Until Ex;
end;

procedure Add;
Var Item : Titem;
    F : Text;
begin
  ClrScr;
  GotoXY(20,1);
  Write('Jauna ieraksta pievienosana');
  Getitem( Item );
  Assign(F, FileName);
  Append(F);
  WriteLn(F, Item.Marka);
  WriteLn(F, Item.Izl_Gads);
  WriteLn(F, Item.Nobr);
  WriteLn(F, Item.Krasa);
  WriteLn(F, Item.Cena);
  Close(F);
  Load;
end;

function Choose : Integer;
var
  I : Integer;
  Ch : Char;
  Rel : Integer;
  Marked : Integer;
  Chosen : Boolean;
begin
  If Count=0 then Exit;
  Rel:=0;
  Marked:=1;
  Repeat
    ClrScr;
	textcolor(green);
    Gotoxy(1,1);     Write('Marka');
    GotoXY(20,1);    Write('Izl_Gads');
    GotoXY(37,1);    Write('Nobraukums');
    GotoXY(56,1);    Write('Krasa');
    GotoXY(68,1);    Write('Cena');
    Writeln;
	textcolor(white);
    for I:=1 to 20 do
    begin
      If I>Count then Break;
      ClrEol;
      If (I+Rel)=Marked then
       begin
         TextColor(Black);
         TextBackground(lightgray);
       end;
      GotoXY(1,1+I);      Write( item[I+Rel].Marka );
      GotoXY(20,1+I);     Write( item[I+Rel].Izl_Gads );
      GotoXY(37,1+I);     Write( item[I+Rel].Nobr );
      GotoXY(56,1+I);     Write( item[I+Rel].Krasa );
      GotoXY(68,1+I);     Write( item[I+Rel].Cena );
      If (I+Rel)=Marked then
       begin
         TextColor(white);
         TextBackground(black);
       end;
    end;
    Ch:=ReadKey;
    Chosen:=False;
    case Ch of
     #72: If Marked>1 then
           begin
             Dec(Marked);
             If Marked>20 then Rel:=Marked-20
             Else Rel:=0;
           end;
     #80: If Marked<Count then
           begin
             Inc(Marked);
             If Marked>20 then Rel:=Marked-20
             Else Rel:=0;
           end;
     #13:  Chosen:=true;
    end;
  Until Chosen;
  Choose:=Marked;
  TextColor(white);
         TextBackground(black);
end;

procedure Delete;
var
  I : Integer;
  Ch : Char;
  Deleted : Integer;
begin
  Deleted:=Choose;
  Writeln;
  Writeln('Izslegt informaciju?(Y/N)');
  Repeat
    Ch:=Readkey;
  Until Ch in['Y','y','N','n'];
  If Ch in ['N','n'] then Exit;
  Writeln('!', Deleted, '!');
  For I:=Deleted to Count-1 do
   begin
     item[I]:=item[I+1];
   end;
  Dec(Count);
  Save;
end;

procedure Edit;
var
  I : Integer;
  Ch : Char;
  Edited : Integer;
begin
  Edited:=Choose;
  Writeln;
  Writeln('Modificet informaciju?(Y/N)');
  Repeat
    Ch:=Readkey;
  Until Ch in['Y','y','N','n'];
  ClrScr;
  If Ch in ['N','n'] then Exit;
  Getitem( item[Edited] );
  Save;
end;

procedure Sort;
Var Ch : Char;
    Tmp : Titem;
    I, J : Integer;
    s1, s2 : String;
begin
  ClrScr;
  Writeln;
  Writeln('Sakartot informaciju : ');
  Writeln('a) pec markas');
  Writeln('b) pec izlaiduma gada');
  Writeln('c) izeja');
  Repeat
    Ch:=Readkey;
  Until Ch in ['A','a','B','b','C','c'];
  If Ch in ['C','c'] then Exit;
  If Ch in ['A','a'] then
   begin
     For I:=1 to Count-1 do
        For J:=1 to Count-I do
         begin
           If StrCmp( item[j].Marka, item[j+1].Marka )=1 then
            begin
              Tmp:=item[J];
              item[J]:=item[J+1];
              item[J+1]:=Tmp;
            end;
         end;
   end
  Else
   begin
     For I:=1 to Count-1 do
        For J:=i+1 to Count do
         if item[j].Izl_Gads<item[i].Izl_Gads then
            begin
              Tmp:=item[i];
              item[i]:=item[J];
              item[J]:=Tmp;
            end;
   end;
  Save;
end;

procedure Search;
Var s : String;
    I, Found : Integer;
    Ch : Char;
    key : Real;
begin
  ClrScr;
  Writeln( 'Atrasana' );
  InputData( s, 2, 15, 'Ievadiet cenu ','' );
  val(s,key,i);
  Writeln;
  Gotoxy(1,3);      Write('Marka');
  GotoXY(20,3);     Write('Izlaiduma gads');
  GotoXY(37,3);     Write('Nobraukums');
  GotoXY(56,3);     Write('Krasa');
  GotoXY(68,3);     Write('Cena');
  Writeln;
  Found:=0;
  For I:=1 to Count do
   begin
     If item[I].Cena<=key then
      begin
        Inc(Found);
        GotoXY(1,4+Found);      Write( item[I].Marka );
        GotoXY(20,4+Found);     Write( item[I].Izl_Gads );
        GotoXY(37,4+Found);     Write( item[I].Nobr );
        GotoXY(56,4+Found);     Write( item[I].Krasa);
        GotoXY(68,4+Found);     Write( item[I].Cena );
        Writeln;
      end;
   end;
  Writeln;
  textcolor(7);
  Writeln('### Nospiediet lai turpinat darbu');
  Ch:=Readkey;
end;

procedure countPrice;
Var sum : Real;
    I : Integer;
    Ch : Char;
begin
  ClrScr;
  Writeln( 'Videjas cenas aprekinasana' );
  Writeln;
  sum:=0;
  For I:=1 to Count do
   begin
     sum:=sum+item[i].cena;
   end;
  writeln('Videja cena = ',sum/count:0:2);
  writeln;
  textcolor(7);
  Writeln('### Nospeistiet lai turpinat darbu');
  Ch:=Readkey;
end;

Procedure parole;
Var s : string;
var i : integer;
var ch : char;

Begin

clrscr;
textcolor(white);
write('Ievadiet paroli: ');
s:='';
 While true do Begin
   ch:=Readkey;
   Case ord(ch) of
     13:break;
     27:Begin
          Exit;
        End;
     Else Begin
       If length(s)<10 Then Begin

		 write('*');
         s:=s+ch;
       End;
     End;
   End;
 End;

  If s='admin' Then Begin
	clrscr;
    writeln('Jus ielagojaties ka Administrators');
    admin := true;
  End Else Begin
	clrscr;
	writeln('Jus ielagojaties ka Letotajs');
    admin := false;
  End;
  Readkey;
  TextBackground(BackC);
  TextColor(TextC);
  Clrscr;
End;

Var I : Integer;
    Ch : Char;  {nospiestais taustins }

begin
  clrscr;
  TextC := 1;
  BackC := 3;
  admin := false;

  parole;

  CurCommand := 0;  {tekosas (iezimetas) komandas numurs}
  Load;

  While True do
  begin
    TextBackground(black);  {noradam fona krasu}

    TextColor(15);  {noradam teksta krasu}
    ClrScr;
    HideCursor;     {****************************}
    {izvadam izvelni uz ekranu}
    Row:= 1;
    Column:=1;
    for I:=0 to MenuCount-1 do
    begin
      GotoXY(Column, Row+I);  {parvietojam kursoru}
      if i=CurCommand then
        begin
          TextBackground(white);
          TextColor(Black);
          write(Menu[i]);
          TextBackground(black);
          TextColor(white);
        end
      else write (Menu[i]);
    end;

    ch:=ReadKey;
    {ja ir nospiests taustins <Esc>, partraucam programmas darbibu}
    if Ord(ch)=27 then Exit;
    {ja ir nospiests vadibas taustins vai taustins <Enter>}
    if (Ord(ch)=0) or (Ord(ch)=13) then
    begin
      {nosakam nospiestu taustinu}
      if Ord(ch) <> 13 then ch:=ReadKey;
      case Ord(ch) of
           {ja ir nospiesta bultina uz leju}
        80:if CurCommand < MenuCount-1 then CurCommand:=CurCommand+1
           else CurCommand:=0;
           {ja ir nospiesta bultina uz augsu}
        72:if CurCommand > 0 then CurCommand:=CurCommand-1
           else CurCommand:=MenuCount-1;
           {ja ir nospiests taustins <Enter>}
        13:case CurCommand of
             0:View;
             1:
			 begin
				if ( admin ) then
				begin
					Add;
				end
				else
				begin
          clrscr;
					writeln( brid );
          readln;
				end;
			 end;
       2:
			 begin
				if ( admin ) then
				begin
					Delete;
				end
				else
				begin
					clrscr;
					writeln( brid );
					readln;
				end;
			 end;
             3:
			 begin
				if ( admin ) then
				begin
					Edit;
				end
				else
				begin
          clrscr;
					writeln( brid );
          readln;
				end;
			 end;
             4:Search;
             5:Sort;
             6:CountPrice;
             7:Exit;
           end
      end
    end
  end
end.
