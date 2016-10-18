#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <windows.h>

int main()
 {
char text[200], temp[32], result[200],c[2],pmet[32];
int i,j,n,length,temp_len,sk;

system("cls");
printf("Ievadiet tekstu\n");
gets(text);
result[0] = '\0';
length=strlen(text);
n=0;
for(i=0; i<=length; i++)
{
         if((text[i]!=' ') && (text[i]!='.') && (text[i]!=',') && (text[i]!='\0') && (text[i]!='?') && (text[i]!='!') && (text[i]!=':') && (text[i]!=';') && (text[i]!='-'))
         {
             temp[n] = text[i];
             n++;            
         }
          else
         {
          temp[n]='\0';
          sk++;
            if(sk%2==1)
              {
               sk;        
               temp_len = strlen(temp);
               for (j=0;j<=temp_len;j++)
                 {
                   pmet[j] = temp[temp_len-j-1];
                 } 
                strcat(result,pmet);
               }
              else
              {
              }
         c[0] = text[i];
         strcat(result,c);
         pmet[0] = '\0';
         temp[0] = '\0';
         n=0;
         }   
}
printf("\nRezultats ir:\n%s", result);
getch();
return 0;
}
