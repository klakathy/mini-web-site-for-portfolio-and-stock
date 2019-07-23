package SQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dbutil.*;
import option.Option;

public class HisD {
	

	public static List<Option> SQLDATA(String sql) {
		List<Option> op=new ArrayList<Option>();

			try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {		
				
	            rs.first();
				
            do {
                Option t= new Option();
                t.name=rs.getString(1);
                t.date=rs.getDate(2);
                t.close=rs.getDouble(3);
                t.open=rs.getDouble(4);
                t.high=rs.getDouble(5);
                t.low=rs.getDouble(6);
                op.add(t);
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
