#define F_CPU 14745600UL
#define BAUD 9600
#define MYUBRR F_CPU/16/BAUD-1
/******* Standarta C un specialo AVR biblioteeku ieklaushana*******************/
#include <avr/io.h>
#include <avr/iom128.h>
#include <avr/interrupt.h>
#include <math.h>
#include <stdlib.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdio.h>
#include <avr/wdt.h>
#include <string.h>
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
void port_init()
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
}
/******************************************************************************/

/*************************Kontrollera inicializacija**************************/
void init_devices()
{
 cli(); //aizliedz visus partraukumus
 XDIV  = 0x00; //takts impulsu dalitajs NEtiek izmantots
 XMCRA = 0x00; //arejo atminju NEizmanto
 MCUCR = 0x00; //NEtiek izmantoti nekadi energiju tauposhi stavokli

 TCCR0=0b00000010;
 TIMSK=0b00000001;

 sei(); //atlauj globalos partraukumus
 port_init(); //inicialize portus
}
/******************************************************************************/

/*************************Globalie mainigie************************************/
volatile unsigned long long taktis=0;
volatile int n = 0;
volatile int k = 1;
uint8_t Temp;
char aizkave[5], aizkave_2[5];
/******************************************************************************/

/**************Partraukuma no taimera/skaititaja0 parpildes funkcija***********/
ISR(TIMER0_OVF_vect)
{
taktis=taktis+256;
}
/******************************************************************************/

/************************USART parraides inicializacija************************/
void USART_Transmit(unsigned char data)
{
/* Wait for empty transmit buffer */
while ( !( UCSR0A & (1<<UDRE)) );
/* Put data into buffer, sends the data */
UDR0 = data;
}
/******************************************************************************/

/***********************USART modula partraukums*******************************/
ISR(USART0_RX_vect)
{
	//define temp value for storing received byte
	//Store data to temp
	Temp=UDR0;
  	USART_Transmit(Temp);

    if (Temp==13){
	k = atoi(aizkave);
	int i=0;
	for (i=0;i<5;i++){
	aizkave[i]=0;}
    n=0;
	}
	else
	{
	aizkave[n] = Temp;
	n++;
	}
}
/******************************************************************************/

/*************************USARD modula inicializacija**************************/
void USART_Init(unsigned int ubrr)
{
/* Set baud rate */
UBRR0H = (unsigned char)(ubrr>>8);
UBRR0L = (unsigned char)ubrr;

/* Enable receiver and transmitter */
//UCSR0B = ((1<<RXEN)|(1<<TXEN))|(1<<RXCIE0);
UCSR0B = 0b10011000;
/* Set frame format: 8data, 2stop bit */
UCSR0C = (1<<USBS)|(3<<UCSZ0);
}
/******************************************************************************/

/*********************USART simbolu rindas parraidisana************************/
void USART_TransmitString(char data[])
{
int i = 0;
while (data[i]!='\0')
{
USART_Transmit(data[i]);
i++;
}
}
/******************************************************************************/

/*********************USART sanemsanas inicializacija**************************/
unsigned char USART_Receive()
{
/* Wait for data to be received */
while ( !(UCSR0A & (1<<RXC)) );
/* Get and return received data from buffer */
return UDR0;
}
/******************************************************************************/

/**************Main funkcija (Ar sho sakas programmas izpilde)*****************/
int main()
{
 unsigned char i, port_data; //Lokalie mainigie

 init_devices(); //Inicializejam kontrolleri
 USART_Init(MYUBRR); //Inicializejam USART moduli

 port_data=0b00000001;
 i=0;
 USART_TransmitString("Hello, world!");
 while(1)  //Muzigais cikls, lai programma nekad nebeigtos
 {
    if (taktis>=(1843200*k))
  	{
	   PORTD=~port_data;
	   port_data = port_data<<1;
	   taktis = 0;
       i++;
       if (i==8)
       {
          port_data = 0b00000001;
          i=0;
       }
    }
 }
 return 1;
}
/*****************************************************************************/

