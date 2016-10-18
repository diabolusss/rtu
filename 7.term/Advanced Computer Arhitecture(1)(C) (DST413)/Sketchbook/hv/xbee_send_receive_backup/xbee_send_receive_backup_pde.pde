//#define RX
#define TX

#define XBEE_PRO
//#define XBEE_NORMAL


#ifdef TX
  #define DEBUG_ON
  #define DEFAULT_TX_NI "WASP3"
  
  #define TX_MAC_ID "0013A20040763BC9" //"0013A20040763BC9" - transmitter socket0      
  #define DESTINATION_MAC_ID "0013A20040763BA5" //"0013A20040763BA5" - receiver socket1
  
  #define TX_MAX_DELAY 0
  
#else
  #define DEBUG_ON
  #define DEFAULT_RX_NI "WASP5"
  
  #define TX_MAC_ID "0013A20040763BA5"    
  #define DESTINATION_MAC_ID "0013A20040763BC9"
  
#endif
      //"0013A20040763BC9"
      //"0013A20040763BC8"
      //"0013A20040763BC4" 
      //"0013A20040763BA5" 
      //"0013A2004052414B"
      //"0013A20040763BB3"
      
#define DEFAULT_DEST_MAC_ID "000000000000FFFF" //for broadcast

#define DEFAULT_CHANNEL 0x17
uint8_t DEFAULT_PANID[2]={0x35,0x10};

      
/**
  *
  *
  *
  **/      

#define MAX_PACKET_TO_SEND      100
#define MAX_DATA_FOR_MESSAGE  100

#define R_OK  0
#define R_NOK 1

#define DEFAULT_MODE UNICAST
  //UNICAST
  //BROADCAST


char*  data="UNIQ DATA DELIVERY";//"0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
uint8_t destination[8];

uint8_t gCounter = 0;

void setup()
{ 
  
  // Inits the XBee 802.15.4 library
  xbee802.init(
    XBEE_802_15_4,
    FREQ2_4G,
    
   #ifdef XBEE_NORMAL
    NORMAL
   #else
    PRO
   #endif
    
   #ifdef TX
    ,SOCKET0
   #else
    ,SOCKET0
   #endif
    );
  
  // Opens the UART and switches the XBee ON (38400bps by default).
  xbee802.ON();
  
  createNetwork(DEFAULT_CHANNEL, DEFAULT_PANID);    
  
  //Opening UART to show messages using 'Serial Monitor'  
  XBee.begin();
  
  #ifdef DEBUG_ON
  XBee.println("\nDEBUG: XBee powered successfully...\n");
  XBee.println  ("DEBUG: #####################################");
  XBee.println  ("DEBUG: ##    XBeeLLO FROM LIBELIUM!       ##");
  XBee.println  ("DEBUG: #####################################\n");
  XBee.print("INFO: Device MAC: ");
  XBee.println(TX_MAC_ID);  
  XBee.print("INFO: Destination MAC: ");
  XBee.println(DESTINATION_MAC_ID);  
  XBee.println  ("DEBUG: #####################################\n");
  
  printinf();
  #endif 
  
}

packetXBee* received_packet;

void loop(){
  char pcData[MAX_DATA_FOR_MESSAGE] = {0};
  uint8_t mode = UNICAST;
  
  long lResult = 0;
  
 #ifdef RX
 
  #ifdef DEBUG_ON
  XBee.println("INFO: Receiver mode ");
  #endif
  
  //Run speed test from RX i.e. count msg and measure time
  if( (lResult = speedTestRx()) != 0){
    XBee.print("\nINFO: speedTest completed. Time elapsed: ");
    XBee.print(lResult, DEC);
    XBee.println(" Delay 20 sec... ");
    delay(20000);
  }
  
 #else /* TX */
  #ifdef DEBUG_ON
  XBee.println("INFO: Transmitter mode ");
  #endif
  
  //load packet fully
  data = (char*) malloc( MAX_DATA_FOR_MESSAGE * sizeof(char) );
  data = fillString(data, MAX_DATA_FOR_MESSAGE);
  
  //run speed test from TX, i.e. send  max loaded packets
  if( (lResult = speedTestTx(data)) == MAX_PACKET_TO_SEND){
    XBee.print("\nINFO: speedTest completed. Packets sent: ");
    XBee.print(lResult, DEC);
    XBee.println(" Delay 20 sec... ");
    delay(20000);
  }
  
  free(data);
  data = NULL;
  
 #endif
}

