<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<title>分配角色保存页面</title>
</head>

<body>
<%
String rolestr=request.getParameter("rolestr");
String userid=request.getParameter("userid");
String sql="DELETE FROM U_AUTHS WHERE USERID='"+userid+"'";
stmt.executeUpdate(sql);
//然后分割菜单字符串
String[] rolearray=dt.toArray(rolestr);
for(int i=0;i<rolearray.length;i++){
	sql="INSERT INTO U_AUTHS (USERID,ROLEID) VALUES ('"+userid+"','"+rolearray[i]+"')";
	stmt.executeUpdate(sql);
}
response.sendRedirect("users_list.jsp");
%>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>