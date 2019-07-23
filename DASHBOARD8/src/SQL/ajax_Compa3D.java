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
@WebServlet("/ajax_Compa3D")
public class ajax_Compa3D extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ajax_Compa3D() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
	 
		String id1=request.getParameter("id1");
		String id2=request.getParameter("id2");
		//2
		String sql="select p1.day as date , p1.r100 as r1, p2.r100 as r2 from prices p1, prices p2 where p1.day=p2.day and p1.id="+id1+" and p2.id="+id2+" group by date limit 100000 offset 1;";
		
		//3
		List<Option> op=new ArrayList<Option>();
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {
			
            	rs.first();
			 do {
	                Option t= new Option();
	                t.date=rs.getDate(1);
	                t.high=rs.getDouble(2);//r1001
	                t.low=rs.getDouble(3);//r1002

	                op.add(t);
	                
//	                System.out.println("Attention!!!!!!r1001 is coming!!!!!!!!!!");
//	                System.out.println(t.r1001);
	                }while(rs.next());
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
				
		String s3DData="";
		int[][] counter=new int[12][12];
		int[] temp;

//////////////////////////////////////////
		for(int i=0; i<op.size();i++) {
			Option p1=op.get(i);
			temp=couterProcess(p1.high,p1.low);
			counter[temp[0]][temp[1]]+=1;	
		}
		
		s3DData+="[";
		for(int j=0; j<12;j++) {
			for(int i=0;i<12;i++) {
				s3DData+="["+j+","+i+","+counter[i][j]+"]"+",";
			}
		}
		s3DData=s3DData.substring(0,s3DData.length()-1);
		s3DData+="]";
		out.print(s3DData);
	}
	
	public static int[] couterProcess(double data1, double data2) {
		int[] temp=new int[2];
		if(data1<-5) {temp[0]=0;}else {
			if(data1>=-5&&data1<-4) {temp[0]=1;}else {
				if(data1>=-4&&data1<-3) {temp[0]=2;}else {
					if(data1>=-3&&data1<-2) {temp[0]=3;}else {
						if(data1>=-2&&data1<-1) {temp[0]=4;}else {
							if(data1>=-1&&data1<0) {temp[0]=5;}else {
								if(data1>=0&&data1<1) {temp[0]=6;}else {
									if(data1>=1&&data1<2) {temp[0]=7;}else {
										if(data1>=2&&data1<3) {temp[0]=8;}else {
											if(data1>=3&&data1<4) {temp[0]=9;}else {
												if(data1>=4&&data1<=5) {temp[0]=10;}else {
													if(data1>5) {temp[0]=11;}}}}}}}}}}}}
		
		if(data2<-5) {temp[1]=11;}else {
			if(data2>=-5&&data2<-4) {temp[1]=10;}else {
				if(data2>=-4&&data2<-3) {temp[1]=9;}else {
					if(data2>=-3&&data2<-2) {temp[1]=8;}else {
						if(data2>=-2&&data2<-1) {temp[1]=7;}else {
							if(data2>=-1&&data2<0) {temp[1]=6;}else {
								if(data2>=0&&data2<1) {temp[1]=5;}else {
									if(data2>=1&&data2<2) {temp[1]=4;}else {
										if(data2>=2&&data2<3) {temp[1]=3;}else {
											if(data2>=3&&data2<4) {temp[1]=2;}else {
												if(data2>=4&&data2<=5) {temp[1]=1;}else {
													if(data2>5) {temp[1]=0;}}}}}}}}}}}}
		return temp;
	}

}


	

