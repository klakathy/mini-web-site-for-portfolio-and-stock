package SQL;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;

import dbutil.DButil;
import option.Option;

/**
 * Servlet implementation class Ajax_Cpn
 */
@WebServlet("/Ajax_Cpn")
public class Ajax_Cpn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id0 = request.getParameter("id0"); 
		String cpns = "";
		List<Option> op = new ArrayList<Option>();
		String sql = "select b.name,c.close,c.sd,c.sr,c.beta,c.alpha,c.r2,c.r100,b.description,c.day from (select id from weights where id="
				+ id0 + " limit 1) a, stocks b, (select id,close,sd,sr,beta,alpha,r2,r100,day from prices where id="
				+ id0 + " order by day desc limit 1) c where c.id=b.id;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if (rs.next()) {
				Option t = new Option();
				t.name = rs.getString(1);
				t.close = rs.getDouble(2);
				t.sd = rs.getDouble(3);
				t.sr = rs.getDouble(4);
				t.beta = rs.getDouble(5);
				t.alpha = rs.getDouble(6);
				t.r2 = rs.getDouble(7);
				t.r100 = rs.getDouble(8);
				t.id = rs.getString(9);// store description
				t.day = rs.getString(10);
				op.add(t);
//					System.out.printf("%s\tweight=%f\tclose=%f\tsd=%f\talpha=%f\n", t.name,t.weight,t.close,t.sd,t.alpha);
			} else {
				response.getWriter().write("no");
				response.getWriter().close();
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success");
		}

		sql = "select b.name,c.close,c.sd,c.sr,c.beta,c.alpha,c.r2,c.r100,a.weight,b.description,a.id2 from (select id2,weight from weights where id="
				+ id0
				+ ") a, stocks b, (select id,close,sd,sr,beta,alpha,r2,r100 from prices where day=(select max(day) from prices)) c where b.id=a.id2 and c.id=a.id2 order by a.weight desc;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			while (rs.next()) {
				Option t = new Option();
				t.name = rs.getString(1);
				t.weight = rs.getDouble(9);
				t.close = rs.getDouble(2);
				t.sd = rs.getDouble(3);
				t.sr = rs.getDouble(4);
				t.beta = rs.getDouble(5);
				t.alpha = rs.getDouble(6);
				t.r2 = rs.getDouble(7);
				t.r100 = rs.getDouble(8);
				t.id = rs.getString(10);// store description
				t.id2 = rs.getString(11);// store id
				op.add(t);
//				System.out.printf("%s\tweight=%f\tclose=%f\tsd=%f\talpha=%f\n", t.name,t.weight,t.close,t.sd,t.alpha);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success");
		}
		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if (value == null)
					return false;
				String[] novalues_cmp1 = new String[] { "open", "high", "low", "rank", "date", "change","wkchange" };
				for (int i_f1 = 0; i_f1 < novalues_cmp1.length; i_f1++) {
					if (novalues_cmp1[i_f1].equals(name)) {
						return false;
					}
				}
				return true;
			}
		};

		cpns = JSON.toJSONString(op, filter);
		response.getWriter().write(cpns);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
