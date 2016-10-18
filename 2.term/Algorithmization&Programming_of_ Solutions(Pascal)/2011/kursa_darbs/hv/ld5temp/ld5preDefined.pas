unit ld5preDefined;

interface
   const
         minX=1;  maxX=80;
         minY=1;  maxY=25;
	 alertClr=4;menuClr=1;defaultClr=0;defaultTxtClr=7;
         maxYear=9999;maxCost=9999999;maxMilage=999999;maxRec=5000;
	 yes=['Y','y'];no=['N','n'];
         YesOrNo=yes+no;
	 numrange:set of char=['0'..'9'];
         chrange:set of char=['A'..'Z','a'..'z'];
	 chnumrange:set of char=['0'..'9','A'..'Z','a'..'z','/',#32];
         equality=['G','g','L','l','<','>','='];
	 stop=[#13,#27];fKeys=[#72,#80,#60,#61,#62,#63,'A','F','f','a','s','S'];
	 lineCount=20;
	 count=12;nbsp='    ';br=#10#13;maxLength=30;
         menuPoints:array[1..count] of string[27]=(' [1] Create New File   '+nbsp,
        				           ' [2] Open Existing File'+nbsp,
        				           ' [3] View E. File      '+nbsp,
        				           ' [4] Edit Record       '+nbsp,
        				           ' [5] Add Record        '+nbsp,
        				           ' [6] Delete Record     '+nbsp,
        				           ' [7] Sort              '+nbsp,
        				           ' [8] Find by Cost      '+nbsp,
        				           ' [9] Pass              '+nbsp,
        				           ' [A] Average Cost      '+nbsp,
        				           ' [C] Close File        '+nbsp,
        				           ' [Q] Exit              '+nbsp
        				    );
         carName:array[1..20] of string[maxLength]=('Audi TTS quattro',
                                                    'Audi A4',
                                                    'Audi A6',
                                                    'Audi 80',
                                                    'Audi 90',
                                                    'Porsche 550 Spyder',
                                                    'Porsche 911',
                                                    'VW-Porsche 914',
                                                    'Porsche 959',
                                                    'Volkswagen Sedan',
                                                    'Volkswagen Cabriolet',
                                                    'Volkswagen Type 2',
                                                    'Volkswagen Pasat',
                                                    'Cadillac Series 60S Fleetwood',
                                                    'Cadillac Calais',
                                                    'Cadillac De Ville',
                                                    'Cadillac XLR-V',
                                                    'Opel Vivaro',
                                                    'Opel Astra',
                                                    'Opel Antara');
         carYear:array[1..20] of integer=(2008,
                                                    1994,
                                                    1994,
                                                    1966,
                                                    1980,
                                                    1953,
                                                    1963,
                                                    1969,
                                                    1986,
                                                    1938,
                                                    1980,
                                                    1950,
                                                    1973,
                                                    1959,
                                                    1970,
                                                    1975,
                                                    2005,
                                                    1905,
                                                    1962,
                                                    2008);



   type str=string[maxLength];
	carData=record
         id:integer;
	 name:str;
	 year:word;
	 cost:LongInt;
         milage:LongInt;
	 color:Byte;
	end;

	typeFile=file of carData;
        
   var 
       maxDataNum:integer;
       glBug:byte;
       allowed,opened:boolean;
       nameFile:str;linkFile:typeFile;
   procedure showdate;

implementation uses dos;

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
       write('DATE ':10,nbsp,tdate,nbsp,month,nbsp,tyear,nbsp,'TIME ',HH,' : ',MM);
   END;


BEGIN
END.
