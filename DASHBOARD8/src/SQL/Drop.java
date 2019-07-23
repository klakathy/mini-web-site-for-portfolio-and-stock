package SQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;

import dbutil.*;
import option.Option;

public class Drop {
	public static List<Option> drop() {
		List<Option> op=new ArrayList<Option>();
		String sql="select name,id from stocks;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.name=rs.getString(1);
				t.id=rs.getString(2);
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
	
	public static String dropjson() {
		String dropjson="";
		List<Option> op=new ArrayList<Option>();
		String sql="select name,id from stocks;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.name=rs.getString(1);
				t.id=rs.getString(2);
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
			System.out.println("Data Retrieval success_dropjson");
		}
		
		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"name","id"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return true;
					}
				}				
				return false;
			}
		};		
		dropjson = JSON.toJSONString(op, filter);
		return dropjson;
	}
	
	public static String droppfjson() {
		String dropjson="";
		List<Option> op=new ArrayList<Option>();
		String sql="select c.name,c.id from stocks c, (select distinct a.id from weights a, prices b where a.id2=b.id and b.close is not null) d where c.id=d.id;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.name=rs.getString(1);
				t.id=rs.getString(2);
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
			System.out.println("Data Retrieval success_droppfjson");
		}
		
		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"name","id"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return true;
					}
				}				
				return false;
			}
		};		
		dropjson = JSON.toJSONString(op, filter);
		return dropjson;
	}
}
