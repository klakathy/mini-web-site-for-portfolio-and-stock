<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="SQL.Drop" %>
<%
	String id0="12";
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
        <script type="text/javascript" src="js/echarts-gl.js"></script>
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>

	<title>Component</title>

<script type="text/javascript">
	//for search bar
	var tagData=JSON.parse('<%=Drop.droppfjson()%>');
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
#titlediv p,
#titlediv h1,
#titlediv h2{
	margin:6px 0 0 10px;
}
#titlediv hr{
	height:2px;
	color:rgba(255,255,255,0.1);
}
.cpntable{
	border: 1px solid white;
	border-collapse:collapse;
}
.cpntable th,
.cpntable td{
	border: 1px solid rgb(200,200,200);
}
.cpntable th{
	text-align: center;
}
</style>

</head>
    <body data-sa-theme="1">
    
        <main class="main">
        	<%@ include file="/same.html"%>
        	<section class="content">
        		<div id="errordiv" style="display: none;"><h2>This page is only available for portfolio analysis.</h2></div>
                
                <div id="chartdiv" class="content__inner">
                	<!-- search div -->
						<span style="color:white;font-weight:500;font-size:15px;">Select a Stock</span>
						<div class="fileId">							
							<input type="text" placeholder="input or choose" autocomplete="off"/>
							<dl style="display: none;"><dt>Click on item to choose</dt></dl>
						</div>
                	<!-- title div -->
					<div id="titlediv" class="cardpadding" style="width: 100%;text-align:left;padding:0;"></div>
									
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">
						<!-- chart1 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<h3 style="margin:0 0 5px 0;">Joint-Distribution</h3>
							<p style="margin:0 3px;">choose two stocks to see joint-distribution</p>
							<div style="display:block;">
								<h3 style="font-size:15px;margin:0;display:inline-block;">Stock1
									<select id="SEL1" data-settings='{"wrapperClass":"flat"}' style="min-width:80px;"></select>
								</h3>								
								<h3 style="font-size:15px;margin:0;display:inline-block;">Stock2
									<select id="SEL2" data-settings='{"wrapperClass":"flat"}' style="min-width:80px;"></select>
								</h3>						
								<span id="JD" class='span_button' style="font-size:15px;">Submit</span>
							</div>							
							<div id="jointchart" style="width:100%;height:90%;min-height:450px;"></div>
						</div>
						<!-- chart2 pie -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<div><h3>Weight</h3></div>						
							<div id="C3" style="width:100%;height:95%;min-height:500px;"></div>
						</div>							
					</div>
					
					<!-- table -->
					<div class="card cardpadding " >
						<table id="cpntable" class="cpntable" style="width: 100%; font-size:8px;">
							<tr>
								<th style="width: 17%">Component</th>													
								<th style="width: 8%">Close price</th>
								<th style="width: 8%">Return rate</th>
								<th style="width: 8%">Standard deviation</th>
								<th style="width: 8%">Sharpe ratio</th>
								<th style="width: 8%">Beta</th>
								<th style="width: 8%">Alpha</th>
								<th style="width: 8%">R<sup>2</sup></th>
								<th style="width: 8%">Weight</th>
								<th colspan="2" style="width: 20.5%">Contribution in overall return</th>
							</tr>												
						</table>
					</div>
					
                </div>
            </section>
        </main>
        
	<!-- AJAX cpn -->
	<script type="text/javascript">
	function cpn_add(id0){
		$.ajax({
			type : 'GET',
			url : 'Ajax_Cpn?id0=' + id0
		}).done(function(data) {
			if(data=='no'){
				$('#errordiv').show();
				$('#chartdiv').hide();
				return;
			}
			var cpnjson=JSON.parse(data);
			//title part initiate
			var html="<p>"+cpnjson[0].id+"</p><h1>"+cpnjson[0].name+"</h1><p>"+cpnjson[0].day+"</p><h2>"+cpnjson[0].close+"</h2><hr/>";
			$('#titlediv').html(html);
			//table reset
			$('#cpntable td').remove();
			//table first row initiate
			html="<tr><td>"+cpnjson[0].name+" ("+cpnjson[0].id+")</td>"
					+"<td>"+cpnjson[0].close.toFixed(1)+"</td>"
					+"<td>"+cpnjson[0].r100.toFixed(2)+"%</td>"
					+"<td>"+cpnjson[0].sd.toFixed(2)+"</td>"
					+"<td>"+cpnjson[0].sr.toFixed(2)+"</td>"
					+"<td>"+cpnjson[0].beta.toFixed(2)+"</td>"
					+"<td>"+cpnjson[0].alpha.toFixed(2)+"</td>"
					+"<td>"+cpnjson[0].r2.toFixed(2)+"</td>"
					+"<td>100%</td>"
					+"<td style='width: 6%'>"+cpnjson[0].r100.toFixed(2)+"%</td>"
					+"<td style='width: 14.5%'><span style='height: 30px;width:30px;display: inline-block;'></span></td></tr>";
			$('#cpntable').append(html);
			//table other rows initiate
			cpnjson.splice(0,1);
			for(var i=0;i<cpnjson.length;i++){	
				var tmpw=cpnjson[i].r100*cpnjson[i].weight;
				html="<tr><td>"+cpnjson[i].name+" ("+cpnjson[i].id+")</td>"
				+"<td>"+cpnjson[i].close.toFixed(1)+"</td>"
				+"<td>"+cpnjson[i].r100.toFixed(2)+"%</td>"
				+"<td>"+cpnjson[i].sd.toFixed(2)+"</td>"
				+"<td>"+cpnjson[i].sr.toFixed(2)+"</td>"
				+"<td>"+cpnjson[i].beta.toFixed(2)+"</td>"
				+"<td>"+cpnjson[i].alpha.toFixed(2)+"</td>"
				+"<td>"+cpnjson[i].r2.toFixed(2)+"</td>"
				+"<td>"+cpnjson[i].weight.toFixed(2)+"%</td>"
				+"<td>"+(tmpw/100).toFixed(2)+"%</td>";
				tmpw*=5;
				if(tmpw<0){														
					tmpw=0-tmpw;
					html+="<td style='text-align:right;padding:0 6.8% 0 0;'><span style='height: 30px; width:"+tmpw+"%; background-color: #c23531; display: inline-block;'></span></td>";
				}else{
					html+="<td style='padding:0 0 0 6.8%;'><span style='height: 30px; width:"+tmpw+"%; background-color:#1eb075ad; display: inline-block;'></span></td>";
				}
				html+="</tr>";
				$('#cpntable').append(html);
				
			}

			option2 = {
				series:[{
					data:cpnjson.map(function(item){
						var tar={};
						tar.value=item.weight;
						tar.name=item.name;
						tar.selected=true;
						return tar;
					})
				}]			
			};	
			myChart2.setOption(option2);
			
			$("#SEL1").empty();
			$("#SEL2").empty();
			//3D part
			cpnjson.map(function(item) {
				$("#SEL1").append("<option value='"+item.id2+"'>"+item.name+"</option>");
		    	$("#SEL2").append("<option value='"+item.id2+"'>"+item.name+"</option>");
			});
		});
	}
	</script>
	
	<!-- AJAX cpn joint-distribution -->	
	<script type="text/javascript">		
		//3D part
		$("#JD").click(function(event){
			var s1=document.getElementById("SEL1").value;
			var s2=document.getElementById("SEL2").value;
			var ss1=$("#SEL1 option[value="+s1+"]").text();
			var ss2=$("#SEL1 option[value="+s2+"]").text();
			$.ajax({
				type:'POST',
			 	data:{
						id1:s1,
						id2:s2,
						}, 
				url:'ajax_Compa3D',
				success: function(result){
					var data = eval(result);			
					var option3 = {						
						xAxis3D: {name:ss1,},
						yAxis3D: {name:ss2,},
					    tooltip: {
					        formatter: function (params) {
					        	var f0='<div style="text-align:left;min-width:220px;">'+ss1+':';
					            if(params.value[0]==0)f0+='Less than -5';
					            else if(params.value[0]==11)f0+='Greater than 5';
					            else f0+=Stock1[params.value[0]];
					            f0+='<br/>'+ss2+':';
					            if(params.value[1]==0)f0+='Greater than 5';
					            else if(params.value[1]==11)f0+='Less than -5';
					            else f0+=Stock2[params.value[1]];
					            
					            return f0+'<br/>Count:'+params.value[2]+'</div>';
					       }    	
					    },
					    series: [{
					        data: data.map(function (item) {
					            return {
					                value: [item[1], item[0], item[2]],
					            }
					        }),
					    }]
					};
					myChart3.setOption(option3);
				}
			});			
		});
	</script>	
	
	<!-- select part initiate -->       
    <script type="text/javascript">
    function cpn_search_init(){//change here
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		if(id0!=undefined){
    			cpn_add(id0);//change here
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
    cpn_search_init();    //change here
    </script>
    
	<!-- initiate chart 2 pie -->
	<script type="text/javascript">
	//pie chart initiate
	var myChart2 = echarts.init(document.getElementById('C3'));
	var option2 = {
			textColor:'white',
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				type : 'scroll',
				orient : 'vertical',
				left : 'right',
				itemGap:-15,
				textStyle:{color:"white"},
			},
			series : [ {
				name:'Weight',
				type : 'pie',
				radius : '40%',
				startAngle:270,
				minShowLabelAngle:40,
				selectedMode: 'multiple',
	            selectedOffset:3,
				center : [ '40%', '60%' ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]		
	};	
	myChart2.setOption(option2);
	</script>
	
	<!-- Chart3 3D-joint-distribution initiate -->
    <script type="text/javascript">		
	var myChart3 = echarts.init(document.getElementById('jointchart'));
	var Stock1 = ["(<-5)",'[-5,-4)','[-4,-3)','[-3,-2)','[-2,-1)','[-1,0)','[0,1)','[1,2)','[2,3)','[3,4)','[4,5]','(>5)'];
	var Stock2 = ["(>5)",'[4,5]','[3,4)','[2,3)','[1,2)','[0,1)','[-1,0)','[-2,-1)','[-3,-2)','[-4,-3)','[-5,-4)','(<-5)'];
	
	var option3 = {
	
	    visualMap: {
	        max: 200,
	        inRange: {
	            color: ['#FFFFFF','#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
	        }
	    },
	    xAxis3D: {
	        type: 'category',
	        data: Stock1,   
	    },
	    yAxis3D: {
	        type: 'category',
	        data: Stock2,     
	    },
	    zAxis3D: {
	        type: 'value',
	        name:'Count',        
	    },
	    grid3D: {
	        boxWidth: 80,
	        boxDepth: 80,
	        viewControl: {
	            // projection: 'orthographic'
	        },
			axisLine:{
	            show:true,
	            lineStyle:{
	                color:'white',
	                opacity:1,
	                width:2,
	            },},
	        light: {
	            main: {
	                intensity: 1.2,
	                shadow: false
	            },
	            ambient: {
	                intensity: 0.3
	            }
	        }
	    },
	    series: [{
	        type: 'bar3D',
	        data: [],
	        shading: 'lambert',
	        label: {
	            textStyle: {
	                fontSize: 16,
	                borderWidth: 1
	            }
	        },
	        itemStyle: {opacity: 0.6,},
	        emphasis: {
	            label: {
	                textStyle: {
	                    fontSize: 20,
	                    color: '#900'
	                }
	            },
	            itemStyle: {
	                color: '#000000'
	            }
	        }
	    }]
	};
	myChart3.setOption(option3);
	</script>
	
	<!-- listen event -->
	<script type="text/javascript">		
		//resize to draw again		
		$(window).resize(function() {
			myChart2.resize();
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