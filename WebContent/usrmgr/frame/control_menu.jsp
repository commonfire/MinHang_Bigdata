<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<HTML>
<HEAD>
<TITLE>菜单显隐控制条</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript">
var AUTO_HIDE_MENU=0;
var arrowpic1="../images/index_20-1.jpg";
var arrowpic2="../images/index_20-2.jpg"
//--------------------- 状态初始 ----------------------
var MENU_SWITCH;
function panel_menu_open(){
	MENU_SWITCH=AUTO_HIDE_MENU;
	panel_menu_ctrl();
}
//------------------ 面板状态切换 ---------------------
function panel_menu_ctrl(){
	if(MENU_SWITCH==0){
		parent.frame2.cols="8,186,19,*,8";
		MENU_SWITCH=1;
		arrow.src=arrowpic1;
	}else {
		parent.frame2.cols="0,0,19,*,8";
		MENU_SWITCH=0;
		arrow.src=arrowpic2;
	}
}
//------------------ 面板状态切换 ---------------------
function enter_menu_ctrl(){
   if(AUTO_HIDE_MENU==1)    // 判断面板是否允许自动隐藏
   {
     if(MENU_SWITCH==0){
        parent.frame2.cols="8,186,19,*,8";
        MENU_SWITCH=1;
        arrow.src=arrowpic1;
     }else{
        parent.frame2.cols="0,0,19,*,8";
        MENU_SWITCH=0;
        arrow.src=arrowpic2;
     }
   }
}
//--------------- 上下框架页显示控制 -----------------
var DB_VIEW=0;                          // 状态值初始
var DB_rows=parent.parent.frame1.rows;  // 保存原始值
function db_display(){
   if (DB_VIEW==0){// 未隐藏
		parent.parent.frame1.rows="0,*,0";
		DB_VIEW=1;
   }else{// 已隐藏
		parent.parent.frame1.rows=DB_rows;   
		DB_VIEW=0;
   }
}
</script>
</head>
<body oncontextmenu="db_display();return false;" onselectstart="return false" leftmargin="0" topmargin="0" onload="panel_menu_open()">
<table onmousemove="enter_menu_ctrl()" height="100%" cellspacing="0" cellpadding="0" width="19" border="0">
	<tr>
		<td height="20"><img height="74" src="../images/index_12.gif" width="19"></td>
	</tr>
	<tr style="cursor: hand" onclick="panel_menu_ctrl()">
		<td valign="top" background="../images/index_23.gif" bgcolor="#ffffff"><img id="arrow" height="302" alt="左键点击控制菜单栏面板,右键点击控制上下状态栏." src="../images/index_20-1.jpg" width="19"></td>
	</tr>
	<tr>
		<td height="40"><img id="dbarrow" height="40" src="../images/index_26.gif" width="19" name="dbarrow"></td>
	</tr>
</table>
</body>
</html>