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
 * Servlet implementation class Ajax_Perf_K2
 */
@WebServlet("/Ajax_Perf_K2")
public class Ajax_Perf_K2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id0 = request.getParameter("id0"); 

		String per1;
		Option op_per1 = new Option();
		op_per1.opdata = new ArrayList<OptionS>();

		String sql="select * from (select day,open,close,high,low,sd,sr,r2,alpha,beta,otup,otdw,r100 from prices where id="
				+id0+ " order by day desc limit 250) a, (select name,description from stocks where id="+id0+") b;";

		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if(rs.next()) {
				op_per1.sd=rs.getDouble(6);
				op_per1.sr=rs.getDouble(7);
				op_per1.r2=rs.getDouble(8);
				op_per1.alpha=rs.getDouble(9);
				op_per1.beta=rs.getDouble(10);
				op_per1.close=rs.getDouble(3);
				op_per1.day=rs.getString(1);
				op_per1.r100=rs.getDouble(13);
				op_per1.name=rs.getString(14);
				op_per1.id=rs.getString(15); //description
			}
			do {
				OptionS t=new OptionS();
				t.dd=rs.getString(1); //day
				t.oo=rs.getDouble(2); //open
				t.cc=rs.getDouble(3); //close
				t.nn=rs.getDouble(4); //high
				t.ll=rs.getDouble(5); //low
				t.pp=rs.getDouble(11);//outlier up
				t.ww=rs.getDouble(12);//outlier down
				t.rr=rs.getDouble(13);//r100
				op_per1.opdata.add(0,t);
			}while(rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_perf_K2");
		}
		
		sql="select RANK from (select r100, name, id, @RankRow := @RankRow+1 as RANK from (select b.name, a.r100, a.id from prices a, stocks b where a.id=b.id and day=(select max(day) from prices)) p join (select @RankRow :=0) r order by p.r100) rx where id="+id0+";";              
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			if(rs.next()) {
				op_per1.rank=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_perf_rank");
		}

		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"weight","open","date","high","low","change","wkchange"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return false;
					}
				}
				return true;
			}
		};
		
		per1 = JSON.toJSONString(op_per1,filter);
		//System.out.println(cmp1.substring(0, 100));
		response.getWriter().write(per1);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
