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
    max-width: 40%;
    padding: 34px;
    margin: 23px;
    margin: auto;
     }
     
    .myDiv {   
       text-align: left;
       }
    p{
      font-size: 20px; 
      text-align: right align;
    }  
    
    h5{
    color:blue;
    } 
    
</style>
</head>
<body>
<h3 style ="text-align:center;"> Register Dog </h3>
<br>
<h5 style ="text-align:center;">To register a new dog, complete the following form with all required fields</h5>
<div class="row">

	
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
<div class="container">
<form action="registration" method="post">
<div >

  <div class="row">
  <c:set var="a" scope="session" value=" " ></c:set>
        <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">person</i>
                    <input type="text" id="firstname" name="first_name" placeholder="First Name" value ="${owner.firstName}"/>
             </div>
        </div>
        <div class="col s12 l6">
            <div class="input-field">
                <input type="text" id="lastname" name="last_name" placeholder="Last Name" value="${owner.lastName}"/>
             </div>
        </div>
    </div>
  <div class="row">
    <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">phone</i>
                    <input type="text" id="phone" name="phone" value="${owner.phoneNumber}"/>
                    <label for="phone">Phone</label>
             </div>
        </div>
    <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">email</i>
                    <input type="email" id="email" name="email" value="${owner.email}"/>                     
                    <label for="email">Email</label>
             </div>
        </div>
     </div>
  <div class="row">

    <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">add_location</i>
                    <input type="text" id="street" name="street" value="${owner.address.street}"/>
                    <label for="street">Street</label>
             </div>
        </div>
        <div class="col s12 l6">
             <div class="input-field">
                    <input type="text" id="secondary_address" name="secondary_address">
                    <label for="secondary_address">Secondary Address</label>
             </div>
        </div>
        <div class="col s12 l6">
           <div class="input-field">
            <i class="material-icons prefix">city</i>
                    <input type="text" id="city" name="city" value="${owner.address.city}"/>
                    <label for="city">City</label>
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
             <select id="state" name="state" ${owner.address.state}>
               <option value="" selected>State</option>
               <option value="PA">PA</option>
               <option value="MD">MD</option>
               <option value="VA">VA</option>
               <option value="NY">NY</option>
               <option value="WV">WV</option>
              </select>
               
             </div>
        </div>
        <div class="col s12 l3">
             <div class="input-field">
                    <input type="text" id="zipcode" name="zipcode" value="${owner.address.zipCode}"/>
                    <label for="zipcode">ZipCode</label>
             </div>
        </div>
     </div>
    <div class="row">
     <div class="col s12 l6">
             <div class="input-field">
                    <i class="material-icons prefix">pets</i>
                    <input type="text" id="dogname" name="dog_name" value="${owner.dog.name}"/>
                    <label for="dogname">Dog's Name</label>
             </div>
        </div>
    <div class="col s12 l6">
             <div class="input-field">
                    <input type="text" id="breed" name="breed" value="${owner.dog.breed}"/>
                    <label for="breed">Breed</label>
             </div>
        </div>
     </div>

   <div>
     <p> Can Dog be off leash?
       <span><label>&nbsp;&nbsp;
              <input type="checkbox" name="leash_yes">${dog.leash_yes}</>
              <span class="right-align"> &nbsp </span>
              </label>
         </span></P>
     </div>
     <div>
     <p> Is Dog allow to go in Water?
       <span><label>&nbsp;&nbsp;
              <input type="checkbox" name="water_yes" >${dog.water_yes}</>
              <span class="right-align">&nbsp </span>
              </label>
         </span></P>
     </div>    
     <div>
     <p>Needs a walk to business?
       <span><label>&nbsp;&nbsp;
              <input type="checkbox" name="walk_yes" >${dog.walk_yes}</>
              <span class="right-align">&nbsp</span>
              </label>
         </span></P>
     </div>   
     <div>
     <p> Can Dog have Treats?
       <span><label>&nbsp;&nbsp;
              <input type="checkbox" name="treats_yes" >${dog.treats_yes}</>
              <span class="right-align">&nbsp</span>
              </label>

         </span></P>
       
         <p> How many times per Day?
           <input type="number" id="times" name="times" max="6">${dog.per_day}</>
         </P>
      
    
    <div class="row" >
	<div class="col l4 s12 left-align">
  		<p>Food Type:</p>
  	</div>
  	<div class="col l6 s12">
    	<div class="input-field" >
     		<select name="foodType" >
     	      <option class="small-text left" value="" ${foodType=='' ? 'selected' : ''}>-- Choose --</option>
	   	      <option class="small-text left" value="Dry" ${foodType=='Dry' ? 'selected' : ''}>Dry Food</option>
     	      <option class="small-text left" value="Canned" ${foodType=='Canned' ? 'selected' : ''}>Canned Food</option>
     	      <option class="small-text left" value="Other" ${foodType=='Other' ? 'selected' : ''}>Other</option>
             </select>
              <!--  <label>Food Type</label> -->

         </div>   
    </div>  
  
     <div class="col l4 s12 right-align">
  		<p class="left-align">Feeding Amount:</p>
  	</div>
  	<div class="col l6 s12">
    	<div class="input-field" >
     		<select name="feedingAmount" >
     	      <option class="small-text left" value="" ${feedingAmount=='' ? 'selected' : ''}>-- Choose --</option>
	   	      <option class="small-text left" value="Quarter" ${feedingAmount=='Quarter' ? 'selected' : ''}>Quarter</option>
     	      <option class="small-text left" value="Half" ${feedingAmount=='Half' ? 'selected' : ''}>Half</option>
     	      <option class="small-text left" value="Three Quater" ${feedingAmount=='Three Quarter' ? 'selected' : ''}>Three Quarter</option>
     	      <option class="small-text left" value="A Cup" ${feedingAmount=='A Cup' ? 'selected' : ''}>A Cup</option>
              <option class="small-text left" value="Two Cup" ${feedingAmount=='Two Cup' ? 'selected' : ''}>Two Cup</option>
             </select>
              <!--  <label>Food Type</label> -->

         </div>   
     </div> 
     
     <div class="col l4 s12 right-align">
  		<p class="left-align">Sleeping Preference:</p>
  	</div>
  	<div class="col l6 s12">
    	<div class="input-field" >
     		<select name="sleeping prefernce" >
     	      <option class="small-text left" value="" ${sleepingPrefernce=='' ? 'selected' : ''}>-- Choose --</option>
	   	      <option class="small-text left" value="On floor" ${sleepingPrefernce=='On floor' ? 'selected' : ''}>On floor</option>
     	      <option class="small-text left" value="Couches" ${sleepingPrefernce=='Couches' ? 'selected' : ''}>Couches</option>
     	      <option class="small-text left" value="Crate" ${sleepingPrefernce=='Crate' ? 'selected' : ''}>Crate</option>
     	      <option class="small-text left" value="Bed" ${sleepinPprefernce=='Bed' ? 'selected' : ''}>Bed</option>
             </select>
              <!--  <label>Food Type</label> -->

         </div>   
     </div>  
      <div class="input-field col s12">
          <textarea id="textarea1" class="materialize-textarea"></textarea>
          <label for="textarea1"> More feeding notes</label>
        </div>
         <div class="input-field col s12">
          <textarea id="textarea1" class="materialize-textarea"></textarea>
          <label for="textarea1"> Medicine notes</label>
        </div>
     
    </div>
  
     
     
    <div  class="input-field right">
       <input type="submit" name="submit" value="Submit " class="btn indigo"/> 
    </div>
 </form>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
  <script>
 document.addEventListener('DOMContentLoaded', function() {
	    var elems = document.querySelectorAll('select');
	    var instances = M.FormSelect.init(elems, options);
	  });

	  // Or with jQuery

	  $(document).ready(function(){
	    $('select').formSelect();
	  });
	  
	  var instance = M.FormSelect.getInstance(elem);
	  
	  instance.getSelectedValues();
	  instance.destroy();
      
 </script>
</body> 
</html>