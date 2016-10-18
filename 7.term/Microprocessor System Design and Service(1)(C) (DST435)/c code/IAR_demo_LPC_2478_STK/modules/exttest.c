/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: exttest.c
 * Description: extension test
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "exttest.h"
#include "string.h"
#include "stdio.h"

test_ext_pin_t pinset[NUMBER_TESTED_PINS];

test_ext_pin_t pull_pin;

test_ext_pin_t led_pin;


void PinsetInit(void)
{
	memcpy((void *)&pinset[0].pin_name, (const char *)&"P0_10", PIN_NAME_SIZE);
	pinset[0].pin_offset = 1<<10;
	pinset[0].pin_get = &FIO0PIN;
	pinset[0].pin_set = &FIO0SET;
	pinset[0].pin_clr = &FIO0CLR;
	pinset[0].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[1].pin_name, (const char *)&"P0_11", PIN_NAME_SIZE);
	pinset[1].pin_offset = 1<<11;
	pinset[1].pin_get = &FIO0PIN;
	pinset[1].pin_set = &FIO0SET;
	pinset[1].pin_clr = &FIO0CLR;
	pinset[1].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[2].pin_name, (const char *)&"P0_15", PIN_NAME_SIZE);
	pinset[2].pin_offset = 1<<15;
	pinset[2].pin_get = &FIO0PIN;
	pinset[2].pin_set = &FIO0SET;
	pinset[2].pin_clr = &FIO0CLR;
	pinset[2].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[3].pin_name, (const char *)&"P0_17", PIN_NAME_SIZE);
	pinset[3].pin_offset = 1<<17;
	pinset[3].pin_get = &FIO0PIN;
	pinset[3].pin_set = &FIO0SET;
	pinset[3].pin_clr = &FIO0CLR;
	pinset[3].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[4].pin_name, (const char *)&"P0_18", PIN_NAME_SIZE);
	pinset[4].pin_offset = 1<<18;
	pinset[4].pin_get = &FIO0PIN;
	pinset[4].pin_set = &FIO0SET;
	pinset[4].pin_clr = &FIO0CLR;
	pinset[4].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[5].pin_name, (const char *)&"P0_19", PIN_NAME_SIZE);
	pinset[5].pin_offset = 1<<19;
	pinset[5].pin_get = &FIO0PIN;
	pinset[5].pin_set = &FIO0SET;
	pinset[5].pin_clr = &FIO0CLR;
	pinset[5].pin_dir = &FIO0DIR;
	
	memcpy((void *)&pinset[6].pin_name, (const char *)&"P4_17", PIN_NAME_SIZE);
	pinset[6].pin_offset = 1<<17;
	pinset[6].pin_get = &FIO4PIN;
	pinset[6].pin_set = &FIO4SET;
	pinset[6].pin_clr = &FIO4CLR;
	pinset[6].pin_dir = &FIO4DIR;
		
	memcpy((void *)&pinset[7].pin_name, (const char *)&"P4_20", PIN_NAME_SIZE);
	pinset[7].pin_offset = 1<<20;
	pinset[7].pin_get = &FIO4PIN;
	pinset[7].pin_set = &FIO4SET;
	pinset[7].pin_clr = &FIO4CLR;
	pinset[7].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[8].pin_name, (const char *)&"P4_21", PIN_NAME_SIZE);
	pinset[8].pin_offset = 1<<21;
	pinset[8].pin_get = &FIO4PIN;
	pinset[8].pin_set = &FIO4SET;
	pinset[8].pin_clr = &FIO4CLR;
	pinset[8].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[9].pin_name, (const char *)&"P4_22", PIN_NAME_SIZE);
	pinset[9].pin_offset = 1<<22;
	pinset[9].pin_get = &FIO4PIN;
	pinset[9].pin_set = &FIO4SET;
	pinset[9].pin_clr = &FIO4CLR;
	pinset[9].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[10].pin_name, (const char *)&"P4_23", PIN_NAME_SIZE);
	pinset[10].pin_offset = 1<<23;
	pinset[10].pin_get = &FIO4PIN;
	pinset[10].pin_set = &FIO4SET;
	pinset[10].pin_clr = &FIO4CLR;
	pinset[10].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[11].pin_name, (const char *)&"P4_24", PIN_NAME_SIZE);
	pinset[11].pin_offset = 1<<24;
	pinset[11].pin_get = &FIO4PIN;
	pinset[11].pin_set = &FIO4SET;
	pinset[11].pin_clr = &FIO4CLR;
	pinset[11].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[12].pin_name, (const char *)&"P4_26", PIN_NAME_SIZE);
	pinset[12].pin_offset = 1<<26;
	pinset[12].pin_get = &FIO4PIN;
	pinset[12].pin_set = &FIO4SET;
	pinset[12].pin_clr = &FIO4CLR;
	pinset[12].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[13].pin_name, (const char *)&"P4_27", PIN_NAME_SIZE);
	pinset[13].pin_offset = 1<<27;
	pinset[13].pin_get = &FIO4PIN;
	pinset[13].pin_set = &FIO4SET;
	pinset[13].pin_clr = &FIO4CLR;
	pinset[13].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[14].pin_name, (const char *)&"P4_30", PIN_NAME_SIZE);
	pinset[14].pin_offset = 1<<30;
	pinset[14].pin_get = &FIO4PIN;
	pinset[14].pin_set = &FIO4SET;
	pinset[14].pin_clr = &FIO4CLR;
	pinset[14].pin_dir = &FIO4DIR;
	
	memcpy((void *)&pinset[15].pin_name, (const char *)&"P4_31", PIN_NAME_SIZE);
	pinset[15].pin_offset = 1<<31;
	pinset[15].pin_get = &FIO4PIN;
	pinset[15].pin_set = &FIO4SET;
	pinset[15].pin_clr = &FIO4CLR;
	pinset[15].pin_dir = &FIO4DIR;	
	
	
	memcpy((void *)&pull_pin.pin_name, (const char *)&"P0_16", PIN_NAME_SIZE);
	pull_pin.pin_offset = 1<<16;
	pull_pin.pin_get = &FIO0PIN;
	pull_pin.pin_set = &FIO0SET;
	pull_pin.pin_clr = &FIO0CLR;
	pull_pin.pin_dir = &FIO0DIR;
	
	memcpy((void *)&led_pin.pin_name, (const char *)&"P1_13", PIN_NAME_SIZE);
	led_pin.pin_offset = 1<<13;
	led_pin.pin_get = &FIO1PIN;
	led_pin.pin_set = &FIO1SET;
	led_pin.pin_clr = &FIO1CLR;
	led_pin.pin_dir = &FIO1DIR;
	
}

