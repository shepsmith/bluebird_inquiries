package com.bluebird.services.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import com.bluebird.model.Contact;
import com.bluebird.model.CustomQuiltOrder;
import com.bluebird.model.Order;
import com.bluebird.services.IAjaxResponse;



public class JsonCustomOrdersResponse implements IAjaxResponse {

	public void getResponseObj(Map<String,Object> map, JSONObject jsonObj) throws Exception {
		// Note - try not specifying ID and Obj json objects in document
		// start with items array
				
		JSONArray itemsArray = jsonObj.getJSONArray("items");
		HashMap m = (HashMap)map;
		
		if (m.get("counts")!=null) {
			doCounts((ArrayList<Order>)map.get("counts"), itemsArray);
		}
		// check each custom order type here and format
		if(m.get("custom_quilt_orders")!=null) {
			doQuiltOrders((ArrayList<CustomQuiltOrder>)map.get("custom_quilt_orders"), itemsArray);
		}
	}	
	
	private void doCounts(ArrayList<Order> counts, JSONArray itemsArray)  throws Exception {
		JSONArray ordersArray = new JSONArray();
		JSONObject jsonObj = null;
		JSONObject countsObj = new JSONObject(); // needs wrapper to avoid json stack overflow issue
		for (int i=0;i<counts.size();i++) {
			Order order = (Order)counts.get(i);
			jsonObj = new JSONObject();
			jsonObj.put("type", order.getType());
			jsonObj.put("count", order.getCount());
			ordersArray.put(jsonObj);
		}
		
		countsObj.put("OrderCounts", ordersArray);
		itemsArray.put(countsObj);
	}
	private void doQuiltOrders(ArrayList<CustomQuiltOrder> quiltOrders, JSONArray itemsArray)  throws Exception {
		JSONArray quiltOrdersArray = new JSONArray();

		for (int i=0;i<quiltOrders.size();i++) {
			CustomQuiltOrder quiltOrder = (CustomQuiltOrder)quiltOrders.get(i);
			JSONObject jsonObj2 = new JSONObject();
			jsonObj2.put("design", quiltOrder.getDesign());
			jsonObj2.put("size", quiltOrder.getSize());
			Contact contact = quiltOrder.getContact();
			JSONObject jsonObj3 = new JSONObject();
			jsonObj3.put("email", contact.getEmail()); // only email for now. add phone, name, etc.
			jsonObj2.put("Contact", jsonObj3);
			jsonObj2.put("message", quiltOrder.getMessage());
			jsonObj2.put("requestDate", quiltOrder.getRequestDateAsString());
			jsonObj2.put("seq", quiltOrder.getSeq());
			JSONArray colorsArray = new JSONArray();
			ArrayList<String> colors = new ArrayList<>();
			for (String color : colors ) {
				colorsArray.put(color); // see how this works!!
			}
			jsonObj2.put("Colors", colorsArray);
			quiltOrdersArray.put(jsonObj2);
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("CustomQuiltOrders", quiltOrdersArray);
		itemsArray.put(jsonObj);
	}
}
