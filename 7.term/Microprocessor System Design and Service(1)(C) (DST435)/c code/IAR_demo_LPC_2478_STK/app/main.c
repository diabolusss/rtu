/*************************************************************************
 *
*    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : main.c
 *    Description : Define main module
 *
 *    History :
 *    1. Date        : 12, September 2007
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *  This example project shows how to use the IAR Embedded Workbench for ARM
 * to develop code for the IAR LPC-2468 board. It shows basic use of the I/O,
 * the timer and the interrupt controllers.
 *  It starts by blinking USB Link LED.
 *
 * Jumpers:
 *  J5      - depending of power source
 *  ISP     - unfilled
 *  nRESET  - unfilled
 *  EINT0   - filled
 *
 * Note:
 *  After power-up the controller get clock from internal RC oscillator that
 * is unstable and may fail with J-Link auto detect, therefore adaptive clocking
 * should always be used. The adaptive clock can be select from menu:
 *  Project->Options..., section Debugger->J-Link/J-Trace  JTAG Speed - Adaptive.
 *
 *    $Revision: 18137 $
 **************************************************************************/
#include <intrinsics.h>
#include <stdio.h>
#include "board.h"
#include "sys.h"
#include "sdram_32M_16bit_drv.h"
#include "glcd_drv.h"
#include "logo.h"
#include "Cursor.h"
#include "smb380_drv.h"
#include "uart.h"
#include "adc.h"
#include "touchscreen.h"
#include "exttest.h"
#include "cantest.h"

#include "includes.h"

#define TIMER0_TICK_PER_SEC   50

#define CCS_DIR		FIO4DIR_bit.P4_15
#define	CCS_LOW()	FIO4CLR = 1<<15;
#define	CCS_HIGH()	FIO4SET = 1<<15;

#define	DCS_DIR		FIO2DIR_bit.P2_23
#define	DCS_LOW()	FIO2CLR = 1<<23;
#define	DCS_HIGH()	FIO2SET = 1<<23;

#define BUTTON1_IO	FIO2PIN_bit.P2_19
#define BUTTON2_IO	FIO2PIN_bit.P2_21

#define LED1SEL		PINSEL3_bit.P1_18
#define	LED1DIR		FIO1DIR_bit.P1_18
#define	LED1SET		FIO1CLR_bit.P1_18
#define	LED1CLR		FIO1SET_bit.P1_18

#define LED2SEL		PINSEL2_bit.P1_13
#define	LED2DIR		FIO1DIR_bit.P1_13
#define	LED2SET		FIO1CLR_bit.P1_13
#define	LED2CLR		FIO1SET_bit.P1_13

#define LED3SEL		PINSEL2_bit.P1_5
#define	LED3DIR		FIO1DIR_bit.P1_5
#define	LED3SET		FIO1SET_bit.P1_5
#define	LED3CLR		FIO1CLR_bit.P1_5


void TestButtons(void);

volatile Boolean Update;

extern Int32U SDRAM_BASE_ADDR;
#define LCD_VRAM_BASE_ADDR ((Int32U)&SDRAM_BASE_ADDR)

void TouchscreenDemo(void);
void AccelerometerDemo(void);
int USBTest(void);
int IRDATest(void);
int VS1002Test(void);


void display_banner(void)
{
	printf("\r\n\r\n\r\n\r\n");
	printf("\r\n***************************************************************");
	printf("\r\n*                                                             *");
	printf("\r\n*                       LPC-2478-STK                          *");
	printf("\r\n*                                                             *");
	printf("\r\n***************************************************************");
	printf("\r\n\r\n");
}

void display_menu(void)
{
	printf("\r\n\r\n\r\n\r\n");
	
	printf("\r\n E - Test Extension & CAN");
	printf("\r\n S - Test Sound");
	printf("\r\n A - Test Accelerometer");
	printf("\r\n T - Test Touchscreen");
	printf("\r\n I - Test IRDA");
	printf("\r\n U - Test USB Device port");
	printf("\r\n B - Test buttons & Trimmer");
	
	printf("\r\n\r\n");
}

int putchar(int ch)
{
	UARTTransmit(ch&0xff, UART_CH_0);
	return ch;
}


unsigned char Smb380Id, Smb380Ver;

/*************************************************************************
 * Function Name: Timer0IntrHandler
 * Parameters: none
 *
 * Return: none
 *
 * Description: Timer 0 interrupt handler
 *
 *************************************************************************/
