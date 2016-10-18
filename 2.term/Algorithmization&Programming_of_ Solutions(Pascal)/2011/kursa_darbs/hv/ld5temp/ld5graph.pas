unit ld5graph;

interface

   procedure header;
   procedure footer(mode:byte);
   procedure setContour(xs,ys,dx,dy,color:byte);
   procedure restoreWindow;
   function allow:boolean;

implementation uses crt,ld5io,ld5preDefined;

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
     end;

   END;

   procedure setContour(xs,ys,dx,dy,color:byte);
    var i,xb,yb:byte;
    BEGIN
     xb:=dx+xs+1;yb:=ys+dy;

     //contour begins
     window(xs,ys,xb,ys);textbackground(color);clrscr;
     write(#218);for i:=1 to dx do write(#196); write(#191);
     window(xs,ys+1,xs,yb); for i:=1 to dy do write(#179);
     window(xb,ys+1,xb,yb); for i:=1 to dy do write(#179);
     window(xs,yb,xb,yb);
     write(#192);for i:=1 to dx do write(#196);write(#217);
     //contour ends
     window(xs+1,ys+1,xb-1,yb-1);textbackground(color);clrscr;textcolor(white);
    END;

    procedure restoreWindow;
     BEGIN
      window(minX,minY,maxX-1,maxY-1);textbackground(black);clrscr;textcolor(white);
     End;

BEGIN
END.
