#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <windows.h>
#define N 15
#define true 1
#define false 0

int ierskaits(FILE*);

int main()
{
 FILE *fails_st,*fails_st2;
 struct seminari
   {
     int Nr,grnum,diena;
     char priek[21], pas[14], laiks[12], audit[14];
   } seminars[N];
 int i,j,choice,choice2,darbojas=true,a,m,kk;
 char p,k='!',u='1';
 
 do
  { 
   system("cls");
   printf("Eduards Sarneckis, DITF, 6.grupa, 37.variants, 101RDB121\n");
   printf("|1| - izvadit faila saturu uz ekranu (ja fails eksiste)\n");
   printf("|2| - pievenot jaunus ierakstus failam\n");
   printf("|3| - izvadit informaciju par seminariem, kuri notiek pirmdienas\n");
   printf("|4| - izdzest failu (ja tas eksiste)\n");
   printf("|0| - iziet no programmas\n");
   printf("Ievadiet Jusu izveli\n");
   choice=getch();
   switch(choice)
      {
        case '1': system("cls");        
                  fails_st = fopen("seminari.txt", "r");
                  fails_st2 = fopen("seminari2.txt", "r");
                  if ( fails_st == NULL )
                    { 
                      printf ("Nevar atvert failu,jo tas neeksiste\n");
                    }
                  else
                    {
                      m=ierskaits(fails_st2);
                      fclose(fails_st2);
                             
                      for(i=0; i<m; i++)
                        fread(seminars,sizeof(seminars),2,fails_st);
                      fclose(fails_st);
                      
                      printf("Seminaru saraksts\n");
                      printf("Nr|           Prieksmets|   Pasniedzejs|Gr.Num|Diena|       Laiks|    Auditorija");
                      for(i=0; i<m; i++)
                        printf("%2d|%21s|%14s|%6d|%5d|%12s|%14s", seminars[i].Nr, seminars[i].priek, seminars[i].pas, seminars[i].grnum, seminars[i].diena, seminars[i].laiks, seminars[i].audit);
                    }
                  printf("Nospidiet jebkuru taustinu\n");  
                  getch();
                  break;
                  
        case '2': system("cls");   
                  printf("Ievadiet cik ierakstus gribat pievienot (ja ne gribat pievienot,ievadiet 0)\n");
                  scanf("%d",&choice2);
                  fails_st = fopen("seminari.txt", "r");
                  fails_st2 = fopen("seminari2.txt", "r");
                  if ( fails_st == NULL )
                    { 
                      j=0;
                    }  
                  else
                    {  
                      j=ierskaits(fails_st2);
                    }
                  printf("Aizpildiet, ludzu, sarakstu\n");
                  for(i=j; i<j+choice2; i++)
                    {
                      seminars[i].Nr=i+1;
                      printf( "Ievadiet prieksmeta nosaukumu:  ");      
                      _flushall();
                      scanf("%s",seminars[i].priek);
                      printf( "Ievadiet pasnedzeja vardu, uzvardu:  ");
                      _flushall();
                      scanf("%s",seminars[i].pas);
                      printf( "Ievadiet grupas numuru, kurai notiek seminars:  ");
                      _flushall();
                      scanf("%d",&seminars[i].grnum);
                      printf( "Ievadiet dienu kura notiek seminars (1 - pirmdiena, 2 - otrdiena...):  ");
                      _flushall();
                      scanf("%d",&seminars[i].diena);
                      printf( "Ievadiet laiku, kad notiek seminars:  ");
                      _flushall();
                      scanf("%s",seminars[i].laiks);
                      printf( "Ievadiet auditoriju, kura notiek seminars:  ");
                      _flushall();
                      scanf("%s",seminars[i].audit);
                      printf("\n");
                    }
                    
                    if ( fails_st == NULL )
                      {
                       fails_st = fopen("seminari.txt", "w");
                       fails_st2 = fopen("seminari2.txt", "w"); 
                       kk=0;
                      }
                    else
                      {
                       fails_st = fopen("seminari.txt", "a");
                       fails_st2 = fopen("seminari2.txt", "a");
                       kk=ierskaits(fails_st2);
                      } 
                           
                   for(i=kk; i<kk+choice2; i++)
                    {
                     fwrite(seminars,sizeof(seminars),1,fails_st);
                    }
                   fclose(fails_st);
                   
                   for(i=kk; i<kk+choice2; i++)
                    {
                     fprintf(fails_st2,"%c",k);
                    }
                   fclose(fails_st2);
                   
                   if(choice2==0)
                    {
                      break;
                    }
                   else
                    {        
                      printf("\nFaila tika veiksmigi ierakstiti %d ieraksti\n",choice2); 
                      printf("Nospidiet jebkuru taustinu\n");
                    }  
                   getch();
                   break;
                   
         case '3': system("cls");
                   fails_st = fopen("seminari.txt", "r");
                   fails_st2 = fopen("seminari2.txt", "r");
                   if ( fails_st == NULL )
                    { 
                      printf ("Nevar atvert failu,jo tas neeksiste\n");
                    }
                   else
                    {
                      m=ierskaits(fails_st2);
                      fclose(fails_st2);
                      
                      printf("Informacija par seminariem,kas notiek pirmdienas\n");
                      printf("Nr|           Prieksmets|   Pasniedzejs|Gr.Num|Diena|       Laiks|    Auditorija");
                      for(i=0; i<m; i++)
                       {
                        fread(seminars,sizeof(seminars),2,fails_st);
                        if(seminars[i].diena==1)
                         {
                           printf("%2d|%21s|%14s|%6d|%5d|%14s|%14s/n", seminars[i].Nr, seminars[i].priek, seminars[i].pas, seminars[i].grnum, seminars[i].diena, seminars[i].laiks, seminars[i].audit);
                         }
                        }
                      fclose(fails_st);
                    }
                   printf("Nospidiet jebkuru taustinu\n");  
                   getch();
                   break;
            
         case '4': a=remove("seminari.txt");
                   a=remove("seminari2.txt");
                   if(a==0)
                     {
                       printf("Fails veiksmigi izdzests\n");
                     }
                   else 
                     {
                       printf("\nNevar izdzest failu\n");
                     }
                   printf("Nospidiet jebkuru taustinu\n");  
                   getch();  
                   break;
                            
         case '0': darbojas=false;
                   break;  
        }//switch beigas
  }//do beigas
  while(darbojas==true);
 return 0;
}

int ierskaits(FILE *rinda)
{
 int count;
 char a,b='!';
 count=0;     
    do {
        a=fgetc(rinda);
        if(a==b) count++;
       }
 while(a!=EOF);
 return count;
}
