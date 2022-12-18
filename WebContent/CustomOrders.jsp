<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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

<title>Bluebirdboxes custom orders</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"
	type="text/javascript"></script>
</head>

<body>
<section class="container section scrollspy" id="inquiries">
<!-- todo add button, and start date 
keep onblur but add getCustomOrders to get orderType & count
then, for each count .. quilts, pictures, carpets, have button in html table to
do 2nd ajax query for each of those details .. getQuiltOrders, getCarpetOrders, etc.

-->
    <input type="submit" name="customOrders" id="customOrders" value="Get Custom Orders" class="btn indigo"  onclick="getCustomOrderCounts()"/> <br>
	

<h3>Custom Orders</h3>

    <div class="row">	
	
	
		<span id=dispcounts></span>
		<div id=dispcountsAsTable></div>
		
		<span id=dispcustomorders></span>
		<div id=dispcustomordersAsTable></div>

	</div>
</section>	
	
<script>
//$(document).ready(function() {
//	debugger;
//        $('#userName').blur(function(event) {
//                var startdate = $('#startDate').val();
//                $.get('CustomOrders', {
//                        startDate : startdate
//                }, function(responseText) {
//                        $('#ajaxGetUserServletResponse').text(responseText);
//                });
//        });
//});
//$(document).ready(function() {
//    $('#customOrders').onclick = function(getCustomOrderCounts);
//    
//    var element = document.getElementById("elem");
//    element.onclick = function(event) {
//      console.log(event);
//    }
    
//});

function getCustomOrderCounts(event){
	// get order counts .. json type : quilts,
    //                          orderCount : count
    debugger;
    $.get('CustomOrders', {}, function(data) {
    	debugger;
    	processCountsData(data);
    },"json");

}

function processCountsData(data) {
	debugger;
	var result1 = data.items[0];  // result1 is product counts
	counts = result1.OrderCounts; // Json Array within Json Array
	count1 = counts[0];
	//$('#dispcounts').text(count1.type + " " + count1.count);
	
	var table = document.createElement('table');
	table.style="responsive-table"
	table.id="counts_table"
	var tr = document.createElement("tr");
	var array = ['Count Type','Count'];
	for (var j = 0; j < array.length; j++) {
		var th = document.createElement('th');
		var text = document.createTextNode(array[j]);
		th.appendChild(text);
		tr.appendChild(th);
	}
	
	table.appendChild(tr);
	
	for (var i = 0; i < counts.length; i++) {
		count1 = counts[i];
		var tr = document.createElement("tr");

		var td1 = document.createElement("td");
		var td2 = document.createElement("td");
		var type = document.createTextNode(count1.type);
		var countVal = document.createTextNode(count1.count);
		tr.id=count1.type+"count";
		//var span1 = document.createElement("span");
		
		//var span1Id = document.createAttribute("id");
		//span1Id.nodeValue = type+"s"; // eg Quilts
		//span1.setAttribute("id", type+"s");

		//span1.appendChild(type);
		//span2.appendChild(countVal);
		//td1.appendChild(span1);
		//td2.appendChild(span2);
		td1.appendChild(type);
		td2.appendChild(countVal)
		tr.appendChild(td1);
		tr.appendChild(td2);
		table.appendChild(tr);
	}
	
	$('#dispcountsAsTable').append(table);

	
	//#dispcounts = counts;
	//custom_quilt_orders = result1.custom_quilt_orders;
	//#customorders = custom_quilt_orders;


}

function getCustomOrders(productType){
	// respond to onclick for each type
	// callback will populate with html table, get appropriate span tag, and insert table to page
	// colors use JSONArray
}
</script>
</body>
</html>