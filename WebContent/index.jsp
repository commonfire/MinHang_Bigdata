<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<jsp:useBean id="td" scope="page" class="edu.soft.MyDate"/>
<jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/>
<title>民航安全监控与信息服务系统</title>
</head>
<%
//这里处理注销
String zx=request.getParameter("zx");
if(zx==null){zx="";}
if(zx.equals("y")){
	session.setAttribute("username","");
	session.setAttribute("realname","");
	session.setAttribute("unitname","");
}
%>
<body leftMargin=0 topMargin=0 marginheight=0 marginwidth=0>
<form action="loginProcess.jsp" method="post" name="login">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="150">&nbsp;</td>
	</tr>
	<tr>
		<td>
			<table width="604" height="309" border="0" align="center" cellpadding="0" cellspacing="0" background="images/cauc_background.gif">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>&nbsp;</td>
								<td>
									<table width="200" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
										<tr>
											<td><div align="center">用户名：</div></td>
											<td><INPUT name="username" size=12 class="textinput" style="background-color:#B2DFFE;" type="text"></td>
										</tr>
										<tr>
											<td><div align="center">密码：</div></td>
											<td><INPUT name="password" size=12 class="textinput" style="background-color:#B2DFFE;" type="password" onKeyDown="javascript:if(event.keyCode==13)validate()"></td>
										</tr>
										<tr>
											<td colspan="2"><div align="center">
											<input name="cmd1" type="submit" class="btn_2k3" value="确定">
											<input name="cmd2" type="reset" class="btn_2k3" value="取消">
                                            <a href="modules/register/student_register.jsp">注册</a>
											</div></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>
</html>