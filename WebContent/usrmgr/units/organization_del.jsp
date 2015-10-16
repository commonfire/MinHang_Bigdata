<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/>
<title>组织机构删除</title>
</head>

<body>
<%
String menuid=dt.toUTF(request.getParameter("menuid"));
//要进行级联删除,要删除角色中包含的菜单
stmt.executeUpdate("DELETE FROM U_ORGANIZATION WHERE ID='"+menuid+"'");
response.sendRedirect("organization_list.jsp");
%>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>