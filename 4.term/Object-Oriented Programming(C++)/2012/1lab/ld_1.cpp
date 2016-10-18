#include <iostream>
#include <conio>
#include <string>

using namespace std;

	class PC{
		private:
			string processor;
			float ghz;
			short ram;
		public:
			PC();
			~PC(){
					cout<<"PC object destroyed!\n";
					  while (kbhit()) getch();
                      getch();
				}
			PC(string, float, short);
			
			void Print() const;//+
			//int GetInfo(string *proc, float* ghz, short* ram) const;
                        string GetProc() const;
                        float GetGhz() const;
                        short GetRam() const;
			void SetProc(string);
			void SetGhz(float);
			void SetRam(short);
	};


PC::PC():processor(0),ghz(0),ram(0){
}

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
 
void main(void){
 PC asus("intel i7",2.2,4), *acer = new PC("Core Duo 2",3.4,16);
 
 string getProc;
 float getGhz;
 short getRam;
 
  asus.Print();
  cout << endl << "**************" << endl << endl;
  //asus.GetInfo(&getProc,&getGhz,&getRam);
  getProc=asus.GetProc();
   getGhz  = asus.GetGhz();
   getRam  =  asus.GetRam();
  
	cout<<"\nProcessor: "<<getProc
		 <<"\nFrecvence: "<<getGhz
		 <<"\nRAM size: "<<getRam<<endl;
  cout << endl << "**************" << endl << endl;
  
  acer->Print();
  cout << endl << "**************" << endl << endl;
  
  acer->SetRam(4);
  acer->Print();
  cout << endl << "**************" << endl << endl;
  
  delete acer;
  
  while (kbhit())
      getch();
   getch();
}
