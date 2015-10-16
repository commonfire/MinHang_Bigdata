<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*"
	import="javax.servlet.http.HttpServletRequest"
	import="java.io.*"
 %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="dbutil" class="edu.soft.DBUtil" scope="page"/>
<jsp:useBean id="oper" class="edu.soft.DBOper" scope="page"/>
<title>用户保存</title>
</head>
<body>
<form name="myForm" method="post" action="">
<%
String[] str=dt.toArray("username,password,realname,email,telephone,ipaddr,category,unitid");
String[] type=dt.toArray("C,C,C,C,C,C,C,C");
int newID=dt.getNewID(stmt,"U_USERS");
oper.save(conn,request,str,"U_USERS",type,newID,"UTF-8",true);
%>
</form>
</body>
</html>
<script language="javascript">
	document.myForm.action="users_list.jsp";
	document.myForm.submit();
</script>
<%@ include file="../../inc/conn_close.jsp"%>