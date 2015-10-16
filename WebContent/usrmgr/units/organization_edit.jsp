<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>组织机构修改</title>
<link rel="StyleSheet" href="../../css/main.css" type="text/css"/>
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
	if(document.getElementById('seq').options.length == 1)return;//如果选择列表的长度==1 返回
	if(document.myForm.seq.selectedIndex==0) return;
	//(1) 保存上一个 selectedIndex-1
	var swapText=document.myForm.seq.options[myForm.seq.selectedIndex-1].text;
	var swapValue=document.myForm.seq.options[myForm.seq.selectedIndex-1].value;
	//(2) 修改上一个 selectedIndex-1
	document.myForm.seq.options[myForm.seq.selectedIndex-1].text=document.myForm.seq.options[myForm.seq.selectedIndex].text;
	document.myForm.seq.options[myForm.seq.selectedIndex-1].value=document.myForm.seq.options[myForm.seq.selectedIndex].value;
	//(3) 修改当前选中的为 selectedIndex-1
	document.myForm.seq.options[myForm.seq.selectedIndex].text=swapText;
	document.myForm.seq.options[myForm.seq.selectedIndex].value=swapValue;
	document.myForm.seq.selectedIndex=document.myForm.seq.selectedIndex-1;
}
//下移过程：交换选中的项和它下面的项
function down(){
	if(document.getElementById('seq').options.length == 1)return;//如果选择列表的长度==1 返回
	if(document.myForm.seq.selectedIndex==document.getElementById('seq').options.length) return;
	//(1) 保存上一个 selectedIndex-1
	var swapText=document.myForm.seq.options[myForm.seq.selectedIndex+1].text;
	var swapValue=document.myForm.seq.options[myForm.seq.selectedIndex+1].value;
	//(2) 修改上一个 selectedIndex-1
	document.myForm.seq.options[myForm.seq.selectedIndex+1].text=document.myForm.seq.options[myForm.seq.selectedIndex].text;
	document.myForm.seq.options[myForm.seq.selectedIndex+1].value=document.myForm.seq.options[myForm.seq.selectedIndex].value;
	//(3) 修改当前选中的为 selectedIndex-1
	document.myForm.seq.options[myForm.seq.selectedIndex].text=swapText;
	document.myForm.seq.options[myForm.seq.selectedIndex].value=swapValue;
	document.myForm.seq.selectedIndex=document.myForm.seq.selectedIndex+1;
}
function change(){
	var si = document.myForm.seq.selectedIndex;
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
	var mc=document.myForm.mc.value;
	if(mc==""){
		window.alert("请输入组织结构名称!");
		return;
	}
	//把菜单的顺序和名称取出来
	var menuOrderName="";
	var order="";
	var name="";
	for(var i=0;i<document.myForm.seq.length;i++){
		//order=document.myForm.seq.options[i].value;
		order=i+1;
		name=document.myForm.seq.options[i].text;
		menuOrderName=menuOrderName+order+","+name+";";
	}
	document.myForm.menustr.value=menuOrderName;
	
	var menuorder=document.myForm.menuorder.value;
	document.myForm.action="organization_edit_save.jsp";//?menustr="+menuOrderName+"&menuid="+document.myForm.menuid.value;
	document.myForm.submit();
}
</script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
</head>
<body>
<%
String menuid=request.getParameter("menuid");
ResultSet rs=stmt.executeQuery("SELECT * FROM U_ORGANIZATION WHERE ID='"+menuid+"'");
String menuname="";
String menuorder="";
if(rs.next()){
	menuname=dt.isNull(rs.getString("MC"));
	menuorder=dt.isNull(rs.getInt("SEQ"));
}
%>
<form name="myForm" method="post" action="organization_edit_save.jsp">
<input name="menustr" type="hidden" id="menustr" value="">
<input name="menuorder" type="hidden" id="menuorder" value="<%=menuorder%>">
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center" class="tableTitle">组织机构修改</div></td>
	</tr>
	<tr>
		<td>
		<table width="50%" align="center" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">组织机构ID：</div></td>
				<td><input name="id" id="id" class="textreadonly" value="<%=menuid%>" size=20></td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">组织机构名称：</div></td>
				<td><input name="mc" id="mc" class="textinput" value="<%=menuname%>" size=20></td>
			</tr>
			<tr>
				<td bgcolor="#e0f0ff"><div align="center">组织机构顺序：</div></td>
				<td>
				<table width="100" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td rowspan="2"><select name="seq" size="3" id="seq" onChange="change();">
						<%//based on parentmenuid to calc sub menus
						rs=stmt.executeQuery("SELECT * FROM U_ORGANIZATION WHERE PID IN (SELECT PID FROM U_ORGANIZATION WHERE ID='"+menuid+"') ORDER BY SEQ");
						while(rs.next()){
						%>
						<option value="<%=dt.isNull(rs.getInt("SEQ"))%>"><%=dt.isNull(rs.getString("MC"))%></option>
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
			</table>
		</td>
	</tr>
    <tr>
		<td><div align="center"><br>
		<input type="hidden" name="menunamestr" value="<%=menuname%>">
		<input name="btn1" type="button" class="btn_2k3" value="确定" onClick="tosave();">
		<input name="btn2" type="button" class="btn_2k3" value="取消" onClick="javascript:window.location='organization_list.jsp'">
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
	for(var i=0;i<document.myForm.seq.length;i++){
		name=document.myForm.seq.options[i].text;
		if(name==menunamestr){
			//选中
			document.myForm.seq.selectedIndex=i;
		}
	}
</script>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>