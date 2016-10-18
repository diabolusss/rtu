    public static void main(String[] args) throws FileNotFoundException, IOExeption{
        //reading properties file in Java exmpl
		Properties props = new Properties();
		FileInputStream fis = new FileInputStream("readxmlproperties.xml");

		//loading properties from file
		props.loadFromXML(fis);

		//reading them
		String username = props.getProperty("jdbc.username");
		
		System.out.println("jdbc.username: " + username);
    }
