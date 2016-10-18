/*************************************************************************
 *
 *    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : LPC24xx_usb.c
 *    Description : usb module (HAL)
 *
 *    History :
 *    1. Date        : January 7, 2007
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *    $Revision: 18137 $
 **************************************************************************/

#define HAL_USB_GLOBAL
#include "LPC24xx_usb.h"

// Single/Double buffered EP flags
static const Boolean UsbEpDoubleBuffType[] =
{
  FALSE,  // OUT 0
  FALSE,  // IN 0
  FALSE,  // OUT 1
  FALSE,  // IN 1
  TRUE,   // OUT 2
  TRUE,   // IN 2
  TRUE,   // OUT 3
  TRUE,   // IN 3
  FALSE,  // OUT 4
  FALSE,  // IN 4
  TRUE,   // OUT 5
  TRUE,   // IN 5
  TRUE,   // OUT 6
  TRUE,   // IN 6
  FALSE,  // OUT 7
  FALSE,  // IN 7
  TRUE,   // OUT 8
  TRUE,   // IN 8
  TRUE,   // OUT 9
  TRUE,   // IN 9
  FALSE,  // OUT 10
  FALSE,  // IN 10
  TRUE,   // OUT 11
  TRUE,   // IN 11
  TRUE,   // OUT 12
  TRUE,   // IN 12
  FALSE,  // OUT 13
  FALSE,  // IN 13
  TRUE,   // OUT 14
  TRUE,   // IN 14
  TRUE,   // OUT 15
  TRUE,   // IN 15
};

static UserFunc_t UsbUserFun [UsbLastEvent] =
{
  // EP 0 Out
  NULL,
  // EP 0 In
  NULL,
  // EP 1 Out
  NULL,
  // EP 1 In
  NULL,
  // EP 2 Out
  NULL,
  // EP 2 Int
  NULL,
  // EP 3 Out
  NULL,
  // EP 3 In
  NULL,
  // EP 4 Out
  NULL,
  // EP 4 In
  NULL,
  // EP 5 Out
  NULL,
  // EP 5 In
  NULL,
  // EP 6 Out
  NULL,
  // EP 6 In
  NULL,
  // EP 7 Out
  NULL,
  // EP 7 In
  NULL,
  // EP 8 Out
  NULL,
  // EP 8 In
  NULL,
  // EP 9 Out
  NULL,
  // EP 9 In
  NULL,
  // EP 10 Out
  NULL,
  // EP 10 In
  NULL,
  // EP 11 Out
  NULL,
  // EP 11 In
  NULL,
  // EP 12 Out
  NULL,
  // EP 12 In
  NULL,
  // EP 13 Out
  NULL,
  // EP 13 In
  NULL,
  // EP 14 Out
  NULL,
  // EP 14 In
  NULL,
  // EP 15 Out
  NULL,
  // EP 15 In
  NULL,
  // UsbClassEp0OutPacket
  NULL,
  // UsbVendorEp0OutPacket
  NULL,
  // UsbUserSofEvent
  NULL,
  // UsbUserClass
  NULL,
  // UsbUserVendor
  NULL,
  // UsbUserGetDescriptor
  NULL,
  // UsbUserConfigure
  NULL,
  // UsbUserReset
  NULL,
  // UsbUserConnect
  NULL,
  // UsbUserSuspend
  NULL,
  // UsbUserEpStall
  NULL,
  // UsbUserEpUnStall
  NULL,
  // UsbUserErrorEvent
  NULL,

};

static volatile UsbDevStat_t USB_DevStatus;

static EpInfo_t EpInfo[ENP_MAX_NUMB];

static UsbEpCtrl_t UsbEp0Ctrl;

static UsbSetupPacket_t UsbEp0SetupPacket;

#pragma data_alignment=4
static Int8U EpCtrlDataBuf[Ep0MaxSize];

static UsbDevCtrl_t UsbDevCtrl = {{UsbDevStatusUnknow,UsbDevStatusNoSuspend},0,0,0,0};

static CommUserFpnt_t UsbCoreT9Fun;

volatile Int32U EpPriority;
#include "usb_common.c"

/*************************************************************************
 * Function Name: USB_Cmd
 * Parameters:  Int16U Command, Int8U Data
 *
 * Return: Int32U - command result
 *
 * Description: Implement commands transmit to USB Engine
 *
 *************************************************************************/
static
Int32U USB_Cmd (Int16U Command, Int8U Data)
{
Int32U save, tmp = 0;
  // Disable interrupt and save current state of the interrupt flags
  save = __get_interrupt_state();
  __disable_interrupt();
  USBDEVINTCLR = bmUSB_CommDataFullInterrupt | bmUSB_CommRegEmptyInterrupt;
  // Load command in USB engine
  USBCMDCODE = ((Command&0xFF) << 16) + USB_CMD_WR;
  // Wait until command is accepted
  while ((USBDEVINTST & bmUSB_CommRegEmptyInterrupt) == 0);
  // clear Command reg. empty interrupt
  USBDEVINTCLR = bmUSB_CommRegEmptyInterrupt;
  // determinate next phase of the command
  switch (Command)
  {
  case CMD_USB_SET_ADDRESS:
  case CMD_USB_CFG_DEV:
  case CMD_USB_SET_MODE:
  case CMD_USB_SET_DEV_STAT:
    USBCMDCODE = (Data << 16) + USB_DATA_WR;
    while ((USBDEVINTST & bmUSB_CommRegEmptyInterrupt) == 0);
    break;
  case CMD_USB_RD_FRAME_NUMB:
  case CMD_USB_RD_TEST_REG:
    USBCMDCODE = (Command << 16) + USB_DATA_RD;
    while ((USBDEVINTST & bmUSB_CommDataFullInterrupt) == 0);
    USBDEVINTCLR = bmUSB_CommDataFullInterrupt;
    tmp = USBCMDDATA;
    USBCMDCODE = (Command << 16) + USB_DATA_RD;
    while ((USBDEVINTST & bmUSB_CommDataFullInterrupt) == 0);
    tmp |= USBCMDDATA << 8;
    break;
  case CMD_USB_GET_DEV_STAT:
  case CMD_USB_GET_ERROR:
  case CMD_USB_RD_ERROR_STAT:
  case CMD_USB_CLR_BUF:
    USBCMDCODE = (Command << 16) + USB_DATA_RD;
    while ((USBDEVINTST & bmUSB_CommDataFullInterrupt) == 0);
    tmp = USBCMDDATA;
    break;
  default:
    switch (Command & 0x1E0)
    {
    case CMD_USB_SEL_EP:
    case CMD_USB_SEL_CLR_INT_EP:
      USBCMDCODE = (Command << 16) + USB_DATA_RD;
      while ((USBDEVINTST & bmUSB_CommDataFullInterrupt) == 0);
      tmp = USBCMDDATA;
      break;
    case CMD_USB_SET_EP_STAT:
      USBCMDCODE = (Data << 16) + USB_DATA_WR;
      while ((USBDEVINTST & bmUSB_CommRegEmptyInterrupt) == 0);
      break;
    }
    break;
  }
  // restore the interrupt flags
  __set_interrupt_state(save);
  return(tmp);
}

