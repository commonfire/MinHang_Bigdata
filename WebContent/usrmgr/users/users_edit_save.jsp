<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="oper" class="edu.soft.DBOper" scope="page"/>
<form name="myForm" method="post" action="">
<%
String[] str=dt.toArray("username,password,realname,email,telephone,ipaddr,category,unitid");
String[] type=dt.toArray("C,C,C,C,C,C,C,C");
request.setCharacterEncoding("UTF-8");//必须在第一个request.getParameter()之前调用该方法才有效
oper.update(conn,request,str,"U_USERS",type,"ID",request.getParameter("id"));
%>
<input type="hidden" name="param_page" value="<%=dt.toUTF(request.getParameter("param_page"))%>"/>
</form>
<script language="javascript">
	window.alert("您已经成功编辑数据!!!");
	document.myForm.action="users_list.jsp";
	document.myForm.submit();
</script>
<%@ include file="../../inc/conn_close.jsp"%>