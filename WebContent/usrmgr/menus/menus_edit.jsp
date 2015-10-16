<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>菜单编辑</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="../../css/main.css" type="text/css"/>
<script type="text/javascript" src="../../js/forms.js"></script>
<script language="javascript">
var sruleid = '';//用来保存选择列表的长度
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
//上移操作过程：交换选中的项和它上面的项
function up(){
	if(document.getElementById('position').options.length == 1)return;//如果选择列表的长度==1 返回
	if(document.myForm.position.selectedIndex==0) return;
	//(1) 保存上一个 selectedIndex-1
	var swapText=document.myForm.position.options[myForm.position.selectedIndex-1].text;
	var swapValue=document.myForm.position.options[myForm.position.selectedIndex-1].value;
	//(2) 修改上一个 selectedIndex-1
	document.myForm.position.options[myForm.position.selectedIndex-1].text=document.myForm.position.options[myForm.position.selectedIndex].text;
	document.myForm.position.options[myForm.position.selectedIndex-1].value=document.myForm.position.options[myForm.position.selectedIndex].value;
	//(3) 修改当前选中的为 selectedIndex-1
	document.myForm.position.options[myForm.position.selectedIndex].text=swapText;
	document.myForm.position.options[myForm.position.selectedIndex].value=swapValue;
	document.myForm.position.selectedIndex=document.myForm.position.selectedIndex-1;
}
//下移过程：交换选中的项和它下面的项
function down(){
	if(document.getElementById('position').options.length == 1)return;//如果选择列表的长度==1 返回
	if(document.myForm.position.selectedIndex==document.getElementById('position').options.length) return;
	//(1) 保存上一个 selectedIndex-1
	var swapText=document.myForm.position.options[myForm.position.selectedIndex+1].text;
	var swapValue=document.myForm.position.options[myForm.position.selectedIndex+1].value;
	//(2) 修改上一个 selectedIndex-1
	document.myForm.position.options[myForm.position.selectedIndex+1].text=document.myForm.position.options[myForm.position.selectedIndex].text;
	document.myForm.position.options[myForm.position.selectedIndex+1].value=document.myForm.position.options[myForm.position.selectedIndex].value;
	//(3) 修改当前选中的为 selectedIndex-1
	document.myForm.position.options[myForm.position.selectedIndex].text=swapText;
	document.myForm.position.options[myForm.position.selectedIndex].value=swapValue;
	document.myForm.position.selectedIndex=document.myForm.position.selectedIndex+1;
}
function change(){
	var si = document.myForm.position.selectedIndex;
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
		//order=document.myForm.position.options[i].value;
		order=i+1;
		name=document.myForm.position.options[i].text;
		menuOrderName=menuOrderName+order+","+name+";";
	}
	document.myForm.menustr.value=menuOrderName;
	
	var menuorder=document.myForm.menuorder.value;
	document.myForm.action="menus_edit_save.jsp";//?menustr="+menuOrderName+"&menuid="+document.myForm.menuid.value;
	document.myForm.submit();
}
</script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
</head>
<body>
<%
String menuid=request.getParameter("menuid");
ResultSet rs=stmt.executeQuery("SELECT * FROM U_MENUS WHERE ID='"+menuid+"'");
String menuname="";
String menuurl="";
String menuorder="";
String isopen="";//新窗口打开 否？
if(rs.next()){
	menuname=dt.isNull(rs.getString("MENUNAME"));
	menuurl=dt.isNull(rs.getString("MENUURL"));
	menuorder=dt.isNull(rs.getInt("MENUORDER"));
	isopen=dt.isNull(rs.getString("ISOPEN"));
}
rs.close();
rs=null;
%>

<form action="menus_edit_save.jsp" method="post" name="myForm">
<input name="menustr" type="hidden" id="menustr" value="">
<input name="menuorder" type="hidden" id="menuorder" value="<%=menuorder%>">
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center" class="tableTitle">菜单编辑</div></td>
	</tr>
	<tr>
		<td>
		<table width="50%" align="center" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">菜单 ID：</div></td>
				<td><input name="id" id="id" class="textinput" value="<%=menuid%>" readonly size=20></td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">菜单名称：</div></td>
				<td><input name="menuname" id="menuname" class="textinput" value="<%=menuname%>" size=20></td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">菜单URL：</div></td>
				<td><%
				if(request.getParameter("url") != null){
					String urlurl = request.getParameter("url");
				%>
				<input name="menuurl" id="menuurl" class="textinput" value="../<%=urlurl.substring(urlurl.indexOf("urls"),urlurl.length()).replace("\\","/")%>" size=20>
				<%}else{%>
				<input name="menuurl" id="menuurl" class="textinput" value="<%=menuurl%>" size=20>
				<%}%></td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">菜单顺序：</div></td>
				<td>
				<table width="100" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td rowspan="2"><select name="position" size="3" id="position" onChange="change();">
						<%//based on parentmenuid to calc sub menus
						ResultSet rss=stmt.executeQuery("SELECT * FROM U_MENUS WHERE PID IN (SELECT PID FROM U_MENUS WHERE ID='"+menuid+"') ORDER BY MENUORDER");
						while(rss.next()){%>
						<option value="<%=dt.isNull(rss.getInt("MENUORDER"))%>"><%=dt.isNull(rss.getString("MENUNAME"))%></option>
						<%}%>
						</select></td>
						<td><input name="button" type="button" class="btn_2k3" onClick="up()" value="上移"></td>
					</tr>
					<tr>
						<td><input name="button" type="button" class="btn_2k3" onClick="down()" value="下移"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">新窗口：</div></td>
				<td><select name="isopen">
				<option value="">请选择</option>
				<option value="N" <%if(isopen.equals("N")){out.println("selected");}%>>原窗口打开</option>
				<option value="Y" <%if(isopen.equals("Y")){out.println("selected");}%>>新窗口打开</option>
				</select></td>
			</tr>
			</table>
		</td>
    </tr>
	<tr>
		<td><div align="center"><br>
		<input type="hidden" name="menunamestr" value="<%=menuname%>">
		<input name="btn1" type="button" class="btn_2k3" value="确定" onClick="tosave();">
		<input name="btn2" type="button" class="btn_2k3" value="取消" onClick="Cancel('menus_list.jsp');">
		</div></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="javascript">
	//下面执行选中的部分
	var menunamestr=document.myForm.menunamestr.value;
	var name=""
	for(var i=0;i<document.myForm.position.length;i++){
		name=document.myForm.position.options[i].text;
		if(name==menunamestr){
			//选中
			document.myForm.position.selectedIndex=i;
		}
	}
function calcPathName(){
	var path=document.myForm.pathname.value;
	var pos=path.indexOf("urls");
	var rightLeft=path.substring(pos);
	rightLeft.replace("\\","/");
	var sPath="..\\"+rightLeft;
	sPath.replace("\\","/");
	document.myForm.menuurl.value=sPath;
}
</script>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>