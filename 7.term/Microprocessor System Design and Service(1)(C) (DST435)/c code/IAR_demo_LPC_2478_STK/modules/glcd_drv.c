/*************************************************************************
 *
*    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : lcd_drv.c
 *    Description : Graphical LCD driver
 *
 *    History :
 *    1. Date        : 6, March 2008
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *
 *    $Revision: 18137 $
 **************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "board.h"
#include "sys.h"
#include "glcd_drv.h"

#define C_GLCD_CLK_PER_LINE     (C_GLCD_H_SIZE + C_GLCD_H_PULSE + C_GLCD_H_FRONT_PORCH + C_GLCD_H_BACK_PORCH)
#define C_GLCD_LINES_PER_FRAME  (C_GLCD_V_SIZE + C_GLCD_V_PULSE + C_GLCD_V_FRONT_PORCH + C_GLCD_V_BACK_PORCH)
#define C_GLCD_PIX_CLK          (6.4MHZ)

extern Int32U SDRAM_BASE_ADDR;

#define LCD_VRAM_BASE_ADDR ((Int32U)&SDRAM_BASE_ADDR)
#define LCD_CURSOR_BASE_ADDR ((Int32U)0xFFE10800)

/*************************************************************************
 * Function Name: GLCD_Cursor_Cnfg
 * Parameters: 
 *             
 * Return: none
 *
 * Description: Configure the cursor
 *
 *************************************************************************/
void GLCD_Cursor_Cfg(int Cfg)
{
  CRSR_CFG = Cfg;
}
/*************************************************************************
 * Function Name: GLCD_Cursor_En
 * Parameters: cursor - Cursor Number
 *             
 * Return: none
 *
 * Description: Enable Cursor 
 *
 *************************************************************************/
void GLCD_Cursor_En(int cursor)
{
  CRSR_CTRL_bit.CrsrNum = cursor;
  CRSR_CTRL_bit.CrsrOn = 1;
}

/*************************************************************************
 * Function Name: GLCD_Cursor_Dis
 * Parameters: None
 *             
 * Return: none
 *
 * Description: Disable Cursor
 *
 *************************************************************************/
void GLCD_Cursor_Dis(int cursor)
{
  CRSR_CTRL_bit.CrsrOn = 0;
}

/*************************************************************************
 * Function Name: GLCD_Move_Cursor
 * Parameters: x - cursor x position
 *             y - cursor y position
 *            
 * Return: none
 *
 * Description: Moves cursor on position (x,y). Negativ values are posible.
 *
 *************************************************************************/
void GLCD_Move_Cursor(int x, int y)
{
  if(0 <= x)
  {//no clipping
    CRSR_CLIP_bit.CrsrClipX = 0;   
    CRSR_XY_bit.CrsrX = x;
  }
  else
  {//clip x
    CRSR_CLIP_bit.CrsrClipX = -x;   
    CRSR_XY_bit.CrsrX = 0;
  }

  if(0 <= y)
  {//no clipping
    CRSR_CLIP_bit.CrsrClipY = 0;   
    CRSR_XY_bit.CrsrY = y;
  }
  else
  {//clip y
    CRSR_CLIP_bit.CrsrClipY = -y;   
    CRSR_XY_bit.CrsrY = 0;
  }
}

/*************************************************************************
 * Function Name: GLCD_Copy_Cursor
 * Parameters: pCursor - pointer to cursor conts image
 *             cursor - cursor Number (0,1,2 or 3)
 *                      for 64x64(size 256) pix cursor always use 0
 *             size - cursor size in words
 * Return: none
 *
 * Description: Copy Cursor from const image to LCD RAM image
 *
 *************************************************************************/
void GLCD_Copy_Cursor (const Int32U *pCursor, int cursor, int size)
{
   Int32U * pDst = (Int32U *)LCD_CURSOR_BASE_ADDR;
   pDst += cursor*64;
   
   for(int i = 0; i < size ; i++) *pDst++ = *pCursor++;
}
/*************************************************************************
 * Function Name: GLCD_Init
 * Parameters: const Int32U *pPain, const Int32U * pPallete
 *
 * Return: none
 *
 * Description: GLCD controller init
 *
 *************************************************************************/
