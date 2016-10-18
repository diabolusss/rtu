/**********************************************************************/
#define FOSC 14745600UL	//cycles per second; repeats F_CPU times per second

/********* Standarta C un specialo AVR bibliot?ku iek?au?ana***********/
#include <avr/io.h>
#include <avr/interrupt.h>

/******************** Portu inicializ?cijas funkcija ******************/
void port_init(void){  
	DDRD  = 0xFF; //visas porta D l?nijas uz IZvadi
	PORTD  = ~(0x00); //porta D izejas l?niju l?me?i uz 0
	
	sei(); 
}

/******************** Rezimu[sakuma vertiibu] uzstadisana *************/
void init_devices(void){
	//timer0 setup
	TCCR0 = 0x05;	//F_CPU/1024 111/ 128
	TIMSK = 0x01;	//overflow enable
	TCNT0 = 0;		//set start value

	port_init();
}

/*****FUNCTION PROTOTYPES**********************************************/
unsigned char _rotl(const unsigned char value, unsigned char shift);

/******************** Globalie mainigie********************************/
volatile unsigned long timer = 0;//no copy's in reg, 
				//no code opt - as compilator doesnt know-interrupt can change it

/******************** Partraukumi *************************************/
ISR(TIMER0_OVF_vect) {
	timer += 255*128;
}

/***************************** Main funkcija **************************/
int main (void){
	init_devices();
	
	//timer variable
	unsigned char port_data = 0x80;

	while (1){
		if(timer > FOSC){
			port_data = _rotl(port_data,3);
			PORTD = ~port_data;
			timer = 0;
		}
	}
	return 1;
}

/**********************************************************************/
/*** PERFORMS CIRCULAR SHIFT ****/
unsigned char _rotl(const unsigned char value, unsigned char shift) {
    if ((shift &= sizeof(value)*8 - 1) == 0) return value;
    return (value << shift) | (value >> (sizeof(value)*8 - shift));
    //return (value >> shift) | (value << (sizeof(value)*8 - shift)); //right
} 
