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
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class ajax
 */
@WebServlet("/ajax_Distri3")
public class ajax_Distri3 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ajax_Distri3() {
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
		
		
		//2.生成SQL语句
		
		String stock1="[";
		String stock2="[";
		String stock3="[";
		String stock4="[";
		String stock5="[";
		String stock6="[";
		String stock7="[";
		String stock8="[";
		String stock9="[";
		String stock10="[";
		String stock11="[";


		
	  	List<Option> op1=new ArrayList<Option>();
	  	List<Option> op2=new ArrayList<Option>();
	  	List<Option> op3=new ArrayList<Option>();
	  	List<Option> op4=new ArrayList<Option>();
	  	List<Option> op5=new ArrayList<Option>();
	  	List<Option> op6=new ArrayList<Option>();
	  	List<Option> op7=new ArrayList<Option>();
	  	List<Option> op8=new ArrayList<Option>();
	  	List<Option> op9=new ArrayList<Option>();
	  	List<Option> op10=new ArrayList<Option>();
	  	List<Option> op11=new ArrayList<Option>();

		 		
			String sql="SELECT a.id, a.day, a.sd, a.sr, a.beta, a.alpha, a.r2 FROM prices a WHERE 10 > (SELECT COUNT(t.id) FROM prices t WHERE t.id = a.id AND t.day > a.day) AND a.id!=12 ORDER BY a.id,a.day;";
			try (Connection con = DButil.getConnection();
				
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			
				int i=0;
				
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
//                System.out.println(rs.getString(1));
                
				op1.add(t);
				
				Option p1=op1.get(i);
				String sd=Double.toString(p1.sd);
				String sr=Double.toString(p1.sr);
				String beta=Double.toString(p1.beta);
				String alpha=Double.toString(p1.alpha);
				String r2=Double.toString(p1.r2);
				stock1+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock1 is coming!!!"+stock1);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
//                System.out.println(rs.getString(1));
				op2.add(t);
				Option p2=op2.get(i);
				String sd=Double.toString(p2.sd);
				String sr=Double.toString(p2.sr);
				String beta=Double.toString(p2.beta);
				String alpha=Double.toString(p2.alpha);
				String r2=Double.toString(p2.r2);
				stock2+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock2 is coming!!!"+stock2);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op3.add(t);
				Option p3=op3.get(i);
				String sd=Double.toString(p3.sd);
				String sr=Double.toString(p3.sr);
				String beta=Double.toString(p3.beta);
				String alpha=Double.toString(p3.alpha);
				String r2=Double.toString(p3.r2);
				stock3+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock3 is coming!!!"+stock3);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op4.add(t);
				Option p4=op4.get(i);
				String sd=Double.toString(p4.sd);
				String sr=Double.toString(p4.sr);
				String beta=Double.toString(p4.beta);
				String alpha=Double.toString(p4.alpha);
				String r2=Double.toString(p4.r2);
				stock4+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock4 is coming!!!"+stock4);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op5.add(t);
				Option p5=op5.get(i);
				String sd=Double.toString(p5.sd);
				String sr=Double.toString(p5.sr);
				String beta=Double.toString(p5.beta);
				String alpha=Double.toString(p5.alpha);
				String r2=Double.toString(p5.r2);
				stock5+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock5 is coming!!!"+stock5);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op6.add(t);
				Option p6=op6.get(i);
				String sd=Double.toString(p6.sd);
				String sr=Double.toString(p6.sr);
				String beta=Double.toString(p6.beta);
				String alpha=Double.toString(p6.alpha);
				String r2=Double.toString(p6.r2);
				stock6+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock6 is coming!!!"+stock6);

				
				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op7.add(t);
				Option p7=op7.get(i);
				String sd=Double.toString(p7.sd);
				String sr=Double.toString(p7.sr);
				String beta=Double.toString(p7.beta);
				String alpha=Double.toString(p7.alpha);
				String r2=Double.toString(p7.r2);
				stock7+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock7 is coming!!!"+stock7);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op8.add(t);
				Option p8=op8.get(i);
				String sd=Double.toString(p8.sd);
				String sr=Double.toString(p8.sr);
				String beta=Double.toString(p8.beta);
				String alpha=Double.toString(p8.alpha);
				String r2=Double.toString(p8.r2);
				stock8+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock8 is coming!!!"+stock8);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op9.add(t);
				Option p9=op9.get(i);
				String sd=Double.toString(p9.sd);
				String sr=Double.toString(p9.sr);
				String beta=Double.toString(p9.beta);
				String alpha=Double.toString(p9.alpha);
				String r2=Double.toString(p9.r2);
				stock9+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock9 is coming!!!"+stock9);

				
				i=0;
				while(i<10&&rs.next()) {
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op10.add(t);
				Option p10=op10.get(i);
				String sd=Double.toString(p10.sd);
				String sr=Double.toString(p10.sr);
				String beta=Double.toString(p10.beta);
				String alpha=Double.toString(p10.alpha);
				String r2=Double.toString(p10.r2);
				stock10+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
//				System.out.println("stock10 is coming!!!"+stock10);

				
				i=0;
//				if(rs.next()) {System.out.print("rsnext is true");}
//				if(!rs.next()) {System.out.print("rsnext is not true");}

				while(i<10&&rs.next()){
				Option t=new Option();
                t.sd=rs.getDouble(3);
                t.sr=rs.getDouble(4);
                t.beta=rs.getDouble(5);
                t.alpha=rs.getDouble(6);
                t.r2=rs.getDouble(7);
				op11.add(t);
				Option p11=op11.get(i);
				String sd=Double.toString(p11.sd);
				String sr=Double.toString(p11.sr);
				String beta=Double.toString(p11.beta);
				String alpha=Double.toString(p11.alpha);
				String r2=Double.toString(p11.r2);
				
				stock11+="["+sd+","+sr+","+beta+","+alpha+","+r2+"],";
				i++;
				}//END of while
				
//				System.out.println("stock11 is coming!!!"+stock11);

					
			rs.close(); 
			con.close();
				 
		} 
		
		catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {

			System.out.println("Data Retrieval success");
		}
		stock1=stock1.substring(0,stock1.length()-1);
		stock2=stock2.substring(0,stock2.length()-1);
		stock3=stock3.substring(0,stock3.length()-1);
		stock4=stock4.substring(0,stock4.length()-1);
		stock5=stock5.substring(0,stock5.length()-1);
		stock6=stock6.substring(0,stock6.length()-1);
		stock7=stock7.substring(0,stock7.length()-1);
		stock8=stock8.substring(0,stock8.length()-1);
		stock9=stock9.substring(0,stock9.length()-1);
		stock10=stock10.substring(0,stock10.length()-1);
		stock11=stock11.substring(0,stock11.length()-1);


		out.print(stock1+"]|"+stock2+"]|"+stock3+"]|"+stock4+"]|"+stock5+"]|"+stock6+"]|"+stock7+"]|"+stock8+"]|"+stock9+"]|"+stock10+"]|"+stock11+"]");

		
	}
	
	

}
	