void GLCD_Init (const Int32U *pPain, const Int32U * pPallete)
{
pInt32U pDst = (pInt32U) LCD_VRAM_BASE_ADDR;
  // Assign pin
  PINSEL0 &= BIN32(11111111,11110000,00000000,11111111);
  PINSEL0 |= BIN32(00000000,00000101,01010101,00000000);
  PINMODE0&= BIN32(11111111,11111100,00000000,11111111);
  PINMODE0|= BIN32(00000000,00000010,10101010,00000000);
  PINSEL3 &= BIN32(11110000,00000000,00000000,11111111);
  PINSEL3 |= BIN32(00000101,01010101,01010101,00000000);
  PINMODE3&= BIN32(11110000,00000000,00000000,11111111);
  PINMODE3|= BIN32(00001010,10101010,10101010,00000000);
  PINSEL4 &= BIN32(11110000,00110000,00000000,00000000);
  PINSEL4 |= BIN32(00000101,01001111,11111111,11111111);
  PINMODE4&= BIN32(11110000,00110000,00000000,00000000);
  PINMODE4|= BIN32(00001010,10001010,10101010,10101010);
  PINSEL9 &= BIN32(11110000,11111111,11111111,11111111);
  PINSEL9 |= BIN32(00001010,00000000,00000000,00000000);
  PINMODE9&= BIN32(11110000,11111111,11111111,11111111);
  PINMODE9|= BIN32(00001010,00000000,00000000,00000000);
  PINSEL11&= BIN32(11111111,11111111,11111111,11110000);
  PINSEL11|= BIN32(00000000,00000000,00000000,00001111);
  // Init GLCD cotroller
  PCONP_bit.PCLCD = 1;      // enable LCD controller clock
  CRSR_CTRL_bit.CrsrOn = 0; // Disable cursor
  LCD_CTRL_bit.LcdEn = 0;   // disable GLCD controller
  LCD_CTRL_bit.LcdBpp= 5;   // 24 bpp
  LCD_CTRL_bit.LcdTFT= 1;   // TFT panel
  LCD_CTRL_bit.LcdDual=0;   // single panel
  LCD_CTRL_bit.BGR   = 0;   // notmal output
  LCD_CTRL_bit.BEBO  = 0;   // little endian byte order
  LCD_CTRL_bit.BEPO  = 0;   // little endian pix order
  LCD_CTRL_bit.LcdPwr= 0;   // disable power
  // init pixel clock
  LCD_CFG_bit.CLKDIV =  SYS_GetFsclk() / (Int32U)C_GLCD_PIX_CLK;
  LCD_POL_bit.BCD    = 1;   // bypass inrenal clk divider
  LCD_POL_bit.CLKSEL = 0;   // clock source for the LCD block is HCLK
  LCD_POL_bit.IVS    = 1;   // LCDFP pin is active LOW and inactive HIGH
  LCD_POL_bit.IHS    = 1;   // LCDLP pin is active LOW and inactive HIGH
  LCD_POL_bit.IPC    = 1;   // data is driven out into the LCD on the falling edge
  LCD_POL_bit.IOE    = 0;   // active high
  LCD_POL_bit.CPL    = C_GLCD_H_SIZE-1;
  // init Horizontal Timing
  LCD_TIMH_bit.HBP   =  C_GLCD_H_BACK_PORCH - 1;
  LCD_TIMH_bit.HFP   =  C_GLCD_H_FRONT_PORCH - 1;
  LCD_TIMH_bit.HSW   =  C_GLCD_H_PULSE - 1;
  LCD_TIMH_bit.PPL   = (C_GLCD_H_SIZE/16) - 1;
  // init Vertical Timing
  LCD_TIMV_bit.VBP   =  C_GLCD_V_BACK_PORCH;
  LCD_TIMV_bit.VFP   =  C_GLCD_V_FRONT_PORCH;
  LCD_TIMV_bit.VSW   =  C_GLCD_V_PULSE;
  LCD_TIMV_bit.LPP   =  C_GLCD_V_SIZE - 1;
  // Frame Base Address doubleword aligned
  LCD_UPBASE         =  LCD_VRAM_BASE_ADDR & ~7UL ;
  LCD_LPBASE         =  LCD_VRAM_BASE_ADDR & ~7UL ;
  // init colour pallet

  if(NULL != pPallete)
  {
    GLCD_SetPallet(pPallete);
  }

  if (NULL == pPain)
  {
    // clear display memory
    for(Int32U i = 0; (C_GLCD_H_SIZE * C_GLCD_V_SIZE) > i; i++)
    {
      *pDst++ = 0;
    }
  }
  else
  {
    // set display memory
    for(Int32U i = 0; (C_GLCD_H_SIZE * C_GLCD_V_SIZE) > i; i++)
    {
      *pDst++ = *pPain++;
    }
  }
    
  for(volatile Int32U i = C_GLCD_ENA_DIS_DLY; i; i--);
}

/*************************************************************************
 * Function Name: GLCD_SetPallet
 * Parameters: const Int32U * pPallete
 *
 * Return: none
 *
 * Description: GLCD init colour pallete
 *
 *************************************************************************/
void GLCD_SetPallet (const Int32U * pPallete)
{
pInt32U pDst = (pInt32U)LCD_PAL_BASE;
  assert(pPallete);
  for (Int32U i = 0; i < 128; i++)
  {
    *pDst++ = *pPallete++;
  }
}

/*************************************************************************
 * Function Name: GLCD_Ctrl
 * Parameters: Boolean bEna
 *
 * Return: none
 *
 * Description: GLCD enable disabe sequence
 *
 *************************************************************************/
void GLCD_Ctrl (Boolean bEna)
{
  if (bEna)
  {
    LCD_CTRL_bit.LcdEn = 1;
    for(volatile Int32U i = C_GLCD_PWR_ENA_DIS_DLY; i; i--);
    LCD_CTRL_bit.LcdPwr= 1;   // enable power
  }
  else
  {
    LCD_CTRL_bit.LcdPwr= 0;   // disable power
    for(volatile Int32U i = C_GLCD_PWR_ENA_DIS_DLY; i; i--);
    LCD_CTRL_bit.LcdEn = 0;
  }
}

