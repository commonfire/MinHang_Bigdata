<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="edu.bupt.display.ExecuteShell" %>
<%@ include file="../inc/conn_oracle.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="css/table_basic.css" type="text/css"/>
<title>用户发表微博内容</title>
</head>
<body>
<form name="myForm" method="post" action="">
<%
	String uid = request.getParameter("uid")!=null?request.getParameter("uid"):null;
	String userAlias = request.getParameter("alias")!=null?request.getParameter("alias"):null;
%>
<table align="center" width="80%" border="0">
<tr><td>
  <table align="center" width="100%" class="datalist">
	<thead>
		<tr>
			<th scope="col">序号</th>
			<th scope="col">用户</th>
			<th scope="col">微博内容</th>
			<th scope="col">发表时间</th>
		</tr>
	</thead>
	<tbody>
		<%
		if(uid!=null){
			ExecuteShell.executeShell(uid,"keyweibocontent");
			while(true){
				int contentstate = SelectOperation.selectEndState("contentstate",conn);
				if(contentstate==1) break;;			
			}
			ResultSet rs = SelectOperation.selectWeiboBasedUid(uid, conn);
			if(rs!=null){
				try{
					while(rs.next()){%>
		<tr class="text-center">
			<td><%=rs.getRow()%></td>
			<td><%=userAlias%></td>
			<td><%=rs.getString("content")!=null?rs.getString("content"):""%></td> 
		    <td><%=rs.getString("publishTime")!=null?rs.getString("publishTime").substring(0, rs.getString("time").lastIndexOf(':')):""%></td>  
		</tr>
		<%
						}
					}catch(SQLException e){
							e.printStackTrace();
					}finally{
						UpdateOperation.updateEndState("contentstate");
					}
				}
			}
		%> 
	</tbody>
</table>
</td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>