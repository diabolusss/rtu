/*************************************************************************
 *
 *    Used with ICCARM and AARM.
 *
 *    (c) Copyright IAR Systems 2007
 *
 *    File name   : LPC24xx_usb.h
 *    Description : usb module header file
 *
 *    History :
 *    1. Date        : January 7, 2007
 *       Author      : Stanimir Bonev
 *       Description : Create
 *
 *    $Revision: 18137 $
 **************************************************************************/

#include "includes.h"
#include "usb_9.h"
#include "lpc24xx_usb_cfg.h"

#ifndef __LPC24XX_USB_H
#define __LPC24XX_USB_H

#ifdef HAL_USB_GLOBAL
#define HAL_USB_EXTERN
#else
#define HAL_USB_EXTERN  extern
#endif

#define MSG_FILE stdout

#if USB_TRACE_LM_EN != 0
#define  USB_LM_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_LM_TRACE_INFO(...)
#endif

#if USB_TRACE_LW_EN != 0
#define  USB_LW_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_LW_TRACE_INFO(...)
#endif

#if USB_TRACE_LE_EN != 0
#define  USB_LE_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_LE_TRACE_INFO(...)
#endif

#if USB_TRACE_T9M_EN != 0
#define  USB_T9M_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_T9M_TRACE_INFO(...)
#endif

#if USB_TRACE_T9W_EN != 0
#define  USB_T9W_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_T9W_TRACE_INFO(...)
#endif

#if USB_TRACE_T9E_EN != 0
#define  USB_T9E_TRACE_INFO(...)   fprintf(MSG_FILE,  __VA_ARGS__)
#else
#define  USB_T9E_TRACE_INFO(...)
#endif

#define CMD_USB_SEL_EP              0x00
#define CMD_USB_SEL_CLR_INT_EP      0x40
#define CMD_USB_SET_EP_STAT         0x140
#define CMD_USB_SET_ADDRESS         0xD0
#define CMD_USB_CFG_DEV             0xD8
#define CMD_USB_CLR_BUF             0xF2
#define CMD_USB_SET_MODE            0xF3
#define CMD_USB_RD_FRAME_NUMB       0xF5
#define CMD_USB_VAL_BUF             0xFA
#define CMD_USB_RD_ERROR_STAT       0xFB
#define CMD_USB_RD_TEST_REG         0xFD
#define CMD_USB_SET_DEV_STAT        0x1FE
#define CMD_USB_GET_DEV_STAT        0xFE
#define CMD_USB_GET_ERROR           0xFF

#define USB_CMD_WR                  0x00000500
#define USB_DATA_WR                 0x00000100
#define USB_DATA_RD                 0x00000200

#define bmUSB_FrameInterrupt        0x00000001
#define bmUSB_FastInterrupt         0x00000002
#define bmUSB_SlowInterrupt         0x00000004
#define bmUSB_DevStatusInterrupt    0x00000008
#define bmUSB_CommRegEmptyInterrupt 0x00000010
#define bmUSB_CommDataFullInterrupt 0x00000020
#define bmUSB_RxPacketInterrupt     0x00000040
#define bmUSB_TxPacketInterrupt     0x00000080
#define bmUSB_EPRealizeInterrupt    0x00000100
#define bmUSB_ErrorInterrupt        0x00000200

#define bmUSB_HP_Frame              0x00000001
#define bmUSB_HP_FastEp             0x00000002

#define bmUSB_Connect               0x00000001
#define bmUSB_ConnectChange         0x00000002
#define bmUSB_Suspend               0x00000004
#define bmUSB_SuspendChange         0x00000008
#define bmUSB_BusReset              0x00000010

#define bmUSB_EpStall               0x00000001
#define bmUSB_EpStallStatus         0x00000002
#define bmUSB_EpSetupPacket         0x00000004
#define bmUSB_EpPOStatus            0x00000010
#define bmUSB_EpCondStall           0x00000080

