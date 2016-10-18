/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: touchscreen.h
 * Description: touchscreen include file
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
#include "adc.h"

#define	X_DEFAULT_RESOLUTION	320
#define	Y_DEFAULT_RESOLUTION	240
#define	P_DEFAULT_RESOLUTION	100

#define	TS_NUM_SAMPLES		2
#define	TS_SETTLING_DELAY	10000

#define	TS_RESOLUTION_BITS	10

#define	TS_X_CHANNEL		ADC_CH_1
#define	TS_Y_CHANNEL		ADC_CH_0

typedef struct touchscreen_data_t
{
	uint32_t	xvalue;
	uint32_t	yvalue;
	uint32_t	pvalue;
} touchscreen_data;

touchscreen_data	GetTS(void);
void	InitTS(touchscreen_data ts_resolution);