<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/conn.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账号地区分布</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
</head>
<%
String mc = request.getParameter("mc");
String cond = " AND LOCATION LIKE '%"+mc+"%'";
System.out.println(mc);
%>
<body>
<table align="center" width="80%" border="0">
<tr>
    	<td height="50" colspan="2"><div align="center" class="tableTitle"><%=mc%>地区账号分布情况</div></td>
</tr>
<tr><td>
    	<table align="center" width="100%" class="datalist">
            <tr>
                <th scope="col">序号</th>
                <th scope="col">昵称</th>
                <th scope="col">微博账号</th>
                <th scope="col">出生日期</th>
                <th scope="col">省份</th>
                <th scope="col">性别</th>
                <th scope="col">注册时间</th>
            </tr>
            <%
			ResultSet rs=stmt.executeQuery("select * from t_user_info where 1=1 "+cond);
			int row=1;
			while(rs.next()){
			%>
            <tr>
                <td><div align="center"><%=row++%></div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("useralias")%></div></td>
                <td><div align="center">&nbsp;<%=rs.getString("userid")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("birthday")%>&nbsp;</div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("location")%></div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("sex")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("registertime")%>&nbsp;</div></td>
            </tr>
            <%}%>
          </table>
    </td></tr>

</table>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>