#define bmUSB_CtrlRdEna             0x00000001
#define bmUSB_CtrlWrEna             0x00000002

#define bmUSB_PacketOverWritten     0x00000001

#define bmUSB_FE                    0x00000001
#define bmUSB_ST                    0x00000002
#define bmUSB_STP                   0x00000004
#define bmUSB_PO                    0x00000008
#define bmUSB_EPN                   0x00000010
#define bmUSB_B_1_FULL              0x00000020
#define bmUSB_B_2_FULL              0x00000040

typedef enum _USB_PacketType_t
{
	// Packet type parameters
  UsbSetupPacket = 0,UsbDataOutPacket,UsbDataInPacket,UsbDmaPacket,
} USB_PacketType_t;

typedef union
{
  Int8U Data;
  struct
  {
    Int8U  Connect        : 1;
    Int8U  ConnectChange  : 1;
    Int8U  Suspend        : 1;
    Int8U  SuspendChange  : 1;
    Int8U  Reset          : 1;
    Int8U                 : 3;
  };
}UsbDevStat_t;

typedef enum _USB_Endpoint_t
{
  CTRL_ENP_OUT=0, CTRL_ENP_IN,
  ENP1_OUT      , ENP1_IN    ,
  ENP2_OUT      , ENP2_IN    ,
  ENP3_OUT      , ENP3_IN    ,
  ENP4_OUT      , ENP4_IN    ,
  ENP5_OUT      , ENP5_IN    ,
  ENP6_OUT      , ENP6_IN    ,
  ENP7_OUT      , ENP7_IN    ,
  ENP8_OUT      , ENP8_IN    ,
  ENP9_OUT      , ENP9_IN    ,
  ENP10_OUT     , ENP10_IN   ,
  ENP11_OUT     , ENP11_IN   ,
  ENP12_OUT     , ENP12_IN   ,
  ENP13_OUT     , ENP13_IN   ,
  ENP14_OUT     , ENP14_IN   ,
  ENP15_OUT     , ENP15_IN   ,
  ENP_MAX_NUMB
} USB_Endpoint_t;

typedef enum _UsbUserEvent_t
{
  UsbEp0Out = 0 , UsbEp0In,
  UsbEp1Out     , UsbEp1In,
  UsbEp2Out     , UsbEp2In,
  UsbEp3Out     , UsbEp3In,
  UsbEp4Out     , UsbEp4In,
  UsbEp5Out     , UsbEp5In,
  UsbEp6Out     , UsbEp6In,
  UsbEp7Out     , UsbEp7In,
  UsbEp8Out     , UsbEp8In,
  UsbEp9Out     , UsbEp9In,
  UsbEp10Out    , UsbEp10In,
  UsbEp11Out    , UsbEp11In,
  UsbEp12Out    , UsbEp12In,
  UsbEp13Out    , UsbEp13In,
  UsbEp14Out    , UsbEp14In,
  UsbEp15Out    , UsbEp15In,
  UsbClassEp0OutPacket,
  UsbVendorEp0OutPacket,
  UsbUserSofEvent,
  UsbUserClass,
  UsbUserVendor,
  UsbUserGetDescriptor,
  UsbUserConfigure,
  UsbUserReset,
  UsbUserConnect,
  UsbUserSuspend,
  UsbUserEpStall,
  UsbUserEpUnStall,
  UsbUserErrorEvent,
  UsbLastEvent,
}UsbUserEvent_t;

typedef struct _EpInfo_t
{
  Int32U MaxSize;
} EpInfo_t, *pEpInfo_t;

typedef enum _USB_ErrorCodes_t
{
  USB_OK = 0,USB_PLL_ERROR, USB_INTR_ERROR,
  USB_EP_OCCUPIER, USB_MEMORY_FULL, USB_BUF_OVERFLOW,
  USB_EP_NOT_VALID, UB_EP_SETUP_UNDERRUN, USB_EP_STALLED,
  UB_EP_SETUP_OVERWRITE, USB_EP_FATAL_ERROR,
} USB_ErrorCodes_t;