/*************************************************************************
 * Function Name: USB_EpIntrClr
 * Parameters: USB_Endpoint_t EndPoint
 *
 * Return: Int8U
 *
 * Description: Clear the EP interrupt flag and return the current EP status
 *
 *************************************************************************/
static
Int8U USB_EpIntrClr(USB_Endpoint_t EndPoint)
{
volatile Int32U TO = 100;
  // Disable interrupt and save current state of the interrupt flags
Int32U save = __get_interrupt_state();
  __disable_interrupt();
  USBDEVINTCLR = bmUSB_CommDataFullInterrupt;
  USBEPINTCLR = 1 << EndPoint;
  while ((USBDEVINTST & bmUSB_CommDataFullInterrupt) == 0)
  {
    if(!--TO)
    {
      break;
    }
  }
  __set_interrupt_state(save);
  return(USBCMDDATA);
}

/*************************************************************************
 * Function Name: USB_Init
 * Parameters: Int32U IntrSlot,
 *
 * Return: none
 *
 * Description: Init USB
 *
 *************************************************************************/
void USB_Init(Int32U IntrSlot, CommUserFpnt_t UserCoreConfigure)
{
  // Init variables
  UsbEp0Ctrl.EpStatus.Status = UsbSetupPhase;
  UsbCoreT9Fun = NULL;
  USB_UserFuncRegistering(UserCoreConfigure,UsbUserConfigure);
  EpPriority = 0;

  // Turn on USB
  PCONP_bit.PCUSB = 1;

#ifdef USB1_ERRATA
  // Errata 2006 Nov 16
  // USB_NEED_CLK is always asserted
  //  Introduction:The USB_NEED_CLK signal is used to facilitate going into and
  // waking up from chip Power Down mode. USB_NEED_CLK is asserted if any of the
  // bits of the USBClkSt register are asserted.
  //  Problem:The USB_NEED_CLK bit of the USBIntSt register (located at 0xE01F C1C0)
  // is always asserted, preventing the chip from entering Power Down mode when
  // the USBWAKE bit is set in the INTWAKE register (located at 0xE01F C144).
  //  Workaround:After setting the PCUSB bit in PCONP (located at 0xE01F C0C4),
  // write 0x1 to address 0xFFE0C008. The USB_NEED_CLK signal will now function correct
  if(RSIR_bit.POR == 1)
  {
    RSIR_bit.POR = 1;
    *(volatile unsigned int *)0xFFE0C008 = 1;
  }
#endif // USB1_ERRATA

  // Init USB engine clk freq - 48MHz
  // 1/3 Fpll - 48 MHz
  USBCLKCFG = USB_CLK_DIV-1;

  USBCLKCTRL = (1<<1) |   // Device clk enable
               (1<<3) |   // Port select clk enable
               (1<<2) |   // I2C clk enable
               (1<<4);    // AHB clk enable

  while((USBCLKST & ((1<<1) | (1<<3) | (1<<4))) != ((1<<1) | (1<<3) | (1<<4)));
  // USB IO assign
#if (USB_PORT_SEL==1)
  // Assign P0.29 to U1+, P0.30 to U1-
  PINSEL1_bit.P0_29  = 1;
  PINSEL1_bit.P0_30  = 1;

  // Enable Link LED, Connect, Vbus sense
  // and disable Pull Up/Down resistor of the Vbus pin
  PINSEL3_bit.P1_18  = 1;

  // Init OTG I2C
  PINSEL3_bit.P1_28  = 1;
  PINSEL3_bit.P1_29  = 1;

  // USB Port select
  USBPORTSEL_bit.PORTSEL = 0;

  USBCLKCTRL = (1<<1) |   // Device clk enable
               (1<<2) |   // I2C clk enable
               (1<<4);    // AHB clk enable

#else
  // Assign P0.31 to U2+
  PINSEL1_bit.P0_31  = 1;
  // Enable Link LED, Connect, Vbus sense
  // and disable Pull Up/Down resistor of the Vbus pin
  PINSEL0_bit.P0_13  = 1;

#ifdef USB3_ERRATA
  FIO0DIR_bit.P1_30  = 0;
  PINSEL3_bit.P1_30  = 0;
#else
  PINSEL3_bit.P1_30  = 2;
#endif // USB3_ERRATA
  PINMODE3_bit.P1_30 = 3;

  // USB Port select
  USBPORTSEL_bit.PORTSEL = 3;

  USBCLKCTRL = (1<<1) |   // Device clk enable
               (1<<4);    // AHB clk enable

#endif // (USB_PORT_SEL==1)

  // Disable USB interrupts
  USBINTS_bit.EN_USB_INTS = 0;

  // Clear all interrupts flags
  USBEPINTCLR = USBDEVINTCLR = 0xFFFFFFFF;

  // USB interrupt enable
  VIC_SetVectoredIRQ(USB_ISR,IntrSlot,VIC_USB);
  VICINTENABLE |= (1<<VIC_USB);

  // Disconnect device
  USB_ConnectRes(FALSE);

  // Set address 0
  USB_SetDefAdd();

  // Init controls endpoints
  USB_HwReset();

  // Init Device status
  UsbSetDevState(UsbDevStatusUnknow);

  // Enable USB interrupts
  USBINTS_bit.EN_USB_INTS = 1;

  // Init Device state var
  USB_DevStatus.Data = USB_Cmd(CMD_USB_GET_DEV_STAT,0);
}

/*************************************************************************
 * Function Name: USB_HwReset
 * Parameters: none
 *
 * Return: none
 *
 * Description: Reset Usb engine
 *
 *************************************************************************/
static
void USB_HwReset (void)
{

  // Disable all endpoint interrupts
  USBEPINTEN = 0;
  // Clear all EP interrupts flags
  USBEPINTCLR  = 0xFFFFFFFF;
  // Clear EP_SLOW, EP_FAST, FRAME interrupts flags
  USBDEVINTCLR = 0x7;
  // All endpoints interrupts are routed to LOW_PRIORITY interrupt
  EpPriority = USBEPINTPRI = 0;
  // USB_Configure
  USB_Configure(FALSE);

  // Control EP Init
  USB_UserFuncRegistering((UserFunc_t)UsbCtrlEp,UsbEp0Out);
  USB_UserFuncRegistering((UserFunc_t)UsbCtrlEp,UsbEp0In);
  USB_RealizeEp(CTRL_ENP_OUT,0,Ep0MaxSize,TRUE);

#if USB_DMA > 0
  // Enable End_of_Transfer_Interrupt and
  // System_Error_Interrupt USB DMA interrupts
	USB_DmaReset(DMA_INT_ENABLE_MASK);
#else
  // Disable the DMA operation
  USBEPDMADIS = 0xFFFFFFFF;
#endif

  // Assign high priority interrupt line
  USBDEVINTPRI = (USB_HIGH_PRIORITY_EVENT > 0)?
                  ((USB_HIGH_PRIORITY_EP  > 0)?bmUSB_HP_FastEp:bmUSB_HP_Frame):
                    0;

  // Enable Device interrupts
  USBDEVINTEN = bmUSB_SlowInterrupt | bmUSB_DevStatusInterrupt |
               (USB_SOF_EVENT   ? bmUSB_FrameInterrupt : 0)    |
               (USB_ERROR_EVENT ? bmUSB_ErrorInterrupt : 0)    |
              ((USB_FAST_EP || USB_HIGH_PRIORITY_EP)? bmUSB_FastInterrupt  : 0);
}

