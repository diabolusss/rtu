/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: adc.h
 * Description: ADC include file
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "board.h"
#include "inttypes.h"

#define	ADC_CLOCK_RATE	(2*1000*1000)

#if ((ADC_CLOCK_RATE) > (4500000))
#warning "ADC clock out of range"
#endif

#define	ADC_CH_0	0
#define	ADC_CH_1	1
#define	ADC_CH_2	2
#define	ADC_CH_3	3
#define	ADC_CH_4	4
#define	ADC_CH_5	5
#define	ADC_CH_6	6
#define	ADC_CH_7	7

void 	InitADC(uint8_t channel);
uint32_t GetADC(uint8_t channel);
