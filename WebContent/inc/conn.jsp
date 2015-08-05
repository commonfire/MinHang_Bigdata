<%@ page language="java" import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
String url="jdbc:mysql://10.108.147.198:3306/weiboanalysis";
//String url="jdbc:mysql://localhost:3306/weiboanalysis";
String dbusername="root";
String dbpassword="root";
Connection conn=null;
Statement stmt=null;
Statement stmt2=null;
try{
	conn= DriverManager.getConnection(url,dbusername,dbpassword);
	stmt=conn.createStatement();
	stmt2=conn.createStatement();
%>