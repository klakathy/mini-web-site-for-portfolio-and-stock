package SQL;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dbutil.*;

public class Risks {
	public Date day;
	public double xx;//x refer to market sp500
	public double yy;
	public double ss;

	
//	public static void main(String[] args) {
	public static void risks(){
		
//		for(int i=1;i<=12;i++) {r100(i+"");}		
//		for(int i=1;i<=12;i++) {rall(i+"");}
//		for(int i=1;i<=12;i++) {rdis(i+"");}
//		for(int i=1;i<=12;i++) {rout(i+"");}
		
		//System.out.println(a/5);
		System.out.println("Finish");
	}
	
	public static void rdis(String qqq) {
		List<Risks> p0 = new ArrayList<Risks>();
		String sql="select day,r100 from prices where id='"+qqq+"' and r100 is not null order by day desc limit 120;";
		//System.out.println(sql);
		
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {  
            while(rs.next()){
            	Risks t = new Risks();
            	t.day=rs.getDate(1);
            	t.xx=rs.getDouble(2);
            	p0.add(t);
            	//System.out.printf(" %f\n", t.xx);
            }
            rs.close();
            
            double[] x0= new double[120];
	        for(int i=0;i<120;i++) {
	            x0[i]=p0.get(i).xx;
	        }
	        double[] rds=rds(x0);//System.out.println(rd);  
	           				 	            
	        String sql2="update prices set dis_5='"+ rds[0]+"',dis_4='"+rds[1]+"',dis_3='"+rds[2]+"',dis_2='"+rds[3]+"',dis_1='"+rds[4]+"',dis1='"+rds[5]+"',dis2='"+rds[6]+"',dis3='"+rds[7]+"',dis4='"+rds[8]+"',dis5='"+rds[9]+"' where id='"+qqq+"' and day='"+p0.get(0).day+"';";
	        Statement s=con.createStatement();
 
			//System.out.println(sql2);				
	        s.execute(sql2);	            
                      
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();  
            }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally{
            System.out.printf("Data Retrieval success for id=%s\n",qqq);
        }
	}
	
	public static void rout(String qqq) {
		//int num=0;
		List<Risks> p0 = new ArrayList<Risks>();
		String sql="select day,r100 from prices where id='"+qqq+"' and r100 is not null order by day;";
		//System.out.println(sql);
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {  
            while(rs.next()){
            	Risks t = new Risks();
            	t.day=rs.getDate(1);
            	t.xx=rs.getDouble(2);
            	p0.add(t);
            	//System.out.printf(" %f\n", t.xx);
            	//num++;if(num>=35)break;
            }
            rs.close();
            
            while(p0.size()>=30) {
            	double[] x0= new double[30];
	            for(int i=0;i<30;i++) {
	            	x0[i]=p0.get(i).xx;
	            }
	            double[] ros=ros(x0);//System.out.println(rd);  
	           				 	            
	            String sql2="update prices set otup='"+ ros[0]+"',otdw='"+ros[1]+"' where id='"+qqq+"' and day='"+p0.get(29).day+"';";
	            Statement s=con.createStatement();
 
				//System.out.println(sql2);				
	            s.execute(sql2);	            
	            p0.remove(0);  
            }                       
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();  
            }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally{
            System.out.printf("Data Retrieval success for id=%s\n",qqq);
        }
	}
	
