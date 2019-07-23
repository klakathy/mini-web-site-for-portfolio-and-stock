<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%@ page import="SQL.Drop" %>
<%@ page import="option.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


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
		<link rel="stylesheet" href="css/common.css">
		<link href="css/font-awesome.css" rel="stylesheet" type="text/css" />
		<link href="css/layui.css" rel="stylesheet" type="text/css" />

        
        <script type="text/javascript" src="js/echarts.all.js"></script>
		<script type="text/javascript" src="js/echarts-gl.js"></script>
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>


		<script src="js/MySearch.js" type="text/javascript"></script>
		<script src="js/jackwei.slider.js"></script>



	<style>
		.layui-btn{
			background-color: black;
		}
		.label{
		    padding: 2px 5px;
		    background: #5FB878;
		    border-radius: 2px;
		    color: black;
		    display: block;
		    line-height: 20px;
		    height: 20px;
		    margin: 2px 5px 2px 0;
		    float: left;
		}
		i{
			display: inline-block;
		    width: 18px;
		    height: 18px;
		    line-height: 18px;
		    text-align: center
		}
		.label:hover{color: black;}
		.label i:hover {
			 background-color: #009E94;
			 border-radius: 2px;
		}
		.layui-form-select dl dd:hover {
			background-color: #5FB878;
			color: green;
		}
		.AD{
			width: 210px;
		    margin-left: 40px;
		    overflow-y: auto;
		    max-height: 200px;
		    border: 2px solid #5fb878;
    		border-radius: 6px;
    		padding: 1px 2px;
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
		
	/****save****/
  .window0 {
    display: none; 
    position: fixed; 
    z-index: 3; 
    padding-top: 200px; 
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    min-width: 700px;
    overflow: auto; 
    background-color: rgba(255,255,255,0.1); 
  }

  .window1-content {
    background-color: rgba(25,25,25,0.8);
    margin: auto;
    padding: 40px 7%;
    border: none;
    width: 500px;
    height:300px;
    font-family: Helvetica;
    color: white;
    font-size:130%;
    border-radius:16px;
  }

  .close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
  }

  .close:hover,
  .close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
  }
	</style>




