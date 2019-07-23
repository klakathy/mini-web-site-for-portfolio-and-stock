package SQL;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbutil.DButil;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import option.Option;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import dbutil.*;
import option.Option;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class ajax
 */
@WebServlet("/Ajax_Hist")
public class Ajax_Hist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Ajax_Hist() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1.获取参数
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		
		

		String Stoid = request.getParameter("StockId");
		
		
		//2.生成SQL语句
		String sql="select * from prices where id="+Stoid+";";
		
		//3.生成op对象(把之前写的复制过来，并把之前的删掉）$('#SEL option:selected').text()
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
		
		DateFormat dateFormat=new  SimpleDateFormat("yyyyMMdd");
		String realInside1=new String();
		double change=0;
		
		 for(int i=0; i<op.size();i++){
			 String[] inside1 = new String[7];
			 Option p1=op.get(i);
			 
			 inside1[0]=p1.name;
			 inside1[1]=dateFormat.format(p1.date);
			 inside1[2]=Double.toString(p1.close);
			 inside1[3]=Double.toString(p1.open);
			 inside1[4]=Double.toString(p1.high);
			 inside1[5]=Double.toString(p1.low);
			 	if(i!=0)
				{change=op.get(i).low-op.get(i-1).low;}
				DecimalFormat f= new DecimalFormat("#.00");
				String changeS=f.format(change);
			 inside1[6]=changeS;
//			 inside1[6]=Double.toString(change);
			 
			 
			 realInside1+="["+inside1[0]+","+inside1[1]+","+inside1[2]+","+inside1[3]+","+inside1[4]+","+inside1[5]+","+inside1[6]+"]"+",";

	 	
	}

		 realInside1=realInside1.substring(0,realInside1.length()-1);
		 realInside1="["+realInside1+"]";
	

			out.print(realInside1);

}
}
	

