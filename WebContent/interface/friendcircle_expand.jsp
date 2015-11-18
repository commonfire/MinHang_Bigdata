<%@page import="edu.bupt.basefunc.DataToJSON"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.bupt.display.ExecuteShell"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ include file="../inc/conn.jsp"%> 
<%
String userID = request.getParameter("uid");
ResultSet rsRelation = null;  //用户关系查询数据结果集
ResultSet rsUserName = null;  //用户昵称查询数据结果集
if(null == userID){
	out.write("0");
	return;
}
if(!SelectOperation.containsField("userID", userID, "t_user_weibocontent_atuser", conn)){
	ExecuteShell.executeShell(userID,"weibocontent_userinfo");	//右键动态扩展，爬取用户关系
	while(true){
			int searchstate = SelectOperation.selectEndState("contentstate",conn);
			if(searchstate==1) break;	
	}
	UpdateOperation.updateEndState("contentstate");
}
try{
	rsRelation = SelectOperation.selectAtuser(userID,"5",conn);  
	rsUserName = SelectOperation.selectAlias(userID, conn);
	out.write(DataToJSON.friendExpandJSON(rsUserName, rsRelation)); 
	rsRelation.close();
	rsUserName.close();
}catch(Exception e){
	e.printStackTrace();	
}




/* out.write("{\"nodes\":[{\"category\":\"2\",\"name\":\"Bill\",\"value\":\"3\"},{\"category\":\"2\",\"name\":\"Lucy\",\"value\":\"3\"}],"
	+"\"links\":[{\"source\":\"李写意\",\"target\":\"Bill\",\"weight\":\"3\"},{\"source\":\"李写意\",\"target\":\"Lucy\",\"weight\":\"3\"}]}");
 */
%>
<%@ include file="../inc/conn_close.jsp"%>
