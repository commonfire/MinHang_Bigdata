<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<%
String isMain=dt.toUTF(request.getParameter("isMain"));
%>
<!--
(==============================================================================)
                   中国石油大学(华东) 计算机与通信工程学院 版权所有㊣           
 ★本软件界面受法律保护，未经授权，盗版或抄袭本软件界面者将受到严厉的法律制裁★ 
(==============================================================================)
--><HTML><HEAD><TITLE><%if(isMain.equals("")){out.println("用户权限管理系统");}else{out.println("软件工程方向暑期实习实践教学管理平台");}%></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<SCRIPT language=JavaScript>
//-------------------- 防止出错 ---------------------------
function killErrors()
{
  return true;
}
window.onerror = killErrors;
//------------------- 窗口最大化 --------------------------
self.moveTo(0,0); 
self.resizeTo(screen.availWidth,screen.availHeight); 
self.focus();  

// 状态栏显示文字
window.defaultStatus=""; 
</SCRIPT>
</HEAD>
<FRAMESET id=frame1 border=0 frameSpacing=0 rows=70,*,20 frameBorder=NO cols=*>
<FRAME name=topFrame src="frame/index_top.jsp?isMain=<%=isMain%>" noResize scrolling=no>
<FRAMESET id=frame2 border=0 frameSpacing=0 rows=* frameBorder=NO cols=8,186,19,*,8>
		<FRAME name=menu_leftbar src="frame/menu_leftbar.jsp" noResize scrolling=no>
		<FRAME name=function_panel src="frame/function_panel.jsp?isMain=<%=isMain%>" noResize scrolling=no>
		<FRAME name=controlmenu src="frame/control_menu.jsp" frameBorder=0 noResize scrolling=no>
		<FRAME id=table_index src="frame/table_index.jsp" frameBorder=0 noResize scrolling=no>
		<FRAME name=menu_rightbar src="frame/menu_rightbar.jsp" frameBorder=0 noResize scrolling=no>
</FRAMESET>
<FRAME name=bottom_frame src="frame/bottom_frame.jsp" noResize scrolling=no>
</FRAMESET><noframes></noframes>
</HTML>