int pin_get(int pin)
{
	return ( (*pinset[pin].pin_get & pinset[pin].pin_offset) ? 1 : 0);
}

void pin_set_dir(int pin, int dir)
{
	if (dir == 0)
	{
		*pinset[pin].pin_dir &= ~(pinset[pin].pin_offset);
	}
	else
	{
		*pinset[pin].pin_dir |= pinset[pin].pin_offset;
	}
}

void pin_set(int pin)
{
	*pinset[pin].pin_set = pinset[pin].pin_offset;
}

void pin_clr(int pin)
{
	*pinset[pin].pin_clr = pinset[pin].pin_offset;
}

void pull_set_low(void)
{
	//int tempFIODIR;
	//tempFIODIR = *pull_pin.pin_dir;
	*pull_pin.pin_dir |= pull_pin.pin_offset;
	//tempFIODIR = *pull_pin.pin_dir;
	*pull_pin.pin_clr = pull_pin.pin_offset;
}

void pull_set_high(void)
{
	*pull_pin.pin_dir |= pull_pin.pin_offset;
	*pull_pin.pin_set = pull_pin.pin_offset;
}

void setallinput(void)
{
	int cntr;
	
	PINSEL0 &= ~(0x3<<20 | 0x3<<22 | 0x3<<30);
	PINSEL1 &= ~(0x3<<0 | 0x3<<2 | 0x3<<4 | 0x3<<6);
	PINSEL9 &= ~(0x3<<2 | 0x3<<8 | 0x3<<10 | 0x3<<12 | 0x3<<14 | 0x3<<16 | 0x3<<20 | 0x3<<22 | 0x3<<28 | 0x3<<30);
	
	PINMODE0 &= ~(0x3<<20 | 0x3<<22 | 0x3<<30);
	PINMODE1 &= ~(0x3<<0 | 0x3<<2 | 0x3<<4 | 0x3<<6);
	PINMODE9 &= ~(0x3<<2 | 0x3<<8 | 0x3<<10 | 0x3<<12 | 0x3<<14 | 0x3<<16 | 0x3<<20 | 0x3<<22 | 0x3<<28 | 0x3<<30);
	
	PINMODE0 |= (0x2<<20 | 0x2<<22 | 0x2<<30);
	PINMODE1 |= (0x2<<0 | 0x2<<2 | 0x2<<4 | 0x2<<6);
	PINMODE9 |= (0x2<<2 | 0x2<<8 | 0x2<<10 | 0x2<<12 | 0x2<<14 | 0x2<<16 | 0x2<<20 | 0x2<<22 | 0x2<<28 | 0x2<<30);
	
	
	for (cntr = 0; cntr < NUMBER_TESTED_PINS; cntr++)
	{
		pin_set_dir(cntr, 0);
	}
}

