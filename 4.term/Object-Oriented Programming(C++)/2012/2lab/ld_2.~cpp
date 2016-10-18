#include <iostream>
#include <conio>
#include <string>

using namespace std;

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
  const int N = 3;

  netPC *npc1 = new netPC("Core Duo 2",3.4,16, "255.255.255.0");
  PC    *npc2 = new netPC();

  PC *asus[N] = {
      new PC("Intel i7",5.0,15),
      new netPC(),
      new netPC("Intel Celeron",1.4,15, "112.234.123.5")
   };
   clrscr();

   cout << "List of asus laptops: " << endl;
   for(int i=0; i<N; i++) {
      cout << (i+1) << ". ";
      asus[i]->Print();
      cout << endl;
   }

   cout << endl << "Display Net Computer:" << endl;
   npc1->Print();
   cout << "\nProcessor: = " << npc1->GetProc() << ".";
   cout << "\nFrecvence: = " << npc1->GetGhz()  << ".";
   cout << "\nRAM = " << npc1->GetRam()  << ".";
   cout << "\nColor = " << npc1->GetIP() << "." << endl << endl;

   for(int k=0; k<N; k++) {
     delete asus[k];
   }
   delete npc1;
   delete npc2;

   while (kbhit())
      getch();
   getch();
}
