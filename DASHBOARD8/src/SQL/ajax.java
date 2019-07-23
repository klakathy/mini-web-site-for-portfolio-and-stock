package SQL;

import java.io.IOException;
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
/**
 * Servlet implementation class ajax
 */
@WebServlet("/ajax")
public class ajax extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ajax() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		String fullname= request.getParameter("LongName");
		PrintWriter out = response.getWriter();
		
		String NameList[] = fullname.split("_");
		
		String sqlN="select day,sum(open) as open,sum(close) as close,sum(high) as high,sum(low) as low from prices where name in (";
		for(int i=0;i<NameList.length;i++) {
			
			sqlN+="'"+NameList[i]+"'";
			sqlN+=",";
		}
		sqlN = sqlN.substring(0,sqlN.length()-1);
		
		sqlN+=") group by day;";
		
		String sql=sqlN;
		List<Option> op= CustM.Custm(sql);
		String K_Sum_Data=Option.K_Charts(op);
		
		out.print(K_Sum_Data);

		
	}
	

}
