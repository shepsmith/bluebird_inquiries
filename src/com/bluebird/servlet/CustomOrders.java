package com.bluebird.servlet;
import java.io.IOException;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.bluebird.business.CustomOrderLogic;
import com.bluebird.services.impl.JsonCustomOrdersResponse;
import com.bluebird.services.IAjaxResponse;

@WebServlet("/CustomOrders")
public class CustomOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		JSONArray itemsArray = new JSONArray();	 // cumulative... 	
		JSONObject jsonObj = new JSONObject();  // 
		jsonObj.put("items", itemsArray); // items + error
		HashMap<String,Object> data = new HashMap<String,Object>(); 
		String[] types = {"Quilt","Carpet"}; // todo.. add these ,"Carpet","BirdHouse","CustomPic"};
		CustomOrderLogic customOrderLogic = new CustomOrderLogic();
		customOrderLogic.formatOrderCounts(data, types); // add ArrayList of counts - Count key, ArrayList is value
		
		customOrderLogic.formatCustomOrders(data, types);
		
		IAjaxResponse iAjaxResponse = new JsonCustomOrdersResponse();
		try {
			iAjaxResponse.getResponseObj(data, jsonObj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String responseStr = jsonObj.toString(); 
		response.setContentType("application/json");
		response.setContentType("text/xml;charset=UTF-8");
		try {
			Writer writer=response.getWriter();
			writer.write(responseStr);
			writer.flush();
		    writer.close();
		} catch (java.io.IOException ioe) {
		    ioe.printStackTrace();
		}
		  catch (java.lang.Exception e) {
		    e.printStackTrace();
		}

		
		// get parameter for button pressed ... getCustomOrders .. counts, getCarpets, etc
		
		
		
//		if(action.equalsIgnoreCase("timecard") || action.equalsIgnoreCase("all")) {	
//			//session.setAttribute("period", period);
//			timeCardLogic.formatTimeCard(sso, period, session, data); // add response pojo 
//		}

		
		
//		String userName = request.getParameter("userName");
//		if(userName == null || "".equals(userName)){
//			userName = "Guest";
//		}
//		
//		String greetings = "Hello " + userName;
//		
//		response.setContentType("text/plain");
//		response.getWriter().write(greetings);
	}

}