/**
  *  Print this node preferences
  *
  *
  **/
  void printinf(){
    
    XBee.println("INFO: INFO");
    
    //A 64-bit RF module’s unique IEEE address. It is divided 
    // in two groups of 32 bits (High and Low).
    // It identifies uniquely a node inside a network 
    // due to it can not be modified and it is given by 
    // the manufacturer. It is used in 64-bit unicast transmissions.
    //xbee802.getOwnMacLow(); // Get 32 lower bits of MAC Address
    //xbee802.getOwnMacHigh(); // Get 32 upper bits of MAC Address
    
    uint32_t macL = xbee802.getOwnMacLow();
    uint32_t macH = xbee802.getOwnMacHigh();
    XBee.print("INFO: Device MAC : ");
    XBee.print(macL, HEX);
    XBee.print(macH, HEX);
    XBee.println();
    
    //A 16-bit Network Address. It identifies a node inside a network, 
    // it can be modified at running time. It is used to send data to a
    // node in 16-bit unicast transmissions.
    //xbee802.setOwnNetAddress(0x12,0x34); // Set 0x1234 as Network Address
    //xbee802.getOwnNetAddress(); // Get Network Address
    
    //16-bit number that identifies the network. It must be unique 
    // to differentiate a network. All the nodes in the same network
    // should have the same PAN ID.
    //panid={0x33,0x31}; // array containing the PAN ID
    //xbee802.setPAN(panid); // Set PANID
    //xbee802.getPAN(); // Get PANID
    
    //A max 20-character ASCII string which identifies the node in a network.
    // It is used to identify a node in the application level. It is
    // also used to search a node using its NI.
    //xbee802.setNodeIdentifier(“forrestnode-01#”); // Set ‘forrestnode-01’ as NI
    //xbee802.getNodeIdentifier(); // Get NI
    
    /* 
      0x0C – Channel 12 2,405 – 2,410 GHz Normal / PRO
      0x0D – Channel 13 2,410 – 2,415 GHz Normal / PRO
      0x0E – Channel 14 2,415 – 2,420 GHz Normal / PRO
      0x0F – Channel 15 2,420 – 2,425 GHz Normal / PRO
      0x10 – Channel 16 2,425 – 2,430 GHz Normal / PRO
      0x11 – Channel 17 2,430 – 2,435 GHz Normal / PRO
      0x12 – Channel 18 2,435 – 2,440 GHz Normal / PRO
      0x13 – Channel 19 2,440 – 2,445 GHz Normal / PRO
      0x14 – Channel 20 2,445 – 2,450 GHz Normal / PRO
      0x15 – Channel 21 2,450 – 2,455 GHz Normal / PRO
      0x16 – Channel 22 2,455 – 2,460 GHz Normal / PRO
      0x17 – Channel 23 2,460 – 2,465 GHz Normal / PRO
      */
    //xbee802.setChannel(0x0D); // Set channel
    //xbee802.getChannel(); // Get Channel
    
    /* 
      0: Digi Mode. 802.15.4 header + Digi header. It enables features 
          as Discover Node and Destination Node.
      1: 802.15.4 without ACKs. It doesn’t support DN and ND features. 
          It is 802.15.4 protocol without generating ACKs when a packet is received.
      2: 802.15.4 with ACKs. It doesn’t support DN and ND features. 
          It is the standard 802.15.4 protocol.
      3: Digi Mode without ACKs. 802.15.4 header + Digi header. It enables features 
          as Discover Node and Destination Node. It doesn’t generate ACKs when a packet is received.
     */
    //xbee802.setMacMode(2); // Set Mac Mode to 802.15.4 header
    //xbee802.getMacMode(); // Get Mac Mode
    
    /*
      Parameter XBee XBee-PRO XBee-PRO International
      0 -10dBm 10dBm PL=4 : 10dBm
      1 -6dBm 12dBm PL=3 : 8dBm
      2 -4dBm 14dBm PL=2 : 2dBm
      3 -2dBm 16dBm PL=1 : -3dBm
      4 0dBm 18dBm PL=0 : -3dBm
      */
      //xbee802.setPowerLevel(0); // Set Power Output Level to the minimum value
      //xbee802.getPowerLevel(); // Get Power Output Level
      
      //XBee.println("");
      //XBee.print("Power level :");
      //XBee.println(xbee802.getPowerLevel());
      
      //xbee802.getRSSI(); // Get the Receive Signal Strength Indicator
      
      /*
      List of channels to scan for all Active and Energy Scans as a bitfield:
      bit 0: 0x0B bit 4: 0x0F bit 8: 0x13 bit 12: 0x17
      bit 1: 0x0C bit 5: 0x10 bit 9: 0x14 bit 13: 0x18
      bit 2: 0x0D bit 6: 0x11 bit 10: 0x15 bit 14: 0x19
      bit 3: 0x0E bit 7: 0x12 bit 11: 0x16 bit 15: 0x1A
      Setting this parameter to 0xFFFF, will cause all the channels to be scanned
      */
      //xbee802.setScanningChannels(0xFF,0xFF); // Sets all channels to scan
      //xbee802.getScanningChannels(); // Gets scanned channel list
  }

