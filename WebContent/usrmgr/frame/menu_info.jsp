<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>登录信息框</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<style type="text/css">
body {
	margin: 0px
}
.small {
	font-size: 9pt
}
</style>
</head>
<%
String str_qx="";
String username=dt.isNull((String)session.getAttribute("username"));
if(username.equals("system")){
	str_qx="系统管理员";
}else{
	str_qx="普通用户";
}
%>
<body>
<table height="74" cellspacing="0" cellpadding="0" width="186" border="0">
	<tr>
		<td background="../images/index_11.gif" colspan="2">
			<table cellspacing="4" cellpadding="0" width="100%" border="0">
				<tr>
					<td nowrap><div class="small" align="center"><%=dt.isNull((String)session.getAttribute("unitname"))%>&gt;&gt;<%=str_qx%> </div></td>
				</tr>
				<tr>
					<td nowrap><div class="small" align="center"><img src="../images/1.gif" align="absmiddle">&nbsp;<%=dt.isNull((String)session.getAttribute("realname"))%> ，
					<script language="javaScript"> 
					now = new Date(),hour = now.getHours() 
					if(hour < 6){document.write("凌晨好！")} 
					else if (hour < 9){document.write("早上好！")} 
					else if (hour < 12){document.write("上午好！")} 
					else if (hour < 14){document.write("中午好！")} 
					else if (hour < 17){document.write("下午好！")} 
					else if (hour < 19){document.write("傍晚好！")} 
					else if (hour < 22){document.write("晚上好！")} 
					else {document.write("夜里好！")} 
					</script>
					&nbsp;</div></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>