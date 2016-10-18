#define F_CPU 14745600UL
/******* Standarta C un specialo AVR biblioteeku ieklaushana*******************/
#include <avr/io.h>
#include <avr/iom128.h>
#include <avr/interrupt.h>  
#include <avr/wdt.h>	  
#include <math.h>
#include <stdlib.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdio.h>
/******************************************************************************/

#define BIT0 0x01  //Nodefineta 0-taa bita maska
#define BIT1 0x02  //Nodefineta 1-taa bita maska
#define BIT2 0x04  //Nodefineta 2-taa bita maska
#define BIT3 0x08  //Nodefineta 3-taa bita maska
#define BIT4 0x10  //Nodefineta 4-taa bita maska
#define BIT5 0x20  //Nodefineta 5-taa bita maska
#define BIT6 0x40  //Nodefineta 6-taa bita maska
#define BIT7 0x80  //Nodefineta 7-taa bita maska

volatile unsigned long long taktis=0;

/************************ Portu inicializacijas funkcija **********************/
void port_init(void)
{ 

 DDRA  = 0x00; //visas porta A linijas uz IEvadi
 DDRB  = 0x00; //visas porta B linijas uz IEvadi
 DDRC  = 0x00; //visas porta C linijas uz IEvadi
 DDRD  = 0xFF; //visas porta D linijas uz IZvadi
 DDRE  = 0x00; //visas porta E linijas uz IEvadi
 DDRF  = 0x00; //visas porta F linijas uz IEvadi
 DDRG  = 0x00; //visas porta G linijas uz IEvadi

 PORTA  = 0x00; //porta A atsienoshie rezistori pret +Vcc NEtiek izmantoti
 PORTB  = 0x00; //porta B atsienoshie rezistori pret +Vcc NEtiek izmantoti
 PORTC  = 0x00; //porta C atsienoshie rezistori pret +Vcc NEtiek izmantoti
 PORTD  = 0x00; //porta D izejas liniju limenji uz 0
 PORTE  = 0x00; //porta E atsienoshie rezistori pret +Vcc NEtiek izmantoti
 PORTF  = 0x00; //porta F atsienoshie rezistori pret +Vcc NEtiek izmantoti
 PORTG  = 0x00; //porta G atsienoshie rezistori pret +Vcc NEtiek izmantoti

 return;
}
/******************************************************************************/

ISR(TIMER0_OVF_vect)
{
	taktis=taktis+256;
}

/************************* Kontrollera inicializacija**************************/
void init_devices(void)
{
 cli(); //aizliedz visus partraukumus
 XDIV  = 0x00; //takts impulsu dalitajs NEtiek izmantots
 XMCRA = 0x00; //arejo atminju NEizmanto
 MCUCR = 0x00; //NEtiek izmantoti nekadi energiju tauposhi stavokli
 port_init(); //inicialize portus

 TCCR0=0b00000010;//tiek izmantots, lai iedarbinatu taimeri
 TIMSK=0b00000001;//tiek izmantots, lai uzstaditu taimera parpildisanas partraukumu

 WDTCR |= (1 << WDCE)|(1 << WDE);
 WDTCR = 0b00001111; // tipisks taimauts(~1,9 s)(taktesanas ciklu periodi)
 sei();//atlauj globalos partraukumus

 return; 
}
/******************************************************************************/

/***** Main  funkcija (Ar sho sakas programmas izpilde)************************/
int main (void)
{
 unsigned char port_data; 

 init_devices(); //Inicializejam kontrolleri

	port_data  = 0b00000001;
	PORTD=~port_data;
 while(1)  //Muzigais cikls, lai programma nekad nebeigtos
 {
		if (taktis > (F_CPU/8)){
    		port_data =(port_data<<1);  
   			PORTD=~port_data;
			taktis=0;
			 __asm__("wdr");
		}

		if (port_data==0b00000000)
		{
			port_data  = 0b00000001;
			PORTD=~port_data;
		}	
 }

 return 1;
}
/*****************************************************************************/
 
