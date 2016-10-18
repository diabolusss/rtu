#include <avr/io.h>
#include <avr/interrupt.h>

ISR(ADC_vect)
{

}

int main(void)
{
  uint8_t thelow = ADCL;
  uint16_t tenbitsval;
  DDRD = 0xFF;

  ADCSRA |= (1 << ADPS2) |(0 << ADPS1)| (0 << ADPS0); // Set ADC prescalar

  ADMUX |= (1 << REFS0);
  ADMUX |= (1 << ADLAR);
  ADMUX |= (1 << MUX1);
  ADMUX |= (1 << MUX0);

  ADCSRA |= (1 << ADFR);  // Set ADC to Free-Running Mode
  ADCSRA |= (1 << ADEN);  // Enable ADC
  ADCSRA |= (1 << ADSC);  // Start A2D Conversions

  while(1)
  {
    tenbitsval = ADCH<<2 | thelow>>6;
    if(tenbitsval > 512)
      PORTD |= 0x01;
    else
      PORTD &= 0x00;

	ADCSRA |= (1 << ADSC);  // Start A2D Conversions
  }

  return 1;
}
