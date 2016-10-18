package org.space4j.examples.phonebook;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

import org.space4j.CommandException;
import org.space4j.LoggerException;
import org.space4j.Space;
import org.space4j.Space4J;
import org.space4j.command.CreateMapCmd;
import org.space4j.command.CreateSequenceCmd;
import org.space4j.command.IncrementSeqCmd;
import org.space4j.command.PutCmd;
import org.space4j.command.RemoveCmd;
import org.space4j.implementation.SimpleSpace4J;


/**
 * This is a simple application demonstrating how Space4J can be easily used as a database.
 * 
 * To execute just do:
 * 
 * java org.space4j.demo.phonebook.PhoneBook
 * 
 * @author Sergio Oliveira Jr.
 */
public class PhoneBook {
	
    // This would be equivalent to a table name...
    protected static final String MAP_NAME = "phonenumbers";
	
    // This is a sequence (like Oracle) used to create unique ids...
    protected static final String SEQ_NAME = "phone_seq";
    
    protected Space4J space4j = null;

    // The space is where all our data is located...
    protected Space space = null;
    
    protected Map<Integer, User> users = null;
    
    public PhoneBook(Space4J space4j) throws Exception {
    	
        this.space4j = space4j;
    	
        // Start the system...
        space4j.start();
        
        // Grab the space where all data resides...
        space = space4j.getSpace();
        
        /*
         * If this is the first time, create our map that will hold our
         * User objects. Space4J comes with many ready-to-use commands.
         * One of them is the CreateMapCmd, that will create our initial
         * empty map that to hold our objects.
         */
        if (!space.check(MAP_NAME)) {
        	
            space4j.exec(new CreateMapCmd<Integer, User>(MAP_NAME));
        }

        /*
         * Save the map reference, so that we don't have to 
         * get it from the Space every time.
         */
        users = space.get(MAP_NAME);
        
        /*
         * If this is the first time, create the sequence for the unique ids
         * using the Space4J CreateSequenceCmd.
         */
        if (!space.check(SEQ_NAME)) {
        	
            space4j.exec(new CreateSequenceCmd(SEQ_NAME));
        }
    }
    
    public void executeSnapshot() throws Exception {
    	
        space4j.executeSnapshot();
    }
    
    /*
     * Increment the sequence and return it,
     * by using the <i>IncrementSeqCmd</i> command.
     */
    protected int getNextId() throws Exception {
    	
        return space4j.exec(new IncrementSeqCmd(SEQ_NAME));
    	
    }
    
    /*
     * Create a new User object and insert it in our map.
     * 
     * We will use the <i>PutCmd</i> for doing that.
     */
    public int addNumber(String first, String last, String phone, int age) throws Exception {
    	
        int id = getNextId();
    	
        User user = new User(id, first, last, phone, age);
    	
        int x = space4j.exec(new PutCmd(MAP_NAME, id, user));
        
        if (x == 1) {
            
            return id;
        }
        
        return -1;
    }
    
    /*
     * Find an User by last name. Notice here that we are not using
     * any kind of indexing, in other words, we are iterating through 
     * all our records to find what we want. This is equivalent to a
     * full table scan in a relational database.
     */
    public Collection<User> findUsers(String last) {
    	
        Collection<User> results = new LinkedList<User>();
    	
        Iterator<User> iter = space.getIterator(MAP_NAME);
    	
        while (iter.hasNext()) {
    		
            User u = iter.next();
    		
            if (u.last.indexOf(last) != -1) {
    		
                results.add(u);
    			
            }
        }
    	
        return results;
    }
    
    /*
     * Find a list of users between minAge and maxAge. Note
     * again that we are not using any index, in other words,
     * a full table scan is being performed.
     * 
     */
    public Collection<User> findUsers(int minAge, int maxAge) {
       
       Collection<User> results = new LinkedList<User>();
      
       Iterator<User> iter = space.getIterator(MAP_NAME);
      
       while (iter.hasNext()) {
         
           User u = iter.next();
         
           if (u.getAge() >= minAge && u.getAge() <= maxAge) {
         
               results.add(u);
            
           }
       }
      
       return results;
    }
    
    /*
     * Remove an user by its id from our map.
     * 
     * We will use the <i>RemoveCmd</i> command to do that.
     */
    public boolean delUser(int id) throws CommandException, LoggerException {
    	
        int x = space4j.exec(new RemoveCmd(MAP_NAME, id));
        
        return x > 0;
        
    }
    
    /*
     * Get an iterator so that we can iterate through
     * all our objects inside our map. This is equivalent
     * to a <i>select * from Users</i> in a relational
     * database.
     */
    public Iterator<User> getUsers() {
    	
        return space.getIterator(MAP_NAME);
        
    }
    
    /*
     * Our User object. Remember that it must be serializable. 
     */
    public static class User implements Serializable {
    	
        private static final long serialVersionUID = 1;
    	
        private int id;
    	
        private String first;
    	
        private String last;
    	
        private String phone;
        
        private int age;
    	
        public User(int id, String first, String last, String phone, int age) {
    		
            this.id = id;
    		
            this.first = first;
    		
            this.last = last;
    		
            this.phone = phone;
            
            this.age = age;
    		
        }
    	
