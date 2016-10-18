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
	TCCR0 = 0x07;	//F_CPU/1024 111/ 128
	TIMSK = 0x01;	//overflow enable
	TCNT0 = 0;		//set start value

	port_init();
}

/*****FUNCTION PROTOTYPES**********************************************/
unsigned char _rotl(const unsigned char value, unsigned char shift)

/******************** Globalie mainigie********************************/
volatile unsigned long timer = 0;//no copy's in reg, 
				//no code opt - as compilator doesnt know-interrupt can change it

/******************** Partraukumi *************************************/
ISR(TIMER0_OVF_vect) {
	timer += 255*128;
}

/***************************** Main funkcija **************************/
int main (void)
{
init_devices(); 				//Inicializ? mikrokontrolleri
unsigned char port_data=0b00000001,x=8;
unsigned long *ptr_delay,time_delay[8]={0.5,1,0.5,1,0.5,1,0.5,1};

ptr_delay = time_delay;


for (;;)	//M???gais cikls, lai programma //nebeigtos
{
	if( timer>(F_CPU*(*ptr_delay))){
			ptr_delay++;

			PORTD=~port_data;
			port_data=port_data<<1;			
			
			if(x==0) {port_data=0b00000001; x = 8; ptr_delay-=8;}
			--x;			
			timer = 0;
		}

}
return 1;					//Beidz main izpildi
}
/********************************************************************/
/***************************** Main funkcija **************************/
int main (void){
	init_devices();
	
	//timer variables
	unsigned char port_data = 0x80, //LED pin
					*delay_value, 	//delay array
					*delay_head,	//delay array head
					i,j;	//temp variables
 
	//save array head
	delay_head = delay_value;
	
	//fill delay array
	//0.50 1.50 0.50 1.50 0.50 1.50 0.50 1.50
	for((i=0,j=8); i < j; *(delay_arr++) = i++ % 2 + 0.5);
	
	//go to array head
	delay_value = delay_head;
	
	while (1){
		(timer > F_CPU*(*delay_value)) ? (PORTD=~_rotl(port_data,1), \
		((*array) ? (delay_value++) : (int)(delay_value = delay_head))\
		 , timer = 0) : (0);
		
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
