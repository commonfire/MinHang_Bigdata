<%@ page language="java" import="java.sql.*"%>
<%
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
String url="jdbc:oracle:thin:@10.108.144.99:1521/orcl";
String dbusername="ZTQ";
String dbpassword="fnl12345678";
Connection conn=null;
Statement stmt=null;
Statement stmt2=null;
try{
	conn= DriverManager.getConnection(url,dbusername,dbpassword);
	stmt=conn.createStatement();
	stmt2=conn.createStatement();
%>