/*************************************************************************
 * Function Name: USB_RealizeEp
 * Parameters: USB_Endpoint_t EndPoint, Boolean FastIntr,
 *             Int32U MaxPacketSize, Boolean IntrEna
 *
 * Return: USB_ErrorCodes_t
 *
 * Description: Enable or disable endpoint
 *
 *************************************************************************/
USB_ErrorCodes_t USB_RealizeEp(USB_Endpoint_t EndPoint, Boolean FastIntr,
                               Int32U MaxPacketSize, Boolean IntrEna)
{
Int32U Mask = (1 << EndPoint);
  assert(!(((USB_FAST_EP == 0) && (USB_HIGH_PRIORITY_EP == 0)) && FastIntr));
  if (MaxPacketSize)
  {
    // Realize both directions of control EP
    if((EndPoint == CTRL_ENP_OUT) || (EndPoint == CTRL_ENP_IN))
    {
      // Output dir
      Mask = 1;
      EndPoint = CTRL_ENP_OUT;
      // Clear  Realize interrupt bit
      USBDEVINTCLR = bmUSB_EPRealizeInterrupt;
      // Realize endpoint
      USBREEP |= Mask;
      // Set endpoint maximum packet size
      USBEPIN     = EndPoint;
      USBMAXPSIZE = MaxPacketSize;
      // Wait for Realize complete
      while ((USBDEVINTST & bmUSB_EPRealizeInterrupt) == 0);
      // Assign EP interrupt line HP/LP
#if (USB_FAST_EP > 0) || (USB_HIGH_PRIORITY_EP > 0)
      if(FastIntr)
      {
        EpPriority |= Mask;
      }
      else
      {
        EpPriority &= ~Mask;
      }
#else
        EpPriority &= ~Mask;
#endif // (USB_FAST_EP > 0) || (USB_HIGH_PRIORITY_EP > 0)
      // Init EP max packet size
      EpInfo[EndPoint].MaxSize = MaxPacketSize;
      if(IntrEna)
      {
        // Enable endpoint interrupt
        USBEPINTEN |= Mask;
      }
      else
      {
        // Disable endpoint interrupt
        USBEPINTEN &=~Mask;
      }
      // input dir
      Mask = 2;
      EndPoint = CTRL_ENP_IN;
    }
    // Clear  Realize interrupt bit
    USBDEVINTCLR = bmUSB_EPRealizeInterrupt;
    // Realize endpoint
    USBREEP  |= Mask;
    // Set endpoint maximum packet size
    USBEPIN     = EndPoint;
    USBMAXPSIZE = MaxPacketSize;
    // Wait for Realize complete
    while ((USBDEVINTST & bmUSB_EPRealizeInterrupt) == 0);
    // Assign EP interrupt line HP/LP
#if (USB_FAST_EP > 0) || (USB_HIGH_PRIORITY_EP > 0)
    if(FastIntr)
    {
      EpPriority |= Mask;
    }
    else
    {
      EpPriority &= ~Mask;
    }
#else
      EpPriority &= ~Mask;
#endif // (USB_FAST_EP > 0) || (USB_HIGH_PRIORITY_EP > 0)
    // Init EP max packet size
    EpInfo[EndPoint].MaxSize = MaxPacketSize;
    if(IntrEna)
    {
      // Enable endpoint interrupt
      USBEPINTEN |= Mask;
    }
    else
    {
      // Disable endpoint interrupt
      USBEPINTEN &=~Mask;
    }
  }
  else
  {
    if((EndPoint == CTRL_ENP_OUT) || (EndPoint == CTRL_ENP_IN))
    {
      Mask = 0x3;
      // Reset EP max packet size
      EpInfo[0].MaxSize = 0;
      EndPoint = CTRL_ENP_IN;
    }
    Mask =~ Mask;
    // Disable relevant endpoint and interrupt
    USBREEP &= Mask;
    USBEPINTEN &= Mask;
    // Reset EP max packet size
    EpInfo[EndPoint].MaxSize = 0;
  }

  USBEPINTPRI = EpPriority;
  return(USB_OK);
}

/*************************************************************************
 * Function Name: USB_SetAdd
 * Parameters: Int32U DevAdd - device address between 0 - 127
 *
 * Return: none
 *
 * Description: Set device address
 *
 *************************************************************************/
static
void USB_SetAdd(Int32U DevAdd)
{
  USB_Cmd(CMD_USB_SET_ADDRESS,DevAdd | 0x80);
  USB_Cmd(CMD_USB_SET_ADDRESS,DevAdd | 0x80);
}

/*************************************************************************
 * Function Name: USB_ConnectRes
 * Parameters: Boolean Conn
 *
 * Return: none
 *
 * Description: Enable Pull-Up resistor
 *
 *************************************************************************/
void USB_ConnectRes (Boolean Conn)
{
	
	

  USB_Cmd(CMD_USB_SET_DEV_STAT, (Conn ? bmUSB_Connect : 0));

#if (USB_PORT_SEL==1)

  PINSEL3_bit.P1_19 = 0;
  FIO1DIR_bit.P1_19 = 1;
  FIO1CLR_bit.P1_19 = 1;
#else
  #ifdef USB2_ERRATA
  FIO0PIN_bit.P0_14 = !Conn;
  #endif // USB2_ERRATA
#endif // (USB_PORT_SEL==1)
}

/*************************************************************************
 * Function Name: USB_Configure
 * Parameters: Boolean Configure
 *
 * Return: none
 *
 * Description: Configure device
 *  When Configure != 0 enable all Realize EP
 *
 *************************************************************************/
static
void USB_Configure (Boolean Configure)
{
  USB_Cmd(CMD_USB_CFG_DEV,Configure);
}

#if USB_REMOTE_WAKEUP != 0
/*************************************************************************
 * Function Name: USB_Wake-up
 * Parameters: none
 *
 * Return: none
 *
 * Description: Wake up Usb
 *
 *************************************************************************/
static
void USB_WakeUp (void)
{
  USBCLKCTRL = (1<<1) |   // Device clk enable
               (1<<4);    // AHB clk enable

  while((USBCLKST & ((1<<1) | (1<<4))) != ((1<<1) | (1<<4)));
  USB_Cmd(CMD_USB_SET_DEV_STAT,bmUSB_Connect);
}
#endif // USB_REMOTE_WAKEUP != 0

