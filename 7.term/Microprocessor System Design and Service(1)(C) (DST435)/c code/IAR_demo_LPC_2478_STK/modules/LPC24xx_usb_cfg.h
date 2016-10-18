/*************************************************************************
 *
 *    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : lpc24xx_usb_cfg.h
 *    Description : Define main module
 *
 *    History :
 *    1. Date        : January 7, 2007
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *    $Revision: 18137 $
**************************************************************************/

#include "includes.h"

#ifndef __LPC_USB_CFG_H
#define __LPC_USB_CFG_H

#define USB1_ERRATA         // USB_NEED_CLK is always asserted
#define USB2_ERRATA         // U1CONNECT/U2CONNECT signal is not functional
#define USB3_ERRATA         // USB VBUS signal is not functional

/* USB port select 1/2*/
#define USB_PORT_SEL              1

/* USB clk divider */
#define USB_CLK_DIV               6

/* USB Events */
#define USB_HIGH_PRIORITY_EVENT   0
#define USB_HIGH_PRIORITY_EP      0

#define USB_SOF_EVENT             0
#define USB_FAST_EP               1
#define USB_ERROR_EVENT           1
#define USB_REMOTE_WAKEUP         1

#if (USB_HIGH_PRIORITY_EVENT > 0) && (USB_HIGH_PRIORITY_EP > 0) && (USB_FAST_EP > 0)
#error "You can set only USB_FAST_EP or USB_HIGH_PRIORITY_EP"
#endif

/* DMA transfer */
#define USB_DMA   								0
#define DMA_DD_MAX_NUMB						0
#define DMA_INT_ENABLE_MASK       0

/* Endpoint definitions */
#define Ep0MaxSize        				8
#define ReportEp          				UsbEp1In
#define ReportEpMaxSize   				3

/* Other definitions */

#endif //__LPC_USB_CFG_H
