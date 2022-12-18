package com.bluebird.services;

import java.util.Map;

import org.json.JSONObject;

public interface IAjaxResponse {
	public void getResponseObj(Map<String,Object> map, JSONObject jsonObj) throws Exception;
}
