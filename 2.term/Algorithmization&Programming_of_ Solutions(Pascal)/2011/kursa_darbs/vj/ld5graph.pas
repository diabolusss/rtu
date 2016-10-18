unit ld5graph;

interface

   procedure header;
   procedure footer(mode:byte);
   procedure setContour(xs,ys,dx,dy,color:byte);
   procedure restoreWindow;
   function allow:boolean;
   procedure showdate;

implementation uses crt,dos,ld5io,ld5pre;

   function allow:boolean;
    var setOfCh:str;j:byte;ch:char;
    BEGIN restoreWindow;
     setOfCh:='';
     setContour(9,9,35,3,alertClr);clrscr;
     write('Enter password to get full access: ');
     window(10,11,43,11);textbackground(white);textcolor(0);
     repeat 
      clrscr; 
      for j:=1 to length(setOfCh) do write('*');
      ch:=readkey;
      readStr(setOfCh,ch);
      until (ch in stop)and(length(setOfCh)>0);
      if (setOfCh='nimda') then allow:=true else allow:=false;
     restoreWindow;
    END;

   procedure header;
    BEGIN
     window(minX,minY,maxX,minY);textbackground(white);clrscr;textcolor(black);
     if allowed then write('Authorized') else write('UnAuthorized');
     showdate;
     window(minX,minY+1,maxX,maxY-1);textbackground(black);clrscr;textcolor(white);
    END;

  procedure footer(mode:byte);
   BEGIN 
    window(minX,maxY-1,maxX,maxY-1);textbackground(white);clrscr;textcolor(black);
    case mode of 
     1:write('F2-ADD F3-DEL F4-Edit F5-Sort f-Find Esc-Exit');
     2:write('       F3-DEL F4-Edit                Esc-Exit');
     3:write('                             Enter/Esc-Accept');
     4:write('                                     Esc-Exit');
     5:write('ArrowUp-Up ArrowDn-Down Enter-Accept Esc-Exit');
     end;

   END;

   procedure setContour(xs,ys,dx,dy,color:byte);
    var i,xb,yb:byte;
    BEGIN
     xb:=dx+xs+1;yb:=ys+dy;

     {contour begins}
     window(xs,ys,xb,ys);textbackground(color);clrscr;textcolor(defaultClr);
     write(#218);for i:=1 to dx do write(#196); write(#191);
     window(xs,ys+1,xs,yb); for i:=1 to dy do write(#179);
     window(xb,ys+1,xb,yb); for i:=1 to dy do write(#179);
     window(xs,yb,xb,yb);
     write(#192);for i:=1 to dx do write(#196);write(#217);
     {contour ends}
     window(xs+1,ys+1,xb-1,yb-1);textbackground(color);clrscr;textcolor(white);
    END;

    procedure restoreWindow;
     BEGIN
      window(minX,minY,maxX-1,maxY-1);textbackground(black);clrscr;textcolor(white);
     End;

   procedure showdate;
   var tyear,tmonth,tdate,tday,HH,MM,SS,MSS:word;
        month:string;
   BEGIN GetDate(tyear,tmonth,tdate,tday);GetTime(HH,MM,SS,MSS);
       case tmonth of
       1:month:='January';
       2:month:='February';
       3:month:='March';
       4:month:='April';
       5:month:='May';
       6:month:='June';
       7:month:='July';
       8:month:='August';
       9:month:='September';
       10:month:='Oktober';
       11:month:='November';
       12:month:='December';
       end;
       write('DATE':15,nbsp:5,tdate,nbsp,month,nbsp,tyear,nbsp:5,'TIME ',HH,':');
       if MM div 10 =0 then write('0',MM) else write(MM);
   END;

BEGIN
END.
