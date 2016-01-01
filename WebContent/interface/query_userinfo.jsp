<%@page import="edu.bupt.basefunc.UserInfoJSON"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="../inc/conn.jsp"%> 
<%
String alias = request.getParameter("alias");
if(null == alias){
	out.write("0");
	return;
}
//解码两次
alias = URLDecoder.decode(alias,"UTF-8");
alias = URLDecoder.decode(alias,"UTF-8"); //获取用户昵称

ResultSet rsUserInfo = null;
String userProperty = SelectOperation.selectUserProperty(alias,"USERALIAS",conn);
if(null == userProperty){
	out.write("0");
}
else{
	if("icon_verify_co_v".equals(userProperty)){ //该账号为公众账号
		out.write("co_verify");
		return;
	}else{
		rsUserInfo = SelectOperation.selectUserinfoByAlias(alias, conn);
		String userInfoJSON = UserInfoJSON.userinfoJSON(alias, rsUserInfo);
		out.write(userInfoJSON);
	}
}
%>
<%@include file="../inc/conn_close.jsp"%>