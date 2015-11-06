<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.util.Properties"%>
<%
Properties pro = new Properties();
String realpath = request.getRealPath("/WEB-INF/classes/");
Class.forName("oracle.jdbc.driver.OracleDriver");
FileInputStream in = null;
try{
	in = new FileInputStream(realpath+"config.properties");
	pro.load(in);
}catch(FileNotFoundException e){
	e.printStackTrace();
}
//读取properties配置文件
String url = pro.getProperty("url");                 //"jdbc:oracle:thin:@10.108.147.143:1521:ORCL";
String dbusername = pro.getProperty("dbusername");   //"bupt";
String dbpassword = pro.getProperty("dbpassword");   // "bupt";
Connection conn=null;
Statement stmt=null;
Statement stmt2=null;
try{
	conn= DriverManager.getConnection(url,dbusername,dbpassword);
	stmt=conn.createStatement();
	stmt2=conn.createStatement();
%>