package org.space4j.examples.phonebook;


import org.space4j.Space4J;
import org.space4j.implementation.MasterSpace4J;
import org.space4j.implementation.SlaveSpace4J;


/**
 * This is to show you how simple it is to make a Space4J cluster!
 * 
 * To make a cluster, open up two shells (or DOS) and execute in the first:
 * 
 * java org.space4j.demos.phonebook.PhoneBookCluster master
 * 
 * and in the second:
 * 
 * java org.space4j.demos.PhoneBookCluster slave 127.0.0.1
 * 
 * You can also use two different machines. Just pass the master IP address to the slave instead of 127.0.0.1.
 * IMPORTANT: If you use two different machines, you must have the main Space4J dir (space4j_db) mounted, so 
 * both machines can have access to it.
 */
public class PhoneBookCluster extends PhoneBookIndexing {
    
    public PhoneBookCluster(Space4J space4j) throws Exception {
    	
        super(space4j);
    	
    }
    
    static Space4J createSpace4J(String master, String master_ip) throws Exception {
    	
        Space4J space4j = null;
    	
        if (master.equals("-master")) {
        	
            space4j = new MasterSpace4J("PhoneBook");
        	
        } else if (master.equals("-slave")) {
        	
            if (master_ip != null) {
            	
                space4j = new SlaveSpace4J("PhoneBook", master_ip);
            	
            } else {
            	
                space4j = new SlaveSpace4J("PhoneBook", "127.0.0.1");
            	
            }
        }
        
        return space4j;
    }
    
    public static void main(String[] args) throws Exception {
    	
        if (args.length < 1 || args.length > 2) {
    		
            System.out.println(
                    "format: java PhoneBookCluster [-master|-slave] <IP def: 127.0.0.1>");
    		
            return;
        }
    	
        Space4J space4j = createSpace4J(args[0],
                args.length > 1 ? args[1] : null);
    	
        PhoneBookCluster book = new PhoneBookCluster(space4j);
        
        run(book);
    }
}
