package SQL;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbutil.DButil;

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
@WebServlet("/ajax_CustM_H")
public class ajax_CustM_H extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String f = request.getParameter("f");
		String namep = request.getParameter("namep");
		String idp = "";
		String sql;
		String maxday = "", minday = "", sectorp = "";
		if (f.equals("1")) {
			sql = "select * from stocks where name = '" + namep + "'";
			try (Connection con = DButil.getConnection();
					Statement statement = con.createStatement();
					ResultSet rs = statement.executeQuery(sql)) {
				if (rs.next()) {
					response.getWriter().write("no");
				}
				response.getWriter().close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally {
				System.out.println("Data Retrieval success_save1");
			}
			response.getWriter().write("error");
			response.getWriter().close();
		}

		String desp = request.getParameter("desp");
		String fullids = request.getParameter("fullids");
		String Cust_weight = request.getParameter("fullweights");

		String idList[] = fullids.split("_");
		String idWeight[] = Cust_weight.split("_");
		String inids = "";
		int l = idList.length;
		if (l == 0) {
			response.getWriter().write("no");
			response.getWriter().close();
		}

		int i = 0;
		for (i = 0; i < idList.length; i++) {
			inids += "'" + idList[i] + "',";
		}
		inids = inids.substring(0, inids.length() - 1);

		// 1 get id,sector,max day,min day; and save in stocks
		sql = "select * from (select max(--id)+1 from stocks) a,(select distinct sector from stocks where id in ("
				+ inids + ")) b,(select max(day) as mday from prices where id in (" + inids
				+ ") group by id order by mday limit 1) c, (select min(day) as minday from prices where id in (" + inids
				+ ") group by id order by minday desc limit 1) d;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if (rs.next()) {
				idp = String.valueOf(rs.getInt(1));
				sectorp = rs.getString(2);
				maxday = rs.getString(3);
				minday = rs.getString(4);
			} else {
				response.getWriter().write("no2");
				response.getWriter().close();
			}
			if (rs.next())
				sectorp = "99";
			//System.out.println(idp);
			Statement stmt = con.createStatement();
			int flag = stmt.executeUpdate("insert into stocks(id,name,description,sector,type) values('" + idp + "','"
					+ namep + "','" + desp + "','" + sectorp + "','portfolio');");
			if (flag <= 0) {
				response.getWriter().write("no2");
				response.getWriter().close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_save2");
		}

		// 2 save in prices close,open,high,low,r100
		sql = "select day, sum(cc),sum(oo) from (";
		for (i = 0; i < idList.length; i++) {
			sql += "select day, close*" + idWeight[i] + " as cc,open*" + idWeight[i] + " as oo from prices where id='"
					+ idList[i] + "' union all ";
		}
		sql = sql.substring(0, sql.length() - 11);
		sql += ") t2 where day <= '" + maxday + "' and day >= '" + minday + "' group by day order by day;";

		double tmpclose = -100;
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if (rs.next()) {
				int size = 0;
				String sql3 = "";
				do {
					Option t = new Option();
					t.open = rs.getDouble(3);
					t.close = rs.getDouble(2);
					// t.date = rs.getDate(1);
					if (t.close > t.open) {
						t.high = t.close;
						t.low = t.open;
					} else {
						t.high = t.open;
						t.low = t.close;
					}
					Statement stmt = con.createStatement();
					if (tmpclose != -100) {
						t.r100 = (t.close - tmpclose) / tmpclose *100;
						stmt.executeUpdate("insert into prices(id,name,day,close,open,high,low,r100) values ('" + idp + "','" + namep
								+ "','" + rs.getString(1) + "'," + t.close +","+t.open+","+t.high+"," +t.low+","+t.r100+");");						
						//sql3 += "insert into prices(id,name,day,close,open,high,low,r100) values ('" + idp + "','" + namep+ "','" + rs.getString(1) + "'," + t.close +","+t.open+","+t.high+"," +t.low+","+t.r100+"); ";
					}else {
						stmt.executeUpdate("insert into prices(id,name,day,close,open,high,low) values ('" + idp + "','" + namep
								+ "','" + rs.getString(1) + "'," + t.close +","+t.open+","+t.high+"," +t.low+"); ");
					
						//sql3 += "insert into prices(id,name,day,close,open,high,low) values ('" + idp + "','" + namep+ "','" + rs.getString(1) + "'," + t.close +","+t.open+","+t.high+"," +t.low+"); ";
					}
					tmpclose = t.close;
					// op.add(t);
					
//					size++;
//					if(size==100) {
//						GetDATA A = new GetDATA();
//						try {
//							String RES = A.SQLDATA(sql3);
//							System.out.print(RES);
//						} catch (Exception e) {
//							// TODO Auto-generated catch block
//							e.printStackTrace();
//						}
//						size=0;
//						sql3="";
//					}
				} while (rs.next());
//				if(!sql3.equals("")) {
//					GetDATA A = new GetDATA();
//					try {
//						String RES = A.SQLDATA(sql3);
//						System.out.print(RES);
//					} catch (Exception e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//				}
			} else {
				response.getWriter().write("no2");
				response.getWriter().close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_save3");
		}

		// 4 save in weights
		double closesum = tmpclose;
		double closethis = 0;
		String sql2 = "";
		sql = "select b.id,a.close from (select close,id from prices where day = (select max(day) as mday from prices where id in ("
				+ inids + ") group by id order by mday limit 1)) a, stocks b where a.id in (" + inids
				+ ") and a.id=b.id;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			if (rs.next()) {
				do {
					String tmpid = rs.getString(1);
					closethis = rs.getDouble(2);
					for (int j = 0; j < l; j++) {
						if (tmpid.equals(idList[j])) {
							closethis = Double.parseDouble(idWeight[j]) * closethis / closesum*100;
							break;
						}
					}
					//sql2 += "insert into weights(id,id2,weight) values ('" + idp + "','" + tmpid + "'," + closethis+ "); ";
					Statement stmt = con.createStatement();
					stmt.executeUpdate("insert into weights(id,id2,weight) values ('" + idp + "','" + tmpid + "'," + closethis+ "); ");
				} while (rs.next());
//				GetDATA A = new GetDATA();
//				try {
//					String RES = A.SQLDATA(sql2);
//					System.out.print(RES);
//				} catch (Exception e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
			} else {
				response.getWriter().write("no2");
				response.getWriter().close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_custom2");
		}

		// 5 update sd,sr,alpha,beta,r2; update otup,otdw; update dis
		Risks.rall(idp);
		Risks.rout(idp);
		Risks.rdis(idp);

		response.getWriter().write("succeed");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

	}

}
