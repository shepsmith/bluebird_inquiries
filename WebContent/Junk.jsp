<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<%
String[] cities = {"Islamabad", "Delhi", "Heathrow"};
pageContext.setAttribute("myCities", cities);
%>

<body>
<c:set var="stuff" value="<%= new java.util.Date() %>" />
Time on the server is ${stuff}

<br><br>
<c:forEach var="tempCity" items="${myCities}">
        ${tempCity}<br/>
</c:forEach>

        <form action="CrunchifyServlet">
            Please enter your Username:  <input type="text" name="username" size="20px"> <br>
            Please enter your Password:  <input type="text" name="password" size="20px"> <br><br>
            size: <select id="size" >
            	<option value="" selected>choose dog size</option>
            	<option value=1>small</option>
            	<option value=1>large</option>
            </select>
        <input type="submit" value="submit">
        </form>
        
</body>
</html>