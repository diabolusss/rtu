unit game_fun;

interface
uses pngimage;

const maxX=640; maxY=480;cBar=20;
      BoolToStr : array [ boolean ] of string = ( 'False', 'True' ) ;

TYPE
  tHero = RECORD
  //hero coord[x,y] movement multiplier[kx,ky] speed [heroSpeed]
  x,y,kx,ky,speed:integer;
  //multiplier[kU-up,kD-down,kL-left,kR-right]
  kU,kD,kL,kR:integer;
  //hero state[in tank=true/out of tank=false]
  state:boolean;
  //png object and png location
  body:TPNGObject;
  bodyPath:string;
  //saves last key
  lastKey:word;
  //length to barrier
  len:integer;
  END;
  
  tBarrier = RECORD
   x,y,width,height:integer;
  END;
  
var
  ground:tPNGObject;  
  hero:tHero;
  barrier,tBarXA,tBarYA,tBarXD,tBarYD:array[0..cBar] of tBarrier;
  BarrierCount:integer;
  t2,t3:integer;

//sorts from lowest->
procedure qsort(var A:array of tBarrier;mode:byte;opt:byte);
procedure addBarrier(x,y,width,height:integer);
procedure setBarLength;
 
implementation
    //aizpildam barjera mas ar 0 un addBarriers
    procedure setBarLength;
    var i:integer;
     BEGIN
      //fill with zeros
      for i:=0 to cBar do begin
        barrier[i].x:=0;
        barrier[i].y:=0;
		barrier[i].width:=0;
        barrier[i].height:=0;
       end;

      //there is no barriers
      BarrierCount:=0;

      //field borders [width,height,x,y ]
      addBarrier(0,0,maxX,0);      //start coord[0,0] horizontal->maxX
      addBarrier(0,0,0,maxY);      //start coord[0,0] vertical->maxY
      addBarrier(0,maxY,maxX,0);   //start coord[0,maxY] horizontal->maxX
      addBarrier(maxX,0,0,maxY);   //start coord[maxX,0] vertical->maxY
	  
	  //rand barriers

	  addBarrier(50,350,50,50); addBarrier(150,350,50,50); addBarrier(250,350,50,50); addBarrier(350,350,50,50);//4	  
	  addBarrier(50,150,50,50); addBarrier(150,150,50,50); addBarrier(250,150,50,50); addBarrier(350,150,50,50);//2
	  addBarrier(50,50,50,50);  addBarrier(150,50,50,50);  addBarrier(250,50,50,50);  addBarrier(350,50,50,50); //1	  
	  addBarrier(50,250,50,50); addBarrier(150,250,50,50); addBarrier(250,250,50,50); addBarrier(350,250,50,50);//3

	  //sort by 0x ascending
      qSort(barrier,0,0);tBarXA:=barrier;
	  //sort by Oy ascending
	  qSort(barrier,1,0);tBarYA:=barrier;
	  //sort by 0x descending
      qSort(barrier,0,1);tBarXD:=barrier;
	  //sort by Oy descending
	  qSort(barrier,1,1);tBarYD:=barrier;
     END;
//saglabajam barjera koord un width un height
procedure addBarrier(x,y,width,height:integer);
var i:integer;
 BEGIN
  for i:=0 to cBar do
   if((barrier[i].width=0)and(barrier[i].height=0))then begin
    barrier[i].x:=x;
	barrier[i].y:=y;
	barrier[i].width:=width;
	barrier[i].height:=height;
	inc(barrierCount);
	break;
   end;
 END;
//sorts ascending[0] descending[1]
 PROCEDURE qsort(var A:array of tBarrier;mode:byte;opt:byte);
    PROCEDURE sort(l,r: integer);
	
	  function xKey(var num:integer):integer;
	   BEGIN
	    case mode of
		 0:xKey:=a[num].x;
		 1:xKey:=a[num].y;
		end;
	   END;
	   
      var i,j,x: integer;
	      y:tBArrier;
     BEGIN
      i := l;
      j := r;
	  
	    case mode of
		 0:x := A[ (l + r) div 2 ].x;
		 1:x := A[ (l + r) div 2 ].y;
		end;	  
	  
      REPEAT
	    case opt of
        0:begin
		   while xKey(i) < x do inc(i);
           while x < xKey(j) do dec(j);
		  end;
        1:begin
		   while xKey(i) > x do inc(i);
           while x > xKey(j) do dec(j);
		  end;
		end;
        if not (i>j) then
          begin
            y    := A[i];
            A[i] := A[j];
            A[j] := y;
            inc(i);
            dec(j);
          end;

      UNTIL i>j;
      if l < j then sort(l,j);
      if i < r then sort(i,r);
     END;
 BEGIN
  sort(0,High(A));
 END;

BEGIN

END.