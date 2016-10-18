#include <iostream>
#include <conio>
#include <string>

using namespace std;

 class OverflowException {
   public:
      OverflowException() {
         cout << endl << "Exception created!" << endl;
      }
      OverflowException(OverflowException&) {
         cout << "Exception copied!" << endl;
      }
      ~OverflowException() {
         cout << "Exception finished!" << endl;
      }
};

	class PC{
		protected:
			string processor;
			float ghz;
			short ram;
		public:
			PC();
                        PC(string, float, short);

			virtual ~PC(){
					cout<<"PC object destroyed!\n";
					  while (kbhit()) getch();
                      getch();
				}
			
			virtual void Print() const;//+
			//int GetInfo(string *proc, float* ghz, short* ram) const;
                        string GetProc() const;
                        float GetGhz() const;
                        short GetRam() const;
			void SetProc(string);
			void SetGhz(float);
			void SetRam(short);
	};

  class netPC :   public PC {
    private:
             string ip_addr;
    public:

            netPC():PC(),ip_addr(""){}
            netPC(string, float, short, string);

            virtual ~netPC(){
                     cout<<"netPC object destroyed!\n";
            }

            string  GetIP() const {
                return ip_addr;
            }
            void SetIP(string ip_addr) {
                this->ip_addr = ip_addr;
            }
            virtual void Print() const;    
 };

//begin lab3 edit
class PCNetwork {
   private:
      typedef netPC* NPCPointer;
      NPCPointer *Nodes;
      static const unsigned int DEF_MAX_LENGTH;
      //max mezglu dz
      unsigned int MaxLength;
      unsigned int Length;
      string CNName;
   public:
      PCNetwork() : MaxLength(DEF_MAX_LENGTH), Length(0),CNName(""){
         Nodes = new NPCPointer[MaxLength];
      }
      PCNetwork(unsigned int MaxLength,string CNNname) : MaxLength(MaxLength), Length(0) {
      this->CNName=CNName;
         Nodes = new NPCPointer[MaxLength];
      }
      ~PCNetwork();
      static unsigned int GetDefaultMaxLength() {
         return DEF_MAX_LENGTH;
      }
      int GetMaxLength() const {
         return MaxLength;
      }
      int GetLength() const {
         return Length;
      }
      short GetMaxRam(){
                short tRam=0;
               for (unsigned int i=0; i<Length; i++) {
                if (tRam<Nodes[i]->GetRam()) tRam=Nodes[i]->GetRam();
               }
               
               return  tRam;
      }
      void AddNode(const netPC&);
      void Print() const;
};
const unsigned int PCNetwork::DEF_MAX_LENGTH = 5;

PCNetwork::~PCNetwork() {
   for(unsigned int i=0; i<Length; i++)
      delete Nodes[i];
   delete [] Nodes;
   cout<<"PCNetwork destroyed"<<endl;
}
void PCNetwork::Print() const {
   cout << "\nComputer's Network name: " << CNName << "." << endl
      << "Network nodes:" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}
void PCNetwork::AddNode(const netPC& Node) {
   if (Length == MaxLength)
      throw OverflowException();
   else
      Nodes[Length++] = new netPC(
         Node.GetProc(), Node.GetGhz(), Node.GetRam(), Node.GetIP()
      );
}
//end lab 3 edit

PC::PC():processor(""),ghz(0),ram(0){}


PC::PC(string proc_c, float ghz_c, short ram_c){
 processor=proc_c;
 ghz=ghz_c;
 ram=ram_c;
}

inline void PC::Print() const{
	cout<<"\nProcessor: "<<processor
		 <<"\nFrecvence: "<<ghz
		 <<"\nRAM size: "<<ram<<endl;

 }

inline string PC::GetProc() const{
  return processor  ;
}
inline float PC::GetGhz() const{
  return ghz     ;
}
inline short PC::GetRam() const{
  return ram   ;
}

 inline void PC::SetProc(string newProc){
  this->processor=newProc;
 }

 inline void PC::SetGhz(float newGhz){
  this->ghz=newGhz;
 }

 inline void PC::SetRam(short newRam){
  this->ram=newRam;
 }

 netPC::netPC(string proc_c, float ghz_c, short ram_c, string ip_addr_c) : PC(proc_c, ghz_c, ram_c) {
   ip_addr = ip_addr_c;
 }

 inline void netPC::Print() const {
   PC::Print();
   cout << "IP Address = " << ip_addr;
 }

 void main(void){
   PCNetwork *network = new PCNetwork(3, "Networks");
   netPC* net1 = new netPC("Intel Celeron",1.4,15, "112.234.123.5");
   netPC net2("Core Duo 2",3.4,14, "255.255.255.0");

   try {
      network->AddNode(*net1);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }
      delete net1;

   cout << "\n\nDefault maximal length (from CLASS): " << 
      PCNetwork::GetDefaultMaxLength() << "." << endl;
   cout << "Default maximal length (from OBJECT): " << 
      network->GetDefaultMaxLength() << "." << endl;
   cout << "Maximal length: " << network->GetMaxLength() << "." << endl;
   cout << "Current length: " << network->GetLength() << "." << endl;



   try {
      network->AddNode(net2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      network->AddNode(net2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

      network->Print();
      cout << "\nMaxRamSize = " << network->GetMaxRam() << "." << endl;

      delete network;

   while (kbhit())
      getch();
   getch();
}
