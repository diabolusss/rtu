/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: adc.h
 * Description: ADC functionality
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "adc.h"
#include "sys.h"

void 	InitADC(uint8_t channel)
{
	
	uint8_t div;
	
	if (channel > 7) channel = 0;
	
	PCONP_bit.PCAD = 1;
	
	switch (channel)
	{
		case 0:
			PINSEL1_bit.P0_23 = 0x01;
			break;
		
		case 1:
			PINSEL1_bit.P0_24 = 0x01;
			break;
			
		case 2:
			PINSEL1_bit.P0_25 = 0x01;
			break;
			
		case 3:
			PINSEL1_bit.P0_26 = 0x01;
			break;
			
		case 4:
			PINSEL3_bit.P1_30 = 0x03;
			break;
			
		case 5:
			PINSEL3_bit.P1_31 = 0x03;
			break;
			
		case 6:
			PINSEL0_bit.P0_12 = 0x03;
			break;
			
		case 7:
			PINSEL0_bit.P0_13 = 0x03;
			break;
	}
	
	
	div = (SYS_GetFpclk(ADC_PCLK_OFFSET) / ADC_CLOCK_RATE) + 1;
	
	AD0CR_bit.CLKDIV = div;
	AD0CR_bit.BURST = 0;
	AD0CR_bit.START = 0;
	AD0CR_bit.PDN = 1;
	
}

uint32_t GetADC(uint8_t channel)
{
	uint32_t result;
	
	if (channel > 7) channel = 0;
	AD0CR_bit.SEL = 1<<channel; /* select the channel */
	AD0CR_bit.START  = 0x01;
	
	while (!AD0GDR_bit.DONE);	/* wait for completion */
	
	AD0CR_bit.START = 0x0;
	
	if (AD0GDR_bit.OVERUN == 1) return 0;
	
	result = AD0GDR_bit.RESULT;
	
	return result;	
}
