<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="SQL.Drop" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Math" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Vendor styles -->
        <link rel="stylesheet" href="vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="vendors/bower_components/animate.css/animate.min.css">
        <link rel="stylesheet" href="vendors/bower_components/jquery.scrollbar/jquery.scrollbar.css">
        <link rel="stylesheet" href="css/app.min.css">
        
		<link rel="stylesheet" type="text/css" href="css/datatables.min.css"/>

        
        <script type="text/javascript" src="js/echarts.all.js"></script>
		<script type="text/javascript" src="js/echarts-gl.js"></script>
 		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>
		
		<script type="text/javascript" src="js/datatables.min.js"></script>


	<title>Historical Data</title>


<style type="text/css"> 

tr{
color:black;
}

#tablehead tr{
color:white;
}

.span_button {
	display: inline-block;
	padding: 3px 8px;
	margin: 0 10px;
	color: white;
	background-color:rgba(255,255,255,0.06);
}

.span_button:hover {
	background-color: rgba(255, 255, 255, 0.3);
	cursor: pointer;
}

#cmp_select {
	text-align: left;
	color: white;
	width: 100%;
}

#cmp_select div{
	position: relative;
	display: inline-block;
	width: 300px;
	height: 130px;
	background-color: rgba(255,255,255,0.06);
	margin: 10px 10px 0 0;
	padding: 0 10px;
}

.fileId{
	position:relative;
	margin: 10px 0;
	padding: 0 10px;
	display:inline-block;
}
.fileId input{
	margin-left:50px;
	width:300px;
}
.fileId dl{
	position:absolute;
	z-index:9;
	right:10px;
	top:30px;
	width:300px;
	background-color:white;
	color:black;
}
.fileId dl dd {
	margin:0;
}
.fileId dl dd:hover {
	background-color: #5FB878;
	color: white;
}
.card{
	border-radius:16px;
}
.cardpadding{
	padding:40px 20px 20px 30px;
	margin:20px;
	min-width:400px;
}
.cardinline{
	flex:1;
	min-width:400px;
	
}
.content__inner{
	min-width:400px;
}
.content__inner:not(.content__inner--sm) {
    max-width: 1820px;
}

.cardpadding option{/*only for this page*/
	color:black;
}
#example td{
	font-size:10px;
	padding: 4px 7px;
}
</style>
<script type="text/javascript">
	//for search bar
	var tagData=JSON.parse('<%=Drop.dropjson()%>');
</script>

