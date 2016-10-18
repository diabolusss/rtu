/******* CONST ********************************************************/
#define FOSC 14745600UL	//MCU System clock(XTAL pin frequency) cycles per second
#define BAUD 9600 // the transfer rate in bit per second (bps)
#define _UBRR FOSC/16/BAUD-1  //Contents of the UBRRH and UBRRL Registers, (0 - 4095)

/****** HEADER FILES **************************************************/
#include <avr/io.h>
#include <avr/interrupt.h> 
#include <stdlib.h>

/***** FUNCTION PROTOTYPES ********************************************/
void port_init(void);
void init_devices(void);

void USART_Init(unsigned int ubrr);
void USART_Transmit(unsigned char data);
unsigned char USART_Receive(void);

void COP_init(void);

unsigned char _strlen(unsigned char *string); //string length
unsigned char _rotl(const unsigned char value, unsigned char shift); //circular shift

/****** GLOBAL VARIABLES **********************************************/
volatile unsigned long timer = 0;

/****** INTERRUPTS ****************************************************/
ISR(TIMER0_OVF_vect) {	    
	timer+=255*128;
}

/****** PROGRAMM BODY *************************************************/
int main(void){
	init_devices();
	
	/**** TIMER VARIABLES **********/
	unsigned char port_data = 0x80, //LED pin
					*delay_value, 	//delay array
					*delay_head,	//delay array head
					i,j;	//temp variables
					
	//save array head
	delay_head = delay_value;
	
	//fill delay array
	//0.50 1.50 0.50 1.50 0.50 1.50 0.50 1.50
	for((i=0,j=8); i < j; *(delay_value++) = i++ % 2 + 0.5);
	
	//go to array head
	delay_value = delay_head;
	/**** END of TIMER VARIABLES **********/
	
	while(1){
		/**** LED CONTROL 'function' **********/
		if(timer > FOSC * (*delay_value)){
			PORTD = ~_rotl(port_data,1);
			(*delay_value) ? (delay_value++) : (delay_value = delay_head);
			timer = 0;
			__asm__ __volatile__ ("wdr");
		/**** END of LED CONTROL **************/



		}		
	}	
	return 0;	
}

/****** SYSTEM CONFIGURATION *******************************************/
void port_init(void){
	DDRD  = 0xFF; 	//port D o/p
	PORTD  = ~(0x00); //LEDs off
	
	sei();	//allow global interrupts
}

void init_devices(void){	

	/**** TIMER0 SETUP **********/
	TCCR0 = 0x07;	//F_CPU/1024 111
	TIMSK = 0x01;	//overflow enable
	TCNT0 = 0;		//set start value
	
	/**** USART0 SETUP **********/
	USART_Init(_UBRR);
	
	/**** WATCHDOG SETUP ********/	
	COP_init();

	/**** PORT SETUP ************/
	port_init(); 
}

void USART_Init(unsigned int ubrr){
	/* Set baud rate */
	UBRR0H = (unsigned char)(ubrr >> 8);
	UBRR0L = (unsigned char)ubrr;

	/* Enable receiver and transmitter */
	UCSR0B = (1 << RXEN)|(1 << TXEN);

	/* Set frame format: 8data, 2stop bit */
	UCSR0C = (1 << USBS)|(3 << UCSZ0);
}

void COP_init(void){
	//initialize and set prescaller	
	#pragma optsize-	//lai nesacakaretu kodu atsledzam opt uz laiku
		//WDTCR =  (1 << WDE) | (1 << WDCE);	//watchdog change enable
		//WDTCR  = 1<<WDE | 1<<WDP2 | 1<<WDP1 | 1<<WDP0; // set  prescaler
		WDTCR = 0x1E;				//A watchdog timer (or computer operating properly (COP) timer) 
		WDTCR = 0x0E;				//WatchDog Enable[can be erased if WDCE=1] todo[disable]: 
		#ifdef _OPTIMIZE_SIZE_		//1)send 1 to both WDCE & WDE 2)in next 4 clocks send 0 to wde[2.lvl is secured against that]
			#pragma optsize+		//WDP2, WDP1, WDP0: Watchdog Timer Prescaler 2, 1, and 0
		#endif						//0 0 0 16K (16,384) 14.8 ms 14.0 ms
									//0 0 1 32K (32,768) 29.6 ms 28.1 ms
									//1 1 0 1,024K (1,048,576) 0.95 s 0.9 s
									//1 1 1 2,048K (2,097,152) 1.9 s 1.8 s
}

/****** IN PROGRAMM FUNCTIONS *****************************************/
void USART_Transmit( unsigned char data ){
	/* Wait for empty transmit buffer (UDRE is set)*/
	while ( !( UCSR0A & (1<<UDRE)) );

	/* Put data into buffer, sends the data */
	UDR0 = data;
}

unsigned char USART_Receive( void ){
	/* Wait for data to be received */
	while ( !(UCSR0A & (1<<RXC0)) );

	/* Get and return received data from buffer */
	return UDR0;
}

/****** WIDE RANGE FUNCTIONS ******************************************/
/******** STRING LENGTH ******************************/
unsigned char _strlen(unsigned char *string){ 
	unsigned char length = 0;
	while(*(string+length)) length++;
	return length;
}

/******** CIRCULAR SHIFT *****************************/
unsigned char _rotl(const unsigned char value, unsigned char shift) {
    if ((shift &= sizeof(value)*8 - 1) == 0) return value;
    return (value << shift) | (value >> (sizeof(value)*8 - shift));
    //return (value >> shift) | (value << (sizeof(value)*8 - shift)); //right
} 
