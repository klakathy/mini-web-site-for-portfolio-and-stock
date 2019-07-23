package dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DButil {
	private static String driverClass;
	private static String url;
	private static String user;
	private static String password;
	
	static {
		ResourceBundle rb=ResourceBundle.getBundle("db");
		driverClass=rb.getString("driverClass");
		url=rb.getString("url");
		user=rb.getString("user");
		password=rb.getString("password");
		
		try {
			Class.forName(driverClass);
		}catch(ClassNotFoundException e) {
            System.out.println("Sorry,can`t find the Driver!");   
            e.printStackTrace();   
		}
	}
	
	public static Connection getConnection() throws SQLException{
		Connection con=DriverManager.getConnection(url,user,password);
		if(!con.isClosed())
            System.out.println("Succeeded connecting to the Database!");
		return con;
	}
}
