/********************************************************************/
#define FOSC 14745600UL	//Mikrokontrollera takts frekvences defin??ana
//#define FOSC 14.7456E6

//#define FOSC 1843200// Clock Speed
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

/********************************************************************/
#include <avr/io.h>
#include <avr/interrupt.h> 
#include <stdlib.h>

/********************************************************************/
void USART_Init(unsigned int ubrr );
void USART_Transmit( unsigned char data );
unsigned char USART_Receive( void );
unsigned char length(unsigned char* msg);

void port_init(void){ 
 DDRD  = 0xFF; //visas porta D l?nijas uz IZvadi
 PORTD  = 0x11; //porta D izejas l?niju l?me?i uz 0
}

void init_devices(void)
{
sei(); 

//timer0 setup
TCCR0 = 0b00000101;	//F_CPU/1024 111
TIMSK = 0b00000001;	//overflow enable
TCNT0 = 0;			//initialize timer

port_init(); 			//Izsauc funkciju, kas inicializ? portus
}

volatile unsigned long timer=0;

ISR(TIMER0_OVF_vect) {	    
	timer+=255*128;
}
/********************************************************************/

int main( void ){
	
	init_devices();
	unsigned char i = 0, send = 1, *temp, msg_length, 
		*msg = "Ievadiet LED gaismas aizkaves vertiibu[apstiprinat ar ENTER] = ";

	temp = msg;
	msg_length = 64;
	

	USART_Init ( MYUBRR );	

	/****LEDs**************/

	unsigned char port_data=0b00000001,x=8,stop=0;
	unsigned long *ptr_delay,time_delay[8]={0.5,1,0.5,1,0.5,1,0.5,1};
	unsigned long got_delay = 1;
	ptr_delay = time_delay;

	while(1){
			if(send){
				for(i = 0 ; i < msg_length; i++, temp++)	{
					USART_Transmit ( *temp );					 					
				}
				if(i == msg_length) {
						temp = msg;
					}
				send = 0;
			}
			
			unsigned char *begin, ii=0,iii;
			
			if(!send & !stop){
			
			//if ((*temp = USART_Receive()) == 'q') USART_Transmit (*temp);
			//unsigned char *begin, ii=0, got_delay = 0;
			begin = temp;
			
				while( (*temp = USART_Receive()) != 'q'){
					temp++;
					ii++;
				}
				
			temp = begin;
				/*
				for(i = ii; ii>0; ii--, temp++)	{
					USART_Transmit (*temp);
					for(iii=0;iii<i;iii++) (*temp)*=10;
					
					USART_Transmit (*temp);
					got_delay=1;
				}*/
				got_delay=(long) atoi(temp);
				stop = 1;
			}
			/******LEDs********************************/
			//if( timer>(FOSC)){
			if( timer>(FOSC*(got_delay))){
				ptr_delay++;

				PORTD=~port_data;
				port_data=port_data<<1;			
			
				if(x==0) {port_data=0b00000001; x = 8; ptr_delay = time_delay; stop = 0; send = 1;}
				else	--x;			
				timer = 0;
			}
			
		
	}
	return 0;	
}
/********************************************************************/
/*global interrupt flag should be cleared (and interrupts globally disabled)
 	when doing the initialization.*/
/*The TXC flag can be used tocheck that the Transmitter
 	has completed all transfers, and the RXC flag can be used
	to check that there are no unread data in the receive buffer.
  	Note that the TXC flag must be cleared before each transmission
  	(before UDR is written) if it is used for this purpose.*/
void USART_Init(unsigned int ubrr ){
	/* Set baud rate */
	UBRR0H = (unsigned char)(ubrr>>8);
	UBRR0L = (unsigned char)ubrr;

	/* Enable receiver and transmitter */
	UCSR0B = (1<<RXEN)|(1<<TXEN);

	/* Set frame format: 8data, 2stop bit */
	UCSR0C = (1<<USBS)|(3<<UCSZ0);
}

/********************************************************************/
/*A data transmission is initiated by loading the transmit buffer with the data to be transmitted*/
void USART_Transmit( unsigned char data ){
/* Wait for empty transmit buffer (UDRE is set)*/
while ( !( UCSR0A & (1<<UDRE)) );

/* Put data into buffer, sends the data */
UDR0 = data;
}

/********************************************************************/
unsigned char USART_Receive( void ){
/* Wait for data to be received */
while ( !(UCSR0A & (1<<RXC0)) );

/* Get and return received data from buffer */
return UDR0;
}
/********************************************************************
unsigned char length(unsigned char* msg){
	unsigned char size,*tmp;
	tmp = msg;
	while
		
	return size;
}*/
