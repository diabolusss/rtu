package org.space4j.examples.phonebook;


import java.util.Collection;
import java.util.Set;
import java.util.concurrent.ConcurrentNavigableMap;

import org.space4j.Space4J;
import org.space4j.implementation.SimpleSpace4J;
import org.space4j.indexing.CollectionOfSets;
import org.space4j.indexing.Index;
import org.space4j.indexing.IndexManager;
import org.space4j.indexing.Key;
import org.space4j.indexing.MultiMap;
import org.space4j.indexing.MultiSortedMap;

public class PhoneBookIndexing extends PhoneBook {
	
    private static final String INDX_LASTNAME = "indx_lastname";
    
    private static final String INDX_AGE = "indx_age";
	
    private final Index<User> indexByLastName;
    
    private final Index<User> indexByAge;
	
    public PhoneBookIndexing(Space4J space4j) throws Exception {
    	
        super(space4j);
    	
        IndexManager im = space.getIndexManager();
    	
        // If index does not exist, let's create it...
        if (!im.checkIndex(INDX_LASTNAME)) {
            
            /*
             * Index name = INDX_LASTNAME
             * Map in the Space that will be indexed = MAP_NAME
             * Type of index = MULTI = non-unique index
             * Object that will be indexed = User.class
             * Atributes of the object that will be indexed = "lastName"
             * 
             * We want to create this index because we will be searching
             * for Users by lastName. We don't want to do a full table
             * scan anymore like in the example without indexes.
             */
        	
            Index<User> indx = new Index<User>(INDX_LASTNAME, MAP_NAME, Index.TYPE.MULTI, User.class, "lastName");
        	
            boolean ok = im.createIndex(indx, space4j);
            
            if (ok) {
            	
                System.out.println(indx + " created!");
            	
            } else {
            	
                System.out.println(indx + " could not be created!");
            }
        }
        
        // If index does not exist, let's create it...
        if (!im.checkIndex(INDX_AGE)) {
            
            /*
             * Index name = INDX_AGE
             * Map in the Space that will be indexed = MAP_NAME
             * Type of index = MULTI = non-unique sorted index
             * Object that will be indexed = User.class
             * Atributes of the object that will be indexed = "age"
             * 
             * We want to create this index because we will be searching
             * for Users by age. The index will be SORTED because we want
             * to search for users in a age range. (age > min and age < max)
             */
         
            Index<User> indx = new Index<User>(INDX_AGE, MAP_NAME, Index.TYPE.MULTI_SORTED, User.class, "age");
         
            boolean ok = im.createIndex(indx, space4j);
            
            if (ok) {
               
                System.out.println(indx + " created!");
               
            } else {
               
                System.out.println(indx + " could not be created!");
            }
        }

        
        indexByLastName = im.getIndex(INDX_LASTNAME);
        indexByAge = im.getIndex(INDX_AGE);
    }
    
    /*
     * Let's override our search method to use our
     * index instead of doing a full table scan.
     */
    @Override
    public Collection<User> findUsers(String last) {
	
    	// Remember that our index is of the type MULTI.
    	
        MultiMap<User> map = indexByLastName.getMap();
        
        // A multi-map will store a Set for each key.
        // That's why our index is NON-UNIQUE meaning the same
        // key (lastName) can be associated with different entries in the map.
        // That makes sense as some users can have the same last name.
    	
       return map.get(last);
    }
    
    @Override
    public Collection<User> findUsers(int minAge, int maxAge) {
       
       // Remember that our index is of the type MULTI_SORTED.
       
       MultiSortedMap<User> map = indexByAge.getMap();
       
       // A multi-sorted-map will store a Set for each key.
       // That's why our index is NON-UNIQUE meaning the same
       // key (minAge, maxAge) can be associated with different entries in the map.
       // The map is also sorted by its key, meaning we can
       // perform range searches efficiently like below.
       
       return map.subMapValues(new Key(minAge), true, new Key(maxAge), true);
    }
    
    public static void main(String[] args) throws Exception {
    	
        PhoneBookIndexing book = new PhoneBookIndexing(
                new SimpleSpace4J("PhoneBook"));

        run(book);
    	
    }
}
