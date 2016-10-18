#include <iostream.h>
#include <conio.h>

void main(void) {
   unsigned int X, Y;
   clrscr();

   X = 1;
   Y = 3;
   cout << "X  : " << X << ", Y  : " << Y << "." << endl;

   asm    Inc X        // X = X+1
   _asm   Mov Ax, 2    // Ax = 2
   __asm  Mul Y        // Dx:Ax := Ax*Y
  _asm    Mov Y, Ax    // Y := Ax

   cout << "X+1: " << X << ", 2*Y: " << Y << "." << endl;
   getch();
}