/********* PWM modulation on PB7 un PB6 pins
 **********************************************************************/

/**********************************************************************/
#define FOSC 14745600UL	//cycles per second; repeats F_CPU times per second

/********* Standarta C un specialo AVR bibliot?ku iek?au?ana***********/
#include <avr/io.h>
#include <avr/interrupt.h>

/******************** Portu inicializ?cijas funkcija ******************/
void port_init(void){  
	DDRD  = 0x00; //visas porta D l?nijas uz IZvadi	
	//setting PWM-Ports as output
	DDRB = (1 << PB7) | (1 << PB6);
	
	sei(); 
}

/******************** Rezimu[sakuma vertiibu] uzstadisana *************/
void init_devices(void){
	//16 bit timer1 setup
	//set to FAST PWM //set H on compare; non-inverting mode
	 TCCR1A |= (1 << WGM10) | (1 << COM1B1) | (1 << COM1C1);
	 TCCR1B |= (1 << WGM12) | (1 << CS11); //set prescaler 8
	 TIMSK |= (1 << TOIE1);

	 //set OCR  value
	 OCR1B = 120;	
	 OCR1C = 120;

	port_init();
}

/*****FUNCTION PROTOTYPES**********************************************/
/******************** Globalie mainigie********************************/

volatile uint16_t timer = 0;

/******************** Partraukumi *************************************/
//0.01(7) sek
ISR(TIMER1_OVF_vect){
	timer++;		
}
/***************************** Main funkcija **************************/
int main (void){
	init_devices();	
	uint8_t hb = OCR1B, hc = OCR1C, kb = 1, kc = -1;

	while (1){
		//palielinam pec 500*0.01(7)
		//up = 1; down = 0
		if(timer > 500){
			hb += kb * 5;
			hc += kc * 15;

			if (hb >= 255) kb = -1; else if (hb <= 0) kb = 1;
			if (hc >= 255) kc = -1; else if (hc <= 0) kc = 1;
					
					
			OCR1B = hb;
			OCR1C = hc;
			timer = 0;
		}
	
	}
	return 1;
}

/**********************************************************************/
