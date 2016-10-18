/****************************************************************************
 *
 * Project: LPC-2478-STK
 *
 * Copyright: Ivan Vasilev, Olimex Ltd. All rights reserved.
 *
 * File: uart.c
 * Description: UART functions
 * Developer: Ivan Vasilev, <ivan at l123.org>
 *
 * Last change: $Date: 2008-07-01 14:12:20 +0300 (???????, 01 ??? 2008) $
 * Revision: $Revision: 58 $
 * Id: $Id: iBMapp.c 58 2008-07-01 11:12:20Z Ivan $
 * Author: $Author: Ivan $
 *
 ****************************************************************************/

#include "uart.h"
#include "sys.h"

/* the "location parameter is used when the particular channel can be connected
 * to many different places. the order is P0_x, P1_x, etc. */	
void	UARTInit(uint32_t baud, uint8_t channel, uint8_t location)
{
	uint32_t temp, div, div_l, div_h;
	
	switch (channel)
	{
		case UART_CH_0:
			PCLKSEL0_bit.PCLK_UART0 = 0x01;
			temp = UART0_PCLK_OFFSET;
			break;
			
		case UART_CH_1:
			PCLKSEL0_bit.PCLK_UART1 = 0x01;
			temp = UART1_PCLK_OFFSET;
			break;
			
		case UART_CH_2:
			PCLKSEL1_bit.PCLK_UART2 = 0x01;
			temp = UART2_PCLK_OFFSET;
			break;
			
		case UART_CH_3:
			PCLKSEL1_bit.PCLK_UART3 = 0x01;
			temp = UART3_PCLK_OFFSET;
			break;
		
		default:
			return;
	}
	
	div = (SYS_GetFpclk(temp) / 16) / baud;
	
	div_h = div / 256;
	div_l = div % 256;
	
	switch (channel)
	{
		case UART_CH_0:
			/*PINSEL0 &= ~(0x00000050);
			PINSEL0 |= 0x00000050;*/
			PINSEL0_bit.P0_2 = 0x01;
			PINSEL0_bit.P0_3 = 0x01;
			PCONP_bit.PCUART0 = 1;
			U0LCR = 0x83;   /* 8 bits, no Parity, 1 Stop bit */
			U0DLM = div_h;
			U0DLL = div_l;
			U0LCR = 0x03;   /* DLAB = 0 */
			U0FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
			break;
			
		case UART_CH_1:
			switch (location)
			{
				case 0:
					PINSEL0_bit.P0_15 = 0x01;
					PINSEL1_bit.P0_16 = 0x01;
					break;
					
				case 1:
					PINSEL4_bit.P2_0 = 0x02;
					PINSEL4_bit.P2_1 = 0x02;
					break;
					
				case 2:
					PINSEL7_bit.P3_16 = 0x03;
					PINSEL7_bit.P3_17 = 0x03;
					break;
			}
			PCONP_bit.PCUART1 = 1;
			U1LCR = 0x83;   /* 8 bits, no Parity, 1 Stop bit */
			U1DLM = div_h;
			U1DLL = div_l;
			U1LCR = 0x03;   /* DLAB = 0 */
			U1FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
			break;
			
		case UART_CH_2:
			switch (location)
			{
				case 0:
					PINSEL0_bit.P0_10 = 0x01;
					PINSEL0_bit.P0_11 = 0x01;
					break;
					
				case 1:
					PINSEL4_bit.P2_8 = 0x02;
					PINSEL4_bit.P2_9 = 0x02;
					break;
					
				case 2:
					PINSEL9_bit.P4_22 = 0x02;
					PINSEL9_bit.P4_23 = 0x02;
					break;
			}
			PCONP_bit.PCUART2 = 1;
			U2LCR = 0x83;   /* 8 bits, no Parity, 1 Stop bit */
			U2DLM = div_h;
			U2DLL = div_l;
			U2LCR = 0x03;   /* DLAB = 0 */
			U2FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
			break;
			
		case UART_CH_3:
			switch (location)
			{
				case 0:
					PINSEL0_bit.P0_0 = 0x02;
					PINSEL0_bit.P0_1 = 0x02;
					FIO0DIR_bit.P0_1 = 1;
					break;
					
				case 1:
					PINSEL1_bit.P0_25 = 0x03;
					PINSEL1_bit.P0_26 = 0x03;
					break;
					
				case 2:
					PINSEL9_bit.P4_28 = 0x03;
					PINSEL9_bit.P4_29 = 0x03;
					break;
			}
			PCONP_bit.PCUART3 = 1;
			U3LCR = 0x83;   /* 8 bits, no Parity, 1 Stop bit */
			U3DLM = div_h;
			U3DLL = div_l;
			U3LCR = 0x03;   /* DLAB = 0 */
			U3FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
			break;
	}
}


uint8_t	UARTIsDataReady(uint8_t channel)
{
	switch (channel)
	{
		case UART_CH_0:
			if (U0LSR_bit.DR) return TRUE;
				else return FALSE;
		
		case UART_CH_1:
			if (U1LSR_bit.DR) return TRUE;
				else return FALSE;
			
		case UART_CH_2:
			if (U2LSR_bit.DR) return TRUE;
				else return FALSE;
			
		case UART_CH_3:
			if (U3LSR_bit.DR) return TRUE;
				else return FALSE;
			
		default:
			return FALSE;
	}
	
}

uint8_t	UARTReceive(uint8_t channel)
{
	switch (channel)
	{
		case UART_CH_0:
			return U0RBR;
		
		case UART_CH_1:
			return U1RBR;
			
		case UART_CH_2:
			return U2RBR;
			
		case UART_CH_3:
			return U3RBR;
			
		default:
			return FALSE;
	}
}

void	UARTTransmit(uint8_t ch, uint8_t channel)
{
	switch (channel)
	{
		case UART_CH_0:
			while (!U0LSR_bit.THRE);
			U0THR = ch;
			break;
		
		case UART_CH_1:
			while (!U1LSR_bit.THRE);
			U1THR = ch;
			break;
			
		case UART_CH_2:
			while (!U2LSR_bit.THRE);
			U2THR = ch;
			break;
			
		case UART_CH_3:
			while (!U3LSR_bit.THRE);
			U3THR = ch;
			break;
			
		default:
			break;
	}
	
}