	public static void rall(String qqq) {
		//int num=0;
		List<Risks> p0 = new ArrayList<Risks>();
		String sql="select a.day,a.r100,b.r100 from (select day,r100 from prices where id='"+qqq+"') a, (select day,r100 from prices where id='12')b where a.day=b.day and a.r100 is not null and b.r100 is not null order by day;";
		//System.out.println(sql);
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) {  
            while(rs.next()){
            	Risks t = new Risks();
            	t.day=rs.getDate(1);
            	t.xx=rs.getDouble(3);
            	t.yy=rs.getDouble(2);
            	p0.add(t);
            	//System.out.printf(" %f\t%f\n", t.xx,t.yy);
            	//num++;
            	//if(num>=35)break;
            }
            rs.close();
            
            while(p0.size()>=30) {
            	double[] x0= new double[30];
	            double[] y0=new double[30];
	            for(int i=0;i<30;i++) {
	            	x0[i]=p0.get(i).xx;
	            	y0[i]=p0.get(i).yy;
	            }
	            double rd=rd(y0);//System.out.println(rd);
	            double rsha=rsha(y0);//System.out.println(rsha);	            
	            double rbeta=rbeta(x0,y0);//System.out.println(rbeta);
	            double ralpha=ralpha(x0,y0);//System.out.println(ralpha);
	            double rr2=rr2(x0,y0);//System.out.println(rr2);     
				 	            
	            String sql2="update prices set sd='"+ rd+"',sr='"+rsha+"',beta='"+rbeta+"', alpha='"+ralpha+"', r2='"+rr2+"' where id='"+qqq+"' and day='"+p0.get(29).day+"';";
	            //String sql2="update prices set  r2='"+rr2+"' where id='"+qqq+"' and day='"+p0.get(29).day+"';";
	            Statement s=con.createStatement();
 
				//System.out.println(sql2);
				
	            s.execute(sql2);
	            
	            p0.remove(0);  
            }
                       
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();  
            }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally{
            System.out.printf("Data Retrieval success for id=%s\n",qqq);
        }
	}
		
	public static void r100(String qqq) {
		String sql="select day,close from prices where id='"+qqq+"' order by day;";
		try (Connection con = DButil.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(sql)) { 
			double t1=0;
			double t2=0;
			if(rs.next())t1=rs.getDouble(2);
            while(rs.next()){
            	t2=rs.getDouble(2);
            	double t3=(t2-t1)/t1*100;
            	String sql3="update prices set r100='"+t3+"' where id='"+qqq+"' and day='"+rs.getDate(1)+"';"; 
            	Statement s=con.createStatement();            				
	            s.execute(sql3);
	            t1=t2;
            }
            rs.close();                             
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();  
            }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally{
            System.out.printf("Data Retrieval success for id=%s\n",qqq);
        }
	}
	


	public static double rsum(double[] a0) {
		double rsum=0;
		for(int i=0; i<a0.length;i++) {
			rsum+=a0[i];
		}
		//System.out.printf("rsum=%f\n",rsum);
		return rsum;
	}
	
	public static double rcsum(double[] a1, double[] a2) {
		double rcsum=0;
		for(int i=0; i<a1.length;i++) {
			rcsum+=a1[i]*a2[i];
		}
		//System.out.printf("rcsum=%f\n",rcsum);
		return rcsum;
	}
	
	public static double rnvar(double[] a0) {
		double rnvar=0;
		double rsum=rsum(a0);
		double rcsum=rcsum(a0,a0);
		rnvar=rcsum-rsum*rsum/a0.length;
		//System.out.printf("rnvar=%f\n",rnvar);
		return rnvar;
	}
	
	public static double rd(double[] a0) {
		double rd;
		rd=rnvar(a0);
		rd/=a0.length;
		rd=Math.sqrt(rd);
		//System.out.printf("rd2=%f\n",rd);		
		//System.out.printf("rd3=%f\n",rd);
		return rd;
	}
	
	public static double rsha(double[] a0) {
		double rsha;
		rsha=rnvar(a0)/a0.length;
		rsha=rsum(a0)/Math.sqrt(rsha)/a0.length;
		return rsha;
	}
	
	public static double rbeta(double[] x0, double[] y0) {
		double rbeta;
		rbeta=rcsum(x0, y0)-(rsum(x0)*rsum(y0))/x0.length;
		rbeta/=rnvar(x0);
		return rbeta;
	}
	
	public static double ralpha(double[] x0, double[] y0) {
		double rbeta=rbeta(x0,y0);
		double ralpha;
		ralpha=rsum(y0)-rsum(x0)*rbeta;
		ralpha/=x0.length;
		return ralpha;
	}
	
	public static double rr2(double[] x0, double[] y0) {
		double rr2=0;
		double rsumy2=rsum(y0)/y0.length;
		double rnvary=rnvar(y0);
		for(int i=0; i<x0.length;i++) {
			double tmp=ralpha(x0,y0)+rbeta(x0,y0)*x0[i]-rsumy2;
			tmp*=tmp;
			rr2+=tmp/rnvary;
		}
		return rr2;
	}
	
	public static double[] ros(double[] x0) {
		double[] ros=new double[2];
		double q1,q3;
		int size=x0.length;
		Arrays.sort(x0);
		if(size%4==0) {
			q1=x0[size/4-1]+x0[size/4];
			q3=x0[size*3/4-1]+x0[size*3/4];
		}else {
			q1=x0[size/4];
			q3=x0[size*3/4];
		}
		if(q1==q3) {
			ros[0]=999;
			ros[1]=-999;
		}else {
			ros[0]=1.5*(q3-q1)+q3;
			ros[1]=-1.5*(q3-q1)+q1;
		}
		return ros;
	}
	
	public static double[] rds(double[] x0) {
		double[] rds={0,0,0,0,0,0,0,0,0,0};
		int i,j,size=x0.length;
		Arrays.sort(x0);
		j=0;i=0;
		while(i<size) {	
			if(j>=9) {
				rds[9]++;i++;
			}else if(x0[i]<=-2+0.5*j) {
				rds[j]++;i++;
			}else j++;
		}
		for(i=0;i<10;i++) {
			rds[i]/=1.2;
		}
		return rds;
	}
		
}