/*************************************************************************
 * Function Name: USB_GetDevStatus
 * Parameters: USB_DevStatusReqType_t Type
 *
 * Return: Boolean
 *
 * Description: Return USB device status
 *
 *************************************************************************/
Boolean USB_GetDevStatus (USB_DevStatusReqType_t Type)
{
  switch (Type)
  {
  case USB_DevConnectStatus:
    return(USB_DevStatus.Connect);
  case USB_SuspendStatus:
    return(USB_DevStatus.Suspend);
  case USB_ResetStatus:
    return(USB_DevStatus.Reset);
  }
  return(FALSE);
}

/*************************************************************************
 * Function Name: USB_SetStallEP
 * Parameters: USB_Endpoint_t EndPoint, Boolean Stall
 *
 * Return: none
 *
 * Description: The endpoint stall/unstall
 *
 *************************************************************************/
void USB_SetStallEP (USB_Endpoint_t EndPoint, Boolean Stall)
{
Boolean CurrStallStatus;
  assert((USBREEP & (1UL<<EndPoint)));  // check whether is a realized EP
  USB_GetStallEP(EndPoint,&CurrStallStatus);
  if(CurrStallStatus != Stall)
  {
    USB_Cmd(CMD_USB_SET_EP_STAT | EndPoint, (Stall ? bmUSB_EpStall : 0));
  }
}

/*************************************************************************
 * Function Name: USB_GetStallEP
 * Parameters: USB_Endpoint_t EndPoint, pBoolean pStall
 *
 * Return: none
 *
 * Description: Get stall state of the endpoint
 *
 *************************************************************************/
static
void USB_GetStallEP (USB_Endpoint_t EndPoint, pBoolean pStall)
{
  assert((USBREEP & (1UL<<EndPoint)));  // check whether is a realized EP
  *pStall = (USB_Cmd(CMD_USB_SEL_EP | EndPoint, 0) & bmUSB_EpStallStatus) != 0;
}

/*************************************************************************
 * Function Name: USB_EpValidate
 * Parameters: USB_Endpoint_t EndPoint
 *
 * Return: USB_ErrorCodes_t
 *
 * Description: Validate/Clear EP buffer
 *
 *************************************************************************/
USB_ErrorCodes_t USB_EpValidate(USB_Endpoint_t EndPoint)
{
  assert((USBREEP & (1UL<<EndPoint)));  // check whether is a realized EP
  if(EndPoint & 1)
  {
    // IN EP (Tx)
    // Validate buffer
    USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);
    USB_Cmd(CMD_USB_VAL_BUF,0);
  }
  else
  {
    // OUT EP (Rx)
    // Select endpoint
    USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);
    // Clear selected end point
    if(USB_Cmd(CMD_USB_CLR_BUF,0) & 1)
    {
      return(UB_EP_SETUP_OVERWRITE);
    }
  }
  return(USB_OK);
}

/*************************************************************************
 * Function Name: USB_EpWrite
 * Parameters: USB_Endpoint_t EndPoint,
 *             const unsigned char *pData, pInt32U pCount
 *
 * Return: USB_ErrorCodes_t
 *
 * Description: Endpoint Write (IN)
 *
 *************************************************************************/
USB_ErrorCodes_t USB_EpWrite (USB_Endpoint_t EndPoint,
                              const unsigned char *pData, pInt32U pCount)
{
Int32U Data, Status, ActSize, Count, CurrSize, SizeHold;

  assert((USBREEP & (1UL<<EndPoint)));  // check whether is a realized EP

  SizeHold = 0;
  ActSize = *pCount;
  *pCount = 0;

  do
  {
    // Get EP Status
    Status = USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);
    // Check EP state Stalled/Unstalled
    if(Status & bmUSB_ST)
    {
      // EP stalled
      return(USB_EP_STALLED);
    }

    // Check Buffers state Full/Empty
    if(Status & bmUSB_FE)
    {
      //  Buffer/s are full
      break;
    }

    // Get smaller of the rest of the user buffer and the received data.
    CurrSize = MIN(EpInfo[EndPoint].MaxSize,(ActSize-SizeHold));

    // Convert EP physical address to logical and set write enable bit
    USBCTRL = ((EndPoint << 1) & 0x3C) | bmUSB_CtrlWrEna;

    // Set data size
    USBTXPLEN = CurrSize;
    if(CurrSize == 0)
    {
      TDATA = 0;
    }
    else
    {
      for (Count = 0; Count < CurrSize; ++Count)
      {
        Data  = *pData++;
        if (++Count < CurrSize) // fix overwrite problem
        {
          Data |= (*pData++) << 8;
          if (++Count < CurrSize)
          {
            Data |= (*pData++) << 16;
            if (++Count < CurrSize)
            {
              Data |= (*pData++) << 24;
            }
          }
        }
        TDATA = Data;
      }
    }

    USBCTRL = 0;
    SizeHold += CurrSize;
    // Clear for pending TX interrupt
    USB_EpIntrClr(EndPoint);
    USB_EpValidate(EndPoint);
  }
  while(SizeHold < ActSize);

  *pCount = SizeHold;
  return(USB_OK);
}

/*************************************************************************
 * Function Name: USB_EpRead
 * Parameters: USB_Endpoint_t EndPoint, pInt8U pData, pInt32U pCount
 *
 * Return: USB_ErrorCodes_t
 *
 * Description: Endpoint Read (OUT)
 *
 *************************************************************************/
