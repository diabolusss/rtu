  unit ld5inter;
  interface
   uses ld5pre;

   procedure createFile(var tFileLink:typeFile;var tFileName:str);
   function  reCreateFile(tFileName:str):boolean;
   procedure openFile(var tFileLink:typeFile;var tFileName:str);
   procedure ViewFCar(var tFileLink:typeFile);
   procedure editFile(var tFileLink:typeFile);
   procedure editRecord(var carName:str;var carYear:Word;var carCost:LongInt;var carRun:LongInt;var carClr:Byte);
   procedure closeFile(var tFileLink:typeFile);
   procedure addCar(var tFileLink:typeFile);
   procedure DelCar(var tFileLink:typeFile;var i:integer;ask:boolean);

  implementation uses crt,ld5io,ld5graph;

   procedure createFile(var tFileLink:typeFile;var tFileName:str);
   var i,j,NumOfData:word;carRec:carData;ch:char;
   BEGIN restoreWindow;
    if opened then begin glBug:=5;globalBug(glBug);exit; end;
     tFileName:='';
     setContour(minX+4,minY+4,50,3,menuClr);clrscr;
     writeln('Input New File Name(length [1;25] characters)');
      repeat clreol;
       write(#13,tFileName,#8#13);
       ch:=readkey;
       readStr(tFileName,ch);
      until (ch in stop)and(length(tFileName)>0);
      
    tFileName:=path+tFileName+'.db';

    assign(tFileLink,tFileName);
    {$I-}  reset(tFileLink);  {$I+}
    if ioResult=0 then begin glBug:=1;
      if reCreateFile(tFileName) then begin
        close(tFileLink);
        {$I-}  rewrite(tFileLink);  {$I+}
	if ioResult<>0 then glBug:=2
	else glBug:=111;
        end
        else exit;
      end
    else begin
      {$I-}  rewrite(tFileLink);  {$I+}
      if ioResult<>0 then glBug:=2
      else glBug:=111;
      end;
    globalBug(glBug);
    NumOfData:=NOD;
    globalBug(glBug);
    j:=1;
    for i:=1 to NumOfData do begin
     with carRec do begin
       id:=i-1;name:=carName[j];year:=carYear[j];cost:=11111-i;milage:=111111+year;
       if j<20 then inc(j) else j:=1; 
       if i<7 then color:=i else color:=0;
       end;
     write(tFileLink,carRec);
     end;
    close(tFileLink);
    restoreWindow;
   END;

   function reCreateFile(tFileName:str):boolean;
    var ch:char;
    BEGIN
     globalBug(glBug);
     setContour(minX+4,minY+4,50,3,menuClr);clrscr;
     write('Do you want to rewrite it!?[y\n] ');
     repeat ch:=readkey; until ch in YesOrNo;
     if ch in yes then reCreateFile:=true
     else reCreateFile:=false;
     
     restoreWindow;
    END;

   procedure openFile(var tFileLink:typeFile;var tFileName:str);
    var ch:char;
    BEGIN
     setContour(minX+4,MinY+4,50,3,menuClr);clrscr;
     ch:='y';
     if opened then begin
      writeln('File ',tFileName,' is opened');
      write('Open other File?[y/n] ');
       repeat ch:=readkey; until ch in YesOrNo;write(ch);
       if ch in Yes then begin
         close(tFileLink);opened:=false;
         end;
       end;
     if ch in Yes then begin tFileName:='';
        clrscr;writeln('Enter file name to open: ');
	repeat
	 clreol;write(#13,tFileName,#8#13);
	 ch:=readkey;
	 readStr(tFileName,ch);
	until (ch in stop)and(length(tFileName)>0);
        tFileName:=path+tFileName+'.db';
	assign(tFileLink,tFileName);
        end;
    {$I-}  reset(tFileLink);  {$I+}
     if ioResult=0 then begin glBug:=111;opened:=true;end
     else glBug:=3;
     globalBug(glBug);
    END;

   procedure editFile(var tFileLink:typeFile);
    var carRec:carData;i:integer;
    BEGIN
     if not opened then begin glBug:=3;globalBug(glBug); exit; end;
     if not allowed then begin glBug:=7;globalBug(glBug); exit; end;
     if fileSize(tFileLink)=0 then begin glBug:=8;globalBug(glBug); exit; end;
       setContour(minX+4,minY+4,50,2,menuClr);clrscr;
       repeat 
        gotoXY(minX,minY);write('Enter record ID to edit: ');
        {$I-} read(i); {$I+}
       until (ioResult=0)and(i>0)and(i<=fileSize(tFileLink));
       i:=i-1;
       seek(tFileLink,i);
       read(tFileLink,carRec);
       with carRec do editRecord(name,year,cost,milage,color);
       seek(tFileLink,i);
       write(tFileLink,carRec);

    END;

   procedure editRecord(var carName:str;var carYear:Word;var carCost:LongInt;var carRun:LongInt;var carClr:Byte);
    var quit:boolean;i:integer;ch:char;
    BEGIN repeat quit:=false;
     footer(3);
     setContour(minX+4,minY+4,70,15,menuClr);clrscr;
     writeln('[id]',br,'[1] CarName:',carName,br,'[2] carYear:',carYear,br,
             '[3] carCost:',carCost,br,'[4] carRun:',carRun,br,'[5] carColor:',carColor(carClr));
     
     repeat gotoXY(minX,minY+6);write('Which field to edit? Enter ID:');ch:=readkey;writeln(ch);
      until (ch in numrange)or(ch in stop);
     case ch of
	'1':repeat
	     clreol;write(#13,carName,#8#13);
	     ch:=readkey;
	     readStr(carName,ch);
	    until (ch in stop)and(length(carName)>0);
	'2':repeat gotoXY(minX,minY+7);clreol;
             write('Enter Year[1900:',maxYear,']: ');
             {$I-}  read(carYear);  {$I+}      
            until (ioResult=0)and(carYear>1899)and(carYear<=maxYear);
	'3':repeat gotoXY(minX,minY+7);clreol;
             write('How much cost ',carName,'[0:',maxCost,']: ');
             {$I-} read(carCost); {$I+} 
            until (ioResult=0)and(carCost>=0)and(carCost<=maxCost);
	'4':repeat gotoXY(minX,minY+7);clreol;
             write('How much is ',carName,' milage[0:',maxMilage,']: ');
             {$I-} read(carRun); {$I+} 
            until (ioResult=0)and(carRun>=0)and(carRun<=maxMilage);

	'5':repeat gotoXY(minX,minY+7);clreol;
             for i:=0 to 7 do begin  
               if i=4 then writeln;
	       write('[',i,']');textbackground(i+6);textcolor(i);
               write(carColor(i));textbackground(red);textcolor(7);
	       end;
             writeln;textbackground(menuClr);clreol;
 	     write('What color has ',carName,': ');{$I-} read(carClr); {$I+}
	    until (ioResult=0)and(carClr<8);
	#13,#27:quit:=true;
     end;
    until quit; END;

   procedure addCar(var tFileLink:typeFile);
    var carRec:carData;i:byte;ch:char;
    BEGIN 
     if not opened then begin glBug:=3;globalBug(glBug); exit; end;
     if not allowed then begin glBug:=7;globalBug(glBug); exit; end;
     if fileSize(tFileLink)=maxRec then begin glBug:=6;globalBug(glBug); exit; end;

     with carRec do begin
     setContour(minX+4,minY+4,50,3,menuClr);
     repeat clrscr;
      write('Do you really want to add new car?[y/n]');ch:=readkey;write(ch); 
     until ch in YesOrNo;
     if ch in no then exit; 
     footer(3);
     setContour(minX+4,minY+2,70,10,menuClr);clrscr;
     name:='';
     repeat
	 clreol;write(#13,'Enter car name: ');write(Name,#8);
	 ch:=readkey;readStr(Name,ch);
     until (ch in stop)and(length(Name)>0);

     repeat gotoXY(minX,minY+1);clreol;
      write('Enter ',Name,' Year[1900:',maxYear,']: ');
      {$I-}  read(Year);  {$I+}      
     until (ioResult=0)and(Year>1899)and(Year<=maxYear);

     repeat gotoXY(minX,minY+2);clreol; 
      write('How much cost ',Name,'[0:',maxCost,']: ');
      {$I-}  read(Cost);  {$I+} 
     until (ioResult=0)and(Cost>=0)and(Cost<=maxCost);

     repeat gotoXY(minX,minY+3);clreol; 
      write('How much is ',Name,' milage[0:',maxMilage,']: ');
      {$I-}  read(milage);  {$I+} 
     until (ioResult=0)and(milage>=0)and(milage<=maxMilage);

     repeat gotoXY(minX,minY+4);clreol;
      for i:=0 to 7 do
	begin  
         if i=4 then writeln;
	 write('[',i,']');textbackground(i+6);textcolor(i);
         write(carColor(i));textbackground(red);textcolor(7);
	end;
       writeln;
       textbackground(menuClr);textcolor(7);
      clreol;write('What color has ',Name,': ');{$I-} read(Color); {$I+}
     until (ioResult=0)and(Color<8);
    id:=fileSize(tFileLink);

    seek(tFileLink,fileSize(tFileLink));
    write(tFileLink,carRec);
    restoreWindow;
    end;
    END;

   procedure DelCar(var tFileLink:typeFile;var i:integer;ask:boolean);
    var carRec:carData;j:integer;
    BEGIN

     if not opened then begin 
      if ask then begin
       glBug:=3; globalBug(glBug);
      end;
     exit; 
     end;
     if not allowed then begin 
      if ask then begin
       glBug:=7; globalBug(glBug);
      end;
     exit; 
     end;
     if fileSize(tFileLink)=0 then begin 
      if ask then begin
       glBug:=8; globalBug(glBug);
      end;
      i:=-1;
      exit; 
     end;
     if i<0 then exit;

     if ask then begin
      setContour(minX+4,minY+4,50,3,menuClr);
      write('Enter record ID to delete: ');
      repeat {$I-}  read(i);  {$I+} until (ioResult=0)and(i>0)and(i<=fileSize(tFileLink));
     end;
  
       j:=i;
       if j=fileSize(tFileLink) then begin
        seek(tFileLink,j-1);read(tFileLink,carRec);i:=carRec.id+1;
        seek(tFileLink,j-1);truncate(tFileLink);
        end
       else begin
        for j:=i-1 to fileSize(tFileLInk)-2 do
         begin
          seek(tFileLink,j+1);
          read(tFileLink,carRec);dec(carRec.id);
          seek(tFileLInk,j);i:=carRec.id+2;
          write(tFileLink,carRec);
         end;
        seek(tFileLink,fileSize(tFileLink)-1);
        truncate(tFileLink);
       end;
    END;

   procedure ViewFCar(var tFileLink:typeFile);
    var i,n,y,size:integer;carRec:carData;quit,ok:boolean;ch:char;
    BEGIN 
     if not opened then begin glBug:=3; globalBug(glBug); exit; end;
     n:=0;y:=n*lineCount;size:=fileSize(tFileLink);
     ok:=true;
    repeat quit:=false;
     y:=(n+1)*lineCount;
    if ok then begin 
     header;
     writeln('ID',nbsp:4,'Name',nbsp:(maxLength-3),'Year',nbsp,'Cost',nbsp:4,'Milage',nbsp:1,'Color');

     for i:=n*lineCount to y do begin
       seek(tFileLink,i);
       if not eof(tFileLink) then begin
        read(tFileLink,carRec);
        with carRec do begin
         write('#',id+1,nbsp:(5-numCount(id)),name,nbsp:(maxLength-length(name)+1),year,
               nbsp,cost,nbsp:(7-numCount(cost)+1),milage,nbsp:(6-numCount(milage)+1));
         textcolor(color+6);textBackground(color);writeln(carColor(color));textColor(7);textBackground(0);
         end;
        end;
       end;
      footer(1);
      end;

    ok:=false;
    repeat ch:=readkey; until (ch in stop)or(ch in fKeys);
     case ch of
      #72:if n>0 then begin dec(n); ok:=true;end;
      #80:if (n+1)*lineCount<size then begin inc(n); ok:=true; end;
      #60:begin
           addCar(tFileLink);
           ok:=true;
           end;
      #61:begin
           delCar(tFileLink,i,true);
           ok:=true;
           end;
      #62:begin
           editFile(tFileLink);ok:=true;
          end;
      #63:begin countingSort(tFileLink);ok:=true;end;
      'F','f':begin searchCar(tFileLink);ok:=true; end;
      #27,#13:quit:=true;
     end;
    until quit;

    END;

   procedure closeFile(var tFileLink:typeFile);
    BEGIN
     if not opened then begin glBug:=3;globalBug(glBug);exit; end;
     close(tFileLink); glBug:=111; globalBug(glBug);
     opened:=false;
    END;

  BEGIN
   glBug:=0;
  END.
