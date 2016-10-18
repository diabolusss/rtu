Program DemoAsm;
Uses CRT;
Var X, Y : Word;
Begin
   ClrScr;

   X := 1;
   Y := 3;
   WriteLn('X  : ', X, ', Y  : ', Y, '.');
   asm
      Inc X        {X := X+1}

      Mov Ax, 2    {Ax := 2}
      Mul Y        {Dx:Ax := Ax*Y}
      Mov Y, Ax    {Y := Ax}
   end;

   WriteLn('X+1: ', X, ', 2*Y: ', Y, '.');
   ReadKey;
End.