USB_ErrorCodes_t USB_EpRead (USB_Endpoint_t EndPoint, pInt8U pData,
                             pInt32U pCount)
{
Int32U Data, Status, ActSize, Count, CurrSize, EpCount, SizeHold;

  assert((USBREEP & (1UL<<EndPoint)));  // check whether is a realized EP

  SizeHold = 0;
  ActSize = *pCount;
  *pCount = 0;

  do
  {
    // Get EP Status
    Status = USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);

    // Check EP state Stalled/Unstalled
    if(Status & bmUSB_ST)
    {
      // EP stalled
      return(USB_EP_STALLED);
    }

    // Check Buffers state Full/Empty
    if(!(Status & bmUSB_FE))
    {
      //  Buffers are empty
      break;
    }

    // Convert EP physical address to logical and set read enable bit
    USBCTRL = ((EndPoint << 1) & 0x3C) | bmUSB_CtrlRdEna;
    while (USBRXPLEN_bit.PKT_RDY == 0);

    // Get data size
    EpCount = USBRXPLEN_bit.PKT_LNGTH;

    // Get smaller of the rest of the user buffer and the received data.
    CurrSize = MIN(EpCount,EpInfo[EndPoint].MaxSize);

    SizeHold += CurrSize;
    if(CurrSize == 0)
    {
      volatile int Dummy = USBRXDATA;
    }
    else
    {
      // the buffer size must be enough bigger to get all available data from
      // the EP in other case remaining data may be lost
      if(EpInfo[EndPoint].MaxSize <= (ActSize-SizeHold))
      {
        *pCount = SizeHold;
        return (USB_BUF_OVERFLOW);
      }

      for(Count = 0; Count < CurrSize; ++Count)
      {
        Data = USBRXDATA;
        *pData++ = Data;
        if(++Count < CurrSize) // fix overwrite problem
        {
          *pData++ = Data >> 8;
          if(++Count < CurrSize)
          {
            *pData++ = Data >> 16;
            if(++Count < CurrSize)
            {
              *pData++ = Data >> 24;
            }
          }
        }
      }
    }

    USBCTRL = 0;
    if(UsbEpDoubleBuffType[EndPoint])
    {
      if(EpInfo[EndPoint].MaxSize <= (ActSize - SizeHold))
      {
        // clear pending interrupt when "user" buffer is not full
        // and can receive more data if is available
        USB_EpIntrClr(EndPoint);
        USB_EpValidate(EndPoint);
      }
      else
      {
        USB_EpValidate(EndPoint);
        // rest of the "user" buffer size isn't enough bigger
        // to get MAXIMUM EP size
        break;
      }
    }
    else
    {
      break;
    }
  } while(SizeHold < ActSize);

  *pCount = SizeHold;
  if(Status & bmUSB_STP)
  {
    return (UB_EP_SETUP_OVERWRITE);
  }
  return (USB_OK);
}

/*************************************************************************
 * Function Name: USB_EpLogToPhysAdd
 * Parameters: Int8U EpLogAdd
 *
 * Return: USB_Endpoint_t
 *
 * Description: Convert the logical to physical address
 *
 *************************************************************************/
USB_Endpoint_t USB_EpLogToPhysAdd (Int8U EpLogAdd)
{
USB_Endpoint_t Address = (USB_Endpoint_t)((EpLogAdd & 0x0F)<<1);
  if(EpLogAdd & 0x80)
  {
    ++Address;
  }
  return(Address);
}

#if USB_SOF_EVENT > 0
/*************************************************************************
 * Function Name: USB_GetFrameNumb
 * Parameters: none
 *
 * Return: Int32U
 *
 * Description: Return current value of SOF number
 *
 *************************************************************************/
Int32U USB_GetFrameNumb (void)
{
  return(USB_Cmd(CMD_USB_RD_FRAME_NUMB,0));
}
#endif // USB_SOF_EVENT > 0

/*************************************************************************
 * Function Name: USB_ISR
 * Parameters: none
 *
 * Return: none
 *
 * Description: USB interrupt subroutine
 *
 *************************************************************************/
static void USB_ISR (void)
{
Int32U EpIntr, i, Mask, Status;

usb_intr_loop:

#if USB_HIGH_PRIORITY_EVENT > 0
  if(USBINTS_bit.USB_INT_REQ_HP)
  {
  #if (USB_HIGH_PRIORITY_EP == 0)
    // Frame interrupt
    if(USBDEVINTST_bit.FRAME)
    {
      USBDEVINTCLR = bmUSB_FrameInterrupt;
      if(UsbUserFun[UsbUserSofEvent] != NULL)
      {
        UsbUserFun[UsbUserSofEvent]((void *)0);
      }
    }
  #else // (USB_HIGH_PRIORITY_EP == 0)
    while(USBDEVINTST_bit.EP_FAST)
    {
      // Get EPs interrupt flag
      EpIntr  = USBEPINTST;
      // Mask with EPs interrupt enable flag
      EpIntr &= USBEPINTEN;
      // Mask with EPs high priority interrupt flag
      EpIntr &= EpPriority;

      // Processing EP interrupt
      for(i = 0, Mask = 1; EpIntr; ++i, Mask <<= 1)
      {
        if(EpIntr & Mask)
        {
          Status = USB_EpIntrClr((USB_Endpoint_t)i);
          if(UsbUserFun[i] != NULL)
          {
            if(Status & bmUSB_EpSetupPacket)
            {
              UsbUserFun[i]((void *)UsbSetupPacket);
            }
            else
            {
              UsbUserFun[i]((void *)((i & 1)?UsbDataInPacket:UsbDataOutPacket));
            }
          }
          EpIntr &= ~Mask;
        }
      }
      // Clear Fast EP interrupt
      USBDEVINTCLR = bmUSB_FastInterrupt;
    }
  #endif // (USB_HIGH_PRIORITY_EP == 0)
  }
#endif // USB_HIGH_PRIORITY_EVENT > 0

	if (USBINTS_bit.USB_INT_REQ_LP)
	{
	
	#if USB_ERROR_EVENT > 0
	  // USB engine error interrupt
	  if(USBDEVINTST_bit.ERR_INT)
	  {
	    USBDEVINTCLR = bmUSB_ErrorInterrupt;
	    Status = USB_Cmd(CMD_USB_RD_ERROR_STAT,0);
	    if(UsbUserFun[UsbUserErrorEvent] != NULL)
	    {
	      UsbUserFun[UsbUserErrorEvent]((void *)Status);
	    }
	  }
	#endif
	
	#if ((USB_SOF_EVENT > 0) && \
      ((USB_HIGH_PRIORITY_EP == 0) || (USB_HIGH_PRIORITY_EP > 0)))
	  // Frame interrupt
	  if(USBDEVINTST_bit.FRAME)
	  {
	    USBDEVINTCLR = bmUSB_FrameInterrupt;
	    if(UsbUserFun[UsbUserSofEvent] != NULL)
	    {
	      UsbUserFun[UsbUserSofEvent]((void *)0);
	    }
	  }
	#endif // ((USB_SOF_EVENT > 0) && \
            ((USB_HIGH_PRIORITY_EP == 0) || (USB_HIGH_PRIORITY_EP > 0)))

	  // Device Status interrupt
	  if(USBDEVINTST_bit.DEV_STAT)
	  {
	    // Clear Device status interrupt
	    USBDEVINTCLR = bmUSB_DevStatusInterrupt;
	    // Get device status
	    USB_DevStatus.Data = USB_Cmd(CMD_USB_GET_DEV_STAT,0);
	    // Device connection status
	    if(USB_DevStatus.ConnectChange)
	    {
        UsbDevConnectCallback(USB_DevStatus.Connect);
	      if(UsbUserFun[UsbUserConnect] != NULL)
	      {
	        UsbUserFun[UsbUserConnect]((void *)USB_DevStatus.Connect);
	      }
	    }
	    // Device suspend status
	    if(USB_DevStatus.SuspendChange)
	    {
        UsbDevSuspendCallback(USB_DevStatus.Suspend);
	      if(UsbUserFun[UsbUserSuspend] != NULL)
	      {
	        UsbUserFun[UsbUserSuspend]((void *)USB_DevStatus.Suspend);
	      }
	    }
	    // Device reset
	    if(USB_DevStatus.Reset)
	    {
	      USB_HwReset();
        UsbDevResetCallback();
	      if(UsbUserFun[UsbUserReset] != NULL)
	      {
	        UsbUserFun[UsbUserReset](NULL);
	      }
	    }
	  }

  #if (USB_FAST_EP > 0)
	  // Fast EP interrupt
    while(USBDEVINTST_bit.EP_FAST)
    {
      // Check for pending high priority or fast EP interrupts
      if((USBINTS_bit.USB_INT_REQ_HP && USB_HIGH_PRIORITY_EVENT))
      {
        goto usb_intr_loop;
      }

      // Get EPs interrupt flag
      EpIntr  = USBEPINTST;
      // Mask with EPs interrupt enable flag
      EpIntr &= USBEPINTEN;
      // Mask with EPs high priority interrupt flag
      EpIntr &= EpPriority;

      // Processing EP interrupt
      for(i = 0, Mask = 1; EpIntr; ++i, Mask <<= 1)
      {
        if(EpIntr & Mask)
        {
          Status = USB_EpIntrClr((USB_Endpoint_t)i);
          if(UsbUserFun[i] != NULL)
          {
            if(Status & bmUSB_EpSetupPacket)
            {
              UsbUserFun[i]((void *)UsbSetupPacket);
            }
            else
            {
              UsbUserFun[i]((void *)((i & 1)?UsbDataInPacket:UsbDataOutPacket));
            }
          }
          EpIntr &= ~Mask;
          break;
        }
      }
      // Clear Fast EP interrupt
      USBDEVINTCLR = bmUSB_FastInterrupt;
    }
	#endif // (USB_FAST_EP > 0)

	  // Slow EP interrupt
    while(USBDEVINTST_bit.EP_SLOW)
    {
      // Check for pending high priority or fast EP interrupts
      if((USBINTS_bit.USB_INT_REQ_HP && USB_HIGH_PRIORITY_EVENT) ||
         (USBDEVINTST_bit.EP_FAST && USB_FAST_EP))
      {
        goto usb_intr_loop;
      }

      // Get EPs interrupt flag
      EpIntr  = USBEPINTST;
      // Mask with EPs interrupt enable flag
      EpIntr &= USBEPINTEN;

      // Processing EP interrupt
      for(i = 0, Mask = 1; EpIntr; ++i, Mask <<= 1)
      {
        if(EpIntr & Mask)
        {
          Status = USB_EpIntrClr((USB_Endpoint_t)i);
          if(UsbUserFun[i] != NULL)
          {
            if(Status & bmUSB_EpSetupPacket)
            {
              UsbUserFun[i]((void *)UsbSetupPacket);
            }
            else
            {
              UsbUserFun[i]((void *)((i & 1)?UsbDataInPacket:UsbDataOutPacket));
            }
          }
          EpIntr &= ~Mask;
          break;
        }
      }
      // Clear Slow EP interrupt
      USBDEVINTCLR = bmUSB_SlowInterrupt;
    }
	}

