#include <stdio.h>
#include <conio.h>
#include <time.h>
#include <windows.h>
#define L 5
#define P 5
#define B 4
#define H 4
                                                                    //apaksfunkciju deklaresana
void funarindeksiem(int array[L][P],int maxrindas, int maxkollonas);
void funarraditajiem(int *array, int maxrindas, int maxkollonas);


int main()
{


int masivs1[L][P], i, j, l, k, c;
int a,b,g,d,e;
system("cls");                                                      //ekrana attirishana
printf("     Vladimirs Logins-Vilkaste 6.GRUPA \n");
printf("             49.VARIANTS\n\n");
printf("======================================\n");
printf("              Izvelne:\n");
printf("======================================\n");
printf("\nKuru masivu generet?\n");
printf("\n1 - Generet masivu 5 X 5. \n");
printf("\n2 - Generet masivu 4 X 4. \n");
scanf("%d",&c);                                                     //massiva aizpildes veida nolasishana
while ((c!=1) && (c!=2))
{
    printf("Nav ievadita pareiza vertiba!\n");
    scanf("%d",&c);
    if (c==1 || c==2) break;

}

if (c==1)                                                           //masivs ar 5x5
{
    system("cls");
    printf("\nKa ievadit masiva elementus?\n");
    printf("\n1 - Ar gadijumu skaitliem.\n");
    printf("\n2 - No tastaturas.\n");
    scanf("%d",&l);



while ((l!=1) && (l!=2))
{
    printf("Nav ievadita pareiza vertiba!\n");
    scanf("%d",&l);
    if (l==1 || l==2) break;

}

if (l==1)                                                           //masivu 5x5 genere automatiski 
{
    srand(time(NULL));
    printf("\nMasivs 5 X 5 ar gadijuma skaitljiem:\n\n");
     for(i=0; i<L; i++)
       {
         for (j=0; j<P; j++)
           {
              masivs1[i][j]=rand()%3;
              printf("%3d", masivs1[i][j]);
            }
          printf("\n");
       }
    getche();
    a=masivs1[0][0];b=masivs1[1][1];g=masivs1[2][2];d=masivs1[3][3];e=masivs1[4][4];
    funarindeksiem(masivs1,L,P);
    masivs1[0][0]=a;masivs1[1][1]=b;masivs1[2][2]=g;masivs1[3][3]=d;masivs1[4][4]=e;
    funarraditajiem(&masivs1[0][0],L,P);
}
else                                                                // masivs 5x5 ievadits no rokas 
{
 
     for(i=0; i<L; i++)
       {
         
         for (j=0; j<P; j++)
           {
              printf("Ievadiet Masiva %d. rindas %d. kollonas vertibu\n", i+1,j+1);
              scanf("%d",&masivs1[i][j]);
              masivs1[i][j]=i+j;

            }
       }
       for(i=0; i<L; i++)
       {
         for (j=0; j<P; j++)
           {
             printf("%3d", masivs1[i][j]);
            }
          printf("\n");
       }
    getche();
    a=masivs1[0][0];b=masivs1[1][1];g=masivs1[2][2];d=masivs1[3][3];e=masivs1[4][4];
    funarindeksiem(masivs1,L,P);
    masivs1[0][0]=a;masivs1[1][1]=b;masivs1[2][2]=g;masivs1[3][3]=d;masivs1[4][4]=e;
    funarraditajiem(&masivs1[0][0],L,P);

}

}

else                //masivs ar 4x4
{
    system("cls");
    printf("\nKa ievadit masiva elementus?\n");
    printf("\n1 - Ar gadijumu skaitliem.\n");
    printf("\n2 - No tastaturas.\n");
    scanf("%d",&l);



while ((l!=1) && (l!=2))
{
    printf("Nav ievadita pareiza vertiba!\n");
    scanf("%d",&l);
    if (l==1 || l==2) break;

}

if (l==1)             //masivu 4x4 genere automatiski
{
    srand(time(NULL));
    printf("\nMasivs 4 X 4 ar gadijuma skaitljiem:\n\n");
     for(i=0; i<B; i++)
       {
         for (j=0; j<H; j++)
           {
              masivs1[i][j]=rand()%3;
              printf("%3d", masivs1[i][j]);
            }
          printf("\n");
       }
    getche();
    a=masivs1[0][0];b=masivs1[1][1];g=masivs1[2][2];d=masivs1[3][3];
    funarindeksiem(masivs1,B,H);
    masivs1[0][0]=a;masivs1[1][1]=b;masivs1[2][2]=g;masivs1[3][3]=d;
    funarraditajiem(&masivs1[0][0],B,H);


}
else             //masivs 4x4 ievada ar roku
{
     for(i=0; i<B; i++)
       {
         for (j=0; j<H; j++)
           {
              printf("Ievadiet Masiva %d. rindas %d. kollonas vertibu\n", i+1,j+1);
              scanf("%d",&masivs1[i][j]);
              masivs1[i][j]=k;

            }
       }
       for(i=0; i<B; i++)
       {
         for (j=0; j<H; j++)
           {
             printf("%3d", masivs1[i][j]);
            }
          printf("\n");
       }
    getche();
    a=masivs1[0][0];b=masivs1[1][1];g=masivs1[2][2];d=masivs1[3][3];
    funarindeksiem(masivs1,B,H);
    masivs1[0][0]=a;masivs1[1][1]=b;masivs1[2][2]=g;masivs1[3][3]=d;
    funarraditajiem(&masivs1[0][0],B,H);
    
}
}


getch();
return 0;


}

