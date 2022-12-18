<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="ISO-8859-1">
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

<title>Insert title here</title>
</head>

<style>
option {
    font-size: 12px;
}
</style>

<body>

<section class="container section scrollspy" id="inquiries">
<h2>Inquiry Search</h2>

<form action="inquirySearch" method="post" > 
    <div class="row">
        <div class="col s12 l6">
	        <div class="input-field" >
	        	<select style="display: block;"  name="status" id="status" >
	        	      <option class="small-text left" value="Select" ${info.status=='Select' ? 'selected' : ''}>Select</option>
		     	      <option class="small-text left" value="New" ${info.status=='New' ? 'selected' : ''}>New</option>
	        	      <option class="small-text left" value="Responded" ${info.status=='Responded' ? 'selected' : ''}>Responded</option>
	        	      <option class="small-text left" value="Closed" ${info.status=='Closed' ? 'selected' : ''}>Closed</option>
                   </select>
                   <label>Status*</label>
            </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <i class="material-icons prefix">email</i>
                    <input type="email" id="email" name="email" value="${info.email}">
                    <label for="email*">Email</label>
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <input type="text" id="responder_name" name="responder_name" value="${info.responderName}">
                    <label for="responder_name">Responder Name</label>
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <input type="button" name="clear" value="Clear" class="btn red" onclick="init()">
             </div>
             <div class="input-field">
                    <input type="submit" name="search" value="Search" class="btn green" >
             </div>
        </div>
    </div>
</form> 

<script>
debugger;
    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
</script>

</section>
<section>
<div class="col s12 l3">
	
	<c:forEach var="responder" items="${responderList}">
				<tr class="hidden">
					<td width="3%"> &nbsp;</td>
					<td width="17%"> &nbsp; </td>
		        	<td width="20%"> &nbsp;</td>
		        	<td width="55%"> &nbsp; </td>
		        	<td width="5%"> &nbsp; </td>
		        </tr>
				<tr>
					<td colspan="2">${responder.name}  </td>
		        	<td width="20%"> ${responder.inquiry.email} </td>
		        	<td width="55%"> ${responder.inquiry.message} </td>

		        </tr>

	</c:forEach>
	
	
</div>
</section>

<script>
function init() {
	debugger;
  //var text = "";
  //document.getElementById("address").innerHTML = "initial address from javascript";
  document.getElementById("status").value = "";
  document.getElementById("email").value = "";
  document.getElementById("responder_name").value = "";
}
</script>


</body>
</html>