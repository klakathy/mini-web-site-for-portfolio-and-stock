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
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>

	<title>Performance</title>

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
#titlediv p,
#titlediv h1,
#titlediv h2{
	margin:6px 0 0 10px;
}
#titlediv hr,
.card2 hr{
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
.card2{
 	display:flex; 
 	flex-wrap:wrap; 
 	align-content:space-between; 
 	justify-content:space-between; 
	width:100%;
}

.card2 p{
	margin:10px;	
	padding:7px 0 0 0;
 	line-height:58px; 
 	vertical-align:middle;	    
    width:320px;
	height:130px;
	border-radius:15px;
 	margin:10px;
	background-color:rgba(255,255,255,0.06);
	text-align:left;
}
.card2 p img{
	height:27px;
	width:70px;
	margin:20px 25px 10px 0;
 	float:right; 
}
.card2 p span{
/* 	height:35px; */
	line-height:1;
	width:200px;
	margin:0 0px 0 0;
	display:inline-block;
	font-size:20px;
    font-weight:500;
    text-align:center;
}
.card2 p b{
	text-align:center;
	margin:0px 0 0 0;
	padding:10px;	
	line-height:40px;
	font-size:40px;
    font-weight:600;
    display:block;
    border-top:2px solid rgba(255,255,255,0.1);
}

</style>

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
               
                <div id="chartdiv" class="content__inner">
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
							<h3 style="display:inline-block">Stock Performance</h3>
						</div>																			
						<div id="C1" style="width: 100%; height: 100%; min-height: 800px;margin:0 0 20px 0;"></div>
					</div>
					
	
									
					<div style="display:flex;flex-wrap:wrap;min-height:50%;">
						<!-- boxes index -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;">
							<h3 style="margin:0 0 5px 0;">Risk Indexes</h3>
							<div class="card2" style="height:90%">							
								<p><span>Standard Deviation</span><img src="img/daily.png"  alt="daily" />
	                               	<b id="R_sd" >...</b>
	                            </p>
	                            		                           
	                            <p><span>Sharpe Ratio</span><img src="img/daily.png"  alt="daily" />
	                            	<b id="R_sr">...</b>
	                            </p>
	                            
		                        <p><span>R square</span><img src="img/daily.png"  alt="daily" />
	                              	<b id="R_r2">...</b>
	                            </p>
	                            
	                            <p><span>Alpha</span><img src="img/daily.png"  alt="daily" />
	                               	<b id="R_alpha">...</b>
	                            </p>
	                            
	                            <p><span>Beta</span><img src="img/daily.png"  alt="daily" />
	                              	<b id="R_beta">...</b>
	                            </p>	                            
							</div>							
						</div>
						<!-- chart2 rank -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;">
							<div><p id="rank" style='color:white;font-size:26px;font-weight:400;margin:0px;'>Sector rank </p></div>						
							<div id="C3" style="width:100%;height:95%;min-height:470px;"></div>
						</div>							
					</div>
					
					
                </div>
            </section>
        </main>
    
        
    <script type="text/javascript">
    var Loading_var=1;
    function Tag_Get_Data(stockid,stockname){
    	//get the choosen tag information
    	if(Loading_var==1){
        	document.getElementById("Loading").style.display="block";
        	$('#Loading').show();
        	console.log(Loading_var);
    	}
    	Loading_var=0;

    	//var stockname=$('#SEL option:selected').text();
    	//var stockname="SRCD";
    	//var stockid=$('#SEL option:selected').val()
    			
		//B_chart ajax draw
		$(document).ready(function(){
			$.ajax({
				type:'POST',
				data:{stockid:stockid},
				url:'ajax_Perf_B',
				success: function(result){
					B_Data = result;
					Draw_Bchart(B_Data);
				}
			});
		});    
			
		$.ajax({
			type:'GET',
			url:'Ajax_Perf_K2?id0='+stockid,
			success: function(data){
				if (data) {
					var data = JSON.parse(data);	
				}else return;
				//title
				var html="<p>"+data.id+"</p><h1>"+data.name+"</h1><p>"+data.day+"</p><h2>"+data.close+"</h2><hr/>";
				$('#titlediv').html(html);
				
				//risk index
				$('#R_sd').text(data.sd.toFixed(2));
				$('#R_sr').text(data.sr.toFixed(2));
				$('#R_r2').text(data.r2.toFixed(2));
				$('#R_alpha').text(data.alpha.toFixed(2));
				$('#R_beta').text(data.beta.toFixed(2));
				//rank
				$('#rank').text("Sector rank: "+data.rank);							
				
				var data_series1=data.opdata.map(function(item){
					var tar=[];
					tar[0]=item.oo;
					tar[1]=item.cc;
					tar[2]=item.ll;
					tar[3]=item.nn;
					return tar;
				});
				console.log(data.opdata);
				//Draw_Kchart(K_Data);				
				option_K={	
						xAxis: [
							{data:data.opdata.map(function(item){return item.dd;}),},
							{data:data.opdata.map(function(item){return item.dd;}),},
						],
						series:[
							{data:data_series1,},
							{data:calculateMA(5,data_series1),},
							{data:calculateMA(10,data_series1),},
							{data:calculateMA(20,data_series1),},
							{data:calculateMA(30,data_series1),},
							{data:data.opdata.map(function(item){return item.rr.toFixed(2);}),},
							{data:data.opdata.map(function(item){return item.pp.toFixed(2);}),},//outlier high
							{stack:'ot',data:data.opdata.map(function(item){return item.ww.toFixed(2);}),},//outlier low
							{stack:'ot',data:data.opdata.map(function(item){return (item.pp-item.ww).toFixed(2);}),},//outlier diff
						]
					};
				$('#Loading').hide();
	        	//setTimeout( function(){
	                K_Chart.setOption(option_K);
	        	//}, 500 );
			}
		});
    
    }

    //initiate K-chart
	function calculateMA(dayCount,data) {
		var result = [];
        for (var i = 0, len = data.length; i < len; i++) {
        	if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                  sum += data[i - j][1];
            }
            result.push((sum / dayCount).toFixed(2));
        }
        return result;
	}
	var K_Chart = echarts.init(document.getElementById('C1'));           
	var option_K = {           	    
		tooltip: {
			trigger: 'axis',
			axisPointer: {type: 'cross'}
		},
		axisPointer:{
			link:{xAxisIndex:'all'},
			label:{backgroundColor:'rgba(255,255,255,0.06)'}
		},
		legend: {
			type:'scroll',
			data:['Price','Moving Average(5 days)','Moving Average(10 days)','Moving Average(20 days)','Moving Average(30 days)','Return Rate'],
			textStyle:{
				color:"white",
				fontSize:"18",           	        	
        	},
        },
        grid: [{
            left: '10%',
            right: '8%',
            height: '50%'
        },{
            left: '10%',
            right: '8%',
            top: '68%',
            height: '30%'
        }],
		xAxis:[{
			type: 'category',
            scale: true,
            boundaryGap : false,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax',
			axisLine:{
				lineStyle:{
					color:'white',
					width:2,
				}
			},
		},{
			type: 'category',
			gridIndex: 1,
            scale: true,
            boundaryGap : false,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax',
			axisLine:{
				lineStyle:{
					color:'rgba(200,200,200,0.5)',
					width:2,
				}
			},
		},],
		yAxis:[{
			scale:true,
			splitArea:{show:false,},
			splitLine:{show:false},
			axisLine:{
				lineStyle:{
				color:'white',
				width:2,
				}
			},	
		},{
			scale: true,
            gridIndex: 1,
            splitNumber: 2,
            //axisLabel: {show: false},
            //axisLine: {show: false},
            //axisTick: {show: false},
            //splitLine: {show: false},
            axisLine:{
				lineStyle:{
				color:'white',
				width:2,
				}
			},	
		}],
		dataZoom:[{
			type:'inside',
			xAxisIndex:[0,1],
			start:50,
			end:100
		},{
			show:true,
			type:'slider',
			xAxisIndex:[0,1],
			top:'62%',
			start:50,
			end:100,
		}],
		series:[{
			name:'Price',
			type:'candlestick',
			//data:data0.values,
			itemStyle:{
				normal:{
					color0: '#ec0000',//upcolor
					color: '#00da3c',
					borderColor0: '#8A0000',
					borderColor:'#008F28',
				}
			},
			markPoint:{
				label:{
					normal:{
						formatter:function(param){return param!=null?Math.round(param.value):'';}
					}
				},
				data:[{
					name:'highestvalue',
					type:'max',
					valueDim:'highest'
				},{
					name:'lowestvalue',
					type:'min',
					valueDim:'lowest'
				},{
					name:'averagevalueonclose',
					type:'average',
					valueDim:'close'
				}],
			},
			markLine:{
				symbol:['none','none'],
				data:[
					[{
						name:'fromlowesttohighest',
						type:'min',
						valueDim:'lowest',
						symbol:'circle',
						symbolSize:10,
						label:{
							normal:{show:false},
							emphasis:{show:false}
						}
					},{
						type:'max',
						valueDim:'highest',
						symbol:'circle',
						symbolSize:10,
						label:{
							normal:{show:false},
							emphasis:{show:false}
						}
					}],
					{
						name:'minlineonclose',
						type:'min',
						valueDim:'close'
					},{
						name:'maxlineonclose',
						type:'max',
						valueDim:'close'
					},
				]
			}
		},{
			name:'Moving Average(5 days)',
			type:'line',
			smooth:true,
			symbolSize:2,
			lineStyle:{normal:{opacity:0.5}}
		},{
			name:'Moving Average(10 days)',
			type:'line',
			smooth:true,
			symbolSize:2,
			lineStyle:{normal:{opacity:0.5}}
		},{
			name:'Moving Average(20 days)',
			type:'line',
			smooth:true,
			symbolSize:2,
			lineStyle:{normal:{opacity:0.5}}
		},{
			name:'Moving Average(30 days)',
			type:'line',
			smooth:true,
			symbolSize:2,
			lineStyle:{normal:{opacity:0.5}}
		},{
			name:'Return Rate',
			type:'line',
			symbolSize:2,
			xAxisIndex: 1,
            yAxisIndex: 1,
		},{
			name:'Outlier_up',
			type:'line',//outlier high
			showSymbol:false,
			hoverAnimation:false,
			lineStyle:{type:'dashed',color:'rgba(200,200,200,0.5)',width:0.5},
			xAxisIndex: 1,
            yAxisIndex: 1,
		},{
			name:'Outlier_down',
			type:'line',//outlier low
			showSymbol:false,
			hoverAnimation:false,
			lineStyle:{type:'dashed',color:'rgba(200,200,200,0.5)',width:0.5},
			stack:'outlier',
			xAxisIndex: 1,
            yAxisIndex: 1,
		},{
			name:'Diff',
			type:'line',//outlier difference
			stack:'outlier',
			showSymbol:false,
			legendHoverLink:false,
			hoverAnimation:false,
			areaStyle:{normal:{color:'rgba(61,165,64,0.3)'}},
			lineStyle:{normal:{color:'rgba(0,0,0,0)'}},
			xAxisIndex: 1,
            yAxisIndex: 1,
		}]
	};
	K_Chart.setOption(option_K);
	</script>
	
	
	<script type="text/javascript">		    
		function Draw_Bchart(DATA){
			var Data_Split = DATA.split("|");
    		var B_chartdata=eval(Data_Split[0]);
    		var B_chartname=eval(Data_Split[1]);           
            
            var option_B = {
            	    textColor:'white',
            		color: '#1792cd',
        
            	    title: {
            	        text: 'Return rate',
            	        left: 0,
            	        textStyle: {
            	        fontWeight: 'normal',    
            	        color: 'white'
            	        },
            	    },
            	    color: ['#3398DB'],
            	    tooltip : {
            	        trigger: 'axis',
            	        axisPointer : {            
            	            type : 'shadow'        
            	        }
            	    },
            	    grid: {
            	        left: '3%',
            	        right: '4%',
            	        bottom: '3%',
            	        containLabel: true
            	    },
            	    xAxis : [
            	        {
            	            type : 'category',
            	            data : B_chartname,
            	            axisTick: {
            	                alignWithLabel: true
            	            },
            	            axisLine:{
            	                lineStyle:{
            	                    color:'white',
            	                    width:2,
            	                }
            	            },
            	        }
            	    ],
            	    yAxis : [
            	        {
            	            type : 'value',
            	            splitLine:{show: false},
            	            axisLine:{
            	                lineStyle:{
            	                    color:'white',
            	                    width:2,
            	                }
            	            },
            	        }
            	    ],
            	    series : [
            	        {
            	            name:'return rate',
            	            type:'bar',
            	            barWidth: '60%',
            	            data:B_chartdata
            	        }
            	    ]
            	};
            B_Chart.setOption(option_B);
		}
        
		var B_Chart = echarts.init(document.getElementById('C3'));       
    </script>
     
	<!-- AJAX cpn -->
	<script type="text/javascript">
	/*
	function per_add(id0){
		$.ajax({
			type : 'GET',
			url : 'Ajax_Cpn?id0=' + id0
		}).done(function(data) {

		});
	}*/
	</script>
	
	<!-- AJAX cpn joint-distribution -->	
	<script type="text/javascript">		

	</script>	
	
	<!-- select part initiate -->       
    <script type="text/javascript">
    function per_search_init(){//change here
    	//choose
    	$(".fileId").on("click","dl dd",function(){
    		var id0 = $(this).attr("value");
    		var name0 = $(this).text();
    		if(id0!=undefined){
    			//per_add(id0);//change here
    			Tag_Get_Data(id0,name0);
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
    per_search_init();    //change here
    </script>
    
	<!-- initiate chart 2 pie -->
	<script type="text/javascript">

	</script>
	
	<!-- Chart3 3D-joint-distribution initiate -->
    <script type="text/javascript">		

	</script>
	
	<!-- listen event -->
	<script type="text/javascript">		
		//resize to draw again		
		$(window).resize(function() {
			K_Chart.resize();
			B_Chart.resize();
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