#if USB_DMA > 0
	if (USBINTS_bit.USB_INT_REQ_DMA)
	{
    Int32U UsbDmaInt = 0,Tmp;
    Tmp = USBEOTINTST;
    if(USBDMAINTEN & 1)
    {
      UsbDmaInt |= Tmp;
    }
    USBEOTINTCLR = Tmp;
    Tmp = USBNDDRINTST;
    if(USBDMAINTEN & 2)
    {
      UsbDmaInt |= Tmp;
    }
    USBNDDRINTCLR = Tmp;
    Tmp = USBSYSERRINTST;
    if(USBDMAINTEN & 4)
    {
      UsbDmaInt |= Tmp;
    }
    USBSYSERRINTCLR = Tmp;

    // Process EPs
    EpIntr = UsbDmaInt;

    // Processing all endpoints without ctrl EP_In, ctrl EP_Out
    for(i = 2, Mask = 4; EpIntr; ++i, Mask <<= 1)
    {
      if(EpIntr & Mask)
      {
        if(UsbUserFun[i] != NULL)
        {
          UsbUserFun[i]((void *)UsbDmaPacket);
        }
        EpIntr &= ~Mask;
      }
    }
	}
#endif

  VICADDRESS = 0;    // Clear interrupt in VIC.
}

/*************************************************************************
 *                          U S B   D M A  P a r t                       *
 *************************************************************************/

#if USB_DMA > 0
#pragma segment="USB_DMA_RAM"
#pragma location="USB_DMA_RAM"
#pragma data_alignment=128
__no_init pUSB_DmaDesc_t USB_DDCA[ENP_MAX_NUMB];

#pragma location="USB_DMA_RAM"
__no_init USB_DmaDesc_t USB_DmaDesc[DMA_DD_MAX_NUMB];

/*************************************************************************
 * Function Name: USB_DmaReset
 * Parameters:  Int32U IntrEna
 *
 * Return: none
 *
 * Description: Reset USB DMA
 *
 *************************************************************************/
void USB_DmaReset (Int32U IntrEna)
{
  // Disable All DMA interrupts
  USBDMAINTEN     = 0;
  // DMA Disable
  USBEPDMADIS     = 0xFFFFFFFF;
  // DMA Request clear
  USBDMARCLR      = 0xFFFFFFFF;
  // End of Transfer Interrupt Clear
  USBEOTINTCLR    = 0xFFFFFFFF;
  // New DD Request Interrupt Clear
  USBNDDRINTCLR   = 0xFFFFFFFF;
  // System Error Interrupt Clear
  USBSYSERRINTCLR = 0xFFFFFFFF;
	for(Int32U i = 0; i < ENP_MAX_NUMB; ++i)
  {
    USB_DDCA[i] = NULL;
  }
  // Set USB UDCA Head register
  USBUDCAH = (Int32U)&USB_DDCA;
  // Enable DMA interrupts
  USBDMAINTEN = IntrEna;
}

/*************************************************************************
 * Function Name: USB_DmaInitTransfer
 * Parameters: USB_Endpoint_t EndPoint, Int32U DmaDescInd,
 *             pInt32U pData, Int32U EpMaxSize, Int32U Size
 *             pDmaIsoPacket_t pDmaIsoPacket,  Boolean EpTransferType
 *
 * Return: UsbDmaStateCode_t
 *
 * Description: Init Transfer by DMA
 *
 *************************************************************************/