<title>Customization</title>
</head>
    <body data-sa-theme="1">
    
        <main class="main">
        	<%@ include file="/same.html"%>
	        <section class="content">
                <div class="content__inner">
				
					<div style="display:flex;flex-wrap:wrap;min-height:45%;">
						<!-- chart K -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;flex-grow: 2;-webkit-flex-grow: 2;">							
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
							<div id="Kcur_Chart" style="width: 100%; height: 95%; min-height: 450px;display:inline-block;"></div>
						</div>
						<!-- select part -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;flex-grow: 1;-webkit-flex-grow: 1;">
							<div id="Dropdownlist" class="card-body">
					         	<form>
									<div id="demo">
									</div>
									<input type="button" style="width:70px;" id = "btn" value = "Virtualize" onclick = "Virtualize()">
									<input type="button" name="saveopen" value = "save portfolio" onclick ="saveopen2()">
									<h6 id="saveprocessing" style="display:none;">SAVE PROCESSING ...<br/>Don't close the page.</h6>
								</form>
					        </div>													
						</div>							
					</div>
					
					<div style="display:flex;flex-wrap:wrap-reverse;min-height:45%;">
						<!-- chart2 distribution -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;flex-grow: 2;-webkit-flex-grow: 2;">
							<div id="His_Chart" style="width: 100%; height: 95%; min-height: 450px;display:inline-block;"></div>
						</div>
						<!-- chart3 joint -->
						<div class="card cardpadding cardinline" style="height: 100%; min-height: 550px;flex-grow: 1;-webkit-flex-grow: 1;">						
							<div id="Pie_Chart" style="width:100%;height:95%;min-height:450px;"></div>
						</div>							
					</div>
					
				</div>
				
				<div id="window0" class="window0">
			      <div class="window1-content" align="left">
			        <span class="close" onclick="saveclose2()">&times;</span>
			        <section id="contact_section">
			          <h3>Save Portfolio</h3><br/>
			          <form name="form_savep">
			            <p>Add a name for the portfolio<sup>*</sup><input type="text" size="10" name="namep" id="namep"/></p>
			            <p>Add description for the portfolio<br/>
			            	<input type="text" size="30" name="desp" id="desp"/>
			            </p><br/>
			            <input type="button" value="OK" name="saveok" onclick="saveok2()"/>
			          </form>
			          <h6 id="savefail" style="display:none;">fail</h6>
			        </section>        
			      </div>
			    </div>
			
               </section>
        </main>


	<script type="text/javascript">
	function saveopen2(){
		var fullids="";
		$("#demo .AD input[type='hidden']").map(function(){
			fullids+=$(this).val()+"_";});
		if(fullids=="")return;		
		$('#window0').show();
	}
	function saveclose2(){
		$('#window0').hide();
	}
	function saveok2(){
		var namep=$('#namep').val();
		if(namep==""){
			$('#savefail').html("Error: Name required");
			$('#savefail').show();
			return;
			}
		$.ajax({
			type : 'GET',
			url : 'ajax_CustM_H?f=1&namep='+namep
		}).done(function(data) {
			//name not used
			if(data=="no"){
				$('#savefail').html("Error: Name used");
				$('#savefail').show();
				return;
			}else if(data=="error"){
				$('#savefail').html("Error: Search failed");
				$('#savefail').show();
				return;
			}
			var desp=$('#desp').val();
			if(desp=="")desp=namep;
							
			var fullids="";
			var fullweights="";
			$("#demo .AD input[type='hidden']").map(function(){
				fullids+=$(this).val()+"_";});
			$("#demo .AD input[type='text']").map(function(){
				fullweights+=$(this).val()/100+"_";});
			if(fullids==""){
				$('#savefail').html("Error: Null portfolio");
				$('#savefail').show();
				return;
			}
			$('#window0').hide();
			$('#saveprocessing').html('SAVE PROCESSING ...<br/>Don\'t close the page.');
			$('#saveprocessing').show();
			$.ajax({
				type : 'GET',
				url : 'ajax_CustM_H?f=0&namep='+namep+'&desp='+desp+'&fullids=' + fullids +'&fullweights='+fullweights
			}).done(function(data) {
				if(data=="no"){
					alert('Error: Invalid Input');
					$('#saveprocessing').hide();
					return;
				}else if(data=="no2"){
					alert('Error: System fail');
					$('#saveprocessing').hide();
					return;
				}
				alert('Succeed');
				$('#saveprocessing').hide();
			})							
						
		})
			
	}
	</script>
	
	<script type="text/javascript">
	
		<%    	
			List<Option> op2= Drop.drop();
			String [] Drop_Data = new String[op2.size()];
			String Res="[";
			
			for(int i=0;i<op2.size();i++){
				Res+="{'name':"+"'"+op2.get(i).name+"','id':"+(i+1)+"},";
			}
			Res+="]";
		%>			
			var tagData2=<%=Res%>;//股票名数组
			
			//for search bar
			var tagData=JSON.parse('<%=Drop.dropjson()%>');
		    $.myMethod("#demo",tagData,"fileIds")
		    $(".sumbit").on("click",function(){
		    	console.log($("form").serialize())
		    })
		    
		    
	</script>

    
	<script type="text/javascript">
		var Loading_var=1;
		var B_chart = echarts.init(document.getElementById('Pie_Chart'));
	    var K_chart = echarts.init(document.getElementById('Kcur_Chart'));
	    var H_chart = echarts.init(document.getElementById('His_Chart'));
	    
		//Pie Chart initiate
	    var option_P = {
	        title : {
	            text: 'Weights Proportion',	            
	            textStyle:{
	                color:'white',
	                fontSize:25,
	            },
	            subtext: 'Customization',
	            x:'center',
	        },
	        tooltip : {
	            trigger: 'item',
	            //formatter: "{a} <br/>{b} : {c} ({d}%)",
				formatter:function (params) {
					var format1=params.name;
					format1+='<br/>'+params.data.id2+'<br/>weight:'+ (params.value*100).toFixed(2)+'%<br/>hundred unit price:'+params.data.unitprice;						            
		            return format1;
		        }
	        },
	        legend: {
	        	type:'scroll',
	            orient: 'horizontal',
	            left: '30%',
	            top:'78%',
	            textStyle:{
	                color:'white',
	                fontSize:16
	            }
	        },
	        series : [
	            {
	                name: 'Weights Proportion',
	                type: 'pie',
	                radius : '55%',
	                center: ['50%', '48%'],
	                selectedMode: 'multiple',
		            selectedOffset:3,
	                //data:P_data,
	                label: {
	                	  normal: {
	                	    position: 'inner',
	                	    show : false
	                	  }
                	},
	                itemStyle: {
	                    emphasis: {
	                        shadowBlur: 10,
	                        shadowOffsetX: 0,
	                        shadowColor: 'rgba(0, 0, 0, 0.5)'
	                    }
	                }
	            }
	        ]
	    };
		B_chart.setOption(option_P);

		
		function Virtualize(){
			if(Loading_var==1){
				document.getElementById("Loading").style.display="block";
			}
			Loading_var=0;
					    
		    var Thread_num=5;
	
			var fullids="";
			var fullweights="";
			$("#demo .AD input[type='hidden']").map(function(){
				fullids+=$(this).val()+"_";});
			$("#demo .AD input[type='text']").map(function(){
				fullweights+=$(this).val()/100+"_";});
			if(fullids=="")return;

			
			$.ajax({
				type : 'GET',
				url : 'ajax_CustM_K?fullids=' + fullids +'&fullweights='+fullweights
			}).done(function(data) {
				var result = JSON.parse(data);
				K_Data=result.kdata;
				Draw_SumKchart(K_Data);
				H_Data=result.hdata;						
				Draw_SumHchart(H_Data)
				P_Data=JSON.parse(result.pdata);
				var option2 = {
						series:{
							data:P_Data.map(function(item){
								var tar={};
								tar.value=item.weight;
								tar.name=item.name;
								tar.unitprice=item.close;
								tar.id2=item.id2;
								tar.selected=true;
								return tar;
							})
						}			
					};	
				setTimeout( function(){
				    B_chart.setOption(option2);
					}, 500 )
			});
			
	    
			function Draw_SumKchart(DATA){
			        var upColor = '#ec0000';
			        var upBorderColor = '#8A0000';
			        var downColor = '#00da3c';
			        var downBorderColor = '#008F28';
			       
		            var data0 = splitData(eval(DATA));
		           		            
			        function splitData(rawData) {
			            var categoryData = [];
			            var values = [];
			            var values2=[];
			            for (var i = 0; i < rawData.length; i++) {
			                categoryData.push(rawData[i].splice(0, 1)[0]);
			                values.push(rawData[i].map(function(item){return item.toFixed(2);}));
			                values2.push(rawData[i]);
			            }
			            return {
			                categoryData: categoryData,
			                values: values,
			                values2:values2
			            };
			        }
			        
			        function calculateMA(dayCount) {
			            var result = [];
			            for (var i = 0, len = data0.values2.length; i < len; i++) {
			                if (i < dayCount) {
			                    result.push('-');
			                    continue;
			                }
			                var sum = 0;
			                for (var j = 0; j < dayCount; j++) {
			                    sum += data0.values2[i - j][1];
			                }
			                result.push((sum / dayCount).toFixed(2));
			            }
			            return result;
			        }
			    var option_K = {
			        	    tooltip: {
			        	        trigger: 'axis',
			        	        axisPointer: {
			        	            type: 'cross'
			        	        }
			        	    },
			        	    legend: {
			        	    	type:'scroll',
			        	        data: ['Price', 'Moving Average(5 day)', 'Moving Average(10 days)', 'Moving Average(20 days)', 'Moving Average(30 days)'],
			        	        textStyle:{color:"white"},
			        	    },
			        	    grid: {
			        	        left: '10%',
			        	        right: '10%',
			        	        bottom: '15%'
			        	    },
			        	    xAxis: {
			        	        type: 'category',
			        	        data: data0.categoryData,
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
			        	    },
			        	    yAxis: {
			        	        scale: true,
			        	        splitArea: {
			        	            show: false,
			        	        },
			        	        splitLine:{show: false},
			    	            axisLine:{
			    	                lineStyle:{
			    	                    color:'white',
			    	                    width:2,
			    	                }
			    	            },
			        	        
			        	    },
			        	    dataZoom: [
			        	        {
			        	            type: 'inside',
			        	            start: 50,
			        	            end: 100
			        	        },
			        	        {
			        	            show: true,
			        	            type: 'slider',
			        	            y: '93%',
			        	            start: 50,
			        	            end: 100
			        	        }
			        	    ],
			        	    series: [
			        	        {
		        	        	  	name: 'Price',
			        	            type: 'candlestick',
			        	            data: data0.values,
			        	            itemStyle: {
			        	                normal: {
			        	                    color0: upColor,
			        	                    color: downColor,
			        	                    borderColor0: upBorderColor,
			        	                    borderColor: downBorderColor
			        	                }
			        	            },
			        	            markPoint: {
			        	                label: {
			        	                    normal: {
			        	                        formatter: function (param) {
			        	                            return param != null ? Math.round(param.value) : '';
			        	                        }
			        	                    }
			        	                },
			        	                data: [
			        	                    {
			        	                    	name: 'XX标点',
			        	                        coord: ['2013/5/31', 2300],
			        	                        value: 2300,
			        	                        itemStyle: {
			        	                            normal: {color: 'rgb(41,60,85)'}
			        	                        }
			        	                    },
			        	                    {
			        	                        name: 'highest value',
			        	                        type: 'max',
			        	                        valueDim: 'highest'
			        	                    },
			        	                    {
			        	                        name: 'lowest value',
			        	                        type: 'min',
			        	                        valueDim: 'lowest'
			        	                    },
			        	                    {
			        	                        name: 'average value on close',
			        	                        type: 'average',
			        	                        valueDim: 'close'
			        	                    }
			        	                ],
			        	                tooltip: {
			        	                    formatter: function (param) {
			        	                        return param.name + '<br>' + (param.data.coord || '');
			        	                    }
			        	                }
			        	            },
			        	            markLine: {
			        	                symbol: ['none', 'none'],
			        	                data: [
			        	                    [
			        	                        {
			        	                            name: 'from lowest to highest',
			        	                            type: 'min',
			        	                            valueDim: 'lowest',
			        	                            symbol: 'circle',
			        	                            symbolSize: 10,
			        	                            label: {
			        	                                normal: {show: false},
			        	                                emphasis: {show: false}
			        	                            }
			        	                        },
			        	                        {
			        	                            type: 'max',
			        	                            valueDim: 'highest',
			        	                            symbol: 'circle',
			        	                            symbolSize: 10,
			        	                            label: {
			        	                                normal: {show: false},
			        	                                emphasis: {show: false}
			        	                            }
			        	                        }
			        	                    ],
			        	                    {
			        	                        name: 'min line on close',
			        	                        type: 'min',
			        	                        valueDim: 'close'
			        	                    },
			        	                    {
			        	                        name: 'max line on close',
			        	                        type: 'max',
			        	                        valueDim: 'close'
			        	                    }
			        	                ]
			        	            }
			        	        },
		            	        {
		            	            name: 'Moving Average(5 days)',
		            	            type: 'line',
		            	            data: calculateMA(5),
		            	            smooth: true,
		            	            lineStyle: {
		            	                normal: {opacity: 0.5}
		            	            }
		            	        },
		            	        {
		            	            name: 'Moving Average(10 days)',
		            	            type: 'line',
		            	            data: calculateMA(10),
		            	            smooth: true,
		            	            lineStyle: {
		            	                normal: {opacity: 0.5}
		            	            }
		            	        },
		            	        {
		            	            name: 'Moving Average(20 days)',
		            	            type: 'line',
		            	            data: calculateMA(20),
		            	            smooth: true,
		            	            lineStyle: {
		            	                normal: {opacity: 0.5}
		            	            }
		            	        },
		            	        {
		            	            name: 'Moving Average(30 days)',
		            	            type: 'line',
		            	            data: calculateMA(30),
		            	            smooth: true,
		            	            lineStyle: {
		            	                normal: {opacity: 0.5}
		            	            }
		            	        },
			
			        	    ]
			        	};
			    
				document.getElementById("Loading").style.display="none";
				setTimeout( function(){
				    K_chart.setOption(option_K);
				    //B_chart.setOption(option_P);
					}, 500 )
	
			}   
		    
			function Draw_SumHchart(DATA){				
	
				var Data_Split = DATA.split("|");
				var xData = eval(Data_Split[0]);
				var sData = eval(Data_Split[1]);
			    var option_H = {
						 tooltip: {},
						
						 title: {
						        text: 'Change Percent Distribution',
						        x:"center",
						        textStyle:{fontSize:40},
						        top:-23,
						        textStyle: {
			            	        fontWeight: 'normal',              //标题颜色
			            	        color: 'white',
			            	        fontSize:30,
		            	        },
						        
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
						        nameTextStyle:{fontWeight:'bold', fontSize:15},
						        axisLabel:{margin:0},
						        data:xData,
	            	            axisLine:{
	            	                lineStyle:{
	            	                    color:'white',
	            	                    width:2,
	            	                }
	            	            },
						    },
						 	yAxis: {
						        name:'Count Numbers',
						        nameLocation:'center',
						        nameTextStyle:{fontWeight:'bold',fontSize:15},
						        nameGap:3,
						        type: 'value',
	            	            axisLine:{
	            	                lineStyle:{
	            	                    color:'white',
	            	                    width:2,
	            	                }
	            	            },
						    },
						    series: [{
						        data: sData,
						        type: 'bar'
						    }]
					
				};
			    H_chart.setOption(option_H);
			}
				
		}
	
	</script>
	
	<!-- listen event -->
	<script type="text/javascript">		
		//resize to draw again		
		$(window).resize(function() {
			K_chart.resize();
			B_chart.resize();
			H_chart.resize();
			});
		
	</script>
	
        <!-- App functions and actions -->
        <script src="js/app.min.js"></script>
                <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
        <script src="vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
        <script src="vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>

        <!-- App functions and actions -->
        <script src="js/app.min.js"></script>
    </body>

</html>