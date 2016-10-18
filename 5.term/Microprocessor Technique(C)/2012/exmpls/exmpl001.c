#include<avr/io.h>
#include<avr/interrupt.h>

int main(){
	DDRB = 1<<PB1;//PB1 IS THE OC1A PIN, SHOULD BE SET AS O/P
	
	TCCR1B = 1<<WGM12; //CTC MODE

	TCCR1A = 1<<COM1A0; //TOGGLE OC1A PIN ON MATCH
	
	TCCR1B |=(1<<CS10)|(1<<CS12); //SET A PRESCALER OF 1024

	OCR1A = F_CPU/1024; //TO GENERATE INTERRUPT EVERY SEC

	TIMSK = 1<<OCIE1A; //ENABLE TIMER INTERRUPTS

	sei(); //enable global interrupts

	while(1); 

return 0;
}

ISR(TIMER1_COMPA_vect){// isr to process timer1 compare match
	PORTB = ~PORTB;
}