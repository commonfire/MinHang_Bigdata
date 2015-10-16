<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="inc/conn.jsp"%>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<%
String username=dt.isNull(request.getParameter("username"));
String password=dt.isNull(request.getParameter("password"));
//验证用户名和密码是否正确。设置session的值
String userid="";//用户ID
String realname="";//真实姓名
String unitid="";//单位ID
String unitname="";//单位名称
String sclass="";//班级名称
String category="";//用户类别
ResultSet rs=stmt.executeQuery("SELECT * FROM U_USERS WHERE USERNAME='"+username+"' AND PASSWORD='"+password+"'");

if(rs.next()){
	userid=dt.isNull(rs.getString("ID"));
	realname=dt.isNull(rs.getString("REALNAME"));
	unitid=dt.isNull(rs.getString("UNITID"));
	category=dt.isNull(rs.getString("CATEGORY"));
	//设置其它的各种信息
	session.setAttribute("userid",userid);
	session.setAttribute("realname",realname);
	session.setAttribute("username",username);
	session.setAttribute("unitid",unitid);//单位ID
	session.setAttribute("category",category);//用户类别
}else{	
	%>
		<script language="javascript">
        window.alert("您输入的用户名和密码不正确~，请重新输入！");
        window.location="index.jsp";
        </script>
        <%out.flush();
        out.close();
}
//释放资源
rs.close();
rs=null;
//转到主框架的页面
if(username.equals("system")){
	response.sendRedirect("usrmgr/default.jsp");//系统管理员进入的页面
}else{
	response.sendRedirect("Frm/default.jsp");
}
%>
<%@ include file="inc/conn_close.jsp"%>