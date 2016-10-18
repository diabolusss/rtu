program check;

uses crt;

const maxX=14;maxY=14;

 procedure addBarrier(x,y,width,height:integer);
  var i,j,BarrierCount:integer;
      mas:array[0..maxY,0..maxX] of integer;
  BEGIN
   if((width=0)or(height=0)) then exit;
   BarrierCount:=0;
   
   for i:=0 to maxY do
    for j:=0 to maxx do mas[i][j]:=0;
	
   while x+width>maxX+1 do dec(width);
   while y+height>maxY+1 do dec(height);

   j:=0;  
   REPEAT
    i:=0;
	
    repeat    
      mas[j+y][i+x]:=1;
	  inc(BarrierCount);
	  inc(i);
    until i=width;
	
    inc(j);
   UNTIL j=height; 
   
   for i:=0 to maxY do begin
    for j:=0 to maxx do write(mas[i][j]);
	writeln;
   end;
   writeln('barCount=',barrierCount);
  END;
  
VAR OK:BOOLEAN; CH:CHAR;tX,tY,tWidth,tHeight:integer;
BEGIN REPEAT ok:=false;
 writeln('Please enter x,y,width,height');
 write('x[0..14]=');readln(tx);
 write('y[0..14]=');readln(ty);
 write('width[max 15]=');readln(twidth);
 write('height[max 15]=');readln(theight);
 addBarrier(tx,ty,twidth,theight);
 ch:=readkey;
 if ch=#27 then ok:=true;
UNTIL OK END.