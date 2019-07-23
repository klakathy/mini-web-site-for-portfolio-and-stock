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
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>

	<title>Detail Analysis</title>

<script type="text/javascript">
	//for search bar
	var tagData=JSON.parse('<%=Drop.droppfjson()%>');
</script>
<style type="text/css">
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
					
					<!-- chart1 weight+count -->
					<div class="card cardpadding " >
						<div>
							<h1>Group by Sector</h1>
							<p>Global Industry Classification Standard (GICS) is commonly used by global financial community. Group all components in the portfolio, record total weight and number of stocks belonging to each sector to mine the logistic of portfolio design.</p>
						</div>
						<div id='C1' style="width: 100%; height: 400px;"></div>
					</div>
					
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">
						<!-- chart2 distribution -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<div>
								<h1>Alpha</h1>
								<p>Alpha (Greek letter) is a term used in investing to
										describe a strategy's ability to beat the market.</p>
							</div>
							<div id="C2" style="width: 100%; height: 95%; min-height: 450px;display:inline-block;"></div>
						</div>
						<!-- chart3 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<div>
								<h1>Beta</h1>
								<p>A beta coefficient is a measure of the volatility, or
									systematic risk, of an individual stock in comparison to the
									unsystematic risk of the entire market.</p>
							</div>						
							<div id="C3" style="width:100%;height:95%;min-height:450px;"></div>
						</div>							
					</div>
					
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">
						<!-- chart2 distribution -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<div>
								<h1>Sharpe ratio</h1>
								<p>is used to help investors understand the return of an
									investment compared to its risk.</p>
							</div>
							<div id="C4" style="width: 100%; height: 95%; min-height: 450px;display:inline-block;"></div>
						</div>
						<!-- chart3 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 600px;">
							<div>
								<h1>R square</h1>
								<p>is a statistical measure that represents the proportion
									of the variance for a dependent variable that's explained by
									an independent variable (S&amp;P 500).</p>
							</div>						
							<div id="C5" style="width:100%;height:95%;min-height:450px;"></div>
						</div>							
					</div>
					
                </div>
            </section>
        </main>
        
	<!-- AJAX cmp main -->
	<script type="text/javascript">
	function da_add(id0){
		$.ajax({
			type : 'GET',
			url : 'Ajax_DA?id0=' + id0
		}).done(function(data) {
			if(data=='no'){
				$('#errordiv').show();
				$('#chartdiv').hide();
				return;
			}
			var dajson=JSON.parse(data);
			
			//title part initiate
			var html="<p>"+dajson[0].id+"</p><h1>"+dajson[0].name+"</h1><p>"+dajson[0].day+"</p><h2>"+dajson[0].close+"</h2><hr/>";
			$('#titlediv').html(html);
			
			dajson.splice(0,1);
			
			//1-weight + count initiate
			var option_da1 = {
				dataset : {source : dajson},
			};
			myChart1.setOption(option_da1);

			//2-alpha + return initiate
			var option_da2 = {
				dataset : {source : dajson},
			};
			myChart2.setOption(option_da2);

			//3-beta + sd chart initiate
			var option_da3 = {
				dataset : {source : dajson},
			};
			myChart3.setOption(option_da3);

			//4-sr(return + sd) chart initiate
			var option_da4 = {
				dataset : {source : dajson},
				series : [ {
					type : 'scatter',
					encode : {
						x : 'sd',
						y : 'r100'
					},
					label : {
						normal : {
							show : true,
							formatter: function (params) {	            
					            return params.data.sr.toFixed(2);
					        },
							position : 'bottom'
						}
					},
					markLine : {
						animation : false,
						label : {
							normal : {
								formatter : 'y = x',
								textStyle : {
									align : 'right'
								}
							}
						},
						lineStyle : {
							normal : {
								type : 'solid',
								color:'white'
							}
						},
						data : [ [ 
							{coord : [ 0, 0 ],symbol : 'none'},
							{coord : [ 0.3, 0.3 ],symbol : 'none'},
						] ]
					}
				},]
			};
			myChart4.setOption(option_da4);

			//5-r2 chart initiate
			var option_da5 = {				
				dataset : {source : dajson},
			};
			myChart5.setOption(option_da5);
		});		
	}
	</script>
	
	
	<!-- select part initiate -->       
    <script type="text/javascript">
    function da_search_init(){
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		if(id0!=undefined){
    			da_add(id0);
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
    da_search_init();    
    </script>
    
	<!-- initiate chart 1-5 -->
	<script type="text/javascript">
	var myChart1 = echarts.init(document.getElementById('C1'));
	var myChart2 = echarts.init(document.getElementById('C2'));
	var myChart3 = echarts.init(document.getElementById('C3'));
	var myChart4 = echarts.init(document.getElementById('C4'));
	var myChart5 = echarts.init(document.getElementById('C5'));

	var visualMap_da = {
			show : false,
			orient : 'horizontal',
			min : 1,
			max : 12,
			dimension : 'rank',
			inRange : {color : [ '#D7DA8B', '#E15457' ]}
	};

	//1-weight + count initiate
	var option_da1 = {
		textColor : 'white',
		grid : [ {
			containLabel : true,
			top : 50,
			right : '10%',
			width : '25%'
		}, {
			containLabel : true,
			top : 50,
			right : '50%',
			width : '45%'
		} ],
		xAxis : [ {
			name : 'count of stocks',
			nameLocation : 'center',
			axisLine : {
				show : false,
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
			axisTick : {show : false},
			axisLabel : {show : false},
			splitLine : {show : false},
			position : 'top',
		}, {
			name : 'weight',
			nameLocation : 'center',
			gridIndex : 1,
			axisLine : {
				show : false,
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
			axisTick : {show : false},
			axisLabel : {show : false},
			splitLine : {show : false},
			position : 'top'
		} ],
		yAxis : [ {
			type : 'category',
			show : false
		}, {
			type : 'category',
			gridIndex : 1,
			axisTick : {
				show : false
			},
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		} ],
		visualMap : visualMap_da,
		tooltip : {
			trigger : 'axis',
			formatter:function (params) {
				var format1='<div style="text-align:left;min-width:300px;"><h3>'+params[0].name;
				for(i=0;i<params.length;i++){
					var tar = params[i];
					format1+='</h3><p>'+tar.data.id+'<br/>weight:'+ tar.data.weight.toFixed(2)+'%<br/>count:'+tar.data.close+'</p></div>';
				}		            
	            return format1;
	        }
		},
		series : [ {
			type : 'bar',
			encode : {
				x : 'close',
				y : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight'
				}
			},
		}, {
			type : 'bar',
			xAxisIndex : 1,
			yAxisIndex : 1,
			encode : {
				x : 'weight',
				y : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.weight.toFixed(2);
			        },
				}
			},
		}, ]
	};
	myChart1.setOption(option_da1);

	//2-alpha + return initiate
	var option_da2 = {
		textColor : 'white',
		grid : [ {
			containLabel : true,
			top : 50,
			right : 0,
			width : '35%'
		}, {
			containLabel : true,
			top : 50,
			right : '45%',
			width : '35%'
		} ],
		xAxis : [ {
			name : 'alpha',
			nameLocation : 'center',
			axisLine : {
				show : false,
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
			axisTick : {show : false},
			axisLabel : {show : false},
			splitLine : {show : false},
			position : 'top',
		}, {
			name : 'return',
			gridIndex : 1,
			nameLocation : 'center',
			axisLine : {
				show : false,
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
			axisTick : {show : false},
			axisLabel : {show : false},
			splitLine : {show : false},
			position : 'top',
		} ],
		yAxis : [ {
			type : 'category',
			show : false
		}, {
			type : 'category',
			gridIndex : 1,
			axisTick : {
				show : false
			},
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		} ],
		visualMap : visualMap_da,
		tooltip : {
			trigger : 'axis',
			formatter:function (params) {
				var format1='<div style="text-align:left;min-width:300px;"><h3>'+params[0].name;
				for(i=0;i<params.length;i++){
					var tar = params[i];
					format1+='</h3><p>'+tar.data.id+'<br/>alpha:'+ tar.data.alpha.toFixed(2)+'<br/>return:'+tar.data.r100.toFixed(2)+'</p></div>';
				}		            
	            return format1;
	        }
		},
		series : [ {
			type : 'bar',
			encode : {
				x : 'alpha',
				y : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.alpha.toFixed(2);
			        },
				}
			},
		}, {
			type : 'bar',
			xAxisIndex : 1,
			yAxisIndex : 1,	
			encode : {
				x : 'r100',
				y : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.r100.toFixed(2);
			        },
				}
			},
		}, ]
	};
	myChart2.setOption(option_da2);

	//3-beta + sd chart initiate
	var option_da3 = {
		textColor : 'white',
		legend : {
			textStyle : {
				color : "white"
			},
		},
		yAxis : [ {
			name : 'sd',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		}, {
			name : 'beta',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		} ],
		xAxis : {
			type : 'category',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		},
		tooltip : {
			trigger : 'axis',
			formatter:function (params) {
				var format1='<div style="text-align:left;min-width:300px;"><h3>'+params[0].name;
				format1+='</h3><p>'+params[0].data.id+'<br/>sd:'+ params[0].data.sd.toFixed(2)+'%<br/>beta:'+params[0].data.beta.toFixed(2)+'</p></div>';	            
	            return format1;
	        }
		},
		series : [ {
			type : 'bar',
			name : 'sd',
			encode : {
				y : 'sd',
				x : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.sd.toFixed(2);
			        },
				}
			},
		}, {
			type : 'bar',
			name : 'beta',
			yAxisIndex : 1,
			encode : {
				y : 'beta',
				x : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.beta.toFixed(2);
			        },
				}
			},
		}]
	};
	myChart3.setOption(option_da3);

	//4-sr(return + sd) chart initiate
	var option_da4 = {
		textColor : 'white',
		xAxis : {
			name : 'sd',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		},
		yAxis : {
			name : 'return',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		},
		visualMap : visualMap_da,
		tooltip : {
			trigger : 'item',
			formatter:function (params) {
				var format1='<div style="text-align:left;min-width:300px;"><h3>'+params.data.name+'</h3><p>'+params.data.id;
				format1+='<br/>sd:'+ params.data.sd.toFixed(2)+'%<br/>return:'+params.data.r100.toFixed(2)+'%<br/>sr:'+params.data.sr.toFixed(2)+'</p></div>';	            
	            return format1;
	        }
		},
		series : []
	};
	myChart4.setOption(option_da4);

	//5-r2 chart initiate
	var option_da5 = {
		textColor : 'white',
		yAxis : [ {
			name : 'r2',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		}],
		xAxis : {
			type : 'category',
			axisLine : {
				lineStyle : {
					color : 'white',
					width : 2,
				}
			},
		},
		tooltip : {
			trigger : 'axis',
			formatter:function (params) {
				var format1='<div style="text-align:left;min-width:300px;"><h3>'+params[0].name;
				format1+='</h3><p>'+params[0].data.id+'<br/>alpha:'+ params[0].data.alpha.toFixed(2)+'<br/>beta:'+params[0].data.beta.toFixed(2)+'<br/>r2:'+params[0].data.r2.toFixed(2)+'</p></div>';	            
	            return format1;
	        }
		},
		visualMap : visualMap_da,
		series : [ {
			type : 'bar',
			name : 'r square',
			encode : {
				y : 'r2',
				x : 'name'
			},
			label : {
				normal : {
					show : true,
					position : 'insideRight',
					formatter: function (params) {	            
			            return params.data.r2.toFixed(2);
			        },
				}
			},
		} ]
	};
	myChart5.setOption(option_da5);
	</script>
	
	<!-- listen event -->
	<script type="text/javascript">		
		//resize to draw again		
		$(window).resize(function() {
			myChart1.resize();
			myChart2.resize();
			myChart3.resize();
			myChart4.resize();
			myChart5.resize();
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