/********************************************************************/
#define F_CPU 14745600UL	//Mikrokontrollera takts frekvences defin??ana

/********* Standarta C un specialo AVR bibliot?ku iek?au?ana*********/
#include <avr/io.h>
#include <util/delay.h>

/******************** Portu inicializ?cijas funkcija ******************/
void port_init(void)
{
DDRD  = 0xFF; 		//Visas porta D l?nijas uz IZvadi
PORTD  = 0x00; 		//Porta D izejas l?niju l?me?i uz 0
}
/********************************************************************/

/******************** Kontrollera inicializ?cija***********************/
void init_devices(void)
{
port_init(); 			//Izsauc funkciju, kas inicializ? portus
}
/********************************************************************/

/***************************** Main funkcija **************************/
int main (void)
{
 unsigned char i,port_data; 	 //Main?go defin??ana

 init_devices();		 //Mikrokontrollera inicializ??ana

 while(1)			 //M???gais cikls, lai programma nekad nebeigtos
 {
   port_data = 0b00000001; 	 //Bin?ras v?rt?bas pie??ir?ana
   for(i=0;i<7;i++)
   {
     PORTD = ~port_data;	 //Izvad?t uz Porta D l?nij?m apgrieztu port_data main?ga v?rt?bu
     port_data <<= 1;        //Parbidit binaru vertibu uz vienu bitu pa kreisi
     _delay_loop_2(65000);   //Aizture
   }
 }
 return 1; 			 //main funkcija atgrie? v?rt?bu 1
}
/********************************************************************/

