<!DOCTYPE html>
<%@ page import="SQL.*" %>
<%@ page import="option.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>

<%
List<Option> op= new ArrayList<Option>();

	//List<Option1> op= GetDATA1.SQLDATA();
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="text/javascript" src="js/echarts.all.js"></script>
<title>SP500_Dashboard</title>
<link href="css/jquery-accordion-menu.css" rel="stylesheet" type="text/css" />
<link href="css/font-awesome.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />

<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"></script>

<script type="text/javascript">
jQuery(document).ready(function () {
	jQuery("#jquery-accordion-menu").jqueryAccordionMenu();
});
$(function(){	
	$("#demo-list li").click(function(){
		$("#demo-list li.active").removeClass("active")
		$(this).addClass("active");
	})	
})	
</script>
</head>
<body style="background-color:#393939;margin:0px;">

<%@ include file="/Header.jsp" %>

<div class="content" style="margin:0px;width:100%;">
    <table  style="width:99%;">
        <tr >
            <td width="250px;" valign="top">
               <%@ include file="/Nav.jsp" %>
            </td>
            
            <!-- ----------------------------------- -->
               <td style="position:relative">   
           	    <div id="Loading" class="scene" style="width:400px;height:4000px;position:absolute;top:100px;left:580px;display:none;z-index:999;">
			        <svg 
			            version="1.1" 
			            id="dc-spinner" 
			            xmlns="http://www.w3.org/2000/svg" 
			            viewBox="0 0 38 38" 
			            preserveAspectRatio="xMinYMin meet"
			        >

			        <text x="14" y="21" font-family="Monaco" font-size="2px" style="letter-spacing:0.6" fill="grey">LOADING
			            <animate 
			            attributeName="opacity"
			            values="0;1;0" dur="1.8s"
			            repeatCount="indefinite"/>
			        </text>
			        <path fill="#373a42" d="M20,35c-8.271,0-15-6.729-15-15S11.729,5,20,5s15,6.729,15,15S28.271,35,20,35z M20,5.203
			            C11.841,5.203,5.203,11.841,5.203,20c0,8.159,6.638,14.797,14.797,14.797S34.797,28.159,34.797,20
			            C34.797,11.841,28.159,5.203,20,5.203z">
			        </path>
			
			        <path fill="#373a42" d="M20,33.125c-7.237,0-13.125-5.888-13.125-13.125S12.763,6.875,20,6.875S33.125,12.763,33.125,20
			            S27.237,33.125,20,33.125z M20,7.078C12.875,7.078,7.078,12.875,7.078,20c0,7.125,5.797,12.922,12.922,12.922
			            S32.922,27.125,32.922,20C32.922,12.875,27.125,7.078,20,7.078z">
			        </path>
			
			        <path fill="#2AA198" stroke="#2AA198" stroke-width="0.6027" stroke-miterlimit="10" d="M5.203,20
			                    c0-8.159,6.638-14.797,14.797-14.797V5C11.729,5,5,11.729,5,20s6.729,15,15,15v-0.203C11.841,34.797,5.203,28.159,5.203,20z">
			        <animateTransform
			                attributeName="transform"
			                type="rotate"
			                from="0 20 20"
			                to="360 20 20"
			                calcMode="spline"
			                keySplines="0.4, 0, 0.2, 1"
			                keyTimes="0;1"
			                dur="2s"
			                repeatCount="indefinite" />      
			        </path>
			
			        <path fill="#859900" stroke="#859900" stroke-width="0.2027" stroke-miterlimit="10" d="M7.078,20
			        c0-7.125,5.797-12.922,12.922-12.922V6.875C12.763,6.875,6.875,12.763,6.875,20S12.763,33.125,20,33.125v-0.203
			        C12.875,32.922,7.078,27.125,7.078,20z">
			        <animateTransform
			            attributeName="transform"
			            type="rotate"
			            from="0 20 20"
			            to="360 20 20"
			            dur="1.8s"  
			            repeatCount="indefinite" />
			            </path>
			        </svg>
    			</div>
            </td>
            <!-- -------------------------------------------------- -->
            
            
            
            
            
            
            <td>
            	<div style="height:800px">
			    <form Id="myForm">
			    	<select name="mySelect">
			    		<option value="select * from prices;">INX</option>
			    		<option value="select * from prices where id=1;">SRCD</option>
			    		<option value="select * from prices where id=2;">SR2</option>
			    		<option value="select * from prices where id=3;">SR3</option>
			    	</select>
			    	<input type="submit" value="Submit" onclick = "Virtualize()">
			    </form>
			   

    	<%
	    	String text=request.getParameter("mySelect");
	    	op= HisD.SQLDATA(text);
	    	pageContext.setAttribute("YYY",text);
	    	System.out.printf("%s",text);
    	%>
   
    
            	<table id="example" class="display">
					    <thead>
					        <tr style="color:white;">
					            <th>Stock</th>
					            <th>Date</th>
					            <th>Close</th>
					            <th>Open</th>
					            <th>High</th>
					            <th>Low</th>
					            <th>Change</th>
					           <!--  <th>Change</th> -->
					        </tr>
					    </thead>
				</table>			
            	</div>
            </td>
        </tr>
        
    </table>
	

</div>

<script type="text/javascript">


	var Loading_var=1;
	function Virtualize(){
	if(Loading_var==1){
		document.getElementById("Loading").style.display="block";
	}
	Loading_var=0;

	<%
		DateFormat dateFormat=new  SimpleDateFormat("yyyyMMdd");
		String realInside1=new String();
		double change=0;
		
		 for(int i=0; i<op.size();i++){
			 String[] inside1 = new String[7];
			 Option p1=op.get(i);
			 
			 inside1[0]=p1.name;
			 inside1[1]=dateFormat.format(p1.date);
			 inside1[2]=Double.toString(p1.close);
			 inside1[3]=Double.toString(p1.open);
			 inside1[4]=Double.toString(p1.high);
			 inside1[5]=Double.toString(p1.low);
			 	if(i!=0)
				{change=op.get(i).low-op.get(i-1).low;}
				DecimalFormat f= new DecimalFormat("##.00");
				String changeS=f.format(change);
			 inside1[6]=changeS;
			 
			 
			 if(i!=0){realInside1+=",";}
			 realInside1+="["+inside1[0]+",";
			 realInside1+=inside1[1]+",";
			 realInside1+=inside1[2]+",";
			 realInside1+=inside1[3]+",";
			 realInside1+=inside1[4]+",";
			 realInside1+=inside1[5]+",";
			 realInside1+=inside1[6]+"]";
	 }%>
	}
	 
	var data1=[<%=realInside1 %>]

	$('#example').DataTable( {
	    data: data1
	} );
	
	
</script>



<script type="text/javascript">
(function($) {
$.expr[":"].Contains = function(a, i, m) {
	return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};
function filterList(header, list) {
	var form = $("<form>").attr({
		"class":"filterform",
		action:"#"
	}), input = $("<input>").attr({
		"class":"filterinput",
		type:"text"
	});
	$(form).append(input).appendTo(header);
	$(input).change(function() {
		var filter = $(this).val();
		if (filter) {
			$matches = $(list).find("a:Contains(" + filter + ")").parent();
			$("li", list).not($matches).slideUp();
			$matches.slideDown();
		} else {
			$(list).find("li").slideDown();
		}
		return false;
	}).keyup(function() {
		$(this).change();
	});
}
$(function() {
	filterList($("#form"), $("#demo-list"));
});
})(jQuery);	
</script>

</body>

</html>