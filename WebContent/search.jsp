<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="ISO-8859-1">
 <!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- Compiled and minified CSS -->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<title>Insert title here</title>
<style>
.container{ 
    max-width: 30%;
    padding: 60px;
    margin: auto;
 }
 
</style>
</head>
<body onload="init()">
<h1 style= text-align:center>Search Dog</h1>
<div class="container">
<font size="5"  face="verdana" color="blue"> Search By Owner </font>
<br><br>
<font size="4" face="Arial" >

<form action="search" method= "post" id="searchForm" > 
	<tr>
	    <td> Owner Name:</td>
	    <td>
	         <input type="text"  name="name" size="40" 	id="name" value=""  >
	    </td> 
	</tr>
	<tr>
	    <td > Email:</td>
	    <td>
	       <input type="email" placeholder=" " size="40" name="email" id="email" >
	    </td>   
	</tr>
	<tr>
	    <td>Phone Number:</td> 
	    <td>
	       <input type="text" placeholder=" " size="40" name="phone" id="phone">
	    </td>  
	 </tr>
	 <td></td>
	 <td align="right">    
	    <input type="submit" name="search" value="Search" class="btn indigo"> 
	 </td>
  </form>

 <br><br>
<font size="5"  face="verdana" color="blue"> Search By Dog </font>
<br><br>

<table widht= "100%" class="responsive-table">
 <form action="search" method= "post" id="searchForm2" > 
     <tr>
	    <td>Dog's Name    : </td>
	    <td>
	         <input type="text" placeholder=" " size="40" name="dog_name" value=" " id="dog_name" >
	    </td> 
	</tr>

	<td></td>
	 <td align="right">    
	    <input type="submit" name="search" value="Search" class="btn indigo"> 
	 </td>
 </form>
<script type="text/javascript">
  init();
</script>

</table>
</div>

<div class="container">
<c:forEach var="owner" items="${ownerList}">
	<form action="registration" method="get" >
				<div id="data">
					<div class="row">
						<div class="col s12 l2">
							<span colspan="2">Owner</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${owner.firstName} ${owner.lastName} &nbsp;&nbsp; <input
								type="submit" name="delete" value="Delete" class="btn indigo">
							<br> <br> <span colspan="2">Dog</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${owner.dog.name}&nbsp;&nbsp; <input type="submit" name="delete"
								value="Delete" class="btn indigo"> <br> <br> <span
								colspan="2">Email</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${owner.email} &nbsp;&nbsp; <input type="submit" name="delete"
								value="Delete" class="btn indigo"> <br> <br> <span>Phone</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${owner.phoneNumber} &nbsp;&nbsp; <input type="submit"
								name="delete" value="Delete" class="btn indigo">
						</div>
					</div>
				</div>
				<br><br>
			 <td></td>
			      <td align="right">    
					    <input type="submit" name="edit details" value="Edit Details" class="btn indigo">&nbsp;&nbsp;&nbsp;
					    <input type="submit" name="schedule visit" value="Schedule Visit" class="btn indigo">&nbsp;&nbsp;&nbsp;
					    <input type="submit" name="delete" value="Delete" class="btn indigo">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    <input type="text" hidden name="ownerId" value="${owner.id}">
					    <input type="text" hidden name="dogId" value="${owner.dog.id}">
					         <!-- 2 hidden inputs for owner id and dog id --> 
				 </td>
		</form>
</c:forEach>
 </div>
<script>
function init() {
	debugger;
  //var text = "";
  //document.getElementById("address").innerHTML = "initial address from javascript";
  document.getElementById("name").value = "";
  document.getElementById("email").value = "";
  document.getElementById("phone").value = "";
  document.getElementById("dog_name").value = "";
  
}
function init2() {
	debugger;
  //var text = "";
  document.getElementById("data").innerHTML = "";
  
}
</script>

</body>
</html>
