<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>Inquiries</h2>
	<table cellpadding="0" cellspacing="0" width="100%" border="0">
	
		<c:forEach var="inquiry" items="${inquiryList}">
			<form action="inquiries" method="post" >
				<tr>
					<td width="10%"> ${inquiry.dateAsString} </td>
		        	<td width="20%"> ${inquiry.email} </td>
		        	<td width="50%"> ${inquiry.message} </td>
		        	<td width="5%"> 
			        	<!-- hidden input-->
		       			<input type="text" hidden name="item" value="${inquiry.dateAsString}${inquiry.email}">
		       			<!--added name attribute-->
		       			<input type="submit" name="delete" value="Delete"> 
		       		</td>
		        </tr>
	        </form>
		</c:forEach>
	
	</table>

</body>
</html>