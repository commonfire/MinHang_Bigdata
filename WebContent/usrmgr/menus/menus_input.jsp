<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>增加菜单</title>
<link rel="stylesheet" href="../../css/dtree.css" type="text/css"/>
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<script type="text/javascript" src="../../js/forms.js"></script>
<script language="javascript">
var sruleid = '';
var p,r,o;
function parseUrl(obj){
	selUrl1 = obj.value.replace(/\\/g,'/');
	selUrl2 = selUrl1.replace(new RegExp(root),'');
	if(selUrl2 == selUrl1){
		alert('对不起，目录不正确');
		return;
	}
	r.value = selUrl2;
	setDispRole(1);
}
function up(){
	if(sruleid == 1)return;
	n = p.options[sruleid-2].innerHTML;
	p.options[sruleid-2].innerHTML = p.options[sruleid-1].innerHTML;
	p.options[sruleid-1].innerHTML = n;
	sruleid--;
	o.value = sruleid;
	p.options[sruleid-1].selected=true;
}
function down(){
	if(sruleid == p.options.length)return;
	n = p.options[sruleid].innerHTML;
	p.options[sruleid].innerHTML = p.options[sruleid-1].innerHTML;
	p.options[sruleid-1].innerHTML = n;
	sruleid++;
	o.value = sruleid;
	p.options[sruleid-1].selected=true;
}
function change(){
	var si = p.selectedIndex;
	while( (sruleid-1) - si != 0 ){
		if(si > sruleid-1)			down()
		else if(si < sruleid-1)	up();
	}
}
function setPoint(obj){
	p.options[sruleid-1].innerHTML = obj.value;
}
function setDispRole(value){
	dsp = document.getElementById('dispOther');
	if(value){
		dsp.style.visibility = 'visible';
	}else{
		dsp.style.visibility = 'hidden';
	}
}
//这是窗体初始化的时候
window.onload = function(){
	//获取它的位置信息
	p = document.getElementById('position');
	o = document.getElementById('menuorder');
	if(!sruleid)	sruleid = p.options.length;
	p.selectedIndex = sruleid -1;
	o.value = sruleid;
}
//提交操作
function tosave(){
	//先判断菜单名称是否输入
	var menuname=document.myForm.menuname.value;
	if(menuname==""){
		window.alert("请输入菜单名称");
		return;
	}
	//把菜单的顺序和名称取出来
	var menuOrderName="";
	var order="";
	var name="";
	for(var i=0;i<document.myForm.position.length;i++){
		order=document.myForm.position.options[i].value;
		name=document.myForm.position.options[i].text;
		//如果是新项目
		if(name=="【新项目】"){
			//人为地给 hidden 域 赋值
			document.myForm.menuorder.value=order;
		}
		menuOrderName=menuOrderName+order+","+name+";";
	}
	document.myForm.menustr.value=menuOrderName;
	document.myForm.action="menus_save.jsp";
	document.myForm.submit();
}
</script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
</head>
<body>
<%
//计算菜单的下一个MENUID
ResultSet rs=stmt.executeQuery("SELECT NVL(MAX(ID),0)+1 AS MENUMAX FROM U_MENUS");
String newmenuid="";
if(rs.next()){
	newmenuid=dt.isNull(rs.getString("MENUMAX"));
}
String menuid=request.getParameter("menuid");
//显示的应该是菜单的父菜单名称
String menuname="";
rs=stmt.executeQuery("SELECT MENUNAME FROM U_MENUS WHERE ID='"+menuid+"'");
if(rs.next()){
	menuname=dt.isNull(rs.getString("MENUNAME"));
}
%>
<form name="myForm" method="post" action="menus_save.jsp">
<input name="menustr" type="hidden" id="menustr" value="">
<input name="menuorder" type="hidden" id="menuorder" value="">
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center" class="tableTitle">增加菜单</div></td>
	</tr>
	<tr>
		<td>
		<table align="center" width="50%" border="1" cellspacing="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">父菜单</div></td>
				<td><div align="left"><%=menuname%>
				<input type="hidden" name="pid" value="<%=menuid%>">
				</div></td>
			</tr>
		<tr>
			<td bgcolor="#e0f0ff"><div align="center">菜单ID：</div></td>
			<td><input name="id" id="id" class="textinput" value="<%=newmenuid%>" readonly size=20>
			<font color="red">(新增菜单ID自动生成)</font>          
			</td>
		</tr>
		<tr>
			<td bgcolor="#e0f0ff"><div align="center">菜单名称：</div></td>
			<td><input name="menuname" id="menuname" class="textinput" value="" size=20></td>
		</tr>
		<tr>
			<td bgcolor="#e0f0ff"><div align="center">菜单URL：</div></td>
			<td><input name="menuurl" id="menuurl" class="textinput" value="" size=20></td>
		</tr>
		<tr>
			<td bgcolor="#e0f0ff"><div align="center">菜单顺序：</div></td>
			<td>
				<table width="100" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td rowspan="2"><select name="position" size="3" id="position" onChange="change();">
						<%
						//先计算菜单的应该顺序
						rs=stmt.executeQuery("SELECT MAX(MENUORDER)+1 AS MENUORDER FROM U_MENUS WHERE PID='"+menuid+"'");
						String menuShouldOrder="";
						if(rs.next()){
							menuShouldOrder=dt.isNull(rs.getInt("MENUORDER"));
						}
						if(menuShouldOrder.equals("")){
							menuShouldOrder="1";
						}
						//based on parentmenuid to calc sub menus
						rs=stmt.executeQuery("SELECT * FROM U_MENUS WHERE PID='"+menuid+"' ORDER BY MENUORDER");
						while(rs.next()){
						%>
						<option value="<%=dt.isNull(rs.getInt("MENUORDER"))%>"><%=dt.isNull(rs.getString("MENUNAME"))%></option>
						<%}%>
						<option value="<%=menuShouldOrder%>" selected>【新项目】</option>
						</select></td>
						<td><input type="button" class="btn_2k3" value="上移" onClick="up()"></td>
					</tr>
					<tr>
						<td><input type="button" class="btn_2k3" value="下移" onClick="down()"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td bgcolor="#e0f0ff"><div align="center">新窗口：</div></td>
			<td><select name="isopen">
			<option value="">请选择</option>
			<option value="N">原窗口打开</option>
			<option value="Y">新窗口打开</option>
			</select></td>
		</tr>
	</table>
	</td>
    </tr>
	<tr>
		<td><div align="center">
		<input name="btn1" type="button" class="btn_2k3" id="btn1" value="确定" onClick="tosave();">
		<input name="btn2" type="button" class="btn_2k3" id="btn2" value="取消" onClick="Cancel('menus_list.jsp');">
		</div></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%
rs.close();
rs=null;
%>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>