#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <windows.h>

int main()
 {
char text[200], temp[32], result[200];
int i,ii,n,id,length;

char tText[200];

system("cls");
printf("Ievadiet tekstu\n");
gets(text);
length=strlen(text);

result[0]=temp[0]=tText[0]='\0';

n=id=0;

for(i=0; i<=length; i++)
{
         if((text[i]!=' ') && (text[i]!='.') && (text[i]!=',') && (text[i]!='\0') && (text[i]!='?') && (text[i]!='!') && (text[i]!=':') && (text[i]!=';') && (text[i]!='-'))
         {
             temp[n] = text[i];
             n++;         
             temp[n]= '\0';
             
             //printf("temp=%c, n=%d, len=%d\n",temp[i],n,strlen(temp));   
         }
         else{
              n=0;

              if ((strlen(temp)>0)){
                                     id++;
                                     if (id%2==1){                      
                                      for(ii=strlen(temp)-1; ii>=0;ii--) tText[strlen(temp)-ii-1]=temp[ii];
                                      
                                      tText[strlen(temp)]='\0';
                                      
                                      //printf("tText=%s\n",tText);
                                      strcat(result," ");
                                      strcat(result,tText);
                                      tText[0]='\0';
                                      }
              }
              //printf("temp=%s id\%2=%d id=%d\n\n",temp,id%2,id);
              temp[0]='\0';              
          }
 
}
printf("\nRezultats ir:%s\n", result);
getch();
return 0;
}
