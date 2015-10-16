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
<jsp:useBean id="findutil" class="edu.soft.FindUtil" scope="page"/>
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
String isMain=dt.toUTF(request.getParameter("isMain"));
String userid="1";//dt.isNull((String)session.getAttribute("userid"));
String category=findutil.getSessionById(session,"category");


	String sql="SELECT * FROM U_MENUS WHERE (ID IN (SELECT MENUID FROM U_RESOURCES WHERE ROLEID IN (SELECT ROLEID FROM U_AUTHS WHERE USERID = '"+userid+"'))) ORDER BY MENUORDER";
	
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){%>
	d.add('<%=dt.isNull(rs.getString("ID"))%>','<%=dt.isNull(rs.getString("PID"))%>','<%=dt.isNull(rs.getString("MENUNAME"))%>',"<%if(!dt.isNull(rs.getString("MENUURL")).equals("")){out.print(dt.isNull(rs.getString("MENUURL")));}%>",'<%=dt.isNull(rs.getString("MENUNAME"))%>','table_main','<%=dt.isNull(rs.getString("MENUPIC"))%>');
	<%}%>
	d.add("997","0","修改密码","../usrmgr/pswd_edit.jsp","","table_main");
	//d.add("998","000","返回首页","javascript:toHome();");
	d.add("999","0","系统退出","javascript:exit();","系统退出","","../dtree/img1/exitSys.gif");

document.write(d);
</script>
</body>
<%@ include file="../../inc/conn_close.jsp"%>