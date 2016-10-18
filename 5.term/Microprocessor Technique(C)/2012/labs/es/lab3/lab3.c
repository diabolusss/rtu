#define F_CPU 14745600UL
/******* Standarta C un specialo AVR biblioteeku ieklaushana*******************/
#include <avr/io.h>
#include <avr/iom128.h>
#include <avr/interrupt.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
/******************************************************************************/

#define BIT0 0x01 //Nodefineta 0-taa bita maska
#define BIT1 0x02 //Nodefineta 1-taa bita maska
#define BIT2 0x04 //Nodefineta 2-taa bita maska
#define BIT3 0x08 //Nodefineta 3-taa bita maska
#define BIT4 0x10 //Nodefineta 4-taa bita maska
#define BIT5 0x20 //Nodefineta 5-taa bita maska
#define BIT6 0x40 //Nodefineta 6-taa bita maska
#define BIT7 0x80 //Nodefineta 7-taa bita maska

volatile unsigned long long taktis; //Globalais mainiigais kursh glabaa taktu skaitu

/********************** Partraukuma no taimera 0 parpildes funkcija ***********/
SIGNAL(SIG_OVERFLOW0)
{

 taktis=taktis + 2048/*Define variable*/; // (8-takts frekvences dalitajs 256-8bitu max skaits (258*8=2048))

}
/******************************************************************************/

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
 cli(); //Aizliedz visus partraukumus
 XDIV  = 0x00; //takts impulsu dalitajs NEtiek izmantots
 XMCRA = 0x00; //arejo atminju NEizmanto
 MCUCR = 0x00; //NEtiek izmantoti nekadi energiju tauposhi stavokli

 port_init(); //inicialize portus

 EICRA = 0x00;
 EICRB = 0x00;
 EIMSK = 0x00; //aizliedz visus arejos partraukumus no portiem
 ETIMSK = 0x00; //aizliedz jebkada veida partraukumus no 16 bitu taimeriem

/*** Timer0 skaititaju piesledz pie takts generatora caur /8 dalitaju ***/
 TCCR0 = 0b00000010;

/*** Atlauj partraukumu no Timer0 parpildes ***/
 TIMSK = 0b00000001; //OCIE2|TOIE2|TICIE1|OCIE1A|OCIE1B|TOIE1|OCIE0|TOIE0

 sei(); //Atlauj visus atlautos partraukumus

 return;
}
/******************************************************************************/

/******************************** Main funkcija *******************************/
int main (void)
{
 unsigned char port_data;
 int i;
 int arr[8];// izveidotais masivs
 int *delayptr;// pointeris

 delayptr = arr;//noradam masiva pirmo elementu

 for (int i=0; i<8; i++)
 {
 *delayptr = (i+1);
  delayptr++;
 }

delayptr = arr;

init_devices(); //inicializejam kontrolleri

port_data  = 0b00000001;

while(1) //muzigais cikls, lai programma nekad nebeigtos
{
   if (taktis > (F_CPU/8*(*delayptr)))
    {
    PORTD=~port_data;
    port_data = port_data<<1;
    taktis = 0 ;
    i++;
   }
   if (i>=8)
   {
    port_data  = 0b00000001;
    delayptr++;
    if (*delayptr==8)
    {
     delayptr = arr;
    }
     i = 0;
   }
}
 return 1;
}
/******************************************************************************/