/**
  Send data
  
  **/
int send(char* data, char* destination, uint8_t mode){
  int result = 0;
  
  packetXBee* paq_sent;  
  
  // Set params to send
  paq_sent=(packetXBee*) calloc(1,sizeof(packetXBee)); 
  paq_sent->mode = mode;
    //BROADCAST
    //UNICAST //fails to send in unicast
    //;
  paq_sent->MY_known=0;
  paq_sent->packetID=0x52;
  paq_sent->opt=0; 
  xbee802.hops=0;
  //xbee802.setOriginParams(paq_sent, “0013A2004030F66A”, MAC_TYPE);
  
  xbee802.setOriginParams(paq_sent, (const char*) DEFAULT_PANID, MY_TYPE); //16-bit Network Address of the reported module
  //xbee802.setOriginParams(paq_sent, "1234", MY_TYPE);
  //xbee802.setOriginParams(paq_sent, "IAIDA_NODE", NI_TYPE); //Node Identifier of the reported module
  
  xbee802.setOriginParams(paq_sent,  TX_MAC_ID, MAC_TYPE);  
  
  if (mode == BROADCAST){
    xbee802.setDestinationParams(paq_sent, DEFAULT_DEST_MAC_ID, data, MAC_TYPE, DATA_ABSOLUTE);
    
  } else{
    //xbee802.setDestinationParams(paq_sent, "0013A20040763BA5", data, MAC_TYPE, DATA_ABSOLUTE); 
    xbee802.setDestinationParams(paq_sent, destination, data, MAC_TYPE, DATA_ABSOLUTE);
  }
  
  //xbee802.setDestinationParams(paq_sent, destination, data, MAC_TYPE, DATA_ABSOLUTE);
  //xbee802.setDestinationParams(paq_sent, “1234”, data, MY_TYPE, DATA_ABSOLUTE); // sets Destination Parameters
  
  xbee802.sendXBee(paq_sent);
  
  if( xbee802.error_TX )
  {
    result = -1;
    //XBee.println();
    //XBee.println("!sending data failed...");
    
  }else {
    //XBee.println();
    //XBee.println("!sending data success..."); 
    
  }
  
  free(paq_sent);
  paq_sent=NULL;
  
  return result;
}

  
/**
    Get received data
      and store in pcData

**/
uint8_t ui8_ReceiveData(){
	uint8_t ui8_RetVal = R_NOK;
	long lprevious = 0;
	
	lprevious = millis();
        
	while(
          ((millis() - lprevious) < 20000) && 
          (ui8_RetVal != R_OK)
          ){
		//XBee.println("Receiving");
		if(XBee.available()){
			xbee802.treatData();
			if(!xbee802.error_RX){
				ui8_RetVal = R_OK;
			}else{
                          #ifdef DEBUG_ON
                          XBee.println("DEBUG: error_RX");
                          #endif
                        }
			break; // failed return R_NOK;
		}
	}

	return ui8_RetVal;
}

/**
    Test how fast are received MAX_PACKET_TO_SEND packets
**/
long speedTestRx(){
  static long lTimeStart = 0;
  static long lTimeEnd = 0;
  static uint8_t lCounter = 0;  
  
  if(ui8_ReceiveData() == R_OK){    
    #ifdef DEBUG_ON
    XBee.print("DEBUG: Received packet count "); 
    XBee.println((char)lCounter, DEC);
    //USB.print("DEBUG_USB: Received packet count "); 
    //USB.println((char)lCounter, DEC);
    #endif
    
    if(lCounter == 0) {
      lTimeStart = millis();
      lCounter++;
      
    }else if (lCounter == MAX_PACKET_TO_SEND){
      lTimeEnd = millis();
      lCounter++;
      
    }else if (lCounter == (MAX_PACKET_TO_SEND + 1) ){
      #ifdef DEBUG_ON
      XBee.print("DEBUG: Time elapsed to receive "); 
      XBee.print((char)MAX_PACKET_TO_SEND);
      XBee.print(" packets: ");
      XBee.println( (lTimeEnd - lTimeStart) );
      #endif
      return (lTimeEnd - lTimeStart);
    }else{
      //vParseData(pcData);
      lCounter++;
    }
  }
  
  return 0;
}

