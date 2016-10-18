/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: uart.h
 * Description: UART include file
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

#define	UART_CH_0	0x0
#define	UART_CH_1	0x1
#define	UART_CH_2	0x2
#define	UART_CH_3	0x4		

void	UARTInit(uint32_t baud, uint8_t location, uint8_t channel);
uint8_t	UARTIsDataReady(uint8_t channel);
uint8_t	UARTReceive(uint8_t channel);
void	UARTTransmit(uint8_t ch, uint8_t channel);