void funarindeksiem(int array[L][P],int maxrindas, int maxkollonas)   //indeksiem
{
int rez1=0,rez2=0,rez=0, j=0, i=0,t=0;
printf("\nREZULTATS AR INDEKSIEM\n");

  for(t=0;t<maxrindas;t++)
   {
    for(i=0;i<maxrindas;i++)
      {
        rez1+=array[i][t];
      }
    
    for(j=0;j<maxkollonas;j++)
      {
        rez2+=array[t][j];
      }
    
    rez=rez1+rez2;
    array[t][t]=rez;
    rez=0;rez1=0;rez2=0;
  }
  
 for(i=0; i<maxrindas; i++)
  {
   for(j=0; j<maxkollonas; j++)
     {
       printf("%3d", array[i][j]);
     }
   printf("\n");
  }
}

void funarraditajiem(int *array,int maxrindas, int maxkollonas)     //raditajiem
{
int rez1=0,rez2=0,rez=0, j=0, i=0,t=0,b=0,k=0,s,u=0;
printf("\n\nREZULTATS AR RADITAJIEM\n");

for(s=1;s<maxrindas+1;s++)
{
 for(t=(s-1);t<s;t++)
 {                      
   for(i=b;i<maxrindas+b;i++)
     {
        rez1+=*(array+t*maxrindas+i);
     }
 if(maxrindas==4)
   {
     b++;  
   }
 else
   {
     b=0;
   }           
 }
 
 for(t=(s-1);t<s;t++)
 {
   k=0;                     
   for(j=0;j<maxrindas;j++)
     {
        rez2+=*(array+j*maxrindas+k+t);
        if(maxrindas==4)
         {
           k++;  
         }
        else
         {
           k=0;
         }  
     }              
 }
 rez=rez1+rez2;
 if(maxrindas==4)
  {
   *(array+(s-1)*maxrindas+u)=rez;
   u+=2;
  }
 else
  {
   *(array+(s-1)*(maxrindas+1))=rez;
  }
 rez=0;rez1=0;rez2=0;
}

b=0;
for(i=0; i<maxrindas; i++)
  {
   for(j=b; j<maxkollonas+b; j++)
     {
       printf("%3d",*(array+i*maxrindas+j));
     }
  if(maxrindas==4)
     {
       b++;
     }
   else
     {
       b=0;
     } 
   printf("\n");
  }

}
