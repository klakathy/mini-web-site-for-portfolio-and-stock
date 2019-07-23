<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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

		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jquery-accordion-menu.js" type="text/javascript"></script>
		<script src="js/jquery.easydropdown.min.js" type="text/javascript"></script>

	<title>Upload</title>

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
#uploads input{
	background-color:rgba(255,255,255,0.8);
}
</style>

</head>
    <body data-sa-theme="1">
    
        <main class="main">
        	<%@ include file="/same.html"%>
        	<section class="content">               
                <div id="chartdiv" class="content__inner">
                	<!-- title div -->
					<div id="titlediv" class="cardpadding" style="width: 100%;text-align:left;padding:0;">
						<h1 style="color:#cb7575;">Sorry, uploading function is still under Construction</h1>
					</div>
									
					<!-- chart1 weight+count -->
					<div id="uploads" class="card cardpadding" style="margin-left: 0px;margin-top:20px;margin-bottom:30px; width: 100%;max-width:1400px;min-width:1100px; height: 100%; min-height: 800px; color:white;text-align:left;">						
						<h2>Update/Add a stock</h2>
						<div>stock excel preview</div>
						<form name="newstock">							
							<input type="file" name="stockexcel" onchange="stockexcel()"/>
							<div>sample stock upload</div>
							
							name: <input type="text" name="stockname"/><br/>
							description: <input type="text" name="stockdescription"/><br/>
							sector: <select name="stocksecor">
								<option value="1" selected>Consumer Discretionary</option>
								<option value="2" selected>Consumer Staples</option>
								<option value="3" selected>Energy</option>
								<option value="4" selected>Financials</option>
								<option value="5" selected>Health Care</option>
								<option value="6" selected>Industrials</option>
								<option value="7" selected>Information Technology</option>
								<option value="8" selected>Materials</option>
								<option value="9" selected>Real Estate</option>
								<option value="10" selected>Communication Services</option>
								<option value="11" selected>Utilities</option>
								<option value="99" selected>Other</option>							
							</select><br/>
							type: <select name="stocktype">
								<option value="stock" selected>stock</option>
								<option value="portfolio" selected>portfolio</option>
								<option value="bond" selected>bond</option>
								<option value="other" selected>other</option>
							</select><br/>
							<input type="button" value="POST" onclick="stocknew()" />
						</form>
						
						<h2>Update/Add weight information for a portfolio</h2>
						<div>weight excel preview</div>
						<form name="newweight">
							<input type="file" name="weightexcel" onchange="weightexcel()"/>
							<div>sample weight excel</div> 
							name of portfolio: <input type="text" name="weightname"/><br/>
							number of components: <input type="text" name="weightn"/><br/>
							<table>
								<tr><th>Name of component</th><th>weight (%)</th></tr>
								<tr><td><input type="text" name="wn1"/></td><td><input type="text" name="ww1"/></td></tr>
								<tr><td><input type="text" name="wn2"/></td><td><input type="text" name="ww2"/></td></tr>
								<tr><td><input type="text" name="wn3"/></td><td><input type="text" name="ww3"/></td></tr>
								<tr><td><input type="text" name="wn4"/></td><td><input type="text" name="ww4"/></td></tr>
							</table>	
							<input type="button" value="POST" onclick="weightnew()" />
						</form>
						
						<h2>Update/Add weight weight for a stock</h2>
						<div>price excel preview</div>
						<form name="newprice">
							<input type="file" name="priceexcel" onchange="priceexcel()"/>
							<div>sample price excel</div> 
							name of stock: <input type="text" name="pricename"/><br/>
							<table>
								<tr><th>date</th><th>close price</th><th>open price</th><th>highest price</th><th>lowest price</th></tr>
								<tr><td><input type="text" name="pd1"/></td><td><input type="text" name="pc1"/></td>
							    	<td><input type="text" name="po1"/></td><td><input type="text" name="ph1"/></td><td><input type="text" name="pl1"/></td></tr>
								<tr><td><input type="text" name="pd2"/></td><td><input type="text" name="pc2"/></td>
							    	<td><input type="text" name="po2"/></td><td><input type="text" name="ph2"/></td><td><input type="text" name="pl2"/></td></tr>
								<tr><td><input type="text" name="pd3"/></td><td><input type="text" name="pc3"/></td>
							    	<td><input type="text" name="po3"/></td><td><input type="text" name="ph3"/></td><td><input type="text" name="pl3"/></td></tr>
								<tr><td><input type="text" name="pd4"/></td><td><input type="text" name="pc4"/></td>
							    	<td><input type="text" name="po4"/></td><td><input type="text" name="ph4"/></td><td><input type="text" name="pl4"/></td></tr>
							</table>	
							<input type="button" value="POST" onclick="weightnew()" />
						</form>
					</div>
					
                </div>
            </section>
        </main>
        
	
	<!-- listen event -->
	<script type="text/javascript">		

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