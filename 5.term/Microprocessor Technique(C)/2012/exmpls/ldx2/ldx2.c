/******* CONST ********************************************************/
#define FOSC 14745600UL	//MCU System clock(XTAL pin frequency) cycles per second
#define BAUD 9600 // the transfer rate in bit per second (bps)
#define _UBRR FOSC/16/BAUD-1  //Contents of the UBRRH and UBRRL Registers, (0 - 4095)
#define SIZE 8

/****** HEADER FILES **************************************************/
#include <avr/io.h>
#include <avr/interrupt.h> 
#include <stdlib.h> //atoi

/****** USER DEFINED TYPES ********************************************/
typedef struct ptr_object{	
	int start;
	int end;
	unsigned char size;
	unsigned char *value;
} ptr_object;

/***** FUNCTION PROTOTYPES ********************************************/
/******* MAIN SETUP ******************/
void port_init(void);
void init_devices(void);

/******* USART SETUP *****************/
void USART_Init(unsigned int ubrr);
void USART_Transmit(unsigned char data);
unsigned char USART_Receive(void);

/******* WD SETUP ********************/
void COP_init(void);

/******* ADC SETUP *******************/
void ADC_Init(void);

/******* CSHIFT **********************/
unsigned char _rotl(const unsigned char value, unsigned char shift); //circular shift

/*******  **********************/
unsigned char _strlen(unsigned char *string);

/******* BUFFER MANIPULATION *********/
void cbWrite(ptr_object *cb, unsigned char *_byte);
uint8_t cbRead(ptr_object *cb);
unsigned char cbIsFull(ptr_object *cb);
unsigned char cbIsEmpty(ptr_object *cb);


/****** GLOBAL VARIABLES **********************************************/

	/******  ******************/
	/****** TIMER0 ******************/	
	/****** ADC *****************/
	volatile unsigned int decnum = 0;

	/****** CBUFFER *****************/
	volatile ptr_object buffer;
	volatile unsigned char tx_complete = 1;
	volatile unsigned int rx_delay = 1;

/****** INTERRUPTS ****************************************************/
//receive complete
ISR(USART0_RX_vect){
	//USART_Transmit(USART_Receive());

	//allow communicate
	tx_complete = 1;	
}

//UDR empty
ISR(USART0_UDRE_vect){
	if (tx_complete == 1){
		uint8_t msg[] = "\n\rSYN:CHAARONII TO YOUR SEVICE\n\r";
		ptr_object elem;

		elem.value = msg;
		elem.size = _strlen(elem.value);		

		do{
			USART_Transmit(*elem.value);				
			elem.size--;
			elem.value++;				
		}while(elem.size);
		
		tx_complete = 0;			
	}
}
//save i/p value
ISR(ADC_vect){
	//volatile unsigned char *first_part = 0, *second_part = 0;

	//calculate real distance value
	decnum = ADLAR == 1 ? (ADCL >> 6) | (ADCH << 2) : ADCL | (ADCH << 8);

	//*first_part = decnum;
	//*second_part = (decnum >> 8);

	//USART_Transmit(decnum);

	//save to buffer received ADC value	
	//cbWrite(&buffer, first_part);
	//cbWrite(&buffer, second_part);	

	ADCSRA |= (1 << ADSC);  // Re Start A2D Conversions 
}
/****** PROGRAMM BODY *************************************************/
int main(void){
	init_devices();

	//LEDs
	unsigned char port_data = 0x80;
	while(1){		
			
		/****** LEDs ******************/		
		//if (decnum > 128) port_data = _rotl(port_data,1);
		//PORTD = ~port_data;
		if (!decnum) port_data = 0x00;				
		else if (decnum < 8)	port_data = 0b00000001;
		else if (decnum < 32)	port_data = 0b00000010;
		else if (decnum < 128)	port_data = 0b00000100;
		else if (decnum < 256)	port_data = 0b00001000;
		else if (decnum < 512)	port_data = 0b00010000;
		else if (decnum > 512)	port_data = 0b10000000;	
		PORTD = port_data;

	}	
	return 0;	
}
/****** END PROGRAMM BODY **********************************************/

/****** SYSTEM CONFIGURATION *******************************************/
void port_init(void){
	DDRD  = 0xFF; 	//port D o/p
	PORTD  = ~(0x00); //LEDs off
	
	//DDRF = 0x00; //set ADC as i/p
	
	sei();	//allow global interrupts
}

void init_devices(void){

	/**** USART0 SETUP **********/
	USART_Init(_UBRR);

	/**** ADC SETUP **********/
	ADC_Init();	

	/**** PORT SETUP ************/
	port_init(); 
}
void ADC_Init(){
	// divide by 128 /Set ADC to 57KHz sample rate @ 16MHz 
	ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); 

	ADMUX |= (1 << REFS1) | (1 << REFS0); //AVCC Internal 2.56V Voltage Reference with external capacitor at AREF pin

	// Interrupt Enable; Free-Running Mode; Enable ADC
	ADCSRA |= (1 << ADIE) | (1 << ADFR) | (1 << ADEN); 
	//ADMUX |= (1 << MUX1) | (1 << MUX0); //MUX4..0 set 0 - ADC0 connected
	
	ADCSRA |= (1 << ADSC); // start conversion
}

void USART_Init(unsigned int ubrr){
	/* Set baud rate */
	UBRR0H = (unsigned char)(ubrr >> 8);
	UBRR0L = (unsigned char)ubrr;

	/* RX complete, USART DATA Register empty interrupt enable, Enable receiver and transmitter */
	//UCSR0B = (1<<RXCIE0)|(1<<TXCIE0)|(1 << RXEN0)|(1 << TXEN0);
	UCSR0B = (1<<RXCIE0)|(1<<UDRIE0)|(1 << RXEN0)|(1 << TXEN0);	

	/* Set frame format: 8data, 2stop bit */
	UCSR0C = (1 << USBS) | (3 << UCSZ0);
	//set by def |(3 << UCSZ0);	!?????

	//MAX buffer size + one empty to avoid start == end
	//buffer.value = (uint8_t) malloc (3 * sizeof(*buffer.value));
	buffer.size = 2 + 1;
	buffer.start = 0;
	buffer.end = 0;	
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

/******** BUFFER FUNC ******************************/
void cbWrite(ptr_object *cb, unsigned char *_byte) {
	//if(cbIsFull(cb)) return;
    cb->value[cb->end] = *_byte;
    cb->end = (cb->end + 1) % cb->size;
    if (cb->end == cb->start)
        cb->start = (cb->start + 1) % cb->size; /* full, overwrite */
}

uint8_t cbRead(ptr_object *cb){
	uint8_t *tmp = NULL;
	*tmp = cb->value[cb->start];
    cb->start = (cb->start + 1) % cb->size;

	return *tmp;
}

unsigned char cbIsFull(ptr_object *cb) {
    return (cb->end + 1) % cb->size == cb->start; }

unsigned char cbIsEmpty(ptr_object *cb){
	return cb->end == cb->start;
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
