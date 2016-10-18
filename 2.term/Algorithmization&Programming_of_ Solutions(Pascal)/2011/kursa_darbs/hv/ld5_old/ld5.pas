program main;
uses ld5preDefined,ld5graph,ld5inter,ld5io,crt;

 procedure findCarData(aCarData:typeArray);

  function enterKey(searchFor:char):str;
   var tWord:str;ch:char;maxNum:longInt;
   BEGIN
   CASE searchFor of
       'N','n':maxNum:=maxLength;
       'Y','y':maxNum:=maxYear;
       'P','p':maxNum:=maxCost;
       'M','m':maxNum:=maxMilage;
       'C','c':maxNum:=7;
   END;clrscr;
     CASE searchFor of
       'N','n':begin
                gotoXY(minX,minY);write('Enter name [0;',maxNum,']: ');
               end;
          else begin
                gotoXY(minX,minY);write('Enter number [0;',maxNum,']: ');
               end;
     END;
   CASE searchFor of 
     'N','n':repeat               
              ch:=readkey; spellcheck(tWord,ch,0);   
              if length(tWord)>maxNum then deleteChar(tWord);      
              gotoXY(minX,MinY+1);clreol;write(tWord);        
             until (ch=accept)and(length(tWord)>0)and(length(tWord)<=maxNum);

      else repeat               
       ch:=readkey; spellcheck(tWord,ch,0);   
       if strToNum(tWord)>maxNum then deleteChar(tWord);      
       gotoXY(minX,MinY+1);clreol;write(tWord);        
      until (ch=accept)and(strToNum(tWord)>0)and(strToNum(tWord)<=maxNum);
   END;
    enterKey:=tWord;
   END;

   function setX(var rCarData:carData;key:char):str;
    BEGIN
     CASE key of
       'N','n':setX:=rCarData.name;
       'Y','y':setX:=numToStr(rCarData.year);
       'P','p':setX:=numToStr(rCarData.cost);
       'M','m':setX:=numToStr(rCarData.milage);
       'C','c':setX:=numToStr(rCarData.color);
     END;
    END;

  var l,h,i:integer;key,x:longInt;found,quit:boolean;fCarData:typeArray;ch,mode:char;keyWord,xWord:str;
  BEGIN
   setContour(minX+4,minY+4,60,3,menuClr);
   gotoXY(minX,minY);write('Search by: [n]Name,[y]Year,[p]Cost,[m]Milage,[c]Color');
   repeat               
    mode:=readkey;
   until mode in dataChar;write(mode);
     CASE mode of
       'N','n':keyWord:=enterKey(mode);
          else key:=strToNum(enterKey(mode));
     END;
    qSortCarData(aCarData,mode,false);
    found:=false;
    l:=low(aCarData);
    h:=high(aCarData);restoreWindow;i:=1;
    repeat
     inc(l);
     CASE mode of
       'N','n':xWord:=setX(aCarData[l],mode);
          else x:=strToNum(setX(aCarData[l],mode));
     END; 
    until (l=h)or(x=Key);
   if x=Key then found:=true;
   IF found then
    repeat
     setLength(fCarData,i);
     fCarData[i-1]:=aCarData[l];
     inc(l);inc(i);
     CASE mode of
       'N','n':xWord:=setX(aCarData[l],mode);
          else x:=strToNum(setX(aCarData[l],mode));
     END;     
    until (l=h)or(x<>Key);
    i:=0;
    repeat quit:=false;
    viewFile(fCarData,i);
    ch:=readkey;
    CASE ch of
          #72:begin
               if i>0 then dec(i);
              end;
          #80:begin
               if i<(high(fCarData) div lineCount) then inc(i);
              end;
      'F','f':begin
               findCarData(aCarData);
               {ok:=true;save:=ok;}
              end;
  'q','Q',#27:begin
               quit:=true;
              end;
    END;
   until quit;
  END;

var i,id:integer;ch:char;quit,ok,save:boolean;arrCarData:typeArray;
BEGIN
{ allowed:=allow;
 opened:=false;
 menu;}
{ var      allowed,opened:boolean;
       nameFile:str;linkFile:typeFile;}
{new procedures===vektorial}
{createFile(linkFile,nameFile);}
openFile(linkFile,nameFile);
getArray(linkFile,arrCarData);
i:=0;ok:=true;save:=false;

repeat quit:=false;
 if ok then viewFile(arrCarData,i);
   footer(1);
 ok:=false;
 ch:=readkey;
 case ch of
  'q','Q',#27:begin
               quit:=true;ok:=true;
               if save then begin 
                setContour(minX+14,minY+9,50,3,menuClr);
                write('Exit without saving? Yes[y]/No[n]/Cancel[c]');
                repeat 
                 ch:=readkey;         
                until ch in YesNoCancel;
                if ch in no then updateFile(linkFile,arrCarData);
                if ch in cancel then quit:=false;
               end;
              end;
          #72:begin
               if i>0 then begin dec(i);ok:=true;end;
              end;
          #80:begin
               if i<(high(arrCarData) div lineCount) then begin inc(i); ok:=true;end;
              end;
          #60:begin
               addACar(arrCarData,i,0);
               ok:=true;save:=ok;
              end;
          #61:begin
               deleteACar(arrCarData);
               ok:=true;save:=ok;
              end;
          #62:begin
               editAArray(arrCarData);
               ok:=true;save:=ok;
              end;
          #63:begin
               qsortCarData(arrCarData,ch,true);
               ok:=true;save:=ok;
              end;
      'F','f':begin
               findCarData(arrCarData);
               ok:=true;{save:=ok;}
              end;
      'S','s':begin
               if save then begin
                updateFile(linkFile,arrCarData);save:=false;
                getArray(linkFile,arrCarData);
                ok:=true;
               end;
              end;
             end;
until quit;

closeFile(linkFile);

END.
