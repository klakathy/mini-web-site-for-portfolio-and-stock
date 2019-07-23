package SQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import dbutil.*;
import option.Option;

public class Distri {

	 public static List<Option> SQLDATA(String sql) {
			List<Option> op=new ArrayList<Option>();
			
		
		  //String sql=new String("select * from prices where id=1 limit 10;");
		 
			
			try (Connection con = DButil.getConnection();
					Statement statement = con.createStatement();
					ResultSet rs = statement.executeQuery(sql)) {		
		            rs.first();
					
		        //int i =0;
	            do {
	                Option t= new Option();
	                t.name=rs.getString(1);
	                t.date=rs.getDate(2);
	                t.close=rs.getDouble(3);

				/*
				 * if(i>=4||(i+1)%5==0) {
				 * t.wkchange=(t.close-op.get(i-4).close)/op.get(i-4).close; }else
				 * {t.wkchange=0;}
				 */

	                op.add(t);
	                //System.out.printf("%s\t%s\n",t.date,t.wkchange);
	                //i++;
	                }while(rs.next());
	                
				
				rs.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally {
				System.out.println("Data Retrieval success");
			}
	        return op;
	    }
}
