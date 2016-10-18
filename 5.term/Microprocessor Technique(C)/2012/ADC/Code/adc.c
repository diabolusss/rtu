#include <avr/io.h>


int main(void)
{
  DDRD = 0xFF;

  ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (0<<ADPS0); // Set ADC prescalar to 16 - 125KHz sample rate @ 16MHz 

  ADMUX |= (1 << REFS0);
  ADMUX |= (1 << ADLAR);
  ADMUX |= (1 << MUX1);
  ADMUX |= (1 << MUX0);

  ADCSRA |= (1 << ADFR);  // Set ADC to Free-Running Mode
  ADCSRA |= (1 << ADEN);  // Enable ADC
  ADCSRA |= (1 << ADSC);  // Start A2D Conversions 


  while(1)
  {
    if(ADCH > 128)		//Skaties te! Tas ir 8-bitu rezims, to vajag parveidot 10-bitu rezima.
      PORTD |= 0x01;
    else
      PORTD &= 0x00;

    ADCSRA |= (1 << ADSC);  // Start A2D Conversions  

  }

  return 1;
}
