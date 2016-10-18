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
        template <class T>
	class PC{
		protected:
			string processor;
			float ghz;
			T ram;
		public:
			PC();
                        PC(string, float, T);

			virtual ~PC(){
					cout<<"PC object destroyed!\n";
					  while (kbhit()) getch();
                      getch();
				}
			
			virtual void Print() const;//+
			//int GetInfo(string *proc, float* ghz, short* ram) const;
                        string GetProc() const;
                        float GetGhz() const;
                        T GetRam() const;
			void SetProc(string);
			void SetGhz(float);
			void SetRam(T);
	};
  template <class T>
  class netPC :   public PC<T> {
    private:
             string ip_addr;
    public:

            netPC():PC<T>(),ip_addr(""){}
            netPC(string, float, T, string);

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
template <class T>
class PCNetwork {
   private:
      typedef netPC<T>* NPCPointer;
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
      T GetMaxRam(){
                T tRam=0;
               for (unsigned int i=0; i<Length; i++) {
                if (tRam<Nodes[i]->GetRam()) tRam=Nodes[i]->GetRam();
               }
               
               return  tRam;
      }
      void AddNode(const netPC<T>&);
      void Print() const;
};
template <class T>
const unsigned int PCNetwork<T>::DEF_MAX_LENGTH = 5;

template <class T>
PCNetwork<T>::~PCNetwork() {
   for(unsigned int i=0; i<Length; i++)
      delete Nodes[i];
   delete [] Nodes;
   cout<<"PCNetwork destroyed"<<endl;
}

template <class T>
void PCNetwork<T>::Print() const {
   cout << "\nComputer's Network name: " << CNName << "." << endl
      << "Network nodes:" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}

template <class T>
void PCNetwork<T>::AddNode(const netPC<T>& Node) {
   if (Length == MaxLength)
      throw OverflowException();
   else
      Nodes[Length++] = new netPC<T>(
         Node.GetProc(), Node.GetGhz(), Node.GetRam(), Node.GetIP()
      );
}
//end lab 3 edit

template <class T>
PC<T>::PC():processor(""),ghz(0),ram(0){}

 template <class T>
PC<T>::PC(string proc_c, float ghz_c, T ram_c){
 processor=proc_c;
 ghz=ghz_c;
 ram=ram_c;
}

template <class T>
inline void PC<T>::Print() const{
	cout<<"\nProcessor: "<<processor
		 <<"\nFrecvence: "<<ghz
		 <<"\nRAM size: "<<ram<<endl;

 }

template <class T>
inline string PC<T>::GetProc() const{
  return processor  ;
}

template <class T>
inline float PC<T>::GetGhz() const{
  return ghz     ;
}

template <class T>
inline T PC<T>::GetRam() const{
  return ram   ;
}

template <class T>
 inline void PC<T>::SetProc(string newProc){
  this->processor=newProc;
 }

 template <class T>
 inline void PC<T>::SetGhz(float newGhz){
  this->ghz=newGhz;
 }

 template <class T>
 inline void PC<T>::SetRam(T newRam){
  this->ram=newRam;
 }

 template <class T>
 netPC<T>::netPC(string proc_c, float ghz_c, T ram_c, string ip_addr_c) : PC<T>(proc_c, ghz_c, ram_c) {
   ip_addr = ip_addr_c;
 }

 template <class T>
 inline void netPC<T>::Print() const {
   PC<T>::Print();
   cout << "IP Address = " << ip_addr;
 }

 void main(void){
   PCNetwork<int> *INTnetwork = new PCNetwork<int>(3, "Networks");
   PCNetwork<short> *SHORTnetwork = new PCNetwork<short>(3, "Networks");

   netPC<int>* INTnet1 = new netPC<int>("Intel Celeron",1.4,15, "112.234.123.5");
   netPC<short>* SHORTnet1 = new netPC<short>("sIntel Celeron",1.4,15, "112.234.123.5");

   netPC<int> INTnet2("Core Duo 2",3.4,14, "255.255.255.0");
   netPC<short> SHORTnet2("sCore Duo 2",3.4,14, "255.255.255.0");

   try {
      INTnetwork->AddNode(*INTnet1);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }
         try {
      SHORTnetwork->AddNode(*SHORTnet1);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      INTnetwork->AddNode(INTnet2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      SHORTnetwork->AddNode(SHORTnet2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }


      delete INTnet1;
      delete SHORTnet1;


      cout << endl << "INT line:";
      INTnetwork->Print();
      cout << endl << "SHORT line:";
      SHORTnetwork->Print();
      //cout << "\nMaxRamSize = " << network->GetMaxRam() << "." << endl;

      delete INTnetwork;
      delete SHORTnetwork;

   while (kbhit())
      getch();
   getch();
}
