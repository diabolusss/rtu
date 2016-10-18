/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: exttest.h
 * Description: extension test include
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

#define NUMBER_TESTED_PINS	16
#define PIN_NAME_SIZE		6

#define EXT_SETTLING_DELAY	100000

typedef struct _test_ext_pin_t
{
	char pin_name[PIN_NAME_SIZE];
	int pin_offset;
	/*int (*pin_get)(void);*/
	unsigned long volatile * pin_get;
	unsigned long volatile * pin_set;
	unsigned long volatile * pin_clr;
	unsigned long volatile * pin_dir;
	
	/*void (*pin_set)(void);
	void (*pin_clr)(void);
	void (*pin_dir)(int dir);*/
} test_ext_pin_t;

void TestExt(void);
