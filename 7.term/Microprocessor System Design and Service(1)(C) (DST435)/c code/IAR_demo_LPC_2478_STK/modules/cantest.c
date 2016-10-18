/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: cantest.c
 * Description: CAN test
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "cantest.h"
#include "stdio.h"

#define CAN_TIMEOUT_VALUE	100000

void wait_timeout(void)
{
	for (int i = CAN_TIMEOUT_VALUE; i; i--);
}

void wait_settling(void)
{
	for (int i = CAN_TIMEOUT_VALUE/20; i; i--);
}

void TestCAN(void)
{
	PINSEL0_bit.P0_0 = 0x00;
	PINSEL0_bit.P0_1 = 0x00;
	PINMODE0_bit.P0_0 = 0x02;
	PINMODE0_bit.P0_1 = 0x02;
	
	FIO0DIR_bit.P0_1 = 0x01;
	FIO0DIR_bit.P0_0 = 0x00;
	
	FIO0CLR_bit.P0_1 = 1;
	wait_timeout();
	
	FIO0SET_bit.P0_1 = 1;
	
	wait_settling();
	if (1 != FIO0PIN_bit.P0_0) goto error;
	
	FIO0CLR_bit.P0_1 = 1;
	
	wait_settling();
	if (0 != FIO0PIN_bit.P0_0) goto error;
	
	wait_timeout();
	
	if (1 != FIO0PIN_bit.P0_0) goto error;
	
	
	printf("\r\n CAN test success");
	return;
	
	
	
error:
	printf("\r\n CAN test Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
}