unit ld5io;
interface uses ld5preDefined;

   function numCount(number:longint):byte;
   function carColor(num:byte):str;
   function NOD:word;
   procedure readStr(var words:str;ch:char);
   procedure globalBug(var exception:byte);
   procedure countingSort(var tFileLink:typeFile;opened:boolean);
   procedure searchCar(var tFileLink:typeFile;opened,allowed:boolean);
   function avgSum(var tFileLink:typeFile):extended;
   procedure saveChange(var tFileLink1,tFileLink2:typeFile);
   procedure fileTmp(var tFileLink:typeFile);
   procedure menu;
   procedure executeCmd(command:byte);


implementation uses crt,ld5inter,ld5graph;

 procedure executeCmd(command:byte);
  var i:integer;
  BEGIN
   case command of
    1:BEGIN 
         createFile(linkFile,nameFile,opened);
      END;
    2:BEGIN
         openFile(linkFile,nameFile,opened);
      END;
    3:BEGIN
         ViewFCar(linkFile,opened,allowed);
      END;
    4:BEGIN
       if not allowed then begin glBug:=7; globalBug(glBug);exit; end;
       editFile(linkFile,opened)
      END;
    5:BEGIN
           if allowed then addCar(linkFile,opened)
           else glBug:=7;globalBug(glBug);
      END;
    6:BEGIN 
       if not opened then begin glBug:=3; globalBug(glBug);exit; end;
       if not allowed then begin glBug:=7; globalBug(glBug);exit; end;
       if fileSize(linkFile)=0 then begin glBug:=8; globalBug(glBug);exit; end;
	  setContour(minX+4,minY+4,50,3,menuClr);clrscr;
          write('Enter record ID to delete: ');
          repeat {$I-}  read(i);  {$I+} until (ioResult=0)and(i>0)and(i<=fileSize(linkFile));
          delCar(linkFile,opened,i);
      END;
    7:BEGIN
        countingSort(linkFile,opened);
      END;
    8:BEGIN
        searchCar(linkFile,opened,allowed);
      END;
    9:BEGIN
        allowed:=allow;
      END;
   10:BEGIN
       if not opened then begin glBug:=3; globalBug(glBug);exit; end;
       if fileSize(linkFile)=0 then begin glBug:=8; globalBug(glBug);exit; end;
	setContour(minX+4,minY+4,50,3,menuClr);clrscr;
        write('Average cost of cars is: ',avgSum(linkFile):0:2);
        readkey;
      END;
   11:BEGIN
         closeFile(linkFile,opened);
       END;
   12:BEGIN
       if opened then begin glBug:=5; globalBug(glBug);exit; end;
       restoreWindow;
       halt;
      END;
   END;
  END;

 procedure menu;
   var 
    ok:boolean;
    i,choosen:integer;
    arrow:char;
   BEGIN clrscr;ok:=true;
    choosen:=1;
    cursorOff;
   REPEAT 
    if ok then begin
     header;
     setContour(minX+14,minY+4,length(menuPoints[1]),minY+length(menuPoints),menuClr);clrscr;
     for i:=1 to length(menuPoints) do begin
      if i=choosen then begin 
       textbackground(defaultTxtClr);textColor(defaultClr);
      end else begin
       textbackground(defaultClr);textColor(defaultTxtClr);
      end;
      gotoXY(minX,i);write(menuPoints[i]);
     end;
    end;
    ok:=false;
   arrow:=readkey;
   case arrow of
    #72:if choosen>1 then begin
         dec(choosen);
         ok:=true;
        end;
    #80:if choosen<length(menuPoints) then begin
         inc(choosen);
         ok:=true;
        end;
    '1':begin
         choosen:=1;executeCmd(choosen);ok:=true;
        end;
    '2':begin
         choosen:=2;executeCmd(choosen);ok:=true;
        end;
    '3':begin
         choosen:=3;executeCmd(choosen);ok:=true;
        end;
    '4':begin
         choosen:=4;executeCmd(choosen);ok:=true;
        end;
    '5':begin
         choosen:=5;executeCmd(choosen);ok:=true;
        end;
    '6':begin
         choosen:=6;executeCmd(choosen);ok:=true;
        end;
    '7':begin
         choosen:=7;executeCmd(choosen);ok:=true;
        end;
    '8':begin
         choosen:=8;executeCmd(choosen);ok:=true;
        end;
    '9':begin
         choosen:=9;executeCmd(choosen);ok:=true;
        end;
'A','a':begin
         choosen:=10;executeCmd(choosen);ok:=true;
        end;
'C','c':begin
         choosen:=11;executeCmd(choosen);ok:=true;
        end;
    #13:begin 
         executeCmd(choosen); ok:=true; 
        end;