        public String toString() {
    		
            StringBuilder sb = new StringBuilder(64);
    		
            sb.append(id).append(": ").append(first).append(" ").append(last);
    		
            sb.append(" (").append(age).append("): ").append(phone);
    		
            return sb.toString();
        }
    	
        public int getId() {
    		
            return id;
        }
    	
        public String getFirstName() {
    		
            return first;
        }
    	
        public String getLastName() {
    		
            return last;
        }
    	
        public String getPhoneNumber() {
    		
            return phone;
        }
    	
        public int hashCode() {
    		
            return id;
        }
        
        public int getAge() {
           
           return age;
        }
    	
        public boolean equals(Object obj) {
    		
            if (obj instanceof User) {
    			
                User u = (User) obj;
    			
                if (u.id == this.id) {
                    return true;
                }
    			
            }
    		
            return false;
        }
    }
    
    /**
     * Just some simple logic for a minimal PhoneBook application.
     * NOTE: This is java code, not Space4J code!
     */
    public static void run(PhoneBook book) throws Exception {
    	
        final String header = "(L)ist | (A)dd | Find by (N)ame | (F)ind by Age  | (R)emove | (S)napshot | (Q)uit => ";
        
        BufferedReader input = new BufferedReader(
                new InputStreamReader(System.in));
        
        System.out.print(header);
        
        while (true) {
        	
            String cmd = input.readLine();
            
            System.out.println();
            
            if (cmd.equalsIgnoreCase("l")) {
            	
                Iterator<User> iter = book.getUsers();
                
                int total = 0;
            	
                while (iter.hasNext()) {
                	
                    User u = iter.next();
                    
                    System.out.println(u.getId() + ": " + u);
                    
                    total++;
                    
                }
                
                System.out.println("\nTotal: " + total + "\n");
                
            } else if (cmd.equalsIgnoreCase("a")) {
            	
                System.out.print("First Name: ");
                
                String first = input.readLine();
                
                System.out.print("Last Name: ");
                
                String last = input.readLine();
                
                System.out.print("Age: ");
                
                String age = input.readLine();
                
                System.out.print("Tel: ");
                
                String phone = input.readLine();
                
                if (!first.trim().equals("") && !last.trim().equals("")
                        && !phone.trim().equals("") && !age.trim().equals("")) {
                   
                   int x = -1;
                   
                   try {
                      x = Integer.parseInt(age);
                      
                   } catch(Exception e) {
                      
                      System.out.println("Invalid age: " + age + "\n");
                   }
                   
                   if (x > 0) {
                	
                      int id = book.addNumber(first, last, phone, x);
                    
                      System.out.println("\nRecord added! (id = " + id + ")\n");
                      
                   }
                }
                
            } else if (cmd.equalsIgnoreCase("n")) {
            	
                System.out.print("Last Name: ");
                
                String last = input.readLine();
                
                System.out.println();
                
                Collection<User> results = book.findUsers(last);
                
                if (results != null && results.size() > 0) {
                	
                    Iterator<User> iter = results.iterator();
                	
                    while (iter.hasNext()) {
                		
                        User u = iter.next();
                		
                        System.out.println(
                                u.getId() + ": " + u);
                    }
                	
                    System.out.println("\nTotal found: " + results.size() + "\n");
                    
                } else {
                	
                    System.out.println("\nNothing found!\n");
                    
                }
                
            } else if (cmd.equalsIgnoreCase("f")) {
               
               System.out.print("Min Age: ");
               
               String min = input.readLine();
               
               System.out.print("Max Age: ");
               
               String max = input.readLine();
               
               System.out.println();
               
               int x = -1, y = -1;
               
               try {
                  x = Integer.parseInt(min);
                  y = Integer.parseInt(max);
               } catch(Exception e) {
                  
                  System.out.println("Invalid ages!\n");
               }
               
               if (x >= 0 && y >= 0) {
               
                  Collection<User> results = book.findUsers(x ,y);
               
                  if (results != null && results.size() > 0) {
                     
                      Iterator<User> iter = results.iterator();
                     
                      while (iter.hasNext()) {
                        
                          User u = iter.next();
                        
                          System.out.println(u.getId() + ": " + u);
                      }
                     
                      System.out.println("\nTotal found: " + results.size() + "\n");
                      
                  } else {
                     
                      System.out.println("\nNothing found!\n");
                      
                  }
               }
                
            } else if (cmd.equalsIgnoreCase("r")) {
            	
                System.out.print("Record ID: ");
                
                try { 
                	
                    int id = Integer.parseInt(input.readLine());
                	
                    if (book.delUser(id)) {
                    	
                        System.out.println("Item removed!\n");
                        
                    } else {
                    	
                        System.out.println("Not found!\n");
                        
                    }
                	
                } catch (Exception e) {
                	
                    System.out.println("Please enter only numbers here!");
                }
                
            } else if (cmd.equalsIgnoreCase("s")) {
            	
                book.executeSnapshot();
                
                System.out.println("Snapshot taken!\n");
                
            } else if (cmd.equalsIgnoreCase("q")) {
            	
                break;
                
            }
            
            System.out.print(header);
        }

    }

    public static void main(String[] args) throws Exception {
    	
        PhoneBook book = new PhoneBook(new SimpleSpace4J("PhoneBook"));

        run(book);
    	
    }
}
