#define NODE1_ADDRESS "0013A20040763BA6"
//#define NODE2_ADDRESS "0013A20040763BB3"

#define CHANNEL1 0x17
//#define CHANNEL2 0x13
 
 packetXBee* paq_sent;
 int8_t state=0;
 long previous=0;
 char*  data="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", packetNr=1;
 int g=0;
 uint8_t PANID1[2]={0x35,0x10};
 //uint8_t PANID2[2]={0x56,0x78};
 int packet_count=0;
 
void setup()
{
  // Inits the XBee 802.15.4 library
  xbee802.init(XBEE_802_15_4,FREQ2_4G,PRO);
  // Powers XBee
  xbee802.ON();
  xbee802.setScanningChannels(0xFF,0xFF);
  xbee802.setDurationEnergyChannels(2);
  printEnergyChannel();
  //createNetwork (CHANNEL1, PANID1);
}

void loop()
{
  //sendReceive(NODE1_ADDRESS);
  
  /*if(packetNr>100)
  {
    XBee.print(millis());
    xbee802.OFF();
  }
  XBee.println("======================");
  XBee.println("======================");
  createNetwork (CHANNEL2, PANID2);
  sendReceive(NODE2_ADDRESS);*/
}

void sendReceive(char* destination) {
 // Set params to send
  paq_sent=(packetXBee*) calloc(1,sizeof(packetXBee)); 
  paq_sent->mode=UNICAST;
  paq_sent->MY_known=0;
  paq_sent->packetID=0x52;
  paq_sent->opt=0; 
  xbee802.hops=0;
  xbee802.setOriginParams(paq_sent, "5678", MY_TYPE); //"5678" - šis skaitlis tiek izmantots paketes apstrādei saņēmējā
  xbee802.setDestinationParams(paq_sent, destination, data , MAC_TYPE, DATA_ABSOLUTE);
  xbee802.sendXBee(paq_sent);
  if( !xbee802.error_TX )
  {
    XBee.println("");
    XBee.println("*******Packet sent!*********");
    
  }
  else
 {
   XBee.println("***********Packet sending failed***********");
 } 
  free(paq_sent);
  paq_sent=NULL;
  
  // Waiting the answer
  previous=millis();
 
 while( (millis()-previous) < 150 ) {
    if( XBee.available() )
    {
      xbee802.treatData();
      if( !xbee802.error_RX )
      {
        XBee.println("***********Answer received!*********");
        // Writing the parameters of the packet received
        while(xbee802.pos>0)
        {
          XBee.print("Network Address Source: ");
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[0],HEX);
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[1],HEX);
          XBee.println("");
          XBee.print("MAC Address Source: ");          
          for(int b=0;b<4;b++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSH[b],HEX);
          }
          for(int c=0;c<4;c++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSL[c],HEX);
          }
          XBee.println("");
          XBee.print("Network Address Origin: ");          
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[0],HEX);
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[1],HEX);
          XBee.println("");
          XBee.print("MAC Address Origin: ");          
          for(int d=0;d<4;d++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOH[d],HEX);
          }
          for(int e=0;e<4;e++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOL[e],HEX);
          }
          XBee.println("");
          XBee.print("RSSI: ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->RSSI,HEX);
          XBee.println("");         
          XBee.print("16B(0) or 64B(1): ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->mode,HEX);
          XBee.println("");
          XBee.print("Data: ");                    
          for(int f=0;f<xbee802.packet_finished[xbee802.pos-1]->data_length;f++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->data[f],BYTE);
          }
          XBee.println("");
          XBee.print("PacketID: ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->packetID,HEX);
          XBee.println("");      
          XBee.print("Type Source ID: ");                              
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->typeSourceID,HEX);
          XBee.println("");     
          XBee.print("Network Identifier Origin: ");          
          while( xbee802.packet_finished[xbee802.pos-1]->niO[g]!='#' )
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->niO[g],BYTE);
            g++;
          }
          g=0;
          XBee.println("");  
          free(xbee802.packet_finished[xbee802.pos-1]);
          xbee802.packet_finished[xbee802.pos-1]=NULL;
          xbee802.pos--;
        }
        previous=millis();
      }
    }
 }
  packetNr++;
  //delay(1000);

}

void createNetwork (uint8_t channel, uint8_t* pan) {
   
  xbee802.setChannel(channel);  //uzstaada paarraides kanaalu
     if( !xbee802.error_AT ) {
     XBee.println(" Channel set OK");
     XBee.println(); 
   }
   else { 
     XBee.println(" Error while changing channel");
     XBee.println();
   }
  
  xbee802.setPAN(pan);  //uzstaada PANID
     if( !xbee802.error_AT ) { 
       XBee.println(" PANID set OK");
       XBee.println(); 
     }
  else {
    XBee.println(" Error while changing PANID");
    XBee.println(); 
  }
   
}

void printEnergyChannel()
{
  USB.print(("\n\n----------------------"));
  USB.print(("\nEnergy Scan (dBm)"));
  USB.print(("\n----------------------"));
  
  USB.print(("\nchannel 0x0B: "));
  USB.print(xbee802.energyChannel[0]*(-1),DEC);
  
  USB.print(("\nchannel 0x0C: "));
  USB.print(xbee802.energyChannel[1]*(-1),DEC);
  
  USB.print(("\nchannel 0x0D: "));
  USB.print(xbee802.energyChannel[2]*(-1),DEC);
  
  USB.print(("\nchannel 0x0E: "));
  USB.print(xbee802.energyChannel[3]*(-1),DEC);
  
  USB.print(("\nchannel 0x0F: "));
  USB.print(xbee802.energyChannel[4]*(-1),DEC);
  
  USB.print(("\nchannel 0x10: "));
  USB.print(xbee802.energyChannel[5]*(-1),DEC);
  
  USB.print(("\nchannel 0x11: "));
  USB.print(xbee802.energyChannel[6]*(-1),DEC);
  
  USB.print(("\nchannel 0x12: "));
  USB.print(xbee802.energyChannel[7]*(-1),DEC);
  
  USB.print(("\nchannel 0x13: "));
  USB.print(xbee802.energyChannel[8]*(-1),DEC);
  
  USB.print(("\nchannel 0x14: "));
  USB.print(xbee802.energyChannel[9]*(-1),DEC);
  
  USB.print(("\nchannel 0x15: "));
  USB.print(xbee802.energyChannel[10]*(-1),DEC);
  
  USB.print(("\nchannel 0x16: "));
  USB.print(xbee802.energyChannel[11]*(-1),DEC);
  
  USB.print(("\nchannel 0x17: "));
  USB.print(xbee802.energyChannel[12]*(-1),DEC);
  
  USB.print(("\nchannel 0x18: "));
  USB.print(xbee802.energyChannel[13]*(-1),DEC);
  
  USB.print(("\nchannel 0x19: "));
  USB.print(xbee802.energyChannel[14]*(-1),DEC);
  
  USB.print(("\nchannel 0x1A: "));
  USB.print(xbee802.energyChannel[15]*(-1),DEC); 
  
}

