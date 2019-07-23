<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="SQL.Drop" %>
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


	<title>Comparison</title>

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

#cmp_select div h1 {
	margin: 0px;
}

#cmp_select div p {
	margin: 5px 3px;
}

#cmp_select div h6 {
	margin: 2px 0px;
}

#cmp_select div h6 b {
	font-size: 200%;
}

#cmp_select div pre {
	display: none;
}

#cmp_select div span {
	position: absolute;
	display: block;
	top: 5px;
	right: 10px;
	padding: 1px 3px;
}

#cmp_select div span:hover {
	background-color: rgba(255, 255, 255, 0.5);
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
</style>

</head>
    <body data-sa-theme="1">
    
        <main class="main">
        	<%@ include file="/same.html"%>
        	<section class="content">
        	
                <div class="content__inner">
                	<!-- title div -->
					<div class="cardpadding" style="width: 100%;text-align:center;padding:0;">
						<!-- search div -->
						<span style="color:white;font-weight:500;font-size:15px;">Add a New Stock to Comparison List</span>
						<div class="fileId">							
							<input type="text" placeholder="input or choose" autocomplete="off"/>
							<dl style="display: none;"><dt>Click on item to choose</dt></dl>
						</div>
						<!-- selected div -->
						<div id='cmp_select'></div>
					</div>
					
					<!-- chart1 price -->
					<div class="card cardpadding" >
						<div style="color:white;text-align:left">
							<h3 style="display:inline-block">Performance Comparison</h3>
							<div style="color:white;float:right;margin:20px 100px 0 0;">
								<span onclick="encodes(1)" class='span_button'>price</span> 
								<span onclick="encodes(3)" class='span_button'>change</span> 
								<span onclick="encodes(2)" class='span_button'>return</span>
							</div>
						</div>																			
						<div id="cmpchart1" style="width: 100%; height: 100%; min-height: 600px;margin:0 0 20px 0;"></div>
					</div>
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">
						<!-- chart2 distribution -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<h3 style="margin:0 0 5px 0;">Historical Return Rate Distribution</h3>
							<div id="cmpchart2" style="width: 100%; height: 95%; min-height: 550px;display:inline-block;"></div>
						</div>
						<!-- chart3 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;text-align:center;">
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
					</div>
                </div>
            </section>
        </main>
        
	<!-- AJAX cmp main -->
	<script type="text/javascript">
		//main part ajax
		function cmp_add(id0) {
			$.ajax({
				type : 'GET',
				url : 'Ajax_Cmp?id0=' + id0
			}).done(function(data) {
				if (data) {
					var r0 = JSON.parse(data);		
					$('#cmp_select').append("<div><p>"+r0.id+"</p><h1>"+r0.name+"</h1><h6>"+r0.day+"<br/><b>"+r0.close+"</b></h6><pre>"+id0+"</pre><span onclick='delete_cmp(this)'>x</span></div>");
					$("#SEL1").append("<option value='"+r0.id2+"'>"+r0.name+"</option>");
			    	$("#SEL2").append("<option value='"+r0.id2+"'>"+r0.name+"</option>");
					for(var i=0;i<tagData.length;i++){
						if(tagData[i].id == id0){
							tagData.splice(i,1);
							break;
						}
					}
					//add chart1
					var tmpseries = {};			
					tmpseries.type = 'line';
					tmpseries.showSymbol = false;
					tmpseries.symbolSize = 8;
					tmpseries.hoverAnimation = false;
					tmpseries.name = r0.name;
					tmpseries.data = [];
					tmpseries.data = r0.opdata.map(function(item) {
						var t9 = new Array;
						t9[0] = item.dd;
						t9[1] = item.cc;
						t9[2] = item.rr;
						t9[3] = item.nn;
						return t9;
					});
					tmpseries.encode = {
						x : 0,
						y : encode
					};
					option1.series.push(tmpseries);
					myChart1.setOption(option1);

					//add chart2
					tmpseries = {};
					tmpseries.type = 'bar';
					tmpseries.label = seriesLabel;
					tmpseries.name = r0.name;
					tmpseries.data = [];
					var t9 = new Array;
					t9[0] = r0.sd;
					t9[1] = r0.sr;
					t9[2] = r0.beta;
					t9[3] = r0.alpha;
					t9[4] = r0.r2;
					t9[5] = r0.r100;
					tmpseries.data = t9;
					option2.series.push(tmpseries);
					myChart2.setOption(option2);
				}
			});
		}
	</script>
	
	<!-- AJAX cmp joint-distribution -->	
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
    function cmp_search_init(){
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		if(id0!=undefined){
    			cmp_add(id0);		
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
    cmp_search_init();    
    </script>
    
	<!-- initiate chart1 -->
	<script type="text/javascript">
		var encode=1;
		var myChart1 = echarts.init(document.getElementById('cmpchart1'));
		var option1 = {
			textColor : 'white',
			tooltip : {
				trigger : 'axis',
				axisPointer : {
					show : true,
					type : 'cross',
					lineStyle : {
						type : 'dashed',
						width : 1
					},
					label:{
						color:'black',
						backgroundColor:'rgba(255,255,255,0.4)',
					}
				},
				formatter: function (params) {
					var format1=params[0].name;
					for(i=0;i<params.length;i++){
						var tar = params[i];
						format1+='<br/>'+ tar.seriesName + ' : ' + tar.value[encode].toFixed(2);
					}		            
		            return format1;
		        }
			},
			grid : {
				containLabel:true,
				top : 20,
				bottom : 80,
				left:50,

			},
			legend : {
				type : 'scroll',
				orient : 'vertical',
				left : 'right',
				itemGap : 0,
				itemHeight : 10,
				textStyle : {
					color : "white"
				},
			},
			dataZoom : [ {
				start : 50
			}, {
				type : 'inside'
			} ],
			xAxis : [ {
				type : 'category',
				boundaryGap : false,
				axisLine : {
					onZero : true,
					lineStyle : {
						color : 'white',
						width : 2,
					}
				},
			} ],
			yAxis : [ {
				type : 'value',
				scale : true,
				splitLine : {
					show : true
				},
				axisLine : {
					lineStyle : {
						color : 'white',
						width : 2,
					}
				},
			} ],
			series : []
		};
		myChart1.setOption(option1);
	</script>

	<!-- initiate chart2 -->
	<script type="text/javascript">
		var myChart2 = echarts.init(document.getElementById('cmpchart2'));
		var seriesLabel = {
			normal : {
				show : true,
				textBorderColor : '#333',
				textBorderWidth : 2,
				formatter: function (params) {	            
		            return params.value.toFixed(1)+'%';
		        },
			}
		}
		var option2 = {
			textColor : 'white',
			grid : {
				top : 50,
				containLabel:true,
			},
			tooltip : {
				trigger : 'axis',
				axisPointer : {
					type : 'shadow'
				},
				formatter: function (params) {
					var format1=params[0].name;
					for(i=0;i<params.length;i++){
						var tar = params[i];
						format1+='<br/>'+ tar.seriesName + ' : ' + tar.value.toFixed(2)+'%';
					}		            
		            return format1;
		        }
			},
			legend : {
				type : 'scroll',
				top : 50,
				textStyle : {
					color : "white"
				},
			},
			xAxis : {
				type : 'value',
				name : 'Probability',
				nameLocation:'center',
				axisLabel : {
					formatter : '{value}%'
				},
				axisLine : {
					lineStyle : {
						color : 'white',
						width : 2,
					}
				},
			},
			yAxis : {
				type : 'category',
				data : [ '<-2%', '-2%--1%', '-1%-0%', '0%-1%', '1%-2%', '>2%' ],
				inverse : true,
				axisLine : {
					lineStyle : {
						color : 'white',
						width : 2,
					}
				},
			},
			series : []
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
		//change price,change,return
		function encodes(enc) {
			encode=enc;
			var need = 0;
			option1.series = option1.series.filter(function(item) {
				if (item.encode.y != encode) {
					item.encode.y = encode;
					need++;
				}
				return item;
			});
			if (need != 0)
				myChart1.setOption(option1);
		}

		//delete one in selected
		function delete_cmp(close) {
			var name0=$(close).siblings().filter("h1").text();
			var id1 = $(close).siblings().filter("pre").text();
			tagData.push({id:id1,name:name0});
			var tmpoption = {};
			option1.series = option1.series.filter(function(item) {
				return name0 !== item.name;
			});
			option2.series = option2.series.filter(function(item) {
				return name0 !== item.name;
			});
			tmpoption = myChart1.getOption();
			tmpoption.series = option1.series;
			myChart1.setOption(tmpoption, true);
			tmpoption = myChart2.getOption();
			tmpoption.series = option2.series;
			myChart2.setOption(tmpoption, true);
			
			$("#SEL1 option[value="+id1+"]").remove();
			$("#SEL2 option[value="+id1+"]").remove();
			$(close).parent().remove();			
		}
		
		//resize to draw again		
		$(window).resize(function() {
			myChart1.resize();
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