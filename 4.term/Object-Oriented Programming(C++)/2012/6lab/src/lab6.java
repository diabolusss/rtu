
public class lab6 {

	/**
	 * @param args
	 */
	//PC mypc("Core Duo 2",512,4);

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PC mypc = new PC("Core Duo 2",512f,(short) 4);
		PC myEmptyPc = new PC();
		
		 String getProc;
		 float getGhz;
		 short getRam;
		 
		 System.out.println( myEmptyPc);
		 
		 myEmptyPc.setProc("Qauntum");
		 myEmptyPc.setGhz(2.2f);
		 myEmptyPc.setRam((short)4);
		 
		 System.out.println(myEmptyPc);
		 
		 getProc=mypc.getProc();
		 getGhz=mypc.getGhz();
		 getRam=mypc.getRam();
		 
		 System.out.println(mypc);
		 
		 System.out.println("");
		System.out.println("PC info!");
		System.out.println("Processor="+getProc);
		System.out.println("Ram="+getGhz);
		System.out.println("Frequence="+getRam);
		
		mypc.setGhz(3f);
		mypc.setProc("intel i7");
		mypc.setRam((short) 12);
		System.out.println("");

		System.out.println(mypc);
	}

}
