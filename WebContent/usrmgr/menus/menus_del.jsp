<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<title>删除菜单</title>
</head>
<body>
<%
String menuid=request.getParameter("menuid");
//要进行级联删除,要删除角色中包含的菜单
stmt.executeUpdate("DELETE FROM U_RESOURCES WHERE MENUID='"+menuid+"'");
stmt.executeUpdate("DELETE FROM U_MENUS WHERE PID='"+menuid+"'");
stmt.executeUpdate("DELETE FROM U_MENUS WHERE ID='"+menuid+"'");
response.sendRedirect("menus_list.jsp");
%>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>