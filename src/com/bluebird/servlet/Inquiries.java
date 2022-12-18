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

public class Inquiries extends HttpServlet {

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
		
		// http:\\localhost:8080\inquiries/all
		String requestUrl = request.getRequestURI();
//		String criteria = requestUrl.substring("/inquiries/".length());
		int start = requestUrl.indexOf("/inquiries/");
		int pos = 0;
		String criteria; // will be null, cannot reference yet
		// TODO ... have criteria like ../search?email=aaa@BBB.COM
		if (start > -1) {
			pos = start + "/inquiries/".length();
			criteria = requestUrl.substring(pos);  // start position to end ... look at javadoc
		} else {
			criteria = ""; // should only set String 1 time since it is immutable
		}

		
		DataStore d = new DataStore();

		ArrayList<Inquiry> inquiryList;
		try {
			inquiryList = d.getInquiries(criteria);
		} catch (Exception e) {
			throw new IOException("database error");
		}
		
		

		if( runOption == 1 ) {	
			ServletOutputStream os = response.getOutputStream();
			os.println("Requested Inquiries" + "\n");
			if(inquiryList != null ) {
				for (Inquiry inquiry : inquiryList) {
					String json = "{\n";
					json += "\"email\": " + JSONObject.quote(inquiry.getEmail()) + ",\n";
					json += "\"message\": " + JSONObject.quote(inquiry.getMessage()) + ",\n";
					json += "\"req date\": " + inquiry.getDate() + "\n";
					json += "\"category\": " + JSONObject.quote(inquiry.getCategory()) + ",\n";
					String ml = "";
					if (inquiry.getMailingList()==true) {
						ml = "Yes";
					} else {
						ml = "No";
					}
					json += "\"mailing list\": " + JSONObject.quote(ml) + ",\n";
					json += "}";
					os.println(json);
				}
			}
			else{
				//Inquiries wasn't found, so return an empty JSON object. We could also return an error.
				os.println("{}");
			}
			return;
		} else {
			if(inquiryList != null ) {
				for (Inquiry inquiry : inquiryList) {
					if (inquiry.getMailingList()) {  // boolean is true or false
						inquiry.setMailingListAsString("Yes");
					} else {
						inquiry.setMailingListAsString("No");
					}
					if( inquiry.getDate() != null ) {
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
						inquiry.setDateAsString(sdf.format(inquiry.getDate()));
					}
				}
				// todo - do jsp
//				request.setAttribute("inquiryList", inquiryList);
				HttpSession session = request.getSession(true);
				session.setAttribute("inquiryList", inquiryList);
//				HashMap statuses = new HashMap();
//				statuses.put("NEW", "New");
//				statuses.put("RESPONDED", "Responded");
//				statuses.put("CLOSED", "Closed");
//				request.setAttribute("statuses", statuses);
				Info info = new Info();
				info.setAddress("this is initial address from servlet");
				info.setEmail("this is initial email from servlet");
				info.setMessage("Put successful or validation error occured stuff here");
				session.setAttribute("info", info);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/Inquiries.jsp");
				rd.forward(request, response);
			}
		}
		HttpSession session = request.getSession(true);

	}
	
	

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(false);
		// check if request is for remove
		if (request.getParameter("delete") != null) {
			// get values
			String item = request.getParameter("item");
			// get data from session
//		  ArrayList<Inquiry> inquiryList = (ArrayList<Inquiry>) request.getAttribute("inquiryList");
			ArrayList<Inquiry> inquiryList = (ArrayList<Inquiry>) session.getAttribute("inquiryList");

			Iterator<Inquiry> it = inquiryList.iterator();
			// iterate through
			String unique = "";
			int count = 0; // used to check rows deleted
			while (it.hasNext()) {
				Inquiry inquiry = it.next();
				// check if values matches
				unique = inquiry.getDateAsString() + inquiry.getEmail();
				if (unique.equals(item)) {
					count = removeItem(inquiry);
					it.remove(); // remove
					request.setAttribute("inquiryList", inquiryList);
					break;
				}
			}

			Info info = new Info();
			info.setMessage(""); // default to no message
			if ( count > 0 ) {
				info.setMessage("Inquiry " + unique + " successfully deleted");
				info.setMessageType("info");
			}
			session.removeAttribute("info");
			session.setAttribute("info", info);
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/Inquiries.jsp");
			rd.forward(request, response);
		} else {
			if (request.getParameter("update") != null) {
				// get values
				String item = request.getParameter("item");
				String status = request.getParameter("status");
				String comment = request.getParameter("comment");

				// get data from session
				// ArrayList<Inquiry> inquiryList = (ArrayList<Inquiry>)
				// request.getAttribute("inquiryList");
				ArrayList<Inquiry> inquiryList = (ArrayList<Inquiry>) session.getAttribute("inquiryList");

				Iterator<Inquiry> it = inquiryList.iterator();
				// iterate through
				String unique = "";
				int count = 0; // used to check rows updated
				while (it.hasNext()) {
					Inquiry inquiry = it.next();
					// check if values matches
					unique = inquiry.getDateAsString() + inquiry.getEmail();
					inquiry.setStatus(status);
					inquiry.setComment(comment);
					if (unique.equals(item)) {
						count = updateItem(inquiry);
						// TODO - delete method to delete from database
						break;
					}
				}
				request.setAttribute("inquiryList", inquiryList);
				Info info = new Info();
				info.setMessage(""); // default to no message
				if ( count > 0 ) {
					info.setMessage("Inquiry " + unique + " successfully updated");
					info.setMessageType("error");
				}
				session.removeAttribute("info");
				session.setAttribute("info", info);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/Inquiries.jsp");
				rd.forward(request, response);
			} else {
				doGet(request, response);
			}
		}
	}
	
	private int removeItem(Inquiry inquiry) throws IOException, ServletException {
		DataStore d = new DataStore();
		int i = 0;
		try {
			i = d.deleteInquiry(inquiry);
		} catch (Exception e) {
			throw new IOException("database error");
		}
		
		int j = 0;
		try {
			j = d.insertInquiry(inquiry);
		} catch (Exception e) {
			throw new IOException("database error");
		}
		
		inquiry.setMessage(inquiry.getMessage() + " - reinserted");
		return i; // 1 if deleted, 0 if unsuccessful
	}
	
	private int updateItem(Inquiry inquiry) throws IOException, ServletException {
		DataStore d = new DataStore();
	
		int i = 0;
		try {
			i = d.updateInquiry(inquiry);
		} catch (Exception e) {
			throw new IOException("database error");
		}
		return i; // > 0 if successful
	}
	
}

