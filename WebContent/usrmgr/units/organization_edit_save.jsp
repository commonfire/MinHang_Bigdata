<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/>
<jsp:useBean id="oper" scope="page" class="edu.soft.DBOper"/>
<%
request.setCharacterEncoding("UTF-8");
String menuid=request.getParameter("id");
String[] str=dt.toArray("mc");
String[] type=dt.toArray("C");
//取出顺序链表
String menustr=dt.toUTF(request.getParameter("menustr"));
String[] menuArray=dt.toArray(menustr,";");
for(int i=0;i<menuArray.length;i++){
	String[] menu=dt.toArray(menuArray[i]);
	stmt.executeUpdate("UPDATE U_ORGANIZATION SET SEQ="+menu[0]+" WHERE MC='"+menu[1]+"' AND PID IN (SELECT PID FROM U_ORGANIZATION WHERE ID='"+menuid+"')");
}
oper.update(conn,request,str,"U_ORGANIZATION",type,"ID",menuid);
response.sendRedirect("organization_list.jsp");
%>
<%@ include file="../../inc/conn_close.jsp"%>