UsbDmaStateCode_t USB_DmaInitTransfer (USB_Endpoint_t EndPoint,
          Int32U DmaDescInd, pInt32U pData, Int32U EpMaxSize, Int32U Size,
          pDmaIsoPacket_t pDmaIsoPacket, Boolean EpTransferType)
{
Int32U EpReg;

  if ((EndPoint == CTRL_ENP_OUT) || (EndPoint == CTRL_ENP_IN))
  {
    return(UsbDmaParametersError);
  }
  if (USB_DmaDesc[DmaDescInd].Status == UsbDmaBeingServiced)
  {
    return(UsbDmaBeingServiced);
  }

  // Init DMA Descriptor
  USB_DmaDesc[DmaDescInd].pNextDD        = NULL;
  USB_DmaDesc[DmaDescInd].NextDDValid    = FALSE;
  USB_DmaDesc[DmaDescInd].pDmaIsoPacket  = pDmaIsoPacket;
  USB_DmaDesc[DmaDescInd].DmaMode        = UsbDmaNormalMode;
  USB_DmaDesc[DmaDescInd].Isochronous    = EpTransferType;
  USB_DmaDesc[DmaDescInd].pDmaBuffer     = pData;
  USB_DmaDesc[DmaDescInd].DmaBufferLegtn = Size;
  USB_DmaDesc[DmaDescInd].MaxPacketSize  = EpMaxSize;
  USB_DmaDesc[DmaDescInd].Status         = UsbDmaNoServiced;

  // Set DD
  USB_DDCA[EndPoint] = &USB_DmaDesc[DmaDescInd];

  // Enable DMA Transfer
  USBEPDMAEN = 1 << EndPoint;

  // Check state of IN/OUT EP buffer
  EpReg = USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);

  if(!EpTransferType &&
      (((EndPoint & 1) && !(EpReg & 0x60)) ||
       (!(EndPoint & 1) && ((EpReg & 0x60) == 0x60))))
  {
    if((USB_DmaDesc[DmaDescInd].DdState != UsbDmaBeingServiced))
    {
      // Retrigger DMA Transfer
      USBDMARSET = 1 << EndPoint;
    }
  }

  return(UsbDmaNoServiced);
}

/*************************************************************************
 * Function Name: USB_DmaGetDesc
 * Parameters: Int32U DmaDescInd
 *
 * Return: pUSB_DmaDesc_t
 *
 * Description: Return pointer to DMA descriptor
 *
 *************************************************************************/
pUSB_DmaDesc_t USB_DmaGetDesc (Int32U DmaDescInd)
{
  return(&USB_DmaDesc[DmaDescInd]);
}

/*************************************************************************
 * Function Name: USB_DmaDisable
 * Parameters: USB_Endpoint_t EndPoint
 *
 * Return: none
 *
 * Description: Disable DMA transfer for the EP
 *
 *************************************************************************/
void USB_DmaDisable (USB_Endpoint_t EndPoint)
{
  USBEPDMADIS = 1 << EndPoint;
}

/*************************************************************************
 * Function Name: USB_DmaRestartTransfer
 * Parameters: USB_Endpoint_t EndPoint, Int32U DmaDescInd,
 *             pInt32U pData, Int32U EpMaxSize, Int32U Size
 *             pDmaIsoPacket_t pDmaIsoPacket,  Boolean EpTransferType
 *
 * Return: none
 *
 * Description: Restart DMA Transfer
 *
 *************************************************************************/
void USB_DmaRestartTransfer (USB_Endpoint_t EndPoint,Int32U DmaDescInd)
{
  // Init DD DMA status
  USB_DmaDesc[DmaDescInd].Status = UsbDmaNoServiced;
  // Enable DMA Transfer
  USBEPDMAEN = 1 << EndPoint;
  if(USB_DmaDesc[DmaDescInd].Isochronous)
  {
    return;
  }
  // Check state of IN/OUT EP buffer
  Int32U EpReg = USB_Cmd(CMD_USB_SEL_EP | EndPoint,0);
  if(!(EndPoint & 1) && ((EpReg & 0x60) == 0x60))
  {
    // Retrigger DMA Transfer
    USBDMARSET = 1 << EndPoint;
  }
  else if ((EndPoint & 1) && !(EpReg & 0x60))
  {
    // Retrigger DMA Transfer
    USBDMARSET = 1 << EndPoint;   // А защо е така кой ще ми каже????
  }
}

#endif // USB_DMA

/*************************************************************************
 * Function Name: UsbCtrlEp
 * Parameters:  void * pArg
 *
 * Return: none
 *
 * Description: USB Ctrl EP Callback
 *
 *************************************************************************/
