package com.bluebird.model;

import java.util.ArrayList;
import java.util.Date;

public class CustomQuiltOrder {
	private String size = "";
	private String design = "";
	private ArrayList<String> colors = null;
	private Contact contact = new Contact();
	private int seq = 0;
	private String message = "";
	private Date requestDate = null;
	private String requestDateAsString = "";
	
	// alternate constructor
	public CustomQuiltOrder(String email, String message, Date date) {
		this.contact.setEmail(email);
		this.message = message;
		this.requestDate = date;
	}
	
	
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getDesign() {
		return design;
	}
	public void setDesign(String design) {
		this.design = design;
	}
	public ArrayList<String> getColors() {
		return colors;
	}
	public void setColors(ArrayList<String> colors) {
		this.colors = colors;
	}
	public Contact getContact() {
		return contact;
	}
	public void setContact(Contact contact) {
		this.contact = contact;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}


	public String getRequestDateAsString() {
		return requestDateAsString;
	}


	public void setRequestDateAsString(String requestDateAsString) {
		this.requestDateAsString = requestDateAsString;
	}
	
	
	
}
