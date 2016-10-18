/*
 *  ------Waspmote XBee 802.15.4 Sending & Receiving Example------
 *
 *  Explanation: This example shows how to send and receive packets
 *  using Waspmote XBee 802.15.4 API
 *
 *  This code sends a packet to another node and waits for an answer from
 *  it. When the answer is received it is shown.
 *
 *  This is the code for the receiver.
 *
 *  Copyright (C) 2009 Libelium Comunicaciones Distribuidas S.L.
 *  http://www.libelium.com
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 * 
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  Version:                0.2
 *  Design:                 David Gascón
 *  Implementation:    Alberto Bielsa
 */
 
 packetXBee* paq_sent;
 long previous=0;
 char*  data="Test message from receiver!";
 uint8_t destination[8];
 uint8_t i=0;
 uint8_t  PANID[2]={0x12,0x34};
 
void setup()
{
  // Inits the XBee 802.15.4 library
  xbee802.init(XBEE_802_15_4,FREQ2_4G,PRO);
  
  // Powers XBee
  xbee802.ON();
  
  xbee802.setChannel(0x12);  //uzstaada paarraides kanaalu
     if( !xbee802.error_AT ) XBee.println("Channel set OK");
  else XBee.println("Error while changing channel");
 
  xbee802.setPAN(PANID);  //uzstaada PANID
     if( !xbee802.error_AT ) XBee.println("PANID set OK");
  else XBee.println("Error while changing PANID"); 
}

void loop()
{
  // Waiting message
  previous=millis();
 
    if( XBee.available() )
    {
      
      xbee802.treatData();
      if( !xbee802.error_RX )
      { 
        XBee.println("*********Packet received!*********");
         // Sending answer back
         while(xbee802.pos>0)
         {
           if( (xbee802.packet_finished[xbee802.pos-1]->naO[0]==0x56) && (xbee802.packet_finished[xbee802.pos-1]->naO[1]==0x78) )
           {
             paq_sent=(packetXBee*) calloc(1,sizeof(packetXBee)); 
             paq_sent->mode=UNICAST;
             paq_sent->MY_known=0;
             paq_sent->packetID=0x52;
             paq_sent->opt=0; 
             xbee802.hops=0;
             xbee802.setOriginParams(paq_sent, "ACK", NI_TYPE);
             while(i<4)
             {
               destination[i]=xbee802.packet_finished[xbee802.pos-1]->macSH[i];
               i++;
             }
             while(i<8)
             {
               destination[i]=xbee802.packet_finished[xbee802.pos-1]->macSL[i-4];
               i++;
             }
             XBee.print("Data: ");   //pakešu secības un skaita pārbaude                 
          for(int f=0;f<xbee802.packet_finished[xbee802.pos-1]->data_length;f++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->data[f],BYTE);
          }
          XBee.println("");
             xbee802.setDestinationParams(paq_sent, destination, data, MAC_TYPE, DATA_ABSOLUTE);
             xbee802.sendXBee(paq_sent);
             
             if( !xbee802.error_TX )
             {
               XBee.println("");
               XBee.println("**********Answer sent********");
             }
             else {
               XBee.println("**********Failed to send answer************");
             }
             free(paq_sent);
             paq_sent=NULL;
           }
           free(xbee802.packet_finished[xbee802.pos-1]);   
           xbee802.packet_finished[xbee802.pos-1]=NULL;
           xbee802.pos--;
        } 
      } else
      {  
        XBee.println("***********Packet receiving failed*********");
    }
    }
  

  //delay(1000);
}


