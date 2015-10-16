<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>组织结构增加</title>
<link rel="stylesheet" href="../dtree/dtree.css" type="text/css"/>
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
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
/*
window.onload = function(){
	//获取它的位置信息
	p = document.getElementById('position');
	o = document.getElementById('menuorder');
	if(!sruleid)	sruleid = p.options.length;
	p.selectedIndex = sruleid -1;
	o.value = sruleid;
}*/
//提交操作
function tosave(){
	//先判断菜单名称是否输入
	var mc=document.myForm.mc.value;
	if(mc==""){
		window.alert("请输入组织机构名称");
		return;
	}
	//把菜单的顺序和名称取出来
	var menuOrderName="";
	var order="";
	var name="";
	for(var i=0;i<document.myForm.seq.length;i++){
		order=document.myForm.seq.options[i].value;
		name=document.myForm.seq.options[i].text;
		//如果是新项目
		if(name=="【新项目】"){
			//人为地给 hidden 域 赋值
			document.myForm.seq.value=order;
		}
		menuOrderName=menuOrderName+order+","+name+";";
	}
	document.myForm.menustr.value=menuOrderName;
	document.myForm.action="organization_save.jsp";
	document.myForm.submit();
}
</script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
</head>
<body>
<%
ResultSet rs=stmt.executeQuery("SELECT NVL(MAX(ID),0)+1 AS MENUMAX FROM U_ORGANIZATION");
String newmenuid="";
if(rs.next()){
	newmenuid=dt.isNull(rs.getString("MENUMAX"));
}
String menuid=request.getParameter("menuid");
//显示的应该是菜单的父菜单名称
String menuname="";
ResultSet rs1=stmt.executeQuery("SELECT MC FROM U_ORGANIZATION WHERE ID='"+menuid+"'");
if(rs1.next()){
	menuname=dt.isNull(rs1.getString("MC"));
}
%>
<form name="myForm" method="post" action="organization_save.jsp">
<input name="menustr" type="hidden" id="menustr" value="">
<input name="menuorder" type="hidden" id="menuorder" value="">
  <table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
    <tr>
      <td height="50"><div align="center" class="tableTitle">增加组织机构</div></td>
    </tr>
    <tr>
      <td><table align="center" width="50%" border="1" cellspacing="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
        <tr>
          <td bgcolor="#e0f0ff"><div align="center">父组织机构：</div></td>
          <td><div align="left"><%=menuname%>
            <input type="hidden" name="pid" value="<%=menuid%>">
          </div></td>
        </tr>
        <tr>
          <td bgcolor="#e0f0ff"><div align="center">组织机构ID：</div></td>
          <td><input name="id" id="id" class="textinput" value="<%=newmenuid%>" readonly size=20>
<font color="red">(新增菜单ID自动生成)</font>          
          </td>
          </tr>
        <tr>
          <td bgcolor="#e0f0ff"><div align="center">组织机构名称：</div></td>
          <td><input name="mc" id="mc" class="textinput" value="" size=20></td>
          </tr>
        <tr>
          <td bgcolor="#e0f0ff"><div align="center">组织机构顺序：</div></td>
          <td><table width="100" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td rowspan="2"><select name="seq" size="3" id="seq" onChange="change();">
                <%
				//先计算菜单的应该顺序
				ResultSet rs2=stmt.executeQuery("SELECT MAX(SEQ)+1 AS MENUORDER FROM U_ORGANIZATION WHERE PID='"+menuid+"'");
				String menuShouldOrder="";
				if(rs2.next()){
					menuShouldOrder=dt.isNull(rs2.getInt("MENUORDER"));
				}
				if(menuShouldOrder.equals("")){
					menuShouldOrder="1";
				}
				//based on parentmenuid to calc sub menus
				ResultSet rss=stmt.executeQuery("SELECT * FROM U_ORGANIZATION WHERE PID='"+menuid+"' ORDER BY SEQ");
				while(rss.next()){
				%>
				<option value="<%=dt.isNull(rss.getInt("SEQ"))%>"><%=dt.isNull(rss.getString("MC"))%></option>
				<%}%>
				<option value="<%=menuShouldOrder%>" selected>【新项目】</option>
				</select></td>
              <td><input type="button" class="btn_2k3" value="上移" onClick="up()"></td>
            </tr>
            <tr>
              <td><input type="button" class="btn_2k3" value="下移" onClick="down()"></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td><div align="center">
        <input name="btn1" type="button" class="btn_2k3" id="btn1" value="确定" onClick="tosave();">
        <input name="btn2" type="button" class="btn_2k3" id="btn2" value="取消" onClick="javascript:window.location='organization_list.jsp'">
      </div></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
</table>
<%
rs.close();
rs=null;
rs1.close();
rs1=null;
%>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>