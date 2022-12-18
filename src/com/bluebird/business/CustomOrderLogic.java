package com.bluebird.business;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;

import com.bluebird.dal.DataStore;
import com.bluebird.model.CustomQuiltOrder;
import com.bluebird.model.Order;

public class CustomOrderLogic {
	
	public void formatOrderCounts (HashMap<String,Object> data, String[] types) throws IOException {
		DataStore dataStore = new DataStore();

		ArrayList<Order> orders = null;
		try {
			orders = dataStore.getCustomOrderCounts(types);
		} catch (Exception e) {
			throw new IOException("database error getting counts");
		}
		data.put("counts", orders);
	}
	
	public void formatCustomOrders( HashMap<String,Object> data, String[] types) throws IOException  {
		DataStore dataStore = new DataStore();
		formatQuiltOrders (data, dataStore);
//		formatCarpetOrders (data, dataStore); //etc
	}
	
	private void formatQuiltOrders (HashMap<String,Object> data, DataStore dataStore) throws IOException  {
		// get items from quilt table, include array of colors, size, type, etc
		ArrayList<CustomQuiltOrder> quiltOrders = null;
		try {
			quiltOrders = dataStore.getCustomQuiltOrders();
		} catch (Exception e) {
			throw new IOException("database error getting custom quilt orders");
		}
		
		data.put("custom_quilt_orders", quiltOrders);
		
	}
	
	//todo - carpets, unique art
}
