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
@WebServlet("/ajax_Perf_risk")
public class ajax_Perf_risk extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ajax_Perf_risk() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1.获取参数
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		String stockname= request.getParameter("stockname");

		//2.生成SQL语句
		String sql="select sd,sr,r2,alpha,beta from prices where day=(select max(day) from prices) and name='"+stockname+"';";
		
		//3.生成op对象(把之前写的复制过来，并把之前的删掉）$('#SEL option:selected').text()
		List<Option> op=new ArrayList<Option>();
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.sd=rs.getDouble(1);
				t.sr=rs.getDouble(2);
				t.r2=rs.getDouble(3);
				t.alpha=rs.getDouble(4);
				t.beta=rs.getDouble(5);
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
		
		
		//4.Option中进行数据处理并返回数据字符串\
		
		String Risk_Data="";
		Risk_Data+=Option.deci2(op.get(0).sd)+"|";
		Risk_Data+=Option.deci2(op.get(0).sr)+"|";
		Risk_Data+=Option.deci2(op.get(0).r2)+"|";
		Risk_Data+=Option.deci2(op.get(0).alpha)+"|";
		Risk_Data+=Option.deci2(op.get(0).beta)+"";
		
		out.print(Risk_Data);

		
	}
	

}
