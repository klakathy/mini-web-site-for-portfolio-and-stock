package SQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dbutil.*;
import option.Option;

public class Perf {
	

			
	public static List<Option> perf(List<Option> op,String stoname) {

		String sql="select day,open,close,high,low from prices where name='"+stoname+"' order by day limit 1,200";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.day=rs.getString(1);
				t.open=rs.getDouble(2);
				t.close=rs.getDouble(3);
				t.high=rs.getDouble(4);
				t.low=rs.getDouble(5);
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
		return op;
	}
	
	
	public static List<Option> risk(String stoname) {
		List<Option> op=new ArrayList<Option>();
		String sql="select sd,sr,r2,alpha,beta from prices where day=(select max(day) from prices) and name='"+stoname+"';";
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
		return op;
	}
	
	
	public static List<Option> r100(String stoid) {
		List<Option> op=new ArrayList<Option>();
		String sql="select a.id, a.r100, b.name from prices a, stocks b where a.id=b.id and b.id in ("+stoid+",2,12) order by day desc limit 3;";
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
		return op;
	}

	public static List<Option> rank(String stoid) {
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
		return op;
	}
	
}