void Timer0IntrHandler (void)
{
	Update = TRUE;
	// Toggle USB Link LED
	USB_D_LINK_LED_FIO ^= USB_D_LINK_LED_MASK;
	// clear interrupt
	T0IR_bit.MR0INT = 1;
	VICADDRESS = 0;
}

/*************************************************************************
 * Function Name: main
 * Parameters: none
 *
 * Return: none
 *
 * Description: main
 *
 *************************************************************************/
int main(void)
{
	typedef Int32U ram_unit;
	
	int print_menu;
	char ch;

	// MAM init
	MAMCR_bit.MODECTRL = 0;
	MAMTIM_bit.CYCLES  = 3;   // FCLK > 40 MHz
	MAMCR_bit.MODECTRL = 2;   // MAM functions fully enabled
	GLCD_Ctrl (FALSE);
	// Init clock
	InitClock();
	// Init GPIO
	GpioInit();
	// Init VIC
	VIC_Init();
	// SDRAM Init
	SDRAM_Init();
	// GLCD init
	
	UARTInit(115200, UART_CH_0, 0);
	
	display_banner();
	
	printf(" Testing SDRAM... please wait...");	
	
	
	if (TRUE == SDRAM_Test())
	{
		printf(" \r\nSDRAM test pass");
	}
	else
	{
		printf("\r\nSDRAM test fault!!!!!!!!!!!!!!!!");
		printf("\r\nAll other tests may behave strange!!!!");
	}
		
	GLCD_Init (LogoPic.pPicStream, NULL);

	GLCD_Cursor_Dis(0);

	GLCD_Copy_Cursor ((Int32U *)Cursor, 0, sizeof(Cursor)/sizeof(Int32U));

	GLCD_Cursor_Cfg(CRSR_FRAME_SYNC | CRSR_PIX_64);



	GLCD_Cursor_En(0);

	// Init USB Link  LED
	USB_D_LINK_LED_FDIR = USB_D_LINK_LED_MASK;
	USB_D_LINK_LED_FSET = USB_D_LINK_LED_MASK;

	// Enable TIM0 clocks
	PCONP_bit.PCTIM0 = 1; // enable clock

	// Init Time0
	T0TCR_bit.CE = 0;     // counting  disable
	T0TCR_bit.CR = 1;     // set reset
	T0TCR_bit.CR = 0;     // release reset
	T0CTCR_bit.CTM = 0;   // Timer Mode: every rising PCLK edge
	T0MCR_bit.MR0I = 1;   // Enable Interrupt on MR0
	T0MCR_bit.MR0R = 1;   // Enable reset on MR0
	T0MCR_bit.MR0S = 0;   // Disable stop on MR0
	// set timer 0 period
	T0PR = 0;
	T0MR0 = SYS_GetFpclk(TIMER0_PCLK_OFFSET)/(TIMER0_TICK_PER_SEC);
	// init timer 0 interrupt
	T0IR_bit.MR0INT = 1;  // clear pending interrupt
	VIC_SetVectoredIRQ(Timer0IntrHandler,0,VIC_TIMER0);
	VICINTENABLE |= 1UL << VIC_TIMER0;
	T0TCR_bit.CE = 1;     // counting Enable
	__enable_interrupt();
	GLCD_Ctrl (TRUE);
	
	UARTInit(115200, UART_CH_0, 0);
	
	print_menu = TRUE;
	
	while (1)
	{
		if (TRUE == print_menu)
		{
			display_menu();
			print_menu = FALSE;
		}
		
		if (TRUE == UARTIsDataReady(UART_CH_0))
		{
			ch = UARTReceive(UART_CH_0);
			/*printf("*%c", UARTReceive(UART_CH_0) + 1);*/
			
			switch (ch)
			{
				case 'E':
				case 'e':
					printf("\r\n Testing Extension...\r\n");
					TestExt();
					printf("\r\n Testing CAN...\r\n");
					TestCAN();
					print_menu = TRUE;
					break;
					
				case 'S':
				case 's':
					printf("\r\n VS1002 Sinewave Test. Press any key to return\r\n");
					VS1002Test();
					print_menu = TRUE;
					break;
					
				case 'A':
				case 'a':
					printf("\r\n Accelerometer Demo. Press any key to return\r\n");
					AccelerometerDemo();
					print_menu = TRUE;
					break;
					
				case 'T':
				case 't':
					printf("\r\n Touchscreen Demo. Press any key to return\r\n");
					TouchscreenDemo();
					print_menu = TRUE;
					break;
					
				case 'I':
				case 'i':
					printf("\r\n IRDA Test. Place the other board or press any key to abort\r\n");
					IRDATest();
					print_menu = TRUE;
					break;
					
				case 'U':
				case 'u':
					printf("\r\n USB Device Demo. Press any key to return\r\n");
					USBTest();
					print_menu = TRUE;
					break;
					
				case 'B':
				case 'b':
					printf("\r\n Check Buttons and Trimmer. Press any key to return\r\n");
					TestButtons();
					print_menu = TRUE;
					break;		

				
					
				default:
					printf("*%c%c*", ch, ch+1);
					break;
			}
			
		}
		
	}



	
	
	/*TouchscreenDemo();*/

	/*PINSEL1_bit.P0_25 = 0;
	PINSEL1_bit.P0_25 = 0;
	FIO0DIR_bit.P0_25 = 1;
	FIO0DIR_bit.P0_25 = 1;
	
	while (1)
	{
		FIO0CLR_bit.P0_25 = 1;
		FIO0SET_bit.P0_25 = 1;
		FIO0SET_bit.P0_25 = 1;
		FIO0CLR_bit.P0_25 = 1;
	}*/
	
	
	
  	/*USBTest();

	while (1) TestCAN();

  	while (1) TestExt();


  	



	InitADC(ADC_CH_7);
	
	touchscreen_data ts_data;
	ts_data.xvalue = 0;
	ts_data.yvalue = 0;
	ts_data.pvalue = 0;
	
	InitTS(ts_data);
	
	while (1)
	{
		ts_data = GetTS();
		printf("\r\nx = %d, y=%d, p=%d", ts_data.xvalue, ts_data.yvalue, ts_data.pvalue);

		for (int i = 100000; i; i--);
	}

	while (1)
	{
		//UARTTransmit(0x55, UART_CH_0);
		//printf("proba, proba, 1, 2, 3...");
		if (UARTIsDataReady(UART_CH_0) == TRUE)
		{
			printf("*%c", UARTReceive(UART_CH_0) + 1);
		}
		printf("\r\n %d", GetADC(ADC_CH_7));
		
		for (int i = 100000; i; i--);
	}*/

}

