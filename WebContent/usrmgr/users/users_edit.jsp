<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<jsp:useBean id="findutil" class="edu.soft.FindUtil" scope="page"/>
<jsp:useBean id="editutil" class="edu.soft.EditUtil" scope="page"/>
<script type="text/javascript" src="../../js/validate.js"></script>
<title>用户编辑</title>
</head>
<%
String[] userlbArr=findutil.getNames(stmt,"U_USERS_CATEGORY","MC");
String id=request.getParameter("id");
HashMap<String,String> editMap=editutil.getEdit(stmt,"SELECT * FROM U_USERS WHERE ID="+id,"username,password,realname,telephone,email,category,unitid");
%>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="40"><div align="center" class="tableTitle">用户编辑</div></td>
	</tr>
	<tr>
		<td><fieldset>
		<legend><font size="4"><b>基本信息</b></font></legend>
		<table align="center" width="100%" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
			<tr>
				<td width="20%" class="bgclass">用户名：</td>
				<td width="30%"><input name="username" id="username" class="textinput" value="<%=editMap.get("username")%>" size="20"></td>
				<td width="20%" class="bgclass"><div align="center">密码：</div></td>
				<td width="30%"><input name="password" id="password" class="textinput" value="<%=editMap.get("password")%>" size="20"></td>
			</tr>
			<tr>
				<td class="bgclass">密码确认：</td>
				<td><input name="password2" id="password2" class="textinput" value="<%=editMap.get("password")%>" size="20"></td>
				<td class="bgclass">真实姓名：</td>
				<td><input name="realname" id="realname" class="textinput" value="<%=editMap.get("realname")%>" size="20"></td>
			</tr>
			<tr>
				<td class="bgclass">电话号码：</td>
				<td><input name="telephone" id="telephone" class="textinput" value="<%=editMap.get("telephone")%>" size="20"></td>
				<td class="bgclass">EMAIL：</td>
				<td><input name="email" id="email" class="textinput" value="<%=editMap.get("email")%>" size="20"></td>
			</tr>
			<tr>
				<td class="bgclass">IP地址：</td>
				<td><input name="ipaddr" id="ipaddr" class="textinput" value="<%=request.getRemoteAddr()%>" size="20"></td>
				<td class="bgclass">用户类别：</td>
				<td><select name="category" id="category">
				<option value="">请选择</option>
				<%for(int i=0;i<userlbArr.length;i++){%>
				<option value="<%=userlbArr[i]%>" <%if(editMap.get("category").equals(userlbArr[i])){out.println("selected");}%>><%=userlbArr[i]%></option>
				<%}%>
				</select></td>
			</tr>
			<tr>
			  <td class="bgclass">单位ID：</td>
			  <td><input name="unitid" id="unitid" class="textinput" value="<%=editMap.get("unitid")%>" size="6" style="color:red;" readonly><input name="btnSel" type="button" class="btn_2k3" id="btnSel" value="选择单位" onClick="OpenWin('open_organization.jsp');"></td>
			  <td class="bgclass">&nbsp;</td>
			  <td>&nbsp;</td>
		  </tr>
		</table>
		</fieldset></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><div align="center"><input type="hidden" name="id" value="<%=id%>"/>
		<input type="button" name="cmd1" value="确定" class="btn_2k3" onClick="Save('users_edit_save.jsp');">&nbsp;
		<input type="button" name="cmd2" value="取消" class="btn_2k3" onClick="Cancel('users_list.jsp');">
		</div></td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>