<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="../../css/main.css" type="text/css"/>
<link rel="StyleSheet" href="../dtree/dtree.css" type="text/css"/>
<script type="text/javascript" src="../dtree/dtree.js"></script>
<title>组织结构选择</title>
<script language="javascript">
function setValue(obj){
	var value=obj.value;
	opener.document.getElementById("unitid").value=value;
	window.close();
}
//选中菜单
function selectmenu(menuid){
	document.myForm.selectmenu.value=menuid;
}
function OK(){
	opener.document.getElementById("unitid").value=document.myForm.selectmenu.value;
	window.close();
}
</script>
</head>

<body>
<form name="myForm" method="post" action="">
<input type="hidden" name="selectmenu" value="">
<table width="100%" border="0">
	<tr>
		<td height="40"><div align="center" class="tableTitle">选择单位</div></td>
	</tr>
	<tr>
		<td>
		<div class="dtree">
		<script>
		d1 = new dTree('d1');
		d1.config.imageDir = '../dtree/img1';
		d1.reSetImagePath();
		<%
		ResultSet rs=stmt.executeQuery("SELECT * FROM U_ORGANIZATION ORDER BY SEQ");
		while(rs.next()){
		String id=rs.getString("ID");
		%>
		d1.add('<%=id%>','<%=rs.getString("PID")%>','<%=rs.getString("MC")%>',"javascript:selectmenu('<%=id%>');");
		<%}%>
		document.write(d1);
		d1.openAll();
		</script>
		</div>
		</td>
	</tr>
	<tr>
		<td><input type="button" name="btnOK" value="确定" onClick="OK();" class="btn_2k3"/></td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>