void InitRTC(void)
{
	PCONP_bit.PCRTC = 1;
	
	CCR_bit.CTCRST = 1;
	CCR_bit.CTCRST = 0;
	CCR_bit.CTTEST = 0;
	CCR_bit.CLKSRC = 1;
	CCR_bit.CLKEN = 1;
}

void TrimmerCursor()
{
	
#define X_RESOLUTION (C_GLCD_H_SIZE - CURSOR_H_SIZE)
	int x_measure;
	
	static int cursor_x = (C_GLCD_H_SIZE - CURSOR_H_SIZE)/2, cursor_y = (C_GLCD_V_SIZE - CURSOR_V_SIZE)/2;

	InitADC(ADC_CH_7);
	
	x_measure = GetADC(ADC_CH_7);
	
	cursor_x = (x_measure * X_RESOLUTION) / 1024;
	
	GLCD_Move_Cursor(cursor_x, cursor_y);
}

void TestButtons(void)
{
	char ch;
	
	int prev_secs;
	
	LED1SEL = 0x0;
	LED2SEL = 0x0;
	LED3SEL = 0x0;
	
	LED1DIR = 0x1;
	LED2DIR = 0x1;
	LED3DIR = 0x1;
	
	LED1CLR = 0x1;
	LED2CLR = 0x1;
	LED3CLR = 0x1;
	
	InitRTC();
	
	prev_secs = SEC_bit.SEC;
	
	while (1)
	{
		
		TrimmerCursor();
		
		if (prev_secs != SEC_bit.SEC)
		{
			prev_secs = SEC_bit.SEC;
			if (prev_secs % 2)
			{
				LED2CLR = 1;
			}
			else
			{
				LED2SET = 1;
			}
		}
		
		if ( 0x0 == BUTTON1_IO )
		{
			LED3SET = 1;
		}
		
		if ( 0x0 == BUTTON2_IO )
		{
			LED3CLR = 1;
		}
		
		if (UARTIsDataReady(UART_CH_0) == TRUE)
		{
			ch = UARTReceive(UART_CH_0);
			return;
		}
	}
	
}