#27,'Q','q':BEGIN
             choosen:=12;executeCmd(choosen);ok:=true;
            END;
   end; 
   UNTIL FALSE; END;

   function numCount(number:longint):byte;
    BEGIN
     numCount:=0;
     repeat
     number:=number div 10;
     inc(numCount);
     until number=0;
    END;
    
   function carColor(num:byte):str;
    BEGIN
     case NUM of
      0:carColor:='BLACK    ';
      1:carColor:='BLUE     ';
      2:carColor:='GREEN    ';
      3:carColor:='LIGHTBLUE';
      4:carColor:='RED      ';
      5:carColor:='VIOLET   ';
      6:carColor:='YELLOW   ';
      7:carColor:='WHITE    ';
     end;
    END;
   
   function NOD:word;
    BEGIN
     setContour(minX+4,minY+4,50,3,menuClr);clrscr;
     repeat gotoXY(minX,minY);clreol;
      write('Enter Number of Records in New File[0;n]: ');
      {$I-}read(NOD);{$I+} until (ioresult=0)and(NOD>=0)and(NOD<=maxRec);
     glBug:=111;
    END;
  
   procedure globalBug(var exception:byte);
    BEGIN
     setContour(minX+14,minY+9,60,3,alertClr);clrscr;
     case exception of
      1:writeln('error 0001: File already exist');
      2:writeln('error 0010: Couldn',#39't create file');
      3:writeln('error 0011: File is not accessible');
      4:writeln('error 0100: Illegal cmd');
      5:writeln('error 0101: Please, close file');
      6:writeln('error 0110: There are no records yet');
      7:writeln('error 0111: To enable these function authorize');
      8:writeln('error 1000: File is empty');
    111:writeln('Well done!');
     end;
     if exception<>0 then begin write('Press any key');readkey;exception:=0;end;
     restoreWindow;
    END;

   procedure readStr(var words:str;ch:char);
   var i,j:byte;tword:str;
   BEGIN i:=length(words);
    case ch of
     #8:
       if i>0 then
        begin
         tword:='';for j:=1 to i-1 do tWord:=tWord+words[j];
         words:=tWord;
         dec(i);
        end;
    else
      if (ch in chnumrange)and(length(words)<maxLength) then
       begin
        words:=words+ch;inc(i);
       end;
    end;
   END;

 procedure countingSort(var tFileLink:typeFile;opened:boolean);
  var carRec,tCarRec:CarData; tFile1,tFile2:typeFile;mode:byte;i:integer;
  BEGIN if not opened then begin glBug:=3; globalBug(glBug);exit; end;
    if fileSize(tFileLink)=0 then begin glBug:=8;globalBug(glBug);exit;end;
   setContour(minX+4,minY+4,50,4,menuClr);clrscr;
   repeat  clrscr; gotoXY(minX,minY);

    writeln('Sort by CarYear ascending[1] or descending[0]?');
    write('Sort by CarName A->Z[3] or Z->A[2]?',#10#13,'Enter number: ');
    {$I-} read(mode); {$I+} 
   until (ioResult=0)and(mode<4);
   seek(tFileLink,0);
   assign(tFile1,'sdata1.tmp'); rewrite(tFile1);
   assign(tFile2,'sdata2.tmp'); rewrite(tFile2);
    while not eof(tFileLink) do
     begin
      read(tFileLink,tCarRec);
      while not eof(tFileLink) do
       begin
        read(tFileLink,carRec);
         case mode of
          0: begin
              if (carRec.Year)>(tCarRec.Year) then begin
                write(tFile2,tCarRec);
                tCarRec:=carRec;
                end 
	      else write(tFile2,carRec);
              end;
          1: begin
              if (carRec.Year)<(tCarRec.Year) then begin
                write(tFile2,tCarRec);
                tCarRec:=carRec;
                end 
	      else write(tFile2,carRec);
              end;
          2: begin
              if (ord(carRec.Name[1]))>(ord(tCarRec.Name[1])) then begin
                write(tFile2,tCarRec);
                tCarRec:=carRec;
                end 
	      else write(tFile2,carRec);
              end;
          3: begin
              if (ord(carRec.Name[1]))<(ord(tCarRec.Name[1])) then begin
                write(tFile2,tCarRec);
                tCarRec:=carRec;
                end 
	      else write(tFile2,carRec);
              end;
         end;
       end;
      write(tFile1,tCarRec);
      rewrite(tFileLink); reset(tFile2); seek(tFile2,0);
      while not eof(tFile2) do begin
        read(tFile2,carRec);
        write(tFileLink,carRec);
        end;
      reset(tFileLink); rewrite(tFile2);
     end;
   reset(tFile1); rewrite(tFileLink); seek(tFile1,0);
   i:=0;
   while not eof(tFile1) do
    begin
    read(tFile1,carRec);carRec.id:=i;write(tFileLink,carRec);inc(i);
    end;
   close(tFile1); close(tFile2);
   erase(tFile1); erase(tFile2); reset(tFileLink);
  END;

   procedure searchCar(var tFileLink:typeFile;opened,allowed:boolean);
    var carRec:carData;i,j,n,y,size:integer;foundFileLink:typeFile;key:longInt;mode:char;quit,ok:boolean;z:byte;ch:char;
    BEGIN if not opened then begin glBug:=3; globalBug(glBug);exit; end;
     if fileSize(tFileLink)=0 then begin glBug:=8;globalBug(glBug);exit;end;
      setContour(minX+4,minY+4,70,3,menuClr);clrscr;
      repeat  gotoXY(minX,minY);clreol;write('Search for greater[>,g], less[<,l] or equal[=]? Enter char: ');
       Mode:=readkey;write(Mode); until mode in equality;
      repeat gotoXY(minX,minY+1);clreol; write('Enter Num [0;9 999 999]: ');{$I-}read(Key);{$I+} until (ioResult=0)and(Key>-1);

      reset(tFileLink);
      assign(foundFileLink,'fData.bin');rewrite(foundFileLink);
      for j:=0 to fileSize(tFileLink)-1 do begin
       seek(tFileLink,j);read(tFileLink,carRec);
       case mode of
        '>','G','g':begin
                     if(carRec.cost > key)then write(foundFileLink,carRec);
                     end;
        '<','L','l':begin
                     if(carRec.cost < key)then write(foundFileLink,carRec);
                     end; 
        '=':        begin
                     if(carRec.cost = key) then write(foundFileLink,carRec);
                     end;
        end;
       end;
       close(foundFileLink);reset(foundFileLink);fileTmp(tFileLink);reset(tFileLink);
       n:=0;y:=n*lineCount;size:=fileSize(foundFileLink);
    ok:=true;
    repeat quit:=false;

     j:=n*lineCount;z:=3+numCount(j);
     y:=(n+1)*lineCount;
    if ok then begin 
     header;
     writeln('ID',nbsp:z,'Name',nbsp:(maxLength),'Year',nbsp:4,'Cost',nbsp:5,'Milage',nbsp:4,'Color');

     for i:=n*lineCount to y do begin
       seek(foundFileLink,i);
       if not eof(foundFileLink) then begin
        read(foundFileLink,carRec);
        with carRec do begin
         write('#',id+1,nbsp:numCount(j),name,nbsp:(maxLength-length(name)+4),year,nbsp,cost,nbsp,milage);
         textcolor(color+6);textBackground(color);writeln(nbsp,carColor(color));textColor(7);textBackground(0);
         end;
        end;
       end;
      footer(2);
      end;
    ok:=false;
    repeat ch:=readkey; until (ch in stop)or(ch in fKeys);
     case ch of
      #72:if n>0 then begin dec(n); ok:=true;end;
      #80:if (n+1)*lineCount<size then begin inc(n); ok:=true; end;
      #61:begin
           if allowed then 
            if fileSize(foundFileLink)>0 then
             begin
	      setContour(minX+4,minY+4,50,3,menuClr);clrscr;
              write('Enter record ID to delete: ');
              repeat {$I-}  read(i);  {$I+} until (ioResult=0)and(i>0)and(i<=fileSize(foundFileLink));
              delCar(foundFileLink,opened,i);delCar(tFileLink,opened,i);
             end
            else begin glBug:=8; globalBug(glBug); end
           else begin glBug:=3; globalBug(glBug); end;
           ok:=true;
           end;
      #62:begin
           if allowed then editFile(foundFileLink,opened)
           else begin glBug:=7; globalBug(glBug); end;
           ok:=true;
           end;
      #27,#13:quit:=true;
     end;
    until quit;
    if allowed then saveChange(tFileLink,foundFileLink);
    close(foundFileLink);
    erase(foundFileLink);
    END;

   procedure saveChange(var tFileLink1,tFileLink2:typeFile);
    var carRec:carData;tmpFile:typeFile;ch:char;
    BEGIN
     setContour(minX+4,minY+4,50,3,menuClr);clrscr;
     write('Do you want to save changes?[y/n]');repeat ch:=readkey; until ch in yesOrNo;
     restoreWindow;
     assign(tmpFile,'data1.bin');reset(tmpFile);
     if ch in yes then begin
      reset(tFileLink1);reset(tFileLink2);
      while not eof(tFileLink2) do begin
       read(tFileLink2,carRec);
       seek(tFileLink1,carRec.id);
       write(tFileLink1,carRec);
       end;
      end else begin 
       rewrite(tFileLink1);
       assign(tmpFile,'data1.bin');reset(tmpFile);
        while not eof(tmpFile) do begin
         seek(tFileLink2,0);
         read(tmpFile,carRec);write(tFileLink1,carRec);
         end;
       reset(tFileLink1);
       end;
       close(tmpFile);erase(tmpFile);
    END;

   function avgSum(var tFileLink:typeFile):extended;
    var n:integer;s:longInt;carRec:carDAta;
    BEGIN 
      n:=fileSize(tFileLink)-1;s:=0;
      seek(tFileLink,0);
      while not eof(tFileLink) do begin
        read(tFileLink,carRec);
        s:=s+carRec.cost;
        end;
      seek(tFileLink,0);
      avgSum:=s/n;
    END;

   procedure fileTmp(var tFileLink:typeFile);
    var carRec:carData;tmpFile:typeFile;
    BEGIN
     reset(tFileLink);assign(tmpFile,'data1.bin');rewrite(tmpFile);
     while not eof(tFileLink) do begin
      read(tFileLink,carRec);write(tmpFile,carRec);
      end;
     close(tmpFile);
    END;


BEGIN
END.