typedef enum _USB_DevStatusReqType_t
{
  USB_DevConnectStatus = 0, USB_SuspendStatus, USB_ResetStatus
} USB_DevStatusReqType_t;

typedef union
{
  Int32U Data;
  struct
  {
    Int32U Frame      : 1;
    Int32U Fast       : 1;
    Int32U Slow       : 1;
    Int32U Status     : 1;
    Int32U CcEmpty    : 1;
    Int32U CdFull     : 1;
    Int32U EpRx       : 1;
    Int32U EpTx       : 1;
    Int32U EpRealize  : 1;
    Int32U Error      : 1;
    Int32U            :22;
  };
}UsbDevIntrStat_t;

typedef Int32U UsbDefStatus_t;
typedef void * (* UserFunc_t)(void * Arg);

extern void VIC_SetVectoredIRQ(void(*pIRQSub)(), unsigned int Priority,
                        unsigned int VicIntSource);

/*************************************************************************
 * Function Name: USB_UserFuncRegistering
 * Parameters: UserFunc_t UserFunc, UsbUserEvent_t UserFuncInd
 *
 * Return: UserFunc_t
 *
 * Description: Registering User callback function
 *
 *************************************************************************/
UserFunc_t USB_UserFuncRegistering (UserFunc_t UserFunc, UsbUserEvent_t UserFuncInd);

/*************************************************************************
 * Function Name: UsbCoreReq
 * Parameters:  UsbCoreReqType_t Type
 *
 * Return: Int32U
 *
 * Description: Return device states
 *
 *************************************************************************/
Int32U UsbCoreReq (UsbCoreReqType_t Type);

#if USB_REMOTE_WAKEUP != 0
/*************************************************************************
 * Function Name: UsbWakeUp
 * Parameters:  none
 *
 * Return: none
 *
 * Description: Wake-up device from suspend mode
 *
 *************************************************************************/
void UsbWakeUp (void);
#endif // USB_REMOTE_WAKEUP != 0

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
Int32U USB_Cmd (Int16U Command, Int8U Data);

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
Int8U USB_EpIntrClr(USB_Endpoint_t EndPoint);

/*************************************************************************
 * Function Name: USB_Init
 * Parameters: Int32U IntrSlot,
 *
 * Return: none
 *
 * Description: Init USB
 *
 *************************************************************************/
void USB_Init(Int32U IntrSlot, CommUserFpnt_t UserCoreConfigure);

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
void USB_HwReset (void);

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
                               Int32U MaxPacketSize, Boolean IntrEna);

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
void USB_SetAdd(Int32U DevAdd);
#define USB_SetDefAdd() USB_SetAdd(0)

/*************************************************************************
 * Function Name: USB_ConnectRes
 * Parameters: Boolean Conn
 *
 * Return: none
 *
 * Description: Enable Pull-Up resistor
 *
 *************************************************************************/
void USB_ConnectRes (Boolean Conn);

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
void USB_Configure (Boolean Configure);

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
void USB_WakeUp (void);
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
Boolean USB_GetDevStatus (USB_DevStatusReqType_t Type);

/*************************************************************************
 * Function Name: USB_SetStallEP
 * Parameters: USB_Endpoint_t EndPoint, Boolean Stall
 *
 * Return: none
 *
 * Description: The endpoint stall/unstall
 *
 *************************************************************************/
void USB_SetStallEP (USB_Endpoint_t EndPoint, Boolean Stall);

/*************************************************************************
 * Function Name: USB_GetStallEP
 * Parameters: USB_Endpoint_t EndPoint, pBoolean pStall
 *
 * Return: none
 *
 * Description: Get stall state of the endpoint
 *
 *************************************************************************/
void USB_GetStallEP (USB_Endpoint_t EndPoint, pBoolean pStall);

