package org.space4j.examples.phonebook;


import java.util.Collection;
import java.util.Iterator;
import java.util.Random;

import org.space4j.Space4J;


public class PhoneBookClusterStress extends PhoneBookCluster {
	
    private final Thread[] insertThread;
	
    private final Thread[] deleteThread;
	
    private final Thread[] selectThread;
	
    private final Thread[] searchThread;
	
    private Thread snapshotThread;
    
    private Random rand = new Random();
    
    private volatile long totalInserted = 0;
    private volatile long totalDeleted = 0;
    private volatile long totalSelected = 0;
    private volatile long totalSearched = 0;
    private volatile long snapshotsTaken = 0;
    
    private long started;
    
    private volatile boolean running = true;
	
    public PhoneBookClusterStress(Space4J space4j, final int nInsert, final int nDelete, final int nSelect, final int nSearch,
            final int sleepTime, final int tableSize, final int snapshotTime) throws Exception {
		
        super(space4j);
		
        // populate the table if needed...
		
        int size = users.size();
		
        if (size < tableSize) {
			
            int diff = tableSize - size;
			
            for (int i = 0; i < diff; i++) {
				
                insertRandom();
				
                System.out.print("\rInserting " + i + "...                 ");
            }
        }
		
        System.out.println();
		
        insertThread = new Thread[nInsert];
		
        deleteThread = new Thread[nDelete];
		
        selectThread = new Thread[nSelect];
		
        searchThread = new Thread[nSearch];
		                         
        for (int i = 0; i < nInsert; i++) {
            insertThread[i] = new Thread(new Runnable() {
			
                public void run() {
				
                    while (running) {
					
                        try {
						
                            Thread.sleep(sleepTime);
						
                            handleInsert();
						
                        } catch (Exception e) {
						
                            return;
                        }
                    }
                }
			
            });
        }
		
        for (int i = 0; i < nDelete; i++) {
            deleteThread[i] = new Thread(new Runnable() {
			
                public void run() {
				
                    while (running) {
					
                        try {
						
                            Thread.sleep(sleepTime);
						
                            handleDelete();
						
                        } catch (Exception e) {
						
                            return;
                        }
                    }
                }
			
            });
        }
		
        for (int i = 0; i < nSelect; i++) {
            selectThread[i] = new Thread(new Runnable() {
			
                public void run() {
				
                    while (running) {
					
                        try {
						
                            Thread.sleep(sleepTime);
						
                            handleSelect();
						
                        } catch (Exception e) {
						
                            return;
                        }
                    }
                }
			
            });
        }
		
        for (int i = 0; i < nSearch; i++) {
            searchThread[i] = new Thread(new Runnable() {
			
                public void run() {
				
                    while (running) {
					
                        try {
						
                            Thread.sleep(sleepTime);
						
                            handleSearch();
						
                        } catch (Exception e) {
						
                            return;
                        }
                    }
                }
			
            });
        }
        
        if (snapshotTime > 0) {
		
	        snapshotThread = new Thread(
	                new Runnable() {
				
	            public void run() {
					
	                while (running) {
						
	                    try {
							
	                        Thread.sleep(snapshotTime);
							
	                        System.out.println("Executing snapshot...");
							
	                        PhoneBookClusterStress.this.executeSnapshot();
							
	                        System.out.println(
	                                "=============================> Snapshot Complete!");
	                        
	                        snapshotsTaken++;
							
	                    } catch (Exception e) {
							
	                        return;
	                    }
	                }
	            }
				
	        });
        }
    }
	
    public void start() {
		
        for (int i = 0; i < insertThread.length; i++) {
            insertThread[i].start();
        }
		
        for (int i = 0; i < deleteThread.length; i++) {
            deleteThread[i].start();
        }
		
        for (int i = 0; i < selectThread.length; i++) {
            selectThread[i].start();
        }
		
        for (int i = 0; i < searchThread.length; i++) {
            searchThread[i].start();
        }
		
        snapshotThread.start();
    }
	
    protected int insertRandom() throws Exception {
    	
    	// insert a random phone number...
		
        StringBuilder sb = new StringBuilder();
        
        sb.append("Oliveira").append(rand.nextInt(100) + 1);
		
        return this.addNumber("Sergio", sb.toString(), "123-4321", rand.nextInt(100) + 1);
    }
	
    protected int deleteRandom() throws Exception {
    	
    	// delete a random phone number
    	// (guess a number, iterate to choose a phone and delete it) 

        Iterator<Integer> iter = users.keySet().iterator();
		
        int count = rand.nextInt(users.size() / 10) + 1;
		
        int index = 0;
		
        int id = -1;
		
        while (iter.hasNext() && index++ <= count) {
			
            id = iter.next();
			
        }
		
        if (id > 0) {
			
            this.delUser(id);
			
        }
		
        return id;
    }
	
