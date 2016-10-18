/***** GLOBAL CONST DEFINE ********************************************/
#define F_CPU 14745600UL	//cycles per second; repeats F_CPU times per second

/***** BIBLIOTEKU IEKLAUSANA ******************************************/
#include <avr/io.h>
#include <avr/interrupt.h>

/***** FUNCTION PROTOTYPES ********************************************/
void port_init(void);
void init_devices(void);

unsigned char _rotl(const unsigned char value, unsigned char shift)

/***** GLOBAL VARS ****************************************************/
volatile unsigned long timer=0;

/***** INTERRUPTS *****************************************************/
ISR(TIMER0_OVF_vect){
	timer+=255*128;
}

//this MCU dont have 'WDT_vect' func

/***** MAIN ***********************************************************/
int main (void){
	init_devices();
	
	//timer variables
	unsigned char port_data=0x80;

	while(1){
		(timer > F_CPU) ? (PORTD=~_rotl(port_data,1),\
		timer = 0,\
		__asm__ __volatile__ ("wdr")) : (0) ;

	}
	return 1;
}

/**********************************************************************/
/***** PERFORMS CIRCULAR SHIFT *********************/
unsigned char _rotl(const unsigned char value, unsigned char shift) {
    if ((shift &= sizeof(value)*8 - 1) == 0) return value;
    return (value << shift) | (value >> (sizeof(value)*8 - shift));
    //return (value >> shift) | (value << (sizeof(value)*8 - shift)); //right
} 

/***** PORTU INICIALIZACIJA ************************/
void port_init(void){  
 DDRD  = 0xFF; //visas porta D linijas uz IZvadi 
}

/***** REZIMU[sakuma vertiibu] UZSTADISANA *********/
void init_devices(void){
	//TIMER0 SETUP
	TCCR0 = 0x07;	//F_CPU/1024 111/ 128
	TIMSK = 0x01;	//overflow enable
	TCNT0 = 0;		//set start value
	
	//WATCHDOG SETUP 
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

	/**** ALLOW GLOBAL INTERRUPTS ********/
	sei();
	
	port_init();
}
