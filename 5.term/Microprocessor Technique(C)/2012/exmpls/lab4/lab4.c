/***** GLOBAL CONST DEFINE ********************************************/
#define F_CPU 14745600UL	//cycles per second; repeats F_CPU times per second

/***** BIBLIOTEKU IEKLAUSANA ******************************************/
#include <avr/io.h>
#include <avr/interrupt.h>

/***** FUNCTION PROTOTYPES ********************************************/
void port_init(void);
void init_devices(void);

/***** GLOBAL VARS ****************************************************/
unsigned long ten_bit_value;
//unsigned int  LA;

/***** INTERRUPTS *****************************************************/
ISR(ADC_vect){
	/*the result is found in these two registers. When ADCL is read, 
	the ADC Data Register is not updated until ADCH is read. Consequently, 
	if ADL[eft]A[djusted]R = 1 and 8-bit precision is required, read ADCH. 
	Otherwise, ADCL must be read first, then ADCH.*/

	//LA = ADCL;

	//TEN_BIT_VAL = ADLAR == 1 ? (LA >> 6) | (ADCH << 2) : LA | (ADCH << 8);
	//at this point there is no difference
	ten_bit_value = ADLAR == 1 ? (ADCL >> 6) | (ADCH << 2) : ADCL | (ADCH << 8);

	ADCSRA |= (1 << ADSC);  // Start A2D Conversions 
}

/***** MAIN ***********************************************************/
int main(void){
	init_devices();
  
	while(1){  		
		ten_bit_value > 255 ? (PORTD |= (1 << PD0)) : (PORTD &= (0 << PD0));
	}

	return 1;
}

/***** PORTU INICIALIZACIJA *******************************************/
void port_init(void){  
	DDRD = 0xFF; //visas porta D l?nijas uz IZvadi
	PORTD = ~(0x00); //porta D izejas l?niju l?me?i uz 0
}

/***** REZIMU[sakuma vertiibu] UZSTADISANA ****************************/
void init_devices(void){
	//ADC SETUP
	ADCSRA |= (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); // divide by 64 /Set ADC prescalar to 16 - 125KHz sample rate @ 16MHz 
	//These bits determine the division factor between the XTAL frequency and the input clock to the ADC.
	ADMUX |= (1 << REFS0); // AVCC with external capacitor at AREF pin  
	ADCSRA |= (1 << ADIE) | (1 << ADFR) | (1 << ADEN); // Interrupt Enable; Free-Running Mode; Enable ADC
	//ADMUX |= (1 << ADLAR); //adlar == 0 (default)
	ADMUX |= (1 << MUX1) | (1 << MUX0);

	/**** ALLOW GLOBAL INTERRUPTS ********/
	sei();

	ADCSRA |= (1 << ADSC);  // Start A2D Conversions 
	port_init();
}

