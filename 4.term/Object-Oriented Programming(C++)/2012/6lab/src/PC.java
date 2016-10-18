
public class PC {

		String processor;
		float ghz;
		short ram;

		private final static String defP="";
		private final static float defG=0;
		private final static short defR=0;
		
		//nav inicializatoru
		public PC(){
			this.processor =defP;
			this.ghz = defG;
			this.ram = defR;			
		}
		//PC(string, float, short);
		public PC(String processor,float ghz,short ram){
			this.processor =processor;
			this.ghz = ghz;
			this.ram = ram;			
		}
		
		//nav destruktoru
		//~PC(){
		//		cout<<"PC object destroyed!\n";
		///		  while (kbhit()) getch();
        //          getch();
		//	}		
		
		//nav sekcijas public
        //string GetProc() const;
		public String getProc(){
			return processor;
		}
//      float GetGhz() const;
		public float getGhz(){
			return ghz;
		}
//      short GetRam() const;
		public short getRam(){
			return ram;
		}      
        
		//void SetProc(string);
		void setProc(String processor){
			this.processor=processor;
		}
		//void SetGhz(float);
		void setGhz(float ghz){
			this.ghz=ghz;
		}
		//void SetRam(short);
		void setRam(short ram){
			this.ram=ram;
		}
		//void Print() const;//+
		public String toString(){
			return "Processor="+processor+" Ram="+ghz+" Frequence="+ram;
		}
}
