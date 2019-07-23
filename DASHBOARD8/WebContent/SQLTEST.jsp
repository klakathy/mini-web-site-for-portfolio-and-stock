<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="SQL.*" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	


	
	
	<p id='SQL_Command'>Example Input: select * from prices limit 0,10;</p>


	
	<form name="myForm"  method="post">
		<input type="text" name="inputText" >
		<input type="submit">
	</form>
	
	<% 
		String text = request.getParameter("inputText");
		String Res = GetDATA.SQLDATA(text);
		pageContext.setAttribute("RES",Res);
	%>
	<p>SQL Data:<br></p>
	<p>${RES}</p>

	
	
</body>
</html>
