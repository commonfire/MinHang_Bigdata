<%@page import="edu.bupt.basefunc.RelationJSON"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="edu.bupt.display.ExecuteShell"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ page import="org.json.*"%>
<%@ include file="../inc/conn.jsp"%> 

<%
String alias = request.getParameter("alias");
String currentTimeStampStr = request.getParameter("currentTimeStamp");
String inTime = request.getParameter("inTime");

if(null != alias && null != currentTimeStampStr && null != inTime){
	//解码两次
	alias = URLDecoder.decode(alias,"UTF-8");
	alias = URLDecoder.decode(alias,"UTF-8"); //获取用户昵称
	long currentTimeStamp = Long.valueOf(currentTimeStampStr);
	System.out.println("!!!!"+alias);
	String uid = null;
	out.write(RelationJSON.relationJSON(alias,currentTimeStamp,inTime,conn));
}
else out.write("0");
//out.write("{\""+alias+"\":[{\"赵天奇什么时候能长大\":\"好友\"},{\"航大东北王\":\"好友\"},{\"灰太狼的铁头\":\"好友\"},{\"光与黑洞\":\"好友\"}]}");
%>
<%@ include file="../inc/conn_close.jsp"%>
