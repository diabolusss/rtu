/*************************************************************************
 *
*    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : glcd_drv.h
 *    Description : Graphical LCD driver include file
 *
 *    History :
 *    1. Date        : 6, March 2008
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *
 *    $Revision: 18137 $
 **************************************************************************/
#include "arm_comm.h"

#ifndef __GLCD_DRV_H
#define __GLCD_DRV_H

typedef struct _Bmp_t {
  Int32U  H_Size;
  Int32U  V_Size;
  Int32U  BitsPP;
  Int32U  BytesPP;
  pInt32U pPalette;
  pInt32U pPicStream;
  pInt8U  pPicDesc;
} Bmp_t, *pBmp_t;


// pixel clock frequency < 6.4MHz
// ~5.4Mhz = 408 clk per line * (240 line + 3 Vsynch pulse
//           + 5 front porch + 15 back porch)

#define C_GLCD_REFRESH_FREQ     (50HZ)
#define C_GLCD_H_SIZE           320
#define C_GLCD_H_PULSE          30
#define C_GLCD_H_FRONT_PORCH    20
#define C_GLCD_H_BACK_PORCH     38
#define C_GLCD_V_SIZE           240
#define C_GLCD_V_PULSE          3
#define C_GLCD_V_FRONT_PORCH    5
#define C_GLCD_V_BACK_PORCH     15

#define C_GLCD_PWR_ENA_DIS_DLY  10000
#define C_GLCD_ENA_DIS_DLY      10000

#define CRSR_PIX_32     0
#define CRSR_PIX_64     1
#define CRSR_ASYNC      0
#define CRSR_FRAME_SYNC 2

void GLCD_Init (const Int32U *pPain, const Int32U * pPallete);
void GLCD_SetPallet (const Int32U * pPallete);
void GLCD_Ctrl (Boolean bEna);
void GLCD_Cursor_Cfg(int Cfg);
void GLCD_Cursor_En(int cursor);
void GLCD_Cursor_Dis(int cursor);
void GLCD_Move_Cursor(int x, int y);
void GLCD_Copy_Cursor (const Int32U *pCursor, int cursor, int size);


#endif // __GLCD_DRV_H
