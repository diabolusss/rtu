#include <iostream.h>
#include <conio.h>

void main(void) {
   unsigned int X, Y;
   clrscr();

   X = 1;
   Y = 3;
   cout << "X  : " << X << ", Y  : " << Y << "." << endl;
   asm {
      Inc X        // X = X+1

      Mov Ax, 2    // Ax = 2
      Mul Y        // Dx:Ax := Ax*Y
      Mov Y, Ax    // Y := Ax
   }
   cout << "X+1: " << X << ", 2*Y: " << Y << "." << endl;
   getch();
}