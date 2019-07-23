package SQL;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import dbutil.*;
import option.Option;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class ajax
 */
@WebServlet("/ajax_Distri")
public class ajax_Distri extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ajax_Distri() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1.获取参数
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		
		
		String parameters= request.getParameter("inputs");
		String Stoid = request.getParameter("StockId");
		
//		System.out.println("inputs---------------------");
//		System.out.println(parameters);
//		
//		System.out.println("StockId---------------------");
//		System.out.println(Stoid);
		
		
		
		String tempMin=parameters.split(",")[0];
		String tempMax=parameters.split(",")[1];
		String tempStep=parameters.split(",")[2];
		String tempDayNum=parameters.split(",")[3];

		double realMin=Double.parseDouble(tempMin)/100;
		double realMax=Double.parseDouble(tempMax)/100;
		double realStep=Double.parseDouble(tempStep)/100;
		double realDayNum=Double.parseDouble(tempDayNum);
		
		 double binStart=realMin;
		 double step=realStep;
		 double tempBinNum=2+((realMax-realMin)/step);
		 int binNum=(int)tempBinNum;
		 int dayNum=(int)realDayNum;
		 int[] counter=new int[binNum];
		
		
		//2.生成SQL语句
		String sql="select * from prices where id="+Stoid+";";
		
		//3.生成op对象(把之前写的复制过来，并把之前的删掉）$('#SEL option:selected').text()
		List<Option> op=new ArrayList<Option>();
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {			
			while(rs.next()) {
				Option t=new Option();
                t.name=rs.getString(1);
                t.date=rs.getDate(2);
                t.close=rs.getDouble(3);
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
		
//		int dayNum=5;
//		int binNum=12;
//		double binStart=-0.05;
//		double step=0.01;
//		int[] counter=new int[binNum]; 
		
		
		String sData="";
		String sXaxis="";

		DateFormat dateFormat=new SimpleDateFormat("yyyyMMdd");
		
		 for(int i=dayNum-1; i+dayNum<=op.size();i+=dayNum){
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
			}}
			}//end inner for,count tempChange into counters
		 }//end first for
		 
//get table column 2 ready for out print as String and Split with _
		String counterString="";
		for(int i=0; i<counter.length;i++) {
		counterString=counterString+Integer.toString(counter[i])+"_";
		}
		
		counterString=counterString.substring(0,counterString.length()-1);
		
//		System.out.println("attention!!!!!!!!!");
//		System.out.println(counterString);
//////////////////////////////////////////

		 

		 
	
		sData+="[";
		for(int z=0;z<binNum;z++){
			if(z!=binNum-1){sData+=Integer.toString(counter[z])+",";}
			else{sData+=Integer.toString(counter[binNum-1]);}
		}
		sData+="]";
		
// 		 System.out.println("sData----------------");
//		 System.out.println(sData);   
		
		 String[] eachBinName=new String[binNum];

		 for(double iii=0;iii<binNum;iii++){
			 double temp=binStart*100;//minimal value
			 temp+=(iii*step*100);
			 if(iii==0){
				 sXaxis+=sXaxis+"'<"+Option.outInt(temp)+"%',";
				 eachBinName[(int)iii]="Less than "+Option.outInt(temp)+"%";}
			 else{
			 if(iii==binNum-2){
				 sXaxis=sXaxis+"'"+"["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+"]"+"'"+",";
				 eachBinName[(int)iii]="["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+"]";}
			 else{
			 if(iii!=binNum-1){
			 	sXaxis=sXaxis+"'"+"["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+")"+"'"+",";
			 	eachBinName[(int)iii]="["+Option.outInt(temp-(step*100))+","+Option.outInt(temp)+")";}
			 else
			 {sXaxis=sXaxis+"'>"+Option.outInt(temp-(step*100))+"%'";
			 eachBinName[(int)iii]="Larger than "+Option.outInt(temp-(step*100))+"%";}	 
		 }}}
		 
		 sXaxis+="]";
		 
		 sXaxis="["+sXaxis;
		 
		//get table column 1 ready for out print as String and Split with _
		 String binNames="";
		 for(int i=0; i<counter.length;i++) {
			 binNames=binNames+eachBinName[i]+"_";
		 }
		binNames=binNames.substring(0,binNames.length()-1);
		
//		System.out.println("attention!!!!!!!!!AGAIN!!!!!!!!");
//		System.out.println(binNames);
		

		 
//		 System.out.println("sXaxis----------------------------");
//		 System.out.println(sXaxis);
		
		
binNames="'"+binNames+"'";
counterString="'"+counterString+"'";


	 
		 
	
		
		out.print(sData+"|"+sXaxis+"|"+binNames+"|"+counterString);

		
	}
	
	

}
	

