/**********************************************************************/
#define F_CPU 14745600UL	//cycles per second; repeats F_CPU times per second

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
	//TCCR0 = 0x07;	//F_CPU/1024 111/ 128
	TCCR0 = 0b00000111;
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
	
	//timer variables
	unsigned char port_data = 0x80, //LED pin
					delay_value[8] = {16, 8, 32, 48, 16, 16, 16, 128}, 	//delay array
					*delay_head,	//delay array head
					i,j;	//temp variables
 
	//save array head
	delay_head = delay_value;
	
	//fill delay array
	//0.50 1.50 0.50 1.50 0.50 1.50 0.50 1.50
	//for((i=1,j=9); i < j; *(delay_value++) = i++ % 2 + 1);
	//for(i = 1; i < 9; i++){	*(delay_head) = i; delay_head++;}
	
	//go to array head
	delay_head = delay_value;
	
	while (1){
		if(timer > (F_CPU/128 * *(delay_head) )){			
			port_data = _rotl(port_data,1);
			PORTD = ~port_data;

			if(*delay_head < 128) delay_head++;
			//else dosn't work why?
			else delay_head = delay_value;

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