unsigned int SSP0Transfer(unsigned int symbol)
{
	SSP0DR = symbol;
	while (SSP0SR_bit.BSY);
	symbol = SSP0DR;
	return symbol;
}

void SSP0Init(void)
{
	PINSEL5_bit.P2_22 = 0x3;	/* SCK */
	PINSEL5_bit.P2_23 = 0x0;	/* SSEL */
	PINSEL5_bit.P2_26 = 0x3;	/* MISO */
	PINSEL5_bit.P2_27 = 0x3;	/* MOSI */
	
	FIO2DIR |= ((1<<22) | (1<<23) | (1<<27));
	FIO2SET = 1<<23;	
	
	PCONP_bit.PCSSP0 = 1;
	
	SSP0CR0_bit.DSS = 0xf;	/* 16-bit transfer size */
	SSP0CR0_bit.FRF = 0; 	/* SPI mode */
	SSP0CR0_bit.SPO = 0;	/* Polarity */
	SSP0CR0_bit.SPH = 0;	/* Phase */
	SSP0CR0_bit.SCR = 0x2;	/* clock divider */
	
	SSP0CR1 = 0x0;		/* clear everything */
	SSP0CR1_bit.SSE = 1;	/* enable the SSP module */
	
}




int VS1002Test(void)
{
	char ch;
	
	SSP0Init();
	
	CCS_HIGH();
	DCS_HIGH();
	
	CCS_DIR = 1;
	DCS_DIR = 1;
	
	
	FIO1DIR |= (1<<13) | (1<<18);
	
	FIO1CLR = 1<<13;
	FIO1CLR = 1<<18;
	
	CCS_LOW();
	SSP0Transfer(0x0200);	/* write SCI_MODE */
	SSP0Transfer(0x0820);	/* set SM_TESTS */
	CCS_HIGH();
	
	DCS_LOW();
	SSP0Transfer(0x53ef);
	SSP0Transfer(0x6e44);
	SSP0Transfer(0x0000);
	SSP0Transfer(0x0000);
	DCS_HIGH();
	
	
	while (1)
	{
		
	
		if (UARTIsDataReady(UART_CH_0) == TRUE)
		{
			DCS_LOW();
			SSP0Transfer(0x4578);
			SSP0Transfer(0x6974);
			SSP0Transfer(0x0000);
			SSP0Transfer(0x0000);
			DCS_HIGH();
			
			ch = UARTReceive(UART_CH_0);
			return TRUE;
		}
	}
}

int USBTest(void)
{
	Int32U State, Count;
	
	char ch;
	
	 USB_Init(1,UsbClassHidConfigure);
	// Init HID
	HidInit();
	__enable_interrupt();
	// Soft connection enable
	USB_ConnectRes(TRUE);
	
	
	while(1)
	{
		if(Update)
		{
			if (UARTIsDataReady(UART_CH_0) == TRUE)
			{
				ch = UARTReceive(UART_CH_0);
				return FALSE;
			}
			
			Update = FALSE;
			if(UsbCoreReq(UsbCoreReqDevState) == UsbDevStatusConfigured &&
				!UsbCoreReq(UsbCoreReqDevSusState))
			{
				// Mouse pointer state machine
				switch(State)
				{
					case 0:
						HidSendReport(0,-2,0);
						if(Count-- == 0)
						{
							State++;
							Count = 50;
						}
						break;
						
					case 1:
						HidSendReport(0,0,2);
						if(Count-- == 0)
						{
							State++;
							Count = 50;
						}
						break;
						
					case 2:
						HidSendReport(0,2,0);
						if(Count-- == 0)
						{
							State++;
							Count =50;
						}
						break;
					
					case 3:
						HidSendReport(0,0,-2);
						if(Count-- == 0)
						{
							State++;
							Count = 50;
						}
						break;
					
					default:
						State = 0;
						Count = 50;
				}
			}
			else
			{
				// Reset state
				State = 0;
				Count = 100;
			}
		// USB Wake-up
		//if (!(K1_FIO & K1_MASK))
		//{
		//	UsbWakeUp();
		//}
	}
}
	
}

