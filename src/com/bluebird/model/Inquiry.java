package com.bluebird.model;

import java.util.Date;

public class Inquiry {
	private String email = "";
	private String message = "";
	private Date date = new Date();
	private String dateAsString = "";
	private String category = "";
	private Boolean mailingList = false;
	private String mailingListAsString = "";
	private String status = "";
	private String comment = "";
	
	// alternate constructor
	public Inquiry(String email, String message, Date date) {
		this.email = email;
		this.message = message;
		this.date = date;
	}
	
	
	public Inquiry() {
		// TODO Auto-generated constructor stub
	}


	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Boolean getMailingList() {
		return mailingList;
	}
	public void setMailingList(Boolean mailingList) {
		this.mailingList = mailingList;
	}
	
	public String getDateAsString() {
		return dateAsString;
	}


	public void setDateAsString(String dateAsString) {
		this.dateAsString = dateAsString;
	}


	public String getMailingListAsString() {
		return mailingListAsString;
	}


	public void setMailingListAsString(String mailingListAsString) {
		this.mailingListAsString = mailingListAsString;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}


	@Override
	public String toString() {
		return "Inquiry [email=" + email + ", message=" + message + ", date=" + date + ", dateAsString=" + dateAsString
				+ ", category=" + category + ", mailingList=" + mailingList + ", mailingListAsString="
				+ mailingListAsString + ", status=" + status + ", comment=" + comment + "]";
	}
	
}
