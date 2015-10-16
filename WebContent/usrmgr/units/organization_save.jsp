<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/>
<jsp:useBean id="oper" scope="page" class="edu.soft.DBOper"/>
<%
String[] str=dt.toArray("id,pid,mc,seq");
String[] type=dt.toArray("C,C,C,C");
oper.save(conn,request,str,"U_ORGANIZATION",type);
//取出上一页面的menustr
String menustr=dt.toGB2312(request.getParameter("menustr"));
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
		stmt.executeUpdate("UPDATE U_ORGANIZATION SET SEQ='"+menu[0]+"' WHERE MC='"+menu[1]+"' AND PID='"+pid+"'");
	//}
}
response.sendRedirect("organization_list.jsp");
%>
<%@ include file="../../inc/conn_close.jsp"%>