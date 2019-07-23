package SQL;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import option.*;
import dbutil.DButil;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import option.Option;
/**
 * Servlet implementation class ajax
 */
@WebServlet("/ajax_Perf_B")
public class ajax_Perf_B extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ajax_Perf_B() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1.获取参数
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		String stoid= request.getParameter("stockid");

		
		
		//2.生成SQL语句
		String sql="select a.id, a.r100, b.name from prices a, stocks b where a.id=b.id and b.id in ("+stoid+",2,12) order by day desc limit 3;";
		
		//3.生成op对象(把之前写的复制过来，并把之前的删掉）$('#SEL option:selected').text()
		List<Option> op=new ArrayList<Option>();

		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.r100=rs.getDouble(2);
				t.name=rs.getString(3);
				op.add(t);
			}
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
	
		
		
		String B_Data=Option.r100(op);
		
		out.print(B_Data);


		
	}
	

}
