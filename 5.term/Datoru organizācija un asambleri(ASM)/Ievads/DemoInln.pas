Program DemoAsm;
Uses CRT;
Var X, Y : Word;
Begin
   ClrScr;

   X := 1;
   Y := 3;
   WriteLn('X  : ', X, ', Y  : ', Y, '.');

   (*
      10 0106  FF 06 0102r		   Inc X	; X := X+1
      11 010A  B8 0002			   Mov Ax, 2	; Ax := 2
      12 010D  F7 26 0104r		   Mul Y	; Dx:Ax := Ax*Y
      13 0111  A3 0104r			   Mov Y, Ax	; Y := Ax
   *)

   inline (
      $FF/$06/X/  {X := X+1}
      $B8/>0002/  {Ax := 2}
      $F7/$26/Y/  {Dx:Ax := Ax*Y}
      $A3/Y       {Y := Ax}
   );

   WriteLn('X+1: ', X, ', 2*Y: ', Y, '.');
   ReadKey;
End.