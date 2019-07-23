package option;

import java.text.DecimalFormat;
import java.util.List;
import java.sql.Date;



public class Option {
	
	public String name;
	public double weight;
	
	public String id;//use to store description in cpn, cmp, da
	public double sd;
	public double sr;
	public double beta;
	public double alpha;
	public double r2;
	public double r100;

	
	public double open;
	public double close;
	public double high;
	public double low;
	public String day;
	public int rank;
	public String id2;
	

	public Date date;
	public double change;

	public double wkchange;
	
	public List<OptionS> opdata;
	
	
	
	public static String legend(List<Option> op) {
		String x="[";
		for(int i=0;i<op.size();i++) {
			if(i!=0)x+=",";
			x+="'"+op.get(i).name+"'";
		}
		x+="]";
		return x;
	}
	
	
	
	public static String K_Charts(List<Option> op) {
		//data form ['date',open,close,highest,lowest]
		String x="[";
		for(int i=0;i<op.size();i++) {
			x+="['"+op.get(i).day+"',"+op.get(i).open+","+op.get(i).close+","+op.get(i).high+","+	op.get(i).low+"],";

		}
		x+="]";
		return x;
	}
	
	public static String Drop_down(List<Option> op) {
		String x="[";
		for(int i=0;i<op.size();i++) {
			x+="'"+op.get(i).day+"',"+op.get(i).open+","+op.get(i).close+","+op.get(i).high+","+	op.get(i).low+"],";

		}
		x+="]";
		return x;
	}
	
	
	public static String r100(List<Option> op) {
		//data form ['date',open,close,highest,lowest]
		String x="[";
		for(int i=0;i<op.size();i++) {
			x+=op.get(i).r100;
			x+=",";
		}
		x+="]|";
		String y="[";
		for(int i=0;i<op.size();i++) {
			y+="'"+op.get(i).name+"'";
			y+=",";
		}
		y+="]";
		x+=y;
		return x;
	}
	
	
	public static int rank(List<Option> op) {
		//data form ['date',open,close,highest,lowest]
			int x;
			x=op.get(0).rank;
		return x;
	}
	
	
	public static String series(List<Option> op) {
		String x="[";
		for(int i=0;i<op.size();i++) {
			if(i!=0)x+=",";
			int v=(int) ((op.get(i).weight+0.5)/1);
			x+="{value:"+v+", name:'"+op.get(i).name+"'}";
		}
		x+="]";
		return x;
	}
	
	public static String deci1(double a0) {	
		DecimalFormat myFormat = new DecimalFormat("0.##");
		return myFormat.format(a0);
	}
	
	
	
	
	public static String deci2(double a0) {	
		DecimalFormat myFormat = new DecimalFormat("###,##0.00");
		return myFormat.format(a0);
	}

	public static String outInt(double a1) {	
		DecimalFormat myFormat = new DecimalFormat("###,##0");
		return myFormat.format(a1);
	}
}
