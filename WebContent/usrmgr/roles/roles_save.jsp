<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="oper" class="edu.soft.DBOper" scope="page"/>
<form name="myForm" method="post" action="">
<%
String[] str=dt.toArray("id,rolename,roledesc");
String[] type=dt.toArray("C,C,C");
oper.save(conn,request,str,"U_ROLES",type);
//response.sendRedirect("roles_list.jsp");
%>
<input type="hidden" name="param_page" value="<%=dt.toUTF(request.getParameter("param_page"))%>"/>
</form>
<script language="javascript">
	window.alert("您已经成功保存数据!!!");
	document.myForm.action="roles_list.jsp";
	document.myForm.submit();
</script>
<%@ include file="../../inc/conn_close.jsp"%>