/**
    Send MAX_PACKET_TO_SEND packets
**/
uint8_t speedTestTx(char* packet){
  static uint8_t lCounter = 0;
  uint8_t lMode = UNICAST;
  
 while(lCounter < MAX_PACKET_TO_SEND){
    
    if ( send(packet, DESTINATION_MAC_ID, lMode) == 0 ) {
      #ifdef DEBUG_ON
      XBee.println();
      XBee.print("DEBUG: !sending data in "); 
      XBee.print(lMode);
      XBee.println(" mode[UNICAST(0)] success!");
      #endif
      
      lCounter++;
      delay(TX_MAX_DELAY);
    }else{
      #ifdef DEBUG_ON
      XBee.println();
      XBee.println("DEBUG: UNICAST node is not available.");      
      XBee.print("DEBUG: Sent packet count "); 
      XBee.println((char)lCounter, DEC);
      #endif 
      
    }
  }
   
 return lCounter; 
}

/**
  Print received data
  
**/
void vParseData(char * pcData){
	int g = 0;
	
	while(xbee802.pos>0){
  
                XBee.println  ("INFO: #####################################");
  
		XBee.print("   Network Address Source: ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[0],HEX);
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[1],HEX);
		XBee.println("");
		XBee.print("   MAC Address Source: ");
		for(int b=0;b<4;b++){
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSH[b],HEX);
		}
		for(int c=0;c<4;c++){
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSL[c],HEX);
		}
		XBee.println("");
		XBee.print("   Network Address Origin: ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[0],HEX);
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[1],HEX);
		XBee.println("");
		XBee.print("   MAC Address Origin: ");
		for(int d=0;d<4;d++){
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOH[d],HEX);
		}
		for(int e=0;e<4;e++){
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOL[e],HEX);
		}
		XBee.println("");
		XBee.print("   RSSI: ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->RSSI,HEX);
		XBee.println("");
		XBee.print("   16B(0) or 64B(1): ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->mode,HEX);
		XBee.println("");

		XBee.print("   PacketID: ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->packetID,HEX);
		XBee.println("");
		XBee.print("   Type Source ID: ");
		XBee.print(xbee802.packet_finished[xbee802.pos-1]->typeSourceID,HEX);
		XBee.println("");
		XBee.print("   Network Identifier Origin: ");
		while( xbee802.packet_finished[xbee802.pos-1]->niO[g]!='#' )
		{
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->niO[g],BYTE);
			g++;
		}
		g = 0;
		XBee.println("");

		XBee.print("   Data: ");
		for(int f = 0; f < (xbee802.packet_finished[xbee802.pos-1]->data_length); f++)	{
			XBee.print(xbee802.packet_finished[xbee802.pos-1]->data[f],BYTE);
		}
		XBee.println  ("INFO: #####################################");
		free(xbee802.packet_finished[xbee802.pos-1]);
		xbee802.packet_finished[xbee802.pos-1]=NULL;
		xbee802.pos--;
	}
}

/**
  Fill string with chars
  Use for test purposes
**/
char* fillString(char* new_string, uint8_t length){  
  for(int i = 0; i < length; i++){
   new_string[i] = 'Z';
  } 
  new_string[length] = '\0';
  
  return new_string;
}

/**
  Setup network
**/
int8_t createNetwork (uint8_t channel, uint8_t* pan) {
   
  xbee802.setChannel(channel);  
   if( !xbee802.error_AT ) {
     XBee.println("DEBUG: Channel set OK");
     
   } else { 
     XBee.println("DEBUG: Error while changing channel");
   }
  
  xbee802.setPAN(pan); 
  if( !xbee802.error_AT ) { 
    XBee.println("DEBUG: PANID set OK");
    
  } else {
    XBee.println("DEBUG: Error while changing PANID");
  }
  
  return 0;
}
