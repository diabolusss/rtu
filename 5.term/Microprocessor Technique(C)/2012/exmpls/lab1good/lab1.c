/********************************************************************/
#define F_CPU 14745600UL	//Mikrokontrollera takts frekvences defin??ana

/********* Standarta C un specialo AVR bibliot?ku iek?au?ana*********/
#include <avr/io.h>

/******************** Portu inicializ?cijas funkcija ******************/
void port_init(void){  
	DDRD  = 0xFF; //visas porta D l?nijas uz IZvadi
	PORTD  = ~(0x00); //porta D izejas l?niju l?me?i uz 0
 
}

/******************** Kontrollera inicializ?cija***********************/
void init_devices(void){
	port_init(); 			//Izsauc funkciju, kas inicializ? portus

}

/********************************************************************/
void blink(){
	unsigned char i;
	unsigned int ii;
	//blink this way ---->>>
	for(i = 1; i < 128; i = i*2){
		PORTD=~i;
		for(ii = 0; ii < 65535; ii++);
		}

	//blink that way <<<----
	for(i = 128; i > 1; i -= i/2){
		PORTD=~i;
		for(ii = 0; ii < 65535; ii++);
		}
}

/***************************** Main funkcija **************************/
int main (void){
	init_devices(); 				//Inicializ? mikrokontrolleri	

	while(1){
		blink();
	}
	return 1;				
}

