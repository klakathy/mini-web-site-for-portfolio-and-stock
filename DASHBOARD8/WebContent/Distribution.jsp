<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="SQL.Drop" %>
<%@ page import="SQL.*" %>
<%@ page import="option.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Math" %>

<%List<Option> op= new ArrayList<Option>();
String sData= new String();
String sXaxis=new String();

%>
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
		<!-- link rel="stylesheet" href="css/common.css"-->
        
        <script type="text/javascript" src="js/echarts.all.js"></script>
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>
		
		<script src="js/customed.js" type="text/javascript"></script>

	<title>Distribution</title>

<script type="text/javascript">
	//for search bar
	var tagData=JSON.parse('<%=Drop.dropjson()%>');
</script>

<style type="text/css">

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
#changebar2 td{
	padding:0 5px;
}
#changebar2{
	display:none;
	width:100%;
}
</style>

<script>
    function textModify(sliderID, textbox)
    {	    	
        var y = document.getElementById(sliderID);
        var obj = document.getElementById(textbox);
        
        if(sliderID=='slider1'){obj.innerHTML='Minimal change:'+y.value+'%';}
        if(sliderID=='slider2'){obj.innerHTML='Maximal change:'+y.value+'%';}
        if(sliderID=='slider3'){obj.innerHTML='Binwidth:'+y.value+'%';}
        if(sliderID=='slider4'){obj.innerHTML='Change over '+y.value+' days';}          
    }   
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
						<div style="color:white;text-align:left">
							<h3 style="display:inline-block">Change Percentage Frequency Distribution</h3>
							<!-- parameters setting -->
							<table id="changebar2">
						    	<tr>			    			    	
							    	<td height="10" style="color:white"><p id="rangeValue1p">test area</p></td>	
							    	<td height="10" style="color:white"><p id="rangeValue2p">test area</p></td>			    		    	
							    	<td height="10" style="color:white"><p id="rangeValue3p">test area</p></td>			    				    	
							    	<td height="10" style="color:white;"><p id="rangeValue4p">test area</p></td>			    	
						    	</tr>
						    	
						    	<tr>			    				    	
							    	<td><input id="slider1" type="range" min="-20" max="0" step="1" onchange="textModify('slider1','rangeValue1p')"  value=-8></td>									
									<td><input id="slider2" type="range" min="0" max="20" step="1"  onchange="textModify('slider2','rangeValue2p')" value=8></td>					 					
							    	<td><input id="slider3" type="range" min="1" max="20" step="1" onchange="textModify('slider3','rangeValue3p')" value=2></td>			    				    	
							    	<td><input id="slider4" type="range" min="1" max="30" step="1" onchange="textModify('slider4','rangeValue4p')" value=5></td>
						    			    	
			 					</tr>
			   				</table>
						</div>
																									
						<div id="C1" style="width: 100%; height: 80%; min-height: 600px;margin:0 0 20px 0;"></div>
					</div>
					
					
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">					
						<!-- chart2 distribution -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<h3 style="margin:0 0 5px 0;">Change Percentage Frequency Distribution</h3>
					 		<table style="border:1px solid white; width:100%">
								<tr>
									<td style="border:1px solid white;width:50%">Percentage of Change</td>
									<td style="border:1px solid white;width:50%">Count</td>
								</tr>				 
							    <tbody id="tbody1">
							    </tbody>
							</table>
						</div>
												
						<!-- chart3 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;text-align:center;">
							<h3 style="margin:0 0 5px 0;">5 Key Indexes of Latest 10 Days</h3>
							<div id="C3" style="width:100%;height:95%;min-height:500px;"></div>						
                        </div>																			
					</div>
					
                </div>
            </section>
        </main>
    
	<!-- select part initiate -->       
    <script type="text/javascript">
    function dis_search_init(){//change here
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		if(id0!=undefined){
    			dis_add(id0);//change here
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
    dis_search_init();    //change here
    </script>    
    	
	<script type="text/javascript">	
	function dis_add(StockId){
		var Loading_var=1;
		if(Loading_var==1){
			document.getElementById("Loading").style.display="block";
		}
		Loading_var=0;
	
	   	var tempMin=document.getElementById("slider1").value;
		var tempMax=document.getElementById("slider2").value;
		var tempStep=document.getElementById("slider3").value;
		var tempDayNum=document.getElementById("slider4").value;
	
		var inputs=tempMin+","+ tempMax+","+tempStep+","+tempDayNum;
		//alert(cc);
		$.ajax({
				type : 'GET',
				url : 'Ajax_Cmp?id0=' + StockId
		}).done(function(data) {
				if (data) {
					var r0 = JSON.parse(data);	
					//title part initiate
					var html="<p>"+r0.id+"</p><h1>"+r0.name+"</h1><p>"+r0.day+"</p><h2>"+r0.close+"</h2><pre style='display:none;'>"+StockId+"</pre><hr/>";
					$('#titlediv').html(html);	
					$('#changebar2').show();
				}
		});
		
		$(document).ready(function(){
				$.ajax({
					type:'POST',
				data:{
						inputs:inputs,
						StockId:StockId,
						},
				url:'ajax_Distri',
				success: function(result){
					T_Data=result;
					//alert(T_Data)
					Draw_Table(T_Data);
					
					var Data_Split = T_Data.split("|");
					var column1= eval(Data_Split[2]);
					var column2= eval(Data_Split[3]);
					var column1Array=column1.split("_");
					var column2Array=column2.split("_");
					creatTable(column1Array,column2Array);
					
					document.getElementById("Loading").style.display="none";
				}
			});
		});
	}
	
	
	$(document).ready(function(){
		$("input").change(function(){
				
				var Loading_var=1;
				if(Loading_var==1){
					document.getElementById("Loading").style.display="block";
				}
				Loading_var=0;
			
		   	var tempMin=document.getElementById("slider1").value;
			var tempMax=document.getElementById("slider2").value;
			var tempStep=document.getElementById("slider3").value;
			var tempDayNum=document.getElementById("slider4").value;
			
			//var StockId=$('#SEL_D option:selected').val();
			var StockId=$('#titlediv pre').html();

			var inputs=tempMin+","+ tempMax+","+tempStep+","+tempDayNum;
			//alert(cc);
			
			$(document).ready(function(){
					$.ajax({
						type:'POST',
					data:{
							inputs:inputs,
							StockId:StockId,
							},
					url:'ajax_Distri',
					success: function(result){
						T_Data=result;
						//alert(T_Data)
						Draw_Table(T_Data);
						
						var Data_Split = T_Data.split("|");
						var column1= eval(Data_Split[2]);
						var column2= eval(Data_Split[3]);
						var column1Array=column1.split("_");
						var column2Array=column2.split("_");
						creatTable(column1Array,column2Array);
						
						document.getElementById("Loading").style.display="none";
					}
				});
			});
		});
	});		
		
	window.onload=function(){
		/*
		textModify('slider1', 'rangeValue1p'); textModify('slider2', 'rangeValue2p'); textModify('slider3', 'rangeValue3p'); textModify('slider4', 'rangeValue4p'); 
				
		var tempMin=document.getElementById("slider1").value;
		var tempMax=document.getElementById("slider2").value;
		var tempStep=document.getElementById("slider3").value;
		var tempDayNum=document.getElementById("slider4").value;
		
		var StockId=$('#titlediv p').html();
		console.log(StockId);
		//var StockId=$('#SEL_D option:selected').val();
		//alert(StockId); successful

		var inputs=tempMin+","+ tempMax+","+tempStep+","+tempDayNum;
		//alert(cc);
		
		$(document).ready(function(){
				$.ajax({
					type:'POST',
				data:{
						inputs:inputs,
						StockId:StockId,
						},
				url:'ajax_Distri',
				success: function(result){
					T_Data=result;
					
					var Data_Split = T_Data.split("|");
					var column1= eval(Data_Split[2]);
					var column2= eval(Data_Split[3]);
					var column1Array=column1.split("_");
					var column2Array=column2.split("_");
					creatTable(column1Array,column2Array);
									
					Draw_Table(T_Data);
				}
			});
		});	
		*/
	/////////////////////////////////////////////////	
		
		$(document).ready(function(){
				$.ajax({
					type:'POST',
				data:{
	/* 					inputs:inputs,
						StockId:StockId, */
						},
				url:'ajax_Distri3',
				success: function(result){
					T_Data2=result;
					
					var Data_Split2 = T_Data2.split("|");
					var stock1= eval(Data_Split2[0]);
					var stock2= eval(Data_Split2[1]);
					var stock3= eval(Data_Split2[2]);
					var stock4= eval(Data_Split2[3]);
					var stock5= eval(Data_Split2[4]);
					var stock6= eval(Data_Split2[5]);
					var stock7= eval(Data_Split2[6]);
					var stock8= eval(Data_Split2[7]);
					var stock9= eval(Data_Split2[8]);
					var stock10= eval(Data_Split2[9]);
					var stock11= eval(Data_Split2[10]);
					
	 				leidatu(stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10, stock11);	 								
			}
			});
		});	
	}//
	</script>
	
	<script type="text/javascript">
	function creatTable(data1,data2){

		  var tableData=""

		  for(var i=0;i<data1.length;i++){
		    tableData+="<tr>"+"<td style='border:1px solid white'>"+data1[i]+"</td>"+"<td style='border:1px solid white'>"+data2[i]+"</td>"+"</tr>"
		  }

		  //现在tableData已经生成好了，把他赋值给上面的tbody
		  $("#tbody1").html(tableData)
	}
	
	var myChart1 = echarts.init(document.getElementById('C1'),'customed'); 
	function Draw_Table(Data){
			//option,setoption
			var Data_Split = Data.split("|");
			var sData = eval(Data_Split[0]);
			var sXaxis = eval(Data_Split[1]);
			var column1= eval(Data_Split[2]);
			var column2= eval(Data_Split[3]);
			
			var option1={
					textColor : 'white',
					 tooltip: {},
					 title: {
					        text: '',
					        x:"center",
					        textStyle:{fontSize:40},
					        top:-40
					        
					    },
					    toolbox: {
					        feature: {
					            dataView: {show: true, readOnly: false},
					            magicType: {show: true, type: ['bar']},
					            restore: {show: true},
					            saveAsImage: {show: true}
					        }
					    },
					    
					 	xAxis: {
					        type: 'category',
					        name:'Change Percentage',
					        nameLocation:'center',
					        nameGap:3,
					        nameTextStyle:{fontWeight:'bold', fontSize:20, color:'#FFFFFF'},
					        axisLabel:{margin:0,color:'white'},
					        data:sXaxis ,
					        axisLine : {
								onZero : true,
								lineStyle : {
									color : 'white',
									width : 2,
								}
							},
							axisTick:{
								lineStyle:{
									color:'white'
								}
							}
					    },
					 	yAxis: {
					        name:'Count Numbers',
					        nameLocation:'center',
					        nameTextStyle:{fontWeight:'bold',fontSize:20,color:'#FFFFFF'},
					        nameGap:3,
					        type: 'value',
					        axisLabel:{color:'white'},
					        axisLine : {
								onZero : true,
								lineStyle : {
									color : 'white',
									width : 2,
								}
							}
					    },
					    series: [{
					        data: sData,
					        type: 'bar'
					    }]
		};//end of option1 setting
		
	myChart1.setOption(option1);	
	}//end of draw function
	</script>
		
	<script type="text/javascript">	
	//chart 3
	var myChart3 = echarts.init(document.getElementById('C3'),'customed');
	function leidatu(stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10, stock11){
		var lineStyle = {
		 normal: {
		     width: 1,
		     opacity: 0.5
		 }
		};
	
		var option3 = {
				
				tooltip: {},
	
		 title: {
		     text: '',
		     left: 'center',
		     textStyle: {
		         color: '#eee'
		     }
		 },
		 legend: {
			 type : 'scroll',
		     bottom: -20,
		     data: ['Consumer Discretionar', 'Consumer Staples', 'Energy', 'Financials', 'Health Care', 'Industrials', 'Information Technology', 'Materials', 'Real Estate', 'Communication Service', 'Utility'],
		 	 itemGap: 0,
		     textStyle: {
		         color: '#fff',
		         fontSize: 12
		     },
		     selectedMode: 'single'
		 },
		 radar: {
		     indicator: [
		         {name: 'Standard Deviation', min:0.2,max: 1},
		         {name: 'Sharp ratio', min:-0.5,max: 0.5},
		         {name: 'Beta', min:-1,max: 2},
		         {name: 'Alpha', min:-1,max: 0.5},
		         {name: 'R Square', min:0,max: 5}
		     ],
		     shape: 'circle',
		     splitNumber: 5,
		     name: {
		         textStyle: {
		             color: 'rgb(238, 197, 102)'
		         },
		            fontSize:15
		     },
		     splitLine: {
		         lineStyle: {
		             color: [
		                 'rgba(238, 197, 102, 0.1)', 'rgba(238, 197, 102, 0.2)',
		                 'rgba(238, 197, 102, 0.4)', 'rgba(238, 197, 102, 0.6)',
		                 'rgba(238, 197, 102, 0.8)'
		             ].reverse()
		         }
		     },
		     splitArea: {
		         show: false
		     },
		     axisLine: {
		         lineStyle: {
		             color: 'rgba(238, 197, 102, 0.5)'
		         }
		     }
		 },
		 series: [
		     {
		         name: 'Consumer Discretionar',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock1,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#F9713C'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Consumer Staples',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock2,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#B3E4A1'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Energy',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock3,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: 'rgb(238, 197, 102)'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Financials',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock4,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#FFFFFF'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Health Care',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock5,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#D73131'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Industrials',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock6,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#18DB59'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Information Technology',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock7,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#9A18DB'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Materials',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock8,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#E4DC06'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },     {
		         name: 'Real Estate',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock9,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#20C731'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },
		     {
		         name: 'Communication Service',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock10,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#68EC75'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     },     {
		         name: 'Utility',
		         type: 'radar',
		         lineStyle: lineStyle,
		         data: stock11,
		         symbol: 'none',
		         itemStyle: {
		             normal: {
		                 color: '#079115'
		             }
		         },
		         areaStyle: {
		             normal: {
		                 opacity: 0.02
		             }
		         }
		     }
		 ]
		};
	
		myChart3.setOption(option3);
	}//end of funtion leidatu 		
	</script>	
    
    <!-- listen event -->
	<script type="text/javascript">		
		//resize to draw again		
		$(window).resize(function() {
			myChart1.resize();
			myChart3.resize();
			});
		
	</script>
    
	<!-- App functions and actions -->
    <script src="js/app.min.js"></script>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
    <script src="vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
    <script src="vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>
        
	</body>
</html>