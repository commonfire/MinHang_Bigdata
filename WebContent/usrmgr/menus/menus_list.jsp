<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>菜单列表</title>
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<link rel="stylesheet" href="../../css/dtree.css" type="text/css"/>
<script type="text/javascript" src="../../js/dtree.js"></script>
<script type="text/javascript" src="../../js/dtree_common.js"></script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
</head>
<body>
<script language="javascript">
function addmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择父菜单！");
		return;
	}
	document.myForm.action="menus_input.jsp?menuid="+menuid;
	document.myForm.submit();
}
function modmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择要修改的菜单！");
		return;
	}
	document.myForm.action="menus_edit.jsp?menuid="+menuid;
	document.myForm.submit();
}
//删除菜单
function delmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择要删除的菜单！");
		return;
	}
	document.myForm.action="menus_del.jsp?menuid="+menuid;
	document.myForm.submit();
}
</script>
<form name="myForm" method="post" action="">
<input type="hidden" name="selectmenu" value="">
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center" class="tableTitle">菜单列表</div></td>
	</tr>
	<tr>
		<td>
		<div class="dtree">
		<script>
		d1 = new dTree('d1');
		<%
		ResultSet rs=stmt.executeQuery("SELECT * FROM U_MENUS ORDER BY MENUORDER");
		while(rs.next()){
		String menuid=rs.getString("ID");
		%>
		d1.add('<%=menuid%>','<%=rs.getString("PID")%>','<%=rs.getString("MENUNAME")%>',"javascript:selectmenu('<%=menuid%>');");
		<%}%>
		document.write(d1);
		d1.openAll();
		</script>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="btn1" type="button" class="btn_2k3" id="btn1" value="增加菜单" onClick="addmenu();">&nbsp;
		<input name="btn2" type="button" class="btn_2k3" id="btn2" value="修改菜单" onClick="modmenu();">&nbsp;
		<input name="btn3" type="button" class="btn_2k3" id="btn3" value="删除菜单" onClick="delmenu();"></td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>