package SQL;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;


import dbutil.DButil;
import option.Option;
import option.OptionS;

/**
 * Servlet implementation class Ajax_Cmp
 */
@WebServlet("/Ajax_Cmp")
public class Ajax_Cmp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id0 = request.getParameter("id0"); 
		//System.out.println(id0);
		String cmp1;
		int i;
		String sql;
		Option op_cmp1 = new Option();
		op_cmp1.opdata = new ArrayList<OptionS>();
		OptionS ps_cmp1 = new OptionS();

		sql = "select * from (select description,name from stocks where id=" + id0
				+ ") b, (select dis_5,dis_4+dis_3,dis_2+dis_1,dis1+dis2,dis3+dis4,dis5,id from prices where id =" + id0
				+ " and dis_5 is not null order by day desc limit 1) a,(select close,day from prices where id=" + id0
				+ " order by day desc limit 1) c;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql);) {
			if (rs.next()) {
				op_cmp1.id = rs.getString(1); // store description
				op_cmp1.name = rs.getString(2);
				op_cmp1.sd = rs.getDouble(3); // store dis_5
				op_cmp1.sr = rs.getDouble(4); // store dis_4+dis_3
				op_cmp1.beta = rs.getDouble(5); // store dis_2+dis_1
				op_cmp1.alpha = rs.getDouble(6); // store dis2+dis1
				op_cmp1.r2 = rs.getDouble(7); // store dis4+dis3
				op_cmp1.r100 = rs.getDouble(8); // store dis5
				op_cmp1.close = rs.getDouble(10);
				op_cmp1.day = rs.getString(11);
				op_cmp1.id2 = rs.getString(9);//store id
				// System.out.printf("%s\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n",p.name,p.day,p.sd,p.sr,p.beta,p.alpha,p.r2,p.r100);
			}

		} catch (SQLException e) {
			// 数据库连接失败异常处理
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_cmp1");
		}

		sql = "select b.day,b.close,b.r100,b.close/c.close*1000 from prices b, (select close from (select day,close from prices where id="
				+ id0 + " order by day desc limit 250) a order by day limit 1) c where id=" + id0
				+ " order by day desc limit 250;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql);) {
			while (rs.next()) {
				ps_cmp1 = new OptionS();
				ps_cmp1.dd = rs.getString(1);
				ps_cmp1.cc = rs.getDouble(2);
				ps_cmp1.rr = rs.getDouble(3);
				ps_cmp1.nn = rs.getDouble(4);
				op_cmp1.opdata.add(0, ps_cmp1);
			}

		} catch (SQLException e) {
			// 数据库连接失败异常处理
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_cmp1");
		}

		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"weight","open","high","low","rank","date","change","wkchange","oo","pp","ww"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return false;
					}
				}
				return true;
			}
		};
		
		cmp1 = JSON.toJSONString(op_cmp1, filter);
		//System.out.println(cmp1.substring(0, 100));
		response.getWriter().write(cmp1);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
