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
@WebServlet("/ajax_Perf_rank")
public class ajax_Perf_rank extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ajax_Perf_rank() {
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
		
		//3.生成op对象(把之前写的复制过来，并把之前的删掉）$('#SEL option:selected').text()
		List<Option> op=new ArrayList<Option>();
		String sql="select RANK from (select r100, name, id, @RankRow := @RankRow+1 as RANK from (select b.name, a.r100, a.id from prices a, stocks b where a.id=b.id and day=(select max(day) from prices)) p join (select @RankRow :=0) r order by p.r100) rx where id="+stoid+";";              
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.rank=rs.getInt(1);
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
		int rank=op.get(0).rank;
		
		//4.Option中进行数据处理并返回数据字符串\
		
		
		
		out.print(rank);

		
	}
	

}
