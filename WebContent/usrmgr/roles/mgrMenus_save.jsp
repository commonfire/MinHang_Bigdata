<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<title>角色权限菜单保存</title>
</head>
<body>
<%
String menustr=request.getParameter("menustr");
String roleid=request.getParameter("roleid");
//首先删除里面所有的 角色 的信息，然后对每个菜单分别插入 RESOURCES 表中
String sql="DELETE FROM U_RESOURCES WHERE ROLEID='"+roleid+"'";
stmt.executeUpdate(sql);
//然后分割菜单字符串
String[] menuarray=dt.toArray(menustr);
for(int i=0;i<menuarray.length;i++){
	sql="INSERT INTO U_RESOURCES (ROLEID,MENUID) VALUES ('"+roleid+"','"+menuarray[i]+"')";
	stmt.executeUpdate(sql);
}
response.sendRedirect("roles_list.jsp");
%>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>