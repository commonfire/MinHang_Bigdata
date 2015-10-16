<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/>
<%
//设置其它的各种信息
session.setAttribute("userid","");
session.setAttribute("realname","");
session.setAttribute("username","");
session.setAttribute("unitid","");
session.setAttribute("userlb","");
%>
<script language="javascript">
	window.alert("您已经成功退出系统！");
	window.location="index.jsp";
</script>