package com.bluebird.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.bluebird.dal.DataStore;
import com.bluebird.model.Info;
import com.bluebird.model.Inquiry;
import com.bluebird.model.Responder;

public class InquirySearch extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final int runOption = 2;  // 1 json, 2 jsp

	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException  {
		HttpSession session = request.getSession(true);
		Info info = new Info();
		info.setStatus("Select");
		info.setEmail("");
		session.setAttribute("info", info);
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/InquirySearch.jsp");
		rd.forward(request, response);
	}
	
	

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(false);
		
		//TODO - get search form fields
		int count = 0;
		DataStore d = new DataStore();
		ArrayList<Inquiry> inquiryList;
		ArrayList<Responder> responderList; // responder containing inquiry or inquiries
		Info info = new Info();
		
		// check if request is for remove
		if (request.getParameter("search") != null) {
			// get values
			String status = request.getParameter("status");
			String email = request.getParameter("email");
			String responderName = request.getParameter("responder_name");
			Inquiry inq = null;
			Responder responder = null;
			if(status != null && status.length()>0 && !(status.equalsIgnoreCase("SELECT"))) {
				inq = new Inquiry();
				inq.setStatus(status);	
			}
			if(email != null && email.length()>0) {
				inq = new Inquiry();
				inq.setEmail(email);
			}			
			if(inq == null) { // not inquiry search, check responder
				if(responderName != null && responderName.length()>0) {
					responder = new Responder();
					responder.setName(responderName);
					info.setResponderName(responderName);
				}
			}
			if(inq!=null) {
				try {
					inquiryList = d.search(inq);
				} catch (Exception e) {
					throw new IOException("database error on inquuiry search");
				}
				session.setAttribute("inquiryList", inquiryList);
			}
			if(responder!=null) {
				try {
					responderList = d.searchResponderInquiries(responder);
				} catch (Exception e) {
					throw new IOException("database error on responder inq search");
				}
				session.setAttribute("responderList", responderList);
				info.setResponderName(responder.getName());
			}
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/InquirySearch.jsp");
			rd.forward(request, response);
		}
			
	}
}

