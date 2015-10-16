<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="dboper" class="edu.soft.DBOper" scope="page"/>
<%
String[] str=dt.toArray("id,pid,menuname,menuurl,menuorder,isopen");
String[] type=dt.toArray("C,C,C,C,C,C");
dboper.save(conn,request,str,"U_MENUS",type);
//上面这个函数，已经设置字符编码UTF-8，下面不用转换，就自动采用这种方式进行解析。
//取出上一页面的menustr
String menustr=dt.isNull(request.getParameter("menustr"));
//测试部分 
String pid=dt.isNull(request.getParameter("pid"));
String[] menuArray=dt.toArray(menustr,";");
for(int i=0;i<menuArray.length;i++){
	//String[] menu=dt.toArray(menuArray[i]);
	String[] menu=new String[2];
	menu[0]=menuArray[i].substring(0,menuArray[i].indexOf(","));
	menu[1]=menuArray[i].substring(menuArray[i].indexOf(",")+1);
	//如果菜单项下面一个都没有，新增加 新项目 顺序没有给出 所以人为地给值1
	//if(menu[0].equals("【新项目】")){
		//db.executeUpdate("UPDATE MENUS SET MENUORDER="+1+" WHERE MENUNAME='"+menu[0]+"' AND PID='"+pid+"'");
	//}else{
		stmt.executeUpdate("UPDATE U_MENUS SET MENUORDER='"+menu[0]+"' WHERE MENUNAME='"+menu[1]+"' AND PID='"+pid+"'");
	//}
}
response.sendRedirect("menus_list.jsp");
%>
<%@ include file="../../inc/conn_close.jsp"%>