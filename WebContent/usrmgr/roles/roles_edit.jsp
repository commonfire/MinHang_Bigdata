<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<script type="text/javascript" src="../../js/forms.js"></script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="editutil" class="edu.soft.EditUtil" scope="page"/>
<title>角色编辑</title>
</head>
<%
String id=dt.toGB2312(request.getParameter("id"));
HashMap<String,String> editMap=editutil.getEdit(stmt,"SELECT * FROM U_ROLES WHERE ID="+id,"id,rolename,roledesc");
%>
<body>
<form name="myForm" method="post" action="">
<input type="hidden" name="id" value="<%=id%>"/>
<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="40"><div align="center" class="tableTitle">角色编辑</div></td>
	</tr>
	<tr>
		<td><fieldset>
		<legend><font size="4"><b>基本信息</b></font></legend>
		<table align="center" width="100%" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
			<tr>
				<td width="20%" class="bgclass">角色名称：</td>
				<td width="30%"><input name="rolename" id="rolename" class="textinput" value="<%=editMap.get("rolename")%>" size="20"></td>
				<td width="20%" class="bgclass"><div align="center">角色描述：</div></td>
				<td width="30%"><input name="roledesc" id="roledesc" class="textinput" value="<%=editMap.get("roledesc")%>" size="20"></td>
			</tr>
		</table>
		</fieldset></td>
	</tr>
	<tr>
		<td><div align="center">
		<input type="button" name="cmd1" value="确定" class="btn_2k3" onClick="Save('roles_edit_save.jsp');">&nbsp;
		<input type="button" name="cmd2" value="取消" class="btn_2k3" onClick="Cancel('roles_list.jsp');">
		</div></td>
	</tr>
</table>
<!--参数列表-->
<input type="hidden" name="param_page" value="<%=dt.isNull(request.getParameter("param_page"))%>"/>
</form>
</body>
</html>
<%
//释放内存空间
editMap=null;
%>
<%@ include file="../../inc/conn_close.jsp"%>