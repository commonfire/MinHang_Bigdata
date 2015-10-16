<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<HTML>
<HEAD>
<TITLE>功能菜单</TITLE>
<LINK href="../../css/main.css" type="text/css" rel="stylesheet">
<LINK href="../dtree/dtree.css" type="text/css" rel="stylesheet">
<script src="../dtree/dtree.js" type="text/javascript"></script>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<script language="javascript">
function toHome(){
	window.parent.parent.location="../../index.jsp";
}
function exit(){
	if(window.confirm("确认要退出系统?")){
		window.parent.parent.location="../../logoff.jsp";
	}else{}
}
</script>
<style type="text/css">
	a:link {color: #000000; text-decoration: none}
	a:visited {color: #000000; text-decoration: none}
	a:active {color: #3333ff; text-decoration: none}
	a:hover {color: #ff0000; text-decoration: underline}
	body {margin: 0px}
</style>
<body background="../images/index_menu.jpg" leftMargin="0" topMargin="3" rightMargin="0" marginheight="0" marginwidth="0">
<script>
d = new dTree('d');
d.config.imageDir = '../dtree/img1';
d.reSetImagePath();
<%
String isMain="N";//dt.toUTF(request.getParameter("isMain"));
String userid=dt.isNull((String)session.getAttribute("userid"));

if(!isMain.equals("Y")){
%>
	d.add(000,-1,' 管理内容',"javascript:void(0);");
	d.add(001,000,'用户列表','../users/users_list.jsp','','table_main');
	d.add(002,000,'角色列表','../roles/roles_list.jsp','','table_main');
	d.add(003,000,'菜单列表','../menus/menus_list.jsp','','table_main');
	d.add(004,000,'组织机构','../units/organization_list.jsp','','table_main');
	d.add(006,000,'返回首页',"javascript:toHome();");
	d.add(007,000,'退出系统',"javascript:exit();");
<%
}%>

document.write(d);
</script>
</body>
<%@ include file="../../inc/conn_close.jsp"%>