#define F_CPU 14745600UL
/******* Standarta C un specialo AVR biblioteeku ieklaushana*******************/
#include <avr/io.h>
#include <avr/iom128.h>
#include <avr/interrupt.h>    
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

/************************* Kontrollera inicializacija**************************/
void init_devices(void)
{
 //cli(); //aizliedz visus partraukumus
 TCCR0 = 0b00000010;	//F_CPU/1024 111/ 128
 TIMSK = 0x00000001;	//overflow enable
 TCNT0 = 0;		//set start value
 port_init(); //inicialize portus
 sei();
 return; 
}
/******************************************************************************/

/******************** Globalie mainigie********************************/
volatile unsigned long taktis = 0; 
/******************************************************************************/

/******************** Partraukumi *************************************/
ISR(TIMER0_OVF_vect)
{
taktis=taktis+256;
}
/******************************************************************************/

/***** Main  funkcija (Ar sho sakas programmas izpilde)************************/
int main (void)
{
 unsigned char port_data; 
 init_devices(); //Inicializejam kontrolleri
 port_data=0b00000001;
 while(1)  //Muzigais cikls, lai programma nekad nebeigtos
 {
 if(taktis > F_CPU/8)
 {
   PORTD=~port_data;
   port_data = port_data << 1;
   taktis = 0;
 }
 if(port_data == 0b00000000)
 {
 port_data = 0b00000001;
 }
}
 return 1;
}
/*****************************************************************************/
