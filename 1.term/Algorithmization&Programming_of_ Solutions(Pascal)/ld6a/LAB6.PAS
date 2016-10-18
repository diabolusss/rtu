 program massiv2;
 const   num=10;   
 var
    oper, i,j,k :   integer;    
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
   
   for j:=1 to num do    
     begin    
    i:=3; 
    If (j<4) then k:=4+j;
    If ((j>=4) and (j<=8)) then begin
    k:=3+j;  If (k>10) then k:=10;
    End;
    If (j>8)then k:=18-j;
    while(i <= k) do    
      begin                                
        ms[i,j]:=wrk;                      
        wrk:=wrk+1;                        
         i:=i+1
      end;
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

