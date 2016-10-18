#include <string>
#include <conio>
#include <iostream>

using namespace std;

void main(void) {
   char* S1;
   char S2[20];
   string S3;

   S1 = "C++";
   strcpy(S2, "C++");
   S3 = "C++";

   cout << "TEXT:   " << S1 << " " << S2 << " " << S3 << endl;
   cout << "LENGTH: " << strlen(S1) << "   " << strlen(S2) << "   " << S3.length() << endl;

   while (kbhit())
      getch();
   getch();
}