void ext_settling_delay(void)
{
	int i;
	for (i = EXT_SETTLING_DELAY; i; i--);
}

void TestExt(void)
{
	int cntr;
	int cntr1;
		
	PinsetInit();
	
	setallinput();
	pull_set_low();
	ext_settling_delay();
	
	for (cntr = 0; cntr < NUMBER_TESTED_PINS; cntr++)
	{
		if (1 == pin_get(cntr))
		{
			printf("\r\nPin %s to Vcc!!!!!!!!!!!!!!!!!", pinset[cntr].pin_name);
			return;
		}
	}
	
	setallinput();
	pull_set_high();
	ext_settling_delay();
	
	for (cntr = 0; cntr < NUMBER_TESTED_PINS; cntr++)
	{
		if (0 == pin_get(cntr))
		{
			printf("\r\nPin %s to GND!!!!!!!!!!!!!!!!!", pinset[cntr].pin_name);
			return;
		}
	}
	
	for (cntr = 0; cntr < NUMBER_TESTED_PINS; cntr++)
	{
		setallinput();
		pull_set_low();
		pin_set_dir(cntr, 1);
		pin_set(cntr);
		ext_settling_delay();
		
		for (cntr1 = 0; cntr1 < NUMBER_TESTED_PINS; cntr1++)
		{
			if (cntr1 == cntr)
			{
				if ( 0 == pin_get(cntr1))
				{
					printf("\r\nPin %s cannot go HIGH, probably short to %s!!!!!!!!!!!!", pinset[cntr1].pin_name, pull_pin.pin_name);
					return;
				}
			}
			else
			{
				if ( 1 == pin_get(cntr1))
				{
					printf("\r\nShort between pins %s and %s !!!!!!!!!!!", pinset[cntr1].pin_name, pinset[cntr].pin_name);
					return;
				}
			}
		}
		
	}
	
	printf("\r\nExtension test OK\r\n");
	
	/**led_pin.pin_dir |= led_pin.pin_offset;
	
	while (1)
	{
		*led_pin.pin_set = led_pin.pin_offset;
	
		*led_pin.pin_clr = led_pin.pin_offset;
	}*/
	
}