/*************************************************************************
 * Function Name: USB_EpValidate
 * Parameters: USB_Endpoint_t EndPoint
 *
 * Return: USB_ErrorCodes_t
 *
 * Description: Validate/Clear EP buffer
 *
 *************************************************************************/
USB_ErrorCodes_t USB_EpValidate(USB_Endpoint_t EndPoint);

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
                              const unsigned char *pData, pInt32U pCount);

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
                             pInt32U pCount);

/*************************************************************************
 * Function Name: USB_EpLogToPhysAdd
 * Parameters: Int8U EpLogAdd
 *
 * Return: USB_Endpoint_t
 *
 * Description: Convert the logical to physical address
 *
 *************************************************************************/
USB_Endpoint_t USB_EpLogToPhysAdd (Int8U EpLogAdd);

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
Int32U USB_GetFrameNumb (void);
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
static void USB_ISR (void);

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
void UsbCtrlEp (USB_PacketType_t Packet);

#if USB_DMA > 0
typedef enum _UsbDmaStateCode_t
{
  UsbDmaNoServiced = 0,UsbDmaBeingServiced,
  UsbDmaNormalCompletion, UsbDmaDataUnderrun,
  UsbDmaDataOverrun = 8, UsbDmaSystemError,
  UsbDmaParametersError,
} UsbDmaStateCode_t;

typedef enum
{
  UsbDmaNormalMode = 0, UsbDmaAtleMode,
} UsbDmaMode_t;

#pragma pack(1)
typedef struct _DmaIsoPacket_t
{
	Int32U PacketLength 			:16;
	Int32U PacketValid  			: 1;
	Int32U FrameNumb 					:15;
} DmaIsoPacket_t, *pDmaIsoPacket_t;

typedef struct _USB_DmaDesc_t
{
	void * pNextDD;
	union
	{
		Int32U Ctrl;
		struct
		{
			Int32U DmaMode 		 	 	: 2;
			Int32U NextDDValid   	: 1;
			Int32U 				 		 	 	: 1;
			Int32U Isochronous 	 	: 1;
			Int32U MaxPacketSize 	:11;
			Int32U DmaBufferLegtn :16;
		};
	};
	pInt32U pDmaBuffer;
	union
	{
		Int32U Status;
		struct
		{
			Int32U	DdRetired			: 1;
			Int32U	DdState 			: 4;
			Int32U	PacketValid		: 1;
			Int32U	LsByteExtr		: 1;
			Int32U	MsByteExtr		: 1;
			Int32U	MessLenPos		: 6;
			Int32U					 			: 2;
			Int32U	PresentCnt		:16;
		};
	};
	pDmaIsoPacket_t pDmaIsoPacket;
} USB_DmaDesc_t, *pUSB_DmaDesc_t;
#pragma pack()

/*************************************************************************
 * Function Name: USB_DmaReset
 * Parameters:  Int32U IntrEna
 *
 * Return: none
 *
 * Description: Reset USB DMA
 *
 *************************************************************************/
void USB_DmaReset (Int32U IntrEna);

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
          pDmaIsoPacket_t pDmaIsoPacket, Boolean EpTransferType);

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
void USB_DmaRestartTransfer (USB_Endpoint_t EndPoint,Int32U DmaDescInd);


/*************************************************************************
 * Function Name: USB_DmaGetDesc
 * Parameters: Int32U DmaDescInd
 *
 * Return: pUSB_DmaDesc_t
 *
 * Description: Return pointer to DMA descriptor
 *
 *************************************************************************/
pUSB_DmaDesc_t USB_DmaGetDesc (Int32U DmaDescInd);

/*************************************************************************
 * Function Name: USB_DmaDisable
 * Parameters: USB_Endpoint_t EndPoint
 *
 * Return: none
 *
 * Description: Disable DMA transfer for the EP
 *
 *************************************************************************/
void USB_DmaDisable (USB_Endpoint_t EndPoint);

#endif  // USB_DMA
#endif //__LPC24XX_USB_H