    private void handleInsert() throws Exception {
		
        int id = insertRandom();
		
        System.out.println("Inserted record number " + id);
        
        totalInserted++;
    }
	
    private void handleDelete() throws Exception {
		
        int id = deleteRandom();
		
        if (id == -1) {
			
            System.out.println("Could not delete anything!");
			
        } else {
			
            System.out.println("Deleted record number " + id);
            
            totalDeleted++;
        }
    }
	
    private void handleSelect() {
    	
    	// select any 300 phone numbers and loop through them...
		
        Iterator<User> iter = users.values().iterator();
		
        int count = 0;
		
        while (iter.hasNext() && count++ <= 300) {
			
            iter.next();
        }
		
        System.out.println("Selected " + count + " records!");
        
        totalSelected += count;
    }

    private void handleSearch() {
    	
    	// choose a user and try to find his phone number...
    	
    	StringBuilder sb= new StringBuilder();
		
        sb.append("Oliveira").append(rand.nextInt(100) + 1);
		
        Collection<User> coll = this.findUsers(sb.toString());
		
        int count = 0;
		
        Iterator<User> iter = coll.iterator();
		
        while (iter.hasNext()) {
			
            count++;
			
            iter.next();
        }
		
        System.out.println("Found " + count + " recods!");
        
        totalSearched += count;
		
    }
    
    private void interruptAll() {
    	
    	for(int i=0;i<insertThread.length;i++) insertThread[i].interrupt();
    	
    	for(int i=0;i<deleteThread.length;i++) deleteThread[i].interrupt();
    	
    	for(int i=0;i<selectThread.length;i++) selectThread[i].interrupt();
    	
    	for(int i=0;i<searchThread.length;i++) searchThread[i].interrupt();
    }
	
    public static void main(String[] args) throws Exception {
		
        if (args.length >= 3) {
			
            if (args[2].equals("-nostress")) {
				
                Space4J space4j = createSpace4J(args[0], args[1]);
					
                PhoneBookCluster phone = new PhoneBookCluster(space4j);
				
                run(phone);
				
                return;
            }
			
        }
		
        if (args.length != 9) {
			
            System.out.println(
                    "format: java PhoneBookClusterStress [-master|-slave] <ip> [-nostress] <number of insert threads> <number of delete threads> "
                            + "<number of select threads> <number of search threads> <thread sleep time> <table size> <snapshot time>");
			
            return;
        }
		
        int nInsert, nDelete, nSelect, nSearch, sleepTime, tableSize, snapTime;
		
        nInsert = Integer.parseInt(args[2]);
		
        nDelete = Integer.parseInt(args[3]);
		
        nSelect = Integer.parseInt(args[4]);
		
        nSearch = Integer.parseInt(args[5]);
		
        sleepTime = Integer.parseInt(args[6]);
		
        tableSize = Integer.parseInt(args[7]);
		
        snapTime = Integer.parseInt(args[8]);
        
        // let the slaves take the snapshot
        if (args[0].equals("-master")) {
        	snapTime = 0;
        }
		
        Space4J space4j = createSpace4J(args[0], args[1]);
		
        final PhoneBookClusterStress stress = new PhoneBookClusterStress(space4j,
                nInsert, nDelete, nSelect, nSearch, sleepTime, tableSize,
                snapTime);
        
        stress.started = System.currentTimeMillis();
        
        Runtime.getRuntime().addShutdownHook(new Thread() {

            @Override
            public void run() {
            	
            	long totalInserted = stress.totalInserted;
            	long totalDeleted = stress.totalDeleted;
            	long totalSelected = stress.totalSelected;
            	long totalSearched = stress.totalSearched;
            	long snapshotsTaken = stress.snapshotsTaken;
            	long now = System.currentTimeMillis();
            	
            	stress.running = false;
            	
            	stress.interruptAll();
            	
            	try { Thread.sleep(1500); } catch(Exception e) { }
            	
            	System.out.println("\n\n========== Results:");
            	System.out.println("Inserted = " + totalInserted);
            	System.out.println("Deleted  = " + totalDeleted);
            	System.out.println("Selected = " + totalSelected);
            	System.out.println("Searched = " + totalSearched);
            	System.out.println("Snashopts= " + snapshotsTaken);
            	System.out.println("Time: " + (now - stress.started) + " ms");
            	
            }
        });
		
        stress.start();
    }
	
}
