unit LAB3U;
Interface
const LenStrMod=255;
      LenStrdata=80;

type STRMod = string [LenStrMod];
     STRData = string [LenStrdata];
 var NumMod : integer;
procedure StrReplace
 ( InpStr : STRMod; NameOut, NameIn : STRData; var OutStr : STRMod);

implementation
var ModPos: integer;
procedure inserttt
 (var StrIn : STRMod;  NameIn : STRData );
 begin
      if (length(StrIn)+length(NameIn) > LenSTRMod) then
          begin StrIn:='????'; NumMod:=-1; exit;end;
      insert( NameIn, StrIn, ModPos);
      NumMod:=NumMod+1;
 end;
procedure StrReplace
 ( InpStr : STRMod; NameOut, NameIn : STRData; var OutStr : STRMod);
begin
      NumMod:=0;
while pos( NameOut, InpStr) > 0 do
      begin
      ModPos:=pos(NameOut, InpStr);
      delete( InpStr, ModPos,  length(NameOut) );
      inserttt(InpStr, NameIn);
      end;

OutStr:= InpStr;
end;
 begin

 end.