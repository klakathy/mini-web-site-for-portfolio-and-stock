<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>
<link href="css/Dropdown.css" rel="stylesheet" type="text/css" />
<%@ page import="option.*" %>
<%@ page import="SQL.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.Math" %>

<div style="padding-top:15px; margin-bottom:15px;">
	<h style="color:white;font-weight:500;font-size:30px;">Stocks Selection</h>
	<select id="SEL" class="dropdown" tabindex="9" data-settings='{"wrapperClass":"flat"}' onchange="Tag_Get_Data()">

	</select>
</div>

<script type="text/javascript">
	
	<%    	
		List<Option> op_drop= Drop.drop();
		String [] Drop_Data = new String[op_drop.size()];
		String Res_tag="[";
		String Res_id="[";
		for(int i=0;i<op_drop.size();i++){
			Res_id+="'";
			Res_id+=op_drop.get(i).id;
			Res_id+="',";

			Res_tag+="'";
			Res_tag+=op_drop.get(i).name;
			Res_tag+="',";
		}
		Res_tag=Res_tag.substring(0,Res_tag.length()-1);
		Res_tag+="]";
		
		Res_id=Res_id.substring(0,Res_id.length()-1);
		Res_id+="]";
		
	%>
	
	var Stocktag = eval(<%=Res_tag%>);
	var Stockid = eval(<%=Res_id%>);
    for(var i=0;i<Stocktag.length;i++){
    	$("#SEL").append("<option value='"+Stockid[i]+"'>"+Stocktag[i]+"</option>");
    }

    
</script>







