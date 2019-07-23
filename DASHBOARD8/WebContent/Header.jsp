<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="SQL.Drop"%>

<style type="text/css">
.head_fileId{
	position:relative;
	margin: 10px;
	padding: 0 10px;
}
.head_fileId input{
	margin-left:50px;
	width:300px;
}
.head_fileId dl{
	position:absolute;
	z-index:9;
	right:0px;
	top:10px;
	width:300px;
	background-color:white;
	color:black;
}
.head_fileId dl dd {
	margin:0;
}
.head_fileId dl dd:hover {
	background-color: #5FB878;
	color: white;
}
</style>

 <div id="Header" style="padding:18px 20px 0 20px;text-align:center;height:60px;margin:0px;background-color:#191f28;">
    <span style="color:white;font-size:20px;font-weight: 500;float:left;">Dashboard</span>
 	<div class="head_fileId" style="height:100%;display:inline-block;margin:0;padding:0;text-align:left;">
		<span style="color:white;font-weight:500;font-size:15px;">Choose a Stock</span>
		<input type="text" placeholder="input or choose" autocomplete="off"/>
		<dl style="display: none;">Click on item to choose</dl>
	</div> 	
 </div>
 
 <script type="text/javascript">
var tagData=JSON.parse('<%=Drop.dropjson()%>');
head_search_init();
function head_search_init(){
	console.log()
	//choose
	$(".head_fileId").on("click","dl dd",function(){
		var id0 = $(this).attr("value");
		if(id0!=undefined){
			cmp_add(id0);		
		}
		$(".head_fileId dl").hide();
		$(".head_fileId input").val("");    
	});    
	              
	//show as input change
	$(".head_fileId input").on("input propertychange",function(){
	   	$(".head_fileId dl dd").remove();
	   	$(".head_fileId dl").hide();
		if(tagData.length>0){
			$(".head_fileId dl").show();    		
			var sear = new RegExp($(this).val())
	    	var temp=0;
		    for(var i=0;i<tagData.length;i++){
		    	if(sear.test(tagData[i].name)){
		    		temp++
			   		$(".head_fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
		    	}
		    }
		    if(temp==0){
		    	$(".head_fileId dl").append('<dd>No data</dd>')
		    }
	    }
	});	
		   	
	//hide
	$(document).click(function(){
		$(".head_fileId dl").hide();
	   	$(".head_fileId input").val("");
	});
		 	
	//show
	$(".head_fileId input").click(function(event){
		$(".head_fileId dl dd").remove();
	  	if(tagData.length==0){
			$(this).val("No data")
	   	}else{
	    	$(".head_fileId dl").show()
	   	}
	   	for(var i=0;i<tagData.length;i++){
	   		$(".head_fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
		}
		event.stopPropagation();
	});	
}

</script>