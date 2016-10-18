 program massiv1;
 const   num=20;   
 var
    oper,        
    i,j :   integer;    
    ms: array[1..num] of real;
    x, dx :real;
    idet : integer;
    MinV: real;         
    label  MENU, SOLVE, BEIGAS;
    label STEP1, STEP2;
 begin
 MENU:
    x:=0.27; dx:=0.345;
    writeln;
    writeln( 'Programma domata ciklu operatoru un masivu apgusanai ');
    writeln( ' 3333 - beigt');
    writeln( ' 1111 - rekinat ar standarta sakumvertibam ');
    writeln( ' jebkurs cits skaitlis rekinat ar pasa uzdotam sakumvertibam');
    read( oper);
    if oper=3333 then goto BEIGAS;
    if oper=1111 then goto SOLVE;
    writeln( 'ievadi divus realus skaitlus,tie noteiks masiva elem. vertibas');
    read(x, dx);
SOLVE:
   for i:=1 to num do
      begin
      ms[i]:=10*sin(x);
      x:=x+dx;
      end;          writeln;
   for i:=1 to num do  
     begin
      write( '      "',i:2, '"', ms[i]:10:5);
      ms[i]:=abs(ms[i]);
     end;
     writeln;   writeln(' Lai turpinatu ievadi jebkuru skaitli ');
     read(j);
 STEP1:
     i:=1;
   while(i<=num) do
   begin
          if (ms[i]>4) then
         begin
           MinV:= ms[i];
           idet:=i;
           goto STEP2
         end
                           else
         i:=i+2;
   end;
   writeln('Apskatamaja kopaa nav neviena elementa, kas butu lielaks par 4');
   goto MENU;
 STEP2:
     i:=1;
   while(i<=num) do
   begin
          if ((ms[i]>4) and (ms[i]<Minv)) then
         begin
           MinV:= ms[i];
           idet:=i;
         end;
         i:=i+2;
   end;
   writeln(' Minimala pec modula masiva elementa vertiba apgabalaa ir :', MinV:10:5);
   writeln(' Minimala pec modula masiva elementa vertiba apgabalaa ir :', idet:5);

    goto MENU;
  BEIGAS:
    end.