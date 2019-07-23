package SQL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class GetDATA {
	
    private String driver = "com.mysql.jdbc.Driver";
    private String url = "";
    private String user = "root";
    private String pass = "";
    Connection conn;
    Statement stmt;
    ResultSet rs;

    public  String executeSql(String sql) throws Exception{
    	String Res="";//!!
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url,user,pass);
            stmt = conn.createStatement();
            boolean hasResultSet = stmt.execute(sql);
            if (hasResultSet) {
                rs = stmt.getResultSet();
                java.sql.ResultSetMetaData rsmd = rs.getMetaData();
                int columnCount = rsmd.getColumnCount();
                
                
                
                
                
	            int count=rsmd.getColumnCount();
	            String[] name=new String[count];
	            for(int i=0;i<count;i++) {
	                name[i]=rsmd.getColumnName(i+1);
	            }
	
	
	            for(int j=0;j<name.length;j++) {
	            	Res+=name[j];
	            	Res+=" ";
	            }
	            Res+="<br/>";
                
                
	            
                
                
                //read the data
                while (rs.next()) {

	            	for(int i=1;i<=name.length;i++) {
	            		Res+=rs.getString(i);
	            		Res+=" ";
	            	}
	            	Res+="<br/>";
                    
                    
                    
                }
            }
            else {
                System.out.println("改SQL语句影响的记录有" + stmt.getUpdateCount() + "条");
            }
        } 
        finally
        {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return Res;
    }
    
    
    
    
    
    
	public static String SQLDATA(String Sql) throws Exception {
		if(Sql==null) {
			return "";
		}
		else {
			GetDATA ed = new GetDATA();
			String Res="";
			
			String [] Sqls = Sql.split(";");
			
	        for(int i=0;i<Sqls.length;i++) {
	        	Res+=ed.executeSql(Sqls[i]);
	        }   
	        return Res;
		}

	}


	
}
