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
 * Servlet implementation class Ajax_DA
 */
@WebServlet("/Ajax_DA")
public class Ajax_DA extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id0 = request.getParameter("id0"); 
		String da1="";
		List<Option> op=new ArrayList<Option>();
		String sql = "select * from (select name,description from stocks where id ="
				+ id0 + ") a, (select close,day,r100,sd,sr,alpha,beta,r2 from prices where id="
				+ id0 + " order by day desc limit 1) b;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if(rs.next()) {
				Option t=new Option();
				t.name=rs.getString(1);
				t.id=rs.getString(2);
				t.close=rs.getDouble(3);
				t.day=rs.getString(4);
				t.r100=rs.getDouble(5);
				t.sd=rs.getDouble(6);
				t.sr=rs.getDouble(7);
				t.alpha=rs.getDouble(8);
				t.beta=rs.getDouble(9);
				t.r2=rs.getDouble(10);
				op.add(t);
				//System.out.println(t.name);
			//System.out.printf("%s\tweight=%f\tclose=%f\tsd=%f\talpha=%f\n", t.name,t.weight,t.low,t.sd,t.alpha);											
			}else {
				response.getWriter().write("no");
				response.getWriter().close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_DA1");
		}
		
		sql = "select b.sector,c.day,count(a.id2),sum(a.weight),sum(c.r100*a.weight)/sum(a.weight),e.r100 from stocks b, (select id2, weight from weights where id="
				+ id0 + ") a, (select a.* from (select id,day,r100 from prices where id in (select id2 from weights where id="
				+ id0 + ")) a, (select day from prices where id = (select id from prices where id in (select id2 from weights where id="
				+ id0 + ") group by id order by max(day) limit 1) order by day desc limit 30) b where a.day=b.day and a.r100 is not null) c, (select r100,day from prices where id=12) e where a.id2=b.id and c.id=b.id and e.day=c.day group by b.sector,c.day order by sum(a.weight) desc,sector,day;";
		int i=0;
		String[] secs=new String[] {"Consumer Discretionary","Consumer Staples","Energy","Financials","Health Care","Industrials","Information Technology","Materials","Real Estate","Communication Services","Utilities","Other"};
		String[] secs2=new String[] {"SRCD","SRCS","SREN","SRFI","SRHC","SRIN","SRIT","SRMA","SRRE","SRTS","SRUT","Other"};
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			double[] x0=new double[30];//sp500
			double[] y0=new double[30];
			while(rs.next()) {
				y0[i]=rs.getDouble(5);
				x0[i]=rs.getDouble(6);//sp500
				i++;
				Option t=new Option();
				if(i==30) {			//not considering available rows < 30 !!!!!!!!!!!!!!!!!		
					int a=rs.getInt(1);
					if(a>11) {a=12;}
					t.name=secs2[a-1];
					t.id=secs[a-1];
					t.rank=a;//store sector id for visual map
					t.close=rs.getDouble(3);//count stock in one sector
					t.day=rs.getString(2);//newest day of the stock whose day is the oldest one					
					t.weight=rs.getDouble(4);//sum weight
					t.r100=Risks.rsum(y0)/y0.length;//mean of {sum(weight*r100)/sum(weight) by sector}   per day
					t.sd=Risks.rd(y0);
					t.alpha=Risks.ralpha(x0, y0);
					t.beta=Risks.rbeta(x0, y0);
					t.r2=Risks.rr2(x0, y0);
					t.sr=Risks.rsha(y0);
					op.add(t);
					i=0;
					x0=new double[30];y0=new double[30];
					//System.out.printf("%s\tweight=%f\tclose=%f\tsd=%f\talpha=%f\n", t.name,t.weight,t.low,t.sd,t.alpha);
				}									
//				System.out.printf("%s\tweight=%f\tclose=%f\tsd=%f\talpha=%f\n", t.name,t.weight,t.close,t.sd,t.alpha);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_DA2");
		}
		
		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"open","high","low","date","change","wkchange","opdata"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return false;
					}
				}
				return true;
			}
		};
		
		da1 = JSON.toJSONString(op, filter);
		
		response.getWriter().write(da1);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
