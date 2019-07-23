package SQL;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;

import dbutil.DButil;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import option.Option;
/**
 * Servlet implementation class ajax
 */
@WebServlet("/ajax_CustM_K")
public class ajax_CustM_K extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fullids= request.getParameter("fullids");
		String Cust_weight = request.getParameter("fullweights");
		
		String cu2="";
		String idList[] = fullids.split("_");
		String idWeight[] = Cust_weight.split("_");
		String inids="";
		int l=idList.length;
		//System.out.println(l);
		if(l==0){response.getWriter().write("no");response.getWriter().close();}
		
		int i=0;
		for(i=0;i<idList.length;i++) {			
			inids+="'"+idList[i]+"',";
		}
		inids = inids.substring(0,inids.length()-1);
		
		String sql="select day, sum(cc),sum(oo) from (";
		for(i=0;i<idList.length;i++) {			
			sql+="select day, close*"+idWeight[i]+" as cc,open*"+idWeight[i]+" as oo from prices where id='"+idList[i]+"' union all ";
		}
		sql = sql.substring(0,sql.length()-11);
		sql+=") t2 where day <= (select max(day) as mday from prices where id in ("+inids+") group by id order by mday limit 1) group by day order by day desc limit 250;";
		//System.out.println(sql);
		List<Option> op=new ArrayList<Option>();
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.day=rs.getString(1);
				t.open=rs.getDouble(3);
				t.close=rs.getDouble(2);
				t.date=rs.getDate(1);
				if(t.close>t.open) {
					t.high=t.close;t.low=t.open;
				}else {
					t.high=t.open;t.low=t.close;
				}
				op.add(0,t);
				//System.out.println("aaa");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_custom1");
		}
		String K_Sum_Data=Option.K_Charts(op);
		
		/******** H part ***********/
		String sData= "[";
		String sXaxis="";
		
		DateFormat dateFormat=new SimpleDateFormat("yyyyMMdd");
		String realInside1=new String();
		
		//default value if no input
	  	double binStart=-0.1; 
		double step=0.01;
		int binNum=22;
		int dayNum=5; //1,5,20,252
		int[] counter=new int[binNum]; 
		
	 	for(i=dayNum-1; i+dayNum<=op.size();i+=dayNum){
			String[] inside1 = new String[4];
			Option p1=op.get(i);
			inside1[0]=p1.name;
			inside1[1]=dateFormat.format(p1.date);
			inside1[2]=Double.toString(p1.close);
			inside1[3]=Double.toString((p1.close-op.get(i-dayNum+1).close)/op.get(i-dayNum+1).close);
			 
			Double tempChange=(p1.close-op.get(i-dayNum+1).close)/op.get(i-dayNum+1).close;
			 //System.out.printf("inside1[2]:%s p1.close:%f tempChange:%f\n",inside1[2],p1.close,tempChange);
			 			
			for(int ii=0;ii<binNum;ii++){
				if((binStart>tempChange)){counter[0]++;
				}else
				{if(tempChange>=(binStart+((binNum-1)*step))){counter[binNum-1]++;
				}else
				{if((binStart+(ii*step))<=tempChange&&tempChange<(binStart+((ii+1)*step))){counter[ii]++;
				}	
			}}}//end inner for,count tempChange into counters
			
		 }//end first for
		 	
		for(int z=0;z<binNum;z++){
			if(z!=binNum-1){sData+=Integer.toString(counter[z])+",";}
			else{sData+=Integer.toString(counter[binNum-1]);}
		}
		 //System.out.println(sData); 
	
		 for(double iii=0;iii<binNum;iii++){
			 double temp=binStart*100;//minimal value
			 temp+=(iii*step*100);
			 if(iii==0){
				 sXaxis+=sXaxis+"'<"+Option.outInt(temp)+"%',";}
			 else{
			 if(iii==binNum-2){
				 sXaxis=sXaxis+"'"+"["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+"]"+"'"+",";}
			 else{
			 if(iii!=binNum-1){
			 	sXaxis=sXaxis+"'"+"["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+")"+"'"+",";}
			 else
			 {sXaxis=sXaxis+"'>"+Option.outInt(temp-(step*100))+"%'";}	 
		 }}}
		 		
		sData+="]";
		String sXaxis_fix="[";
		sXaxis_fix+=sXaxis;
		sXaxis_fix+="]";
		
		String H_Sum_Data="";
		H_Sum_Data+=sXaxis_fix;
		H_Sum_Data+="|";
		H_Sum_Data+=sData;
		
		/**************** Weight pie part ********************/		
		double closesum=op.get(op.size()-1).close;
		List<Option> op2=new ArrayList<Option>();
		sql="select b.id,b.name,a.close,b.description from (select close,id from prices where day = (select max(day) as mday from prices where id in ("
				+inids+") group by id order by mday limit 1)) a, stocks b where a.id in ("+inids+") and a.id=b.id;";
		
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
				t.name=rs.getString(2);
				t.id=rs.getString(1);
				t.id2=rs.getString(4);//store description	
				t.close=rs.getDouble(3);
				for(int j=0;j<l;j++) {
					if(t.id.equals(idList[j])) {
						t.weight=Double.parseDouble(idWeight[j])*t.close/closesum;
						break;
					}
				}
				op2.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			System.out.println("Data Retrieval success_custom2");
		}
		
		PropertyFilter filter = new PropertyFilter() {
			public boolean apply(Object source, String name, Object value) {
				if(value==null)return false;
				String[] novalues_cmp1=new String[] {"weight","name","id2","close"};
				for(int i_f1=0;i_f1<novalues_cmp1.length;i_f1++) {
					if(novalues_cmp1[i_f1].equals(name)) {
						return true;
					}
				}
				return false;
			}
		};
		
		String P_Sum_Data = JSON.toJSONString(op2, filter);
		CustM mm0=new CustM();
		mm0.hdata=H_Sum_Data;
		mm0.kdata=K_Sum_Data;
		mm0.pdata=P_Sum_Data;
		
		cu2=JSON.toJSONString(mm0);
		response.getWriter().write(cu2);	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				doGet(request, response);

		
	}
	

}
