<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="oper" class="edu.soft.DBOper" scope="page"/>
<form name="myForm" method="post" action="">
<%
String id=request.getParameter("id");
stmt.executeUpdate("DELETE FROM U_USERS WHERE ID IN ("+id+")");
%>
<input type="hidden" name="param_page" value="<%=dt.toUTF(request.getParameter("param_page"))%>"/>
</form>
<script language="javascript">
	window.alert("您已经成功删除数据!!!");
	document.myForm.action="users_list.jsp";
	document.myForm.submit();
</script>
<%@ include file="../../inc/conn_close.jsp"%>