#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#define case1 5
#define case2 4

void function1(int current, int arra[][case1]);
void function2(int current, int *arra);


int main()
{
	printf(" Vladimirs logins-Vilkaste, 6.grupa, 49.variants \n\n");
	bool isFirst=true;

	srand(time(NULL));
	char d;
	
	int current=0;
	do {
	printf("parbaudit 1.variantu? y/n");
	scanf("%c", &d);	
		switch (d){
			case 'y':
				fflush(stdin); //buffera attirisana;
				isFirst = true;
				current = case1;
			break;
			case 'n':
				fflush(stdin); //buffera attirisana;
				isFirst = false;
				current = case2;
			break;
		} 
	} while (current==0);
	
	int arr[case1][case1];
	
	printf("manuali ? y/n \n");
	scanf("%c", &d);
	
	if ((d=='y') || (d=='Y'))
    {
		for (int i=0;i<current;i++)
        {
			for (int ii=0;ii<current;ii++)
            {
				printf("elements[%d][%d] ", i, ii);
				scanf("%d", &arr[i][ii]);
			}
		}
		system("cls");
	} 
    else 
    {
		if ((d=='N') || (d=='n'))
        {
			for (int i=0;i<current;i++)
            {
				for (int ii=0;ii<current;ii++)
                  {
					arr[i][ii]=rand()%10;
    	          }
			}
		} 
        else 
        {
			printf("y vai n");
		}
	}

	for (int i=0;i<current;i++){
		for (int ii=0;ii<current;ii++){
			printf("%d ",arr[i][ii]);
		}
		printf("\n");
	}
	printf("\n");
	
	function1(current, arr);
    function2(current, &arr[0][0]);	

	system("PAUSE");
	return 0;
}

void function1(int current, int arra[][case1])
{
 int rez1=0,rez2=0,rez=0, j=0, i=0,t=0;
 
	if (current == case1)
       {
	   	 printf("ispildas 1.variants ar indeksiem \n \n");	
	   } 
    else 
       {
		 printf("ispildas 2.variants ar indeksiem \n \n");
	   }
	   
 for(t=0;t<current;t++)
   {
    for(i=0;i<current;i++)
      {
        rez1+=arra[i][t];
      }
    
    for(j=0;j<current;j++)
      {
        rez2+=arra[t][j];
      }
    
    rez=rez1+rez2;
    arra[t][t]=rez;
    rez=0;rez1=0;rez2=0;
  }
  
 for(i=0; i<current; i++)
  {
   for(j=0; j<current; j++)
     {
       printf("%3d", arra[i][j]);
     }
   printf("\n");
  }

}

void function2(int current, int *arra)
{
  int rez1=0,rez2=0,rez=0, j=0, i=0,t=0;
  
	if (current == case1)
     {
		printf("ispildas 1.variants ar raditajiem\n \n");	
	 } 
    else 
     {
		printf("ispildas 2.variants ar raditajiem\n \n");
	 }
	 
  for(t=0;t<current;t++)
   {
    for(i=0;i<current;i++)
      {
        rez1+=*(arra+t*current+i);
      }
    for(j=0;j<current;j++)
      {
        rez2+=*(arra+j*current+t);
      }
    printf("\n\n%d\n\n",*(arra+t*current));
    rez=rez1+rez2;
    
    *(arra+t*(current+1))=rez; 
    rez=0;rez1=0;rez2=0;
  }
     
  for(i=0; i<current; i++)
  {
   for(j=0; j<current; j++)
     {
       printf("%3d", *(arra+i*current+j));
     }
   printf("\n");
  }
}
