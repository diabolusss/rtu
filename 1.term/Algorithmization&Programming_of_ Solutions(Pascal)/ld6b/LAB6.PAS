 program massiv2;
 const   num=10;   
 var
    oper, i,j :   integer;   
    wrk: integer ;
    ms: array[1..num, 1..num] of integer;
 label MENU, BEIGAS;
 begin
 MENU:
    writeln;
    writeln( 'Programma domata ciklu operatoru un masivu apgusanai ');
    writeln( ' 3333 - beigt');
    writeln( ' jebkurs cits skaitlis aizpildit masiva prasito dalu ');
    writeln( ' ar vertibam 1 2 3 ... pa horizontali ');
    read( oper);
    if oper=3333 then goto BEIGAS;
   for i:=1 to num do
   for j:=1 to num do
     ms[i,j]:=0;
   wrk:=1; 
   
   for j:=1 to (num div 2) do      
     begin                                 
      i:=(num+1)-j;                           
        ms[i,j]:=wrk;                      
        wrk:=wrk+1; 
        ms[j,i]:=wrk;                      
        wrk:=wrk+1;  
      end;
        
   for i:=1 to num do  
     begin writeln;
           for j:=1 to num do
           write( ms[i,j]:7)
     end;
     writeln;   writeln(' Lai turpinatu ievadi jebkuru skaitli ');
     read(j);
    goto MENU;
  BEIGAS:
    end.

