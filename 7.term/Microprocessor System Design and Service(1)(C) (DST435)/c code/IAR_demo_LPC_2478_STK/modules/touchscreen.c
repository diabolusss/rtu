/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: touchscreen.c
 * Description: touchscreen include file
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "touchscreen.h"

touchscreen_data res_data;

void polarizeXx(void)
{
	PINSEL1_bit.P0_24 = 0x00;
	PINSEL1_bit.P0_22 = 0x00;
	FIO0DIR_bit.P0_24 = 0x01;
	FIO0DIR_bit.P0_22 = 0x01;
	
	FIO0SET = 1<<24;
	FIO0CLR = 1<<22;
}

void polarizexX(void)
{
	PINSEL1_bit.P0_24 = 0x00;
	PINSEL1_bit.P0_22 = 0x00;
	FIO0DIR_bit.P0_24 = 0x01;
	FIO0DIR_bit.P0_22 = 0x01;
	
	FIO0CLR = 1<<24;
	FIO0SET = 1<<22;
}

void polarizeYy(void)
{
	PINSEL1_bit.P0_23 = 0x00;
	PINSEL1_bit.P0_21 = 0x00;
	FIO0DIR_bit.P0_23 = 0x01;
	FIO0DIR_bit.P0_21 = 0x01;
	
	FIO0SET = 1<<23;
	FIO0CLR = 1<<21;
}

void polarizeyY(void)
{
	PINSEL1_bit.P0_23 = 0x00;
	PINSEL1_bit.P0_21 = 0x00;
	FIO0DIR_bit.P0_23 = 0x01;
	FIO0DIR_bit.P0_21 = 0x01;
	
	FIO0CLR = 1<<23;
	FIO0SET = 1<<21;
}

void	InitTS(touchscreen_data ts_resolution)
{
	if (ts_resolution.xvalue != 0)
	{
		res_data.xvalue = ts_resolution.xvalue;
	}
	else
	{
		res_data.xvalue = X_DEFAULT_RESOLUTION;
	}
	
	if (ts_resolution.yvalue != 0)
	{
		res_data.yvalue = ts_resolution.yvalue;
	}
	else
	{
		res_data.yvalue = Y_DEFAULT_RESOLUTION;
	}
	
	if (ts_resolution.pvalue != 0)
	{
		res_data.pvalue = ts_resolution.pvalue;
	}
	else
	{
		res_data.pvalue = P_DEFAULT_RESOLUTION;
	}
	
}

void ts_settling_delay(void)
{
	int i;
	for (i = TS_SETTLING_DELAY; i; i--);
}

touchscreen_data	GetTS(void)
{
	
#define XDELTA_MAX	100
#define	YDELTA_MAX	100
	touchscreen_data samples[TS_NUM_SAMPLES*2];
	/*static*/ /*touchscreen_data ts_result_p, ts_result_n, ts_result;*/
	touchscreen_data ts_result;
	int i;
	int yvalue_min = 1023;
	int yvalue_max = 0;
	int xvalue_min = 1023;
	int xvalue_max = 0;
	int xdelta, ydelta;
	int ts_max_value = 2<<(TS_RESOLUTION_BITS-1);
	
	ts_settling_delay();
	ts_settling_delay();
	ts_settling_delay();
	
	for ( i=0; i<TS_NUM_SAMPLES; i++)
	{
		FIO0DIR_bit.P0_21 = 0;
		PINMODE1_bit.P0_21 = 0x02;
		PINMODE1_bit.P0_23 = 0x02;
		polarizeXx();
		InitADC(TS_Y_CHANNEL);
		ts_settling_delay();
		samples[i*2].xvalue = GetADC(TS_Y_CHANNEL);
		/*samples[i*2+1].xvalue = ts_max_value - samples[i*2].xvalue;*/
		
		FIO0DIR_bit.P0_22 = 0;
		PINMODE1_bit.P0_22 = 0x02;
		PINMODE1_bit.P0_24 = 0x02;
		polarizeYy();
		InitADC(TS_X_CHANNEL);
		ts_settling_delay();
		samples[i*2].yvalue = GetADC(TS_X_CHANNEL);
		
		samples[i*2].pvalue = 0;

		
		FIO0DIR_bit.P0_21 = 0;
		PINMODE1_bit.P0_21 = 0x02;
		PINMODE1_bit.P0_23 = 0x02;
		polarizexX();
		InitADC(TS_Y_CHANNEL);
		ts_settling_delay();
		samples[(i*2)+1].xvalue = GetADC(TS_Y_CHANNEL);
		/*samples[i*2].xvalue = ts_max_value - samples[i*2+1].xvalue;*/
		
		FIO0DIR_bit.P0_22 = 0;
		PINMODE1_bit.P0_22 = 0x02;
		PINMODE1_bit.P0_24 = 0x02;
		polarizeyY();
		InitADC(TS_X_CHANNEL);
		ts_settling_delay();
		samples[(i*2)+1].yvalue = GetADC(TS_X_CHANNEL);
		
		samples[(i*2)+1].pvalue = 0;
		
	}
	
/*	ts_result_p.xvalue = 0;
	ts_result_p.yvalue = 0;
	ts_result_p.pvalue = 0;
	ts_result_n.xvalue = 0;
	ts_result_n.yvalue = 0;
	ts_result_n.pvalue = 0;
*/	
	
	ts_result.xvalue = 0;
	ts_result.yvalue = 0;
	ts_result.pvalue = 0;
		
	for (i = 0; i<(TS_NUM_SAMPLES	); i++)
	{
		int tempyval = ts_max_value - samples[i*2+1].yvalue;
		int tempxval = ts_max_value - samples[i*2+1].xvalue;
		
		ts_result.xvalue += samples[i*2].xvalue;
		ts_result.yvalue += samples[i*2].yvalue;
		/*ts_result.pvalue += samples[i*2].pvalue;*/
		
		ts_result.xvalue += ((ts_max_value)-samples[(i*2)+1].xvalue);
		ts_result.yvalue += ((ts_max_value)-samples[(i*2)+1].yvalue);
		
		
		if (yvalue_min > samples[i*2].yvalue) yvalue_min = samples[i*2].yvalue;
		if (yvalue_max < samples[i*2].yvalue) yvalue_max = samples[i*2].yvalue;
		
		if (yvalue_min > tempyval) yvalue_min = tempyval;
		if (yvalue_min < tempyval) yvalue_max = tempyval;
		
		if (xvalue_min > samples[i*2].xvalue) xvalue_min = samples[i*2].xvalue;
		if (xvalue_max < samples[i*2].xvalue) xvalue_max = samples[i*2].xvalue;
		
		if (xvalue_min > tempxval) xvalue_min = tempxval;
		if (xvalue_min < tempxval) xvalue_max = tempxval;
	}
	
	
	ts_result.xvalue = ts_result.xvalue / (TS_NUM_SAMPLES*2);
	ts_result.yvalue = ts_result.yvalue / (TS_NUM_SAMPLES*2);
	
	xdelta = xvalue_max - xvalue_min;
	ydelta = yvalue_max - yvalue_min;
	
	if (	(ts_result.xvalue < 910) && \
		(ts_result.yvalue < 910) && \
		(xdelta < XDELTA_MAX) && \
		(ydelta < YDELTA_MAX) )
	{
		ts_result.pvalue = 1024;
	}
	else
	{
		ts_result.pvalue = 0;
	}
	
	ts_result.yvalue = ts_max_value - ts_result.yvalue;
	
	return ts_result;
	
}
