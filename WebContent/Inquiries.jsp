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

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery.datetimepicker.min.css"/ >
<script src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.datetimepicker.full.min.js"></script>



<style>
*{
  margin : 0;
  padding : 0;
}
body {
    height: 100vh;
    background-color: #F0FFFF;
    font-family: 'Roboto',sans-serif;
    /*background: linear-gradient(180deg,#DB302A 0%,#62186B 100%) no-repeat;*/
}
.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.box-minmax{
  margin-top: 30px;
  /*width: 608px;*/
  width: 308px;
  display: flex;
  justify-content: space-between;
  font-size: 20px;
  color: #A52A2A;
  span:first-child{
    margin-left: 10px;
  }
}
.range-slider {
    margin-top: 30vh;
    
}
.rs-range {
    margin-top: 29px;
    width: 1000px;
    -webkit-appearance: none;
    &:focus {
        outline: none;
    }
    &::-webkit-slider-runnable-track {
        width: 100%;
        height: 1px;
        cursor: pointer;
        box-shadow: none;
        background: #ffffff;
        border-radius: 0px;
        border: 0px solid #010101;
    }
    &::-moz-range-track {
        width: 100%;
        height: 1px;
        cursor: pointer;
        box-shadow: none;
        background: #ffffff;
        border-radius: 0px;
        border: 0px solid #010101;
    }
  
    &::-webkit-slider-thumb {
        box-shadow: none;
        border: 0px solid #ffffff;
        box-shadow: 0px 10px 10px rgba(0,0,0,0.25);
        height: 42px;
        width: 22px;
        border-radius: 22px;
        background: rgba(255,255,255,1);
        cursor: pointer;
        -webkit-appearance: none;
        margin-top: -20px;
    }
  &::-moz-range-thumb{
        box-shadow: none;
        border: 0px solid #ffffff;
        box-shadow: 0px 10px 10px rgba(0,0,0,0.25);
        height: 42px;
        width: 22px;
        border-radius: 22px;
        background: rgba(255,255,255,1);
        cursor: pointer;
        -webkit-appearance: none;
        margin-top: -20px;
  }
  &::-moz-focus-outer {
    border: 0;
    }
}
.rs-label {
    
    position: relative;
    transform-origin: center center;
    display: block;
    width: 98px;
    height: 98px;
    background: transparent;
    border-radius: 50%;
    line-height: 30px;
    text-align: center;
    font-weight: bold;
    padding-top: 22px;
    box-sizing: border-box;
    border: 2px solid #BA55D3;
    margin-top: 20px;
    margin-left: -38px;
    left: attr(value);
    color: #BA55D3;
    font-style: normal;
    font-weight: normal;
    line-height: normal;
    font-size: 36px;
    &::after {
        content: "kg";
        display: block;
        font-size: 20px;
        letter-spacing: 0.07em;
        margin-top: -2px;
    }
    
}

</style>

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



	<p>NOTE: Information object message displayed below - GREEN if deleted successfully and RED if updated successfully
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

	<div class="container">
	  
	  <div class="range-slider">
	    <span id="rs-bullet" class="rs-label">0</span>
	    <input id="rs-range-line" class="rs-range" type="range" value="0" min="0" max="200">
	    
	  </div>
	  
	  <div class="box-minmax">
	    <span>0</span><span>200</span>
	  </div>
	  
	</div>
 	<span>select date and time: </span><input id="datetimepicker" type="text" >

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
	var rangeSlider = document.getElementById("rs-range-line");
	var rangeBullet = document.getElementById("rs-bullet");
	
	rangeSlider.addEventListener("input", showSliderValue, false);
	
	function showSliderValue() {
	  rangeBullet.innerHTML = rangeSlider.value;
	  var bulletPosition = (rangeSlider.value /rangeSlider.max);
	  rangeBullet.style.left = (bulletPosition * 578) + "px";
	}
	
	jQuery('#datetimepicker').datetimepicker();
</script>

</body>
</html>