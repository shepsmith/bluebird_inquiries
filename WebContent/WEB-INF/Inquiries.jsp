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


<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/rangeslider.css">
<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/rangeslider.js"></script>

<title>Insert title here</title>
</head>

<style>
option {
    font-size: 12px;
}
</style>


<!--  <body onload="init()">  -->
<body>


<section class="container section scrollspy" id="inquiries">
<h2>Inquiries</h2>
    <div class="row">
        <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">email</i>
                    <input type="text" id="address" name="address" value="${info.address}">
                    <label for="address">Address</label>
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <i class="material-icons prefix">email</i>
                    <input type="email" id="email" name="email" value="${info.email}">
                    <label for="email">Email</label>
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <input type="button" name="clear" value="Clear" class="btn red" onclick="init()">
             </div>
        </div>
    </div>
    <div class="row">

	<p>NOTE: Infoo object message displayed below - GREEN if deleted successfully and RED if updated successfully
	This is just example of how message color can switch back and forth using JSTL.</p>
	<c:set var="a" scope="session" value="${info.messageType}" ></c:set>
	<c:choose>
	  <c:when test="${info.messageType eq 'error'}">
	        <div class="col s12 l12 red-text" id="messageDiv">
				${info.message}
	        </div>
	  </c:when>
	  <c:otherwise>
	          <div class="col s12 l12 green-text" id="messageDiv">
				${info.message}
	        </div>
	  </c:otherwise>
	 </c:choose>
 
	<table cellpadding="0" cellspacing="0" width="100%" border="0" class="responsive-table">
	
		<c:forEach var="inquiry" items="${inquiryList}">
			<form action="inquiries" method="post" >
				<tr class="hidden">
					<td width="3%"> &nbsp;</td>
					<td width="17%"> &nbsp; </td>
		        	<td width="20%"> &nbsp;</td>
		        	<td width="55%"> &nbsp; </td>
		        	<td width="5%"> &nbsp; </td>
		        </tr>
				<tr>
					<td colspan="2"> ${inquiry.dateAsString} </td>
		        	<td width="20%"> ${inquiry.email} </td>
		        	<td width="55%"> ${inquiry.message} </td>

		        	<td width="5%"> 
			        	<!-- hidden input-->
		       			<input type="text" hidden name="item" value="${inquiry.dateAsString}${inquiry.email}">
		       			<!--added name attribute-->
		       			<input type="submit" name="delete" value="Delete" class="btn indigo"> 
		       		</td>
		        </tr>
		        <tr>
		        	<td class="right-align">Status:
		        	<td colspan="1">

		        	<div class="input-field" >
		        	<select style="display: block;"  name="status" >
		        	      <option class="small-text left" value="New" ${inquiry.status=='New' ? 'selected' : ''}>New</option>
		        	      <option class="small-text left" value="Responded" ${inquiry.status=='Responded' ? 'selected' : ''}>Responded</option>
		        	      <option class="small-text left" value="Closed" ${inquiry.status=='Closed' ? 'selected' : ''}>Closed</option>
                    </select>
                    <!--  <label>Status</label> -->
                    </div>

                    </td>
		        
					<td colspan="1" class="right-align"> Comment:&nbsp; </td>
		        	<td colspan="1"> 
		       			<input type="text" name="comment" value="${inquiry.comment}">
		        	</td>
		        	<td width="5%"> 
		       			<!--added name attribute-->
		       			<input type="submit" name="update" value="Update" class="btn green"> 
		       		</td>
		        </tr>
	        </form>
		</c:forEach>
	
	</table>


<div>
<input type="range" min="0" max="5" data-rangeslider="" data-orientation="vertical" 
		style="position: absolute; width: 1px; height: 1px; overflow: hidden; opacity: 0;">
<div id="js-example-orientation"><h3>Orientation support</h3><br> <input type="range" 
	min="0" max="5" data-rangeslider="" data-orientation="vertical" 
	style="position: absolute; width: 1px; height: 1px; overflow: hidden; opacity: 0;">
<div class="rangeslider rangeslider--vertical" id="js-rangeslider-6"><div class="rangeslider__fill" style="height: 42px;"></div><div class="rangeslider__handle" style="bottom: 22px;"></div></div> 
<output style="display:inline-block; margin-bottom: 0;">1</output></div>
</div>

</section>

<script>
function init() {
	debugger;
  //var text = "";
  //document.getElementById("address").innerHTML = "initial address from javascript";
  document.getElementById("address").value = "";
  document.getElementById("email").value = "";
}
</script>

<script>
    // Initialize a new plugin instance for all
    // e.g. $('input[type="range"]') elements.
    $('input[type="range"]').rangeslider();

    // Destroy all plugin instances created from the
    // e.g. $('input[type="range"]') elements.
    $('input[type="range"]').rangeslider('destroy');

    // Update all rangeslider instances for all
    // e.g. $('input[type="range"]') elements.
    // Usefull if you changed some attributes e.g. `min` or `max` etc.
    $('input[type="range"]').rangeslider('update', true);

	$('input[type="range"]').rangeslider({
	
	    // Feature detection the default is `true`.
	    // Set this to `false` if you want to use
	    // the polyfill also in Browsers which support
	    // the native <input type="range"> element.
	    polyfill: true,
	
	    // Default CSS classes
	    rangeClass: 'rangeslider',
	    disabledClass: 'rangeslider--disabled',
	    horizontalClass: 'rangeslider--horizontal',
	    verticalClass: 'rangeslider--vertical',
	    fillClass: 'rangeslider__fill',
	    handleClass: 'rangeslider__handle',
	
	    // Callback function
	    onInit: function() {},
	
	    // Callback function
	    onSlide: function(position, value) {
	    	
	    },
	
	    // Callback function
	    onSlideEnd: function(position, value) {
	    	
	    }
	});
</script>

</body>
</html>