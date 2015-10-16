<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../dtree/dtree.js"></script>
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<link rel="stylesheet" href="../dtree/dtree.css" type="text/css"/>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<title>组织机构</title>
<script language="javascript">
function d1openTo(nId,check) {
		for (var n=0; n<d1.aNodes.length; n++) {
			if (d1.aNodes[n].id == nId) {
				nId=n;
				break;
			}
		}
	var cn=d1.aNodes[nId];
	document.all["menuck_"+d1.aNodes[nId].id].checked=check
	if (cn.pid==d1.root.id) return;	
	d1openTo(cn.pid, check);
}
//自己增加的函数
function selectChild(id,check){
	for (var n=0; n<d1.aNodes.length; n++) {
		if (d1.aNodes[n].pid == id ) {	
			document.all["menuck_"+d1.aNodes[n].id].checked=check
			selectChild(d1.aNodes[n].id,check);		
		}
	}
}
function setSelect(menuid){
	document.all["menuck_"+menuid].checked=! document.all["menuck_"+menuid].checked;	
	if(document.all["menuck_"+menuid].checked){
		d1openTo(menuid,document.all["menuck_"+menuid].checked);
        //这句是我加的，功能是调用我写的那个脚本语言函数
		selectChild(menuid,document.all["menuck_"+menuid].checked);	
	}
	else d1closeAllChildren(menuid,document.all["menuck_"+menuid].checked);
}
//选中菜单
function selectmenu(menuid){
	document.myForm.selectmenu.value=menuid;
}
function d1closeAllChildren(id,check){				
	for (var n=0; n<d1.aNodes.length; n++) {
		if (d1.aNodes[n].pid == id ) {	
			document.all["menuck_"+d1.aNodes[n].id].checked=check
			d1closeAllChildren(d1.aNodes[n].id,check);		
		}
	}
}
function d1openTo(nId,check){
	for(var n=0; n<d1.aNodes.length; n++){
		if(d1.aNodes[n].id == nId){
			nId=n;
			break;
		}
	}
	var cn=d1.aNodes[nId];
	document.all["menuck_"+d1.aNodes[nId].id].checked=check
	if(cn.pid==d1.root.id) return;	
	d1openTo(cn.pid, check);
}
function addmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择父组织结构！");
		return;
	}
	document.myForm.action="organization_input.jsp?menuid="+menuid;
	document.myForm.submit();
}
function modmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择要修改的组织结构！");
		return;
	}
	document.myForm.action="organization_edit.jsp?menuid="+menuid;
	document.myForm.submit();
}
//删除菜单
function delmenu(){
	//菜单的增加或者保存.
	var menuid=document.myForm.selectmenu.value;
	if(menuid==""){
		window.alert("请先选择要删除的组织机构！");
		return;
	}
	document.myForm.action="organization_del.jsp?menuid="+menuid;
	document.myForm.submit();
}
</script>
</head>

<body>
<form name="myForm" method="post" action="">
<input type="hidden" name="selectmenu" value="">
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center" class="tableTitle">组织机构</div></td>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="btn1" type="button" class="btn_2k3" id="btn1" value="增加单位" onClick="addmenu();">&nbsp;
		<input name="btn2" type="button" class="btn_2k3" id="btn2" value="修改单位" onClick="modmenu();">&nbsp;
		<input name="btn3" type="button" class="btn_2k3" id="btn3" value="删除单位" onClick="delmenu();"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>