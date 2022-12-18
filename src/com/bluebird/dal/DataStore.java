package com.bluebird.dal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import com.bluebird.model.CustomQuiltOrder;
import com.bluebird.model.Inquiry;
import com.bluebird.model.Order;
import com.bluebird.model.Responder;
import com.bluebird.util.Constants;

public class DataStore {
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;

	private String host = "localhost";
	private String user = "shep";
	private String passwd = "1234";
	private String database = "bluebirdboxes";

	public ArrayList<Order> getQuiltRequests(Date date) {
		return new ArrayList<Order>();
	}
	
	//$conn = mysqli_connect('localhost','shep','1234','bluebirdboxes');
	public ArrayList<Inquiry> getInquiries(String criteria) throws Exception {
		ArrayList<Inquiry> inquiryList = new ArrayList<>();
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");

			// Setup the connection with the DB
			connect = DriverManager.getConnection(
					"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

			// Statements allow to issue SQL queries to the database
			statement = connect.createStatement();
			// Result set get the result of the SQL query
			resultSet = statement.executeQuery("select * from inquiry");

			// ResultSet is initially before the first data set
			while (resultSet.next()) {
				// It is possible to get the columns via name
				// also possible to get the columns via the column number
				// which starts at 1
				// e.g. resultSet.getString(2);
				String email = resultSet.getString("email");
				String message = resultSet.getString("message");
				Date date = resultSet.getDate("date");
				String category = resultSet.getString("category");
				int i = resultSet.getInt("mailinglist");
				Boolean mailingList;
				if (i == 0) {
					mailingList = false;
				} else {
					mailingList = true;
				}
				String status = resultSet.getString("status");
				String comment = resultSet.getString("comment");
				
				Inquiry inquiry = new Inquiry(email, message, date);
				inquiry.setCategory(category);
				inquiry.setMailingList(mailingList);
				inquiry.setStatus(status);
				inquiry.setComment(comment);
				inquiryList.add(inquiry);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			connect.close();
		}

		return inquiryList;
	}
	
	public ArrayList<CustomQuiltOrder> getCustomQuiltOrders() throws Exception {
		ArrayList<CustomQuiltOrder> quilts = new ArrayList<>();
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");

			// Setup the connection with the DB
			connect = DriverManager.getConnection(
					"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

			// Statements allow to issue SQL queries to the database
			statement = connect.createStatement();
			// Result set get the result of the SQL query
			resultSet = statement.executeQuery("select * from quilt");

			// ResultSet is initially before the first data set
			while (resultSet.next()) {
				// It is possible to get the columns via name
				// also possible to get the columns via the column number
				// which starts at 1
				// e.g. resultSet.getString(2);
				String email = resultSet.getString("email");
				String message = resultSet.getString("message");
				Date date = resultSet.getDate("request_date");
				String design = resultSet.getString("design");

				String size = resultSet.getString("size");

				
				CustomQuiltOrder customQuiltOrder = new CustomQuiltOrder(email, message, date);
				SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
				customQuiltOrder.setRequestDateAsString(sdf.format(customQuiltOrder.getRequestDate()));
//				customQuiltOrder.setMessage(message);
				customQuiltOrder.setDesign(design);
//				customQuiltOrder.setRequestDate(date);
				customQuiltOrder.setSize(size);
				
				quilts.add(customQuiltOrder);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			connect.close();
		}

		return quilts;
//		return null;
	}
	
	// todo - carpets, etc

		public int deleteInquiry(Inquiry inquiry) throws Exception {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");

			// Setup the connection with the DB
			connect = DriverManager.getConnection(
					"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

			// Statements allow to issue SQL queries to the database
			statement = connect.createStatement();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = sdf.format(inquiry.getDate());
			// Result set get the result of the SQL query
			int count  = statement.executeUpdate("delete from " 
					+ Constants.database 
					+ "." 
					+ Constants.inquiry 
					+ " where email = '"
					+ inquiry.getEmail() 
					+ "' and date = '"
					+ strDate
					+ "'");
			return count;
		}
		
		public int insertInquiry(Inquiry inquiry) throws Exception {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");

			// Setup the connection with the DB
			connect = DriverManager.getConnection(
					"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

			// Statements allow to issue SQL queries to the database
			statement = connect.createStatement();
			// Result set get the result of the SQL query
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = sdf.format(inquiry.getDate());
			
			StringBuffer sb = new StringBuffer();
			sb.append("insert into bluebirdboxes.inquiry ");
			sb.append(" ( `email`, `message`, `date`, `category`, `mailinglist`) ");
			sb.append(" values ( '" );
			sb.append( inquiry.getEmail() );
			sb.append( "', '" );
			sb.append( inquiry.getMessage() );
			sb.append( "', '" );
			sb.append( strDate );
			sb.append( "', '" );
			sb.append( inquiry.getCategory() );
			sb.append( "', " );
			if(inquiry.getMailingList()) {
				sb.append( 1 );
			} else {
				sb.append( 0 );
			}
			sb.append( " )" );
			String strSql = sb.toString();
			
			int count = statement.executeUpdate( strSql);

			return count;
		}
		
		public int updateInquiry(Inquiry inquiry) throws Exception {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");

			// Setup the connection with the DB
			connect = DriverManager.getConnection(
					"jdbc:mysql://" + host + "/" + database + "?" + "user=" + user + "&password=" + passwd);

			// Statements allow to issue SQL queries to the database
			statement = connect.createStatement();
			// Result set get the result of the SQL query
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = sdf.format(inquiry.getDate());
			
			StringBuffer sb = new StringBuffer();
			sb.append("update bluebirdboxes.inquiry ");
			sb.append(" set `status` = '");
			sb.append( inquiry.getStatus());
			sb.append("', `comment` = '");
			sb.append( inquiry.getComment());
			sb.append( "' where email = '");
			sb.append( inquiry.getEmail()); 
			sb.append( "' and date =  '");
			sb.append( inquiry.getDate());
			sb.append( "'");

			String strSql = sb.toString();
			
			int count = statement.executeUpdate( strSql);

			return count;
		}
		
		public ArrayList<Inquiry> search(Inquiry inquiry) throws Exception {
			ArrayList<Inquiry> inquiryList = new ArrayList<>();
			try {
				// This will load the MySQL driver, each DB has its own driver
				Class.forName("com.mysql.jdbc.Driver");

				// Setup the connection with the DB
				connect = DriverManager.getConnection(
						"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

				// Statements allow to issue SQL queries to the database
				statement = connect.createStatement();
				// Result set get the result of the SQL query
				resultSet = statement.executeQuery("select * from inquiry");
				// todo add where status and email preds
				// ResultSet is initially before the first data set
				while (resultSet.next()) {
					// It is possible to get the columns via name
					// also possible to get the columns via the column number
					// which starts at 1
					// e.g. resultSet.getString(2);
					String email = resultSet.getString("email");
					String message = resultSet.getString("message");
					Date date = resultSet.getDate("date");
					String category = resultSet.getString("category");
					int i = resultSet.getInt("mailinglist");
					Boolean mailingList;
					if (i == 0) {
						mailingList = false;
					} else {
						mailingList = true;
					}
					String status = resultSet.getString("status");
					String comment = resultSet.getString("comment");
					
					Inquiry inquiry2 = new Inquiry(email, message, date);
					inquiry2.setCategory(category);
					inquiry2.setMailingList(mailingList);
					inquiry2.setStatus(status);
					inquiry2.setComment(comment);
					inquiryList.add(inquiry2);
				}
			} catch (Exception e) {
				throw e;
			} finally {
				connect.close();
			}

			return inquiryList;
		}

		public ArrayList<Responder> searchResponderInquiries(Responder resp) throws Exception {
			ArrayList<Responder> responderList = new ArrayList<>();
			try {
				// This will load the MySQL driver, each DB has its own driver
				Class.forName("com.mysql.jdbc.Driver");

				// Setup the connection with the DB
				connect = DriverManager.getConnection(
						"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

				// Statements allow to issue SQL queries to the database
				statement = connect.createStatement();
				StringBuffer sb = new StringBuffer();
				sb.append("SELECT r.name, r.title, i.email, i.date, i.message ");
				sb.append(" FROM responder r ");
				sb.append(" inner join responder_inquiry ri on ri.responder_id = r.id ");
				sb.append(" inner join inquiry i on i.id = ri.inquiry_id ");
				sb.append(" where r.name = '");
				sb.append(resp.getName());
				sb.append("';");
				String strSql = sb.toString();
				// Result set get the result of the SQL query
				resultSet = statement.executeQuery( strSql );

				// ResultSet is initially before the first data set
				while (resultSet.next()) {
					// It is possible to get the columns via name
					// also possible to get the columns via the column number
					// which starts at 1
					// e.g. resultSet.getString(2);
					String name = resultSet.getString("name");
					String title = resultSet.getString("title");
					String email = resultSet.getString("email");
					Date date = resultSet.getDate("date");
					String message = resultSet.getString("message");

					Responder responder = new Responder();
					Inquiry inquiry = new Inquiry();
					responder.setName(name);
					responder.setTitle(title);
					inquiry.setEmail(email);
					inquiry.setMessage(message);
					inquiry.setDate(date);
					if(date!=null) {
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
						inquiry.setDateAsString(sdf.format(inquiry.getDate()));
					}
					responder.setInquiry(inquiry);
					responderList.add(responder);
				}
			} catch (Exception e) {
				throw e;
			} finally {
				connect.close();
			}
			return responderList;
		}
		
		public ArrayList<Order> getCustomOrderCounts(String types[]) throws Exception {
			ArrayList<Order> orders = new ArrayList<Order>();
			try {
				// This will load the MySQL driver, each DB has its own driver
				Class.forName("com.mysql.jdbc.Driver");

				// Setup the connection with the DB
				connect = DriverManager.getConnection(
						"jdbc:mysql://" + Constants.host + "/" + Constants.database + "?" + "user=" + Constants.user + "&password=" + Constants.passwd);

				// Statements allow to issue SQL queries to the database
				statement = connect.createStatement();
				// Result set get the result of the SQL query
				for (String type : types) {
					Order order = new Order(type);
					String strSql = "select count(*) from " + type + ";";
					ResultSet rs = statement.executeQuery(strSql);
					if(rs.next()) {
						order.setCount( rs.getInt(1) );
						orders.add(order);
					}
				}

			} catch (Exception e) {
				throw e;
			} finally {
				connect.close();
			}
			return orders;
			
		}

}