static inline
void UsbCtrlEp (USB_PacketType_t Packet)
{
Int32U CurrCount;

  if(Packet == UsbSetupPacket)
  {
    // Setup packet
    UsbEp0Ctrl.EpStatus.Status = UsbSetupPhase;

    UsbEp0Ctrl.pData   = EpCtrlDataBuf;
    UsbEp0Ctrl.Counter = Ep0MaxSize;
    USB_EpRead(CTRL_ENP_OUT,EpCtrlDataBuf,&UsbEp0Ctrl.Counter);

    // Copy new setup packet int setup buffer
    memcpy((Int8U *)&UsbEp0SetupPacket,EpCtrlDataBuf,sizeof(UsbEp0SetupPacket));

    if(UsbEp0Ctrl.Counter != sizeof(UsbSetupPacket_t))
    {
      UsbEp0SetupPacket.mRequestType.Type = UsbTypeReserved;
    }
    else
    {
      // validate OUT/IN EP
      if(USB_EpValidate(CTRL_ENP_OUT) == UB_EP_SETUP_OVERWRITE)
      {
        return;
      }
      USB_SetStallEP(CTRL_ENP_IN,FALSE);
    }

    switch(UsbEp0SetupPacket.mRequestType.Type)
    {
    // Standard
    case UsbTypeStandart:
      // Decoding standard request
      switch (UsbEp0SetupPacket.bRequest)
      {
      case GET_STATUS:
        UsbGetStatus();
        break;
      case CLEAR_FEATURE:
        UsbClearFeature();
        break;
      case SET_FEATURE:
        UsbSetFeature();
        break;
      case SET_ADDRESS:
        UsbSetAddress();
        break;
      case GET_DESCRIPTOR:
        if(UsbEp0SetupPacket.mRequestType.Recipient == UsbRecipientDevice)
        {
          UsbGetDescriptor();
        }
        // Only get descriptor for device is standard request
        else if ((UsbEp0SetupPacket.mRequestType.Dir == UsbDevice2Host) &&
                 (UsbUserFun[UsbUserGetDescriptor] != NULL) &&
                 ((Int32U)UsbUserFun[UsbUserGetDescriptor](&UsbEp0Ctrl) == UsbPass))
        {
          if(UsbEp0Ctrl.Counter >= UsbEp0SetupPacket.wLength.Word)
          {
            UsbEp0Ctrl.Counter = UsbEp0SetupPacket.wLength.Word;
            UsbEp0Ctrl.EpStatus.NoZeroLength = TRUE;
          }
          else
          {
            UsbEp0Ctrl.EpStatus.NoZeroLength = FALSE;
          }
          UsbEp0Ctrl.EpStatus.Status = UsbDataPhase;
        }
        else
        {
          UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
        }
        break;
      case SET_DESCRIPTOR:
        // Optional (only for configuration and string descriptors)
        UsbSetDescriptor();
        break;
      case GET_CONFIGURATION:
        UsbGetConfiguration();
        break;
      case SET_CONFIGURATION:
        UsbSetConfiguration();
        break;
      case GET_INTERFACE:
        UsbGetInterface();
        break;
      case SET_INTERFACE:
        UsbSetInterface();
        break;
      case SYNCH_FRAME:
        UsbSynchFrame();
        break;
      default:
        UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
      }
      break;
    // Class
    case UsbTypeClass:
      if(UsbUserFun[UsbUserClass] != NULL &&
         ((Int32U)UsbUserFun[UsbUserClass](&UsbEp0Ctrl) == UsbPass))
      {
        if(UsbEp0Ctrl.Counter >= UsbEp0SetupPacket.wLength.Word)
        {
          UsbEp0Ctrl.Counter = UsbEp0SetupPacket.wLength.Word;
          UsbEp0Ctrl.EpStatus.NoZeroLength = TRUE;
        }
        else
        {
          UsbEp0Ctrl.EpStatus.NoZeroLength = FALSE;
        }
        UsbEp0Ctrl.EpStatus.Status = UsbDataPhase;
      }
      else
      {
        UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
      }
      break;
    // Vendor
    case UsbTypeVendor:
      if(UsbUserFun[UsbUserVendor] != NULL &&
        ((Int32U)UsbUserFun[UsbUserVendor](&UsbEp0Ctrl) == UsbPass))
      {
        if(UsbEp0Ctrl.Counter >= UsbEp0SetupPacket.wLength.Word)
        {
          UsbEp0Ctrl.Counter = UsbEp0SetupPacket.wLength.Word;
          UsbEp0Ctrl.EpStatus.NoZeroLength = TRUE;
        }
        else
        {
          UsbEp0Ctrl.EpStatus.NoZeroLength = FALSE;
        }
        UsbEp0Ctrl.EpStatus.Status = UsbDataPhase;
      }
      else
      {
        UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
      }
      break;
    // Other
    default:
      UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
    }
  }

  switch (UsbEp0Ctrl.EpStatus.Status)
  {
  case UsbDataPhase:
    if (UsbEp0SetupPacket.mRequestType.Dir == UsbHost2Device)
    {
      if (Packet == UsbDataOutPacket)
      {
        // Data receiving
        CurrCount = Ep0MaxSize;
        if(USB_EpRead(CTRL_ENP_OUT,UsbEp0Ctrl.pData,&CurrCount) == UB_EP_SETUP_OVERWRITE)
        {
          return;
        }
        UsbEp0Ctrl.pData += CurrCount;
        UsbEp0Ctrl.Counter -= CurrCount;
        // Receiving of data complete when all data was received or
        // when host send short packet
        if ((UsbEp0Ctrl.Counter == 0) ||
            (CurrCount < Ep0MaxSize))
        {
          // Find appropriate callback function depending of current request
          // after data was received
          switch (UsbEp0SetupPacket.mRequestType.Type)
          {
          case UsbTypeStandart:
            if ((UsbCoreT9Fun != NULL) &&
                ((Int32U)UsbCoreT9Fun(NULL) == UsbPass))
            {
              UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
            }
            else
            {
            // Stall EP if callback function isn't set, but host
            // send this request type or when callback function
            // return an error.
              UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
            }
            UsbCoreT9Fun = NULL;
            break;
          case UsbTypeClass:
            if ((UsbUserFun[UsbClassEp0OutPacket] != NULL) &&
                ((Int32U)UsbUserFun[UsbClassEp0OutPacket](NULL) == UsbPass))
            {
              UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
            }
            else
            {
              UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
            }
            break;
          case UsbTypeVendor:
            if ((UsbUserFun[UsbVendorEp0OutPacket] != NULL) &&
                ((Int32U)UsbUserFun[UsbVendorEp0OutPacket](NULL) == UsbPass))
            {
              UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
            }
            else
            {
              UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
            }
            break;
          default:
            UsbEp0Ctrl.EpStatus.Status = UsbEpStall;
          }
          if(UsbEp0Ctrl.EpStatus.Status == UsbStatusPhase)
          {
            CurrCount = 0;
            USB_EpWrite(CTRL_ENP_IN,NULL,&CurrCount);
            UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
          }
        }
      }
      else if (UsbEp0Ctrl.Counter == 0)
      {
        CurrCount = 0;
        USB_EpWrite(CTRL_ENP_IN,NULL,&CurrCount);
        UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
      }
    }
    else
    {
       // Data transmit
      if (Packet == UsbDataOutPacket)
      {
        // Status phase packet
        // but we still wait for IN EP ackn interrupt
        CurrCount = 0;
        if(USB_EpRead(CTRL_ENP_OUT,NULL,&CurrCount) == UB_EP_SETUP_OVERWRITE)
        {
          return;
        }
        if(USB_EpValidate(CTRL_ENP_OUT) == UB_EP_SETUP_OVERWRITE)
        {
          return;
        }
        UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
        break;
      }
      CurrCount = Ep0MaxSize;
      if ((UsbEp0Ctrl.Counter == 0) && UsbEp0Ctrl.EpStatus.NoZeroLength)
      {
        UsbEp0Ctrl.EpStatus.Status = UsbStatusPhase;
        break;
      }
      else if(UsbEp0Ctrl.Counter < Ep0MaxSize)
      {
        UsbEp0Ctrl.EpStatus.NoZeroLength = TRUE;
        CurrCount = UsbEp0Ctrl.Counter;
      }
      USB_EpWrite(CTRL_ENP_IN,UsbEp0Ctrl.pData,&CurrCount);
      UsbEp0Ctrl.Counter -= CurrCount;
      UsbEp0Ctrl.pData += CurrCount;
    }
    break;
  case UsbStatusPhase:
    if (UsbEp0SetupPacket.bRequest == SET_ADDRESS)
    {
      // Device address is set after status phase of set address request
      UsbDevCtrl.DevAdd = UsbEp0SetupPacket.wValue.Lo;
      USB_SetAdd(UsbDevCtrl.DevAdd);
      if(UsbDevCtrl.DevAdd)
      {
        UsbSetDevState(UsbDevStatusAddress);
      }
      else
      {
        // when address is 0 put device init configuration state
        UsbSetDevState(UsbDevStatusDefault);
        UsbUserFun[UsbUserConfigure](NULL);
      }
    }
    if (Packet == UsbDataOutPacket)
    {
      CurrCount = 0;
      if(USB_EpRead(CTRL_ENP_OUT,NULL,&CurrCount) == UB_EP_SETUP_OVERWRITE)
      {
        return;
      }
      if(USB_EpValidate(CTRL_ENP_OUT) == UB_EP_SETUP_OVERWRITE)
      {
        return;
      }
    }
    UsbEp0Ctrl.EpStatus.Status = UsbSetupPhase;
    break;
  default:
    // Error
    USB_SetStallEP(CTRL_ENP_IN,TRUE);
    USB_SetStallEP(CTRL_ENP_OUT,TRUE);
    UsbEp0Ctrl.EpStatus.Status = UsbSetupPhase;
  }
}

