{
Searching for Files
Stop. This is the one and only solution to file searching. Use Delphi to find any file in any directory and/or subdirectory that match a certain mask. Start searching.

Article:
. http://delphi.about.com/library/weekly/aa051600a.htm

********************************************
Zarko Gajic
About.com Guide to Delphi Programming
http://delphi.about.com
email: delphi.guide@about.com
********************************************
}
unit cNNFunctions;

{$R-,T-,X+,H+,B-}

interface
    {$IFDEF MSWINDOWS}
    uses  Windows, SysUtils, Classes, Messages,  Variants,  Graphics, Controls, Forms, Dialogs, ComCtrls, ExtCtrls, StdCtrls;
    {$ENDIF}
    {$IFDEF LINUX}       
    {$ENDIF}
    uses cGlobalHeader;
    
    PROCEDURE printWeights(const weightArray: _weightVecS);
    PROCEDURE printLinks(link2DArray:_link2DVecI);

    PROCEDURE initN2RLinks(
      var tmpLinks:_link2DVecI;
      receptorCount:Integer;
      neironCount:integer;
      posLinkCount:Integer;
      negLinkCount:integer
    );
    
    PROCEDURE initWeights(
      var tmpWeights:_weightVecS;
      neironCount:integer
      );

implementation

  //
  //Sets random weights
  PROCEDURE initWeights(
      var tmpWeights:_weightVecS;
      neironCount:integer
      );
  VAR
    i
    :sizeInt;
  BEGIN
    Randomize();
    
    setLength(tmpWeights, neironCount);
    
    for i := low(tmpWeights) to high(tmpWeights) do begin
      tmpWeights[i] := 2*Random - 1;
    end;

  END;

  //
  //Sets random links between receptors
  //and neirons
  PROCEDURE initN2RLinks(
      var tmpLinks:_link2DVecI;
      receptorCount:Integer;
      neironCount:integer;
      posLinkCount:Integer;
      negLinkCount:integer
    );
  VAR

    i, 
    j,
    random_pos
    :sizeInt;

  BEGIN
    Randomize();
    
    setLength(tmpLinks, receptorCount);
    for i := low(tmpLinks) to high(tmpLinks) do begin
        setLength(tmpLinks[i], neironCount);
    end;

     //fill array with zeroes
    for i :=low(tmpLinks) to high(tmpLinks) do begin
      for j := low(tmpLinks[i]) to high(tmpLinks[i]) do begin
        tmpLinks[i,j] := 0;
      end;
    end;

    //create random links
    for i := low(tmpLinks) to high(tmpLinks) do begin
    
        for j := low(tmpLinks) to posLinkCount-1 do begin
            random_pos := Random(neironCount-1);
            tmpLinks[i,random_pos] := 1;
        end;
        
        for j := low(tmpLinks) to negLinkCount-1 do begin
            random_pos := Random(neironCount-1);
            tmpLinks[i,random_pos] := 9;
        end;

    end;

  END;
  
{#REGION Custom functions}
    PROCEDURE printWeights(const weightArray: _weightVecS);
    VAR
        i
        :sizeInt;
    BEGIN
        writeln('=========================');
        for i:=low(weightArray) to high(weightArray) do begin
            writeln('[',i , '] ',weightArray[i]);
        end;
        writeln('=========================');
    END;
    
    PROCEDURE printLinks(link2DArray:_link2DVecI);
    VAR
        i,j
        :sizeInt;
    BEGIN
        writeln('=========================');
        for i :=low(link2DArray) to high(link2DArray) do begin
            for j := low(link2DArray[i]) to high(link2DArray[i]) do begin
                write(link2DArray[i,j]);
            end;
            writeln();
        end;
        writeln('=========================');
    
    END;
{#ENDREGION Custom functions}

BEGIN
END.