</head>
    <body data-sa-theme="1">   
        <main class="main">
        	<%@ include file="/same.html"%>
        	<section class="content">
        		<div id="Loading" class="scene" style="position:absolute;top:250px;left:50%;height:200px;width:200px;margin-left:-100px;display:none;z-index:999;">
					<svg version="1.1" id="dc-spinner" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 38 38" preserveAspectRatio="xMinYMin meet">							
						<text x="14" y="21" font-family="Monaco" font-size="2px" style="letter-spacing:0.6" fill="grey">LOADING
							<animate attributeName="opacity" values="0;1;0" dur="1.8s" repeatCount="indefinite"/>
						</text>
						<path fill="#373a42" d="M20,35c-8.271,0-15-6.729-15-15S11.729,5,20,5s15,6.729,15,15S28.271,35,20,35z M20,5.203C11.841,5.203,5.203,11.841,5.203,20c0,8.159,6.638,14.797,14.797,14.797S34.797,28.159,34.797,20C34.797,11.841,28.159,5.203,20,5.203z">
						</path>										
						<path fill="#373a42" d="M20,33.125c-7.237,0-13.125-5.888-13.125-13.125S12.763,6.875,20,6.875S33.125,12.763,33.125,20S27.237,33.125,20,33.125z M20,7.078C12.875,7.078,7.078,12.875,7.078,20c0,7.125,5.797,12.922,12.922,12.922 S32.922,27.125,32.922,20C32.922,12.875,27.125,7.078,20,7.078z">
						</path>					
						<path fill="#2AA198" stroke="#2AA198" stroke-width="0.6027" stroke-miterlimit="10" d="M5.203,20c0-8.159,6.638-14.797,14.797-14.797V5C11.729,5,5,11.729,5,20s6.729,15,15,15v-0.203C11.841,34.797,5.203,28.159,5.203,20z">
							<animateTransform attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" calcMode="spline" keySplines="0.4, 0, 0.2, 1" keyTimes="0;1" dur="2s" repeatCount="indefinite" />      
						</path>
						<path fill="#859900" stroke="#859900" stroke-width="0.2027" stroke-miterlimit="10" d="M7.078,20c0-7.125,5.797-12.922,12.922-12.922V6.875C12.763,6.875,6.875,12.763,6.875,20S12.763,33.125,20,33.125v-0.203C12.875,32.922,7.078,27.125,7.078,20z">
							<animateTransform attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="1.8s" repeatCount="indefinite" />
						</path>
					</svg>
				</div>
				
                <div class="content__inner">
					<!-- search div -->
					<span style="color:white;font-weight:500;font-size:15px;">Select a Stock</span>
					<div class="fileId">							
						<input type="text" placeholder="input or choose" autocomplete="off"/>
						<dl style="display: none;"><dt>Click on item to choose</dt></dl>
					</div>
                	<!-- title div -->
					<div id="titlediv" class="cardpadding" style="width: 100%;text-align:left;padding:0;"></div>
					
					<!-- chart1 price -->
					<div class="card cardpadding" >						
						<table id="example" class="display">
							<thead>
								<tr class="tablehead" style="color: white !important">
									<th>Stock</th>
									<th>Date</th>
									<th>Close</th>
									<th>Open</th>
									<th>High</th>
									<th>Low</th>
									<th>Change</th>
								</tr>
							</thead>
						</table>
						
					</div>
                </div>
            </section>
        </main>
	<!-- select part initiate -->       
    <script type="text/javascript">
    function his_search_init(){//change here
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		if(id0!=undefined){
    			his_add(id0);//change here
    		}
    		$(".fileId dl").hide();
    		$(".fileId input").val("");    
    	});    
    	              
    	//show as input change
    	$(".fileId input").on("input propertychange",function(){
    	   	$(".fileId dl dd").remove();
    	   	$(".fileId dl").hide();
    		if(tagData.length>0){
    			$(".fileId dl").show();    		
    			var sear = new RegExp($(this).val())
    	    	var temp=0;
    		    for(var i=0;i<tagData.length;i++){
    		    	if(sear.test(tagData[i].name)){
    		    		temp++
    			   		$(".fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
    		    	}
    		    }
    		    if(temp==0){
    		    	$(".fileId dl").append('<dd>No data</dd>')
    		    }
    	    }
    	});	
    		   	
    	//hide
    	$(document).click(function(){
    		$(".fileId dl").hide();
    	   	$(".fileId input").val("");
    	});
    		 	
    	//show
    	$(".fileId input").click(function(event){
    		$(".fileId dl dd").remove();
    	  	if(tagData.length==0){
    			$(this).val("No data")
    	   	}else{
    	    	$(".fileId dl").show()
    	   	}
    	   	for(var i=0;i<tagData.length;i++){
    	   		$(".fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
    		}
    		event.stopPropagation();
    	});	
    }	
    his_search_init();    //change here
    </script>           

	<script type="text/javascript">	
	function his_add(StockId){
		var Loading_var=1;
		if(Loading_var==1){
			document.getElementById("Loading").style.display="block";
		}
		Loading_var=0;
		$.ajax({
			type : 'GET',
			url : 'Ajax_Cmp?id0=' + StockId
		}).done(function(data) {
			if (data) {
				var r0 = JSON.parse(data);	
				//title part initiate
				var html="<p>"+r0.id+"</p><h1>"+r0.name+"</h1><p>"+r0.day+"</p><h2>"+r0.close+"</h2><pre style='display:none;'>"+StockId+"</pre><hr/>";
				$('#titlediv').html(html);	
			}
		});
			
		$(document).ready(function(){
				$.ajax({
					type:'POST',
				data:{
						StockId:StockId,
						},
				url:'Ajax_Hist',
				success: function(result){
					var T_Data=eval(result);
						
					table=$('#example').DataTable( {
						"destroy": true,
					    data: T_Data
					} );
					
					document.getElementById("Loading").style.display="none";						
				}
			});
		});
	
	}	
			
	</script>

	<!-- App functions and actions -->
    <script src="js/app.min.js"></script>
    <script src="vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
    <script src="vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
    <script src="vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>
        
	</body>
</html>