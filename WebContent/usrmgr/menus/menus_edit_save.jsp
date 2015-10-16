<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="dboper" class="edu.soft.DBOper" scope="page"/>
<%
//必须在第一个request.getParameter()之前调用该方法才有
request.setCharacterEncoding("UTF-8");
String menuid=request.getParameter("id");
String[] str=dt.toArray("id,menuname,menuurl,isopen");
String[] type=dt.toArray("C,C,C,C");
//取出顺序链表
String menustr=dt.isNull(request.getParameter("menustr"));
String[] menuArray=dt.toArray(menustr,";");
for(int i=0;i<menuArray.length;i++){
	String[] menu=dt.toArray(menuArray[i]);
	stmt.executeUpdate("UPDATE U_MENUS SET MENUORDER="+menu[0]+" WHERE MENUNAME='"+menu[1]+"' AND PID=(SELECT PID FROM U_MENUS WHERE ID='"+menuid+"')");
}
dboper.update(conn,request,str,"U_MENUS",type,"ID",menuid);
response.sendRedirect("menus_list.jsp");
%>
<%@ include file="../../inc/conn_close.jsp"%>