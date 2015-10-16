<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<html>
<head>
<title>系统标题栏</title>
<script language="javascript">
//显示首页面
function showDesktop(){
	parent.parent.table_main.src="portlet/leader_list.jsp";
}
//询问注销系统
function iflogout(){
	if(window.confirm('确定要退出系统吗？')){
		parent.parent.location="../logoff.jsp";// 页面跳转
	}
}
//******************************************************************
var week; 
if(new Date().getDay()==0)          week="星期日"
if(new Date().getDay()==1)          week="星期一"
if(new Date().getDay()==2)          week="星期二" 
if(new Date().getDay()==3)          week="星期三"
if(new Date().getDay()==4)          week="星期四"
if(new Date().getDay()==5)          week="星期五"
if(new Date().getDay()==6)          week="星期六"

var timerID = null;
var timerRunning = false;
function stopclock (){
	if(timerRunning)
	clearTimeout(timerID);
	timerRunning = false;
}
function startclock () {
	stopclock();
	showtime();
}
function showtime () {
	var now = new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var seconds = now.getSeconds()
	var timeValue = now.getYear()+"年"+(now.getMonth()+1)+"月"+now.getDate()+"日 " + week +((hours >= 12) ? " 下午 " : " 上午 " );
	timeValue += ((hours >12) ? hours -12 :hours);
	timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
	timeValue += ((seconds < 10) ? ":0" : ":") + seconds;
	document.myForm.thetime.value = timeValue;
	timerID = setTimeout("showtime()",1000);
	timerRunning = true;
}
//****************************-屏蔽鼠标右键***********************************
if (window.Event)
	document.captureEvents(Event.MOUSEUP);
function nocontextmenu(){
	event.cancelBubble = true
	event.returnValue = false;
	return false;
}
function norightclick(e){
	if (window.Event){
		if (e.which == 2 || e.which == 3)
			return false;
	}else if (event.button == 2 || event.button == 3){
		event.cancelBubble = true
		event.returnValue = false;
		return false;
	}
}
document.oncontextmenu = nocontextmenu;  // for IE5+
document.onmousedown = norightclick;     // for all others
//****************************-屏蔽鼠标右键***********************************
</script>
<%
String isMain=dt.toUTF(request.getParameter("isMain"));
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/main.css" type="text/css" rel="stylesheet">
</head>
<body onselectstart="return false" leftmargin="0" topmargin="0" onLoad="startclock();">
<form name="myForm" method="post" action="">
<table height="70" cellspacing="0" cellpadding="0" width="100%" align="right" background="../images/index_01.gif" border="0">
	<tr align=right>
		<td width="1"><img height="70" src="../images/index_01.gif" width="1"></td>
		<td nowrap align="left" width="500" height="50" rowspan="2">
		<div align="left"><img height="70" src="<%if(!isMain.equals("Y")){out.println("../images/logo.gif");}else{out.println("../../images/mylogo.gif");}%>" width="500" align=middle></div>
		</td>
		<td>
			<table height="70" cellspacing="0" cellpadding="0" width="500" border="0">
			<tr>
			<td height="50">
				<table cellspacing="0" cellpadding="0" align="right" border="0">
					<tr>
						<td valign="center" align="middle" width="75"><img src="../images/index_05.gif" width="75" border="0"></td>
						<td valign="center" align="middle" width="48"><img src="../images/index_06.gif" width="48" border="0"></td>
						<td valign="center" align="middle" width="58"><img src="../images/index_07.gif" width="58" border="0" onClick="javascript:iflogout()"></td>
					</tr>
				</table>
			</td></tr>
			<tr>
			<td class="small" style="color: #d3e3f6" align=right>现在时刻：<b><span id=time_area></span></b>&nbsp;&nbsp;
			<input name="thetime" style="font-size: 9pt;color: #ffffff;background-color:transparent;border:0px;"size="40">&nbsp;&nbsp; 
			</td></tr>
			</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>