int IRDATest(void)
{
	const char testchar = 0xB1;
	char ch;
	UARTInit(9600, UART_CH_3, 1);
	U3ICR_bit.IRDAEN = 1;
	
	while (1)
	{
		UARTTransmit(testchar, UART_CH_3);
		for (int i = 100000; i; i--);
		
		if (UARTIsDataReady(UART_CH_3) == TRUE)
		{
			ch = UARTReceive(UART_CH_3);
			
			if (testchar == ch)
			{
				printf("\r\n IRDA Test pass \r\n");
				return TRUE;
			}
		}
		
		if (UARTIsDataReady(UART_CH_0) == TRUE)
		{
			ch = UARTReceive(UART_CH_0);
			
			//if (('n' == ch) || ('N' == ch))
			return FALSE;
		}
		
	}
}

void TouchscreenDemo(void)
{
#define	TS_MIN_X	200
#define	TS_MAX_X	910
#define	TS_MIN_Y	150
#define	TS_MAX_Y	800
	
	char ch;
	
	int cursor_x = (C_GLCD_H_SIZE)/2, cursor_y = (C_GLCD_V_SIZE)/2;
	touchscreen_data ts_data;
	
	GLCD_Move_Cursor(cursor_x, cursor_y);
	
	while (1)
	{
		//for (int i =0; i<100000; i++);
		
		if (TRUE == UARTIsDataReady(UART_CH_0))
		{
			ch = UARTReceive(UART_CH_0);
			return;
		}
		
		ts_data = GetTS();
		
		if (ts_data.pvalue > 512)
		{
			cursor_x = (C_GLCD_H_SIZE * (ts_data.xvalue - TS_MIN_X)) /(TS_MAX_X - TS_MIN_X);
			cursor_y = (C_GLCD_V_SIZE * (ts_data.yvalue - TS_MIN_Y)) /(TS_MAX_Y - TS_MIN_Y);
			
			cursor_x = cursor_x - CURSOR_H_SIZE/2;
			cursor_y = cursor_y - CURSOR_V_SIZE/2;
			
			if (cursor_x < -28) cursor_x = -28;
			if (cursor_y < -28) cursor_y = -28;
			
			if ((cursor_x + CURSOR_H_SIZE) > (C_GLCD_H_SIZE+28)) cursor_x = (C_GLCD_H_SIZE - CURSOR_H_SIZE + 28);
			if ((cursor_y + CURSOR_V_SIZE) > (C_GLCD_V_SIZE+28)) cursor_y = (C_GLCD_V_SIZE - CURSOR_V_SIZE + 28);

			GLCD_Move_Cursor(cursor_x, cursor_y);
			//printf("\r\nx=%d, x_cursor=%d, y=%d, y_cursor=%d", ts_data.xvalue, cursor_x, ts_data.yvalue, cursor_y);
		}
	}
}

void AccelerometerDemo(void)
{
	char ch;
	int cursor_x = (C_GLCD_H_SIZE - CURSOR_H_SIZE)/2, cursor_y = (C_GLCD_V_SIZE - CURSOR_V_SIZE)/2;
	
	GLCD_Move_Cursor(cursor_x, cursor_y);
	
	SMB380_Init();

	SMB380_GetID(&Smb380Id, &Smb380Ver);

	SMB380_Data_t XYZT;

	while(1)
	{
		if (TRUE == UARTIsDataReady(UART_CH_0))
		{
			ch = UARTReceive(UART_CH_0);
			return;
		}
		
		for(int i = 0; i < 100000;  i++);

		SMB380_GetData (&XYZT);

		cursor_x += XYZT.AccX/512;
		cursor_y += XYZT.AccY/512;

		if((C_GLCD_H_SIZE - CURSOR_H_SIZE/2) < cursor_x)
		{
			cursor_x = C_GLCD_H_SIZE - CURSOR_H_SIZE/2;
		}

		if(-(CURSOR_H_SIZE/2) > cursor_x)
		{
			cursor_x = -(CURSOR_H_SIZE/2);
		}

		if((C_GLCD_V_SIZE - CURSOR_V_SIZE/2) < cursor_y)
		{
			cursor_y = (C_GLCD_V_SIZE - CURSOR_V_SIZE/2);
		}

		if(-(CURSOR_V_SIZE/2) > cursor_y)
		{
			cursor_y = -(CURSOR_V_SIZE/2);
		}

		GLCD_Move_Cursor(cursor_x, cursor_y);
	}
}