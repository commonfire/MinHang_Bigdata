<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="edu.bupt.display.ExecuteShell" %>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<title>用户基本信息</title>
</head>
<body>
<form name="myForm" method="post" action="">
<%
	String userID = request.getParameter("uid")!=null?request.getParameter("uid"):"";
	String userAlias = request.getParameter("alias")!=null?request.getParameter("alias"):"";
%>
<table align="center" width="80%" border="0">
<tr>
    <td height="50"><div align="center" class="tableTitle"><%=userAlias%>用户基本信息</div></td>
</tr>

<tr><td>
<table align="center" width="100%" class="datalist">
		<%
			if(!userID.equals("")){
				 if(!SelectOperation.containsUser(userID, "USERID", conn)) {  //不重复爬取用户信息
					ExecuteShell.executeShell(userID, "userinfo");
							while (true) {
								int userinfostate = SelectOperation.selectEndState("userinfostate", conn);
								if (userinfostate == 1)
									break;
							}
					}
				
				String userProperty = SelectOperation.selectUserProperty(userID, "USERID ",conn);
				//System.out.println("!!!"+userProperty);
				if("icon_verify_co_v".equals(userProperty)){
			%>
				<script language="javascript">alert("该用户为公众账号");</script>			
			<% 		
				}
				else{
			%>
				<thead>
					<tr>
						<th scope="col">昵称</th>
						<th scope="col">所在地</th>
						<th scope="col">性别</th>
						<th scope="col">生日</th>
						<th scope="col">博客</th>
						<th scope="col">个性域名</th>
						<th scope="col">简介</th>
						<th scope="col">注册时间</th>
					</tr>
				</thead>
				<tbody>
					<% 		
							ResultSet rs = SelectOperation.selectUserinfo(userID, conn);
							if (rs != null) {
								try {
									while (rs.next()) {
					%>
					<tr class="text-center">
						<td><%=rs.getString("userAlias")!=null?rs.getString("userAlias"):""%></td>
						<td><%=rs.getString("location")!=null?rs.getString("location"):""%></td> 
					    <td><%=rs.getString("sex")!=null?rs.getString("sex"):""%></td>
					    <td><%=rs.getString("birthday")!=null?rs.getString("birthday"):""%></td> 
					    <td><%=rs.getString("blog")!=null?rs.getString("blog"):""%></td> 
					    <td><%=rs.getString("domain")!=null?rs.getString("domain"):""%></td>   
					    <td><%=rs.getString("brief")!=null?rs.getString("brief"):""%></td> 
					    <td><%=rs.getString("registertime")!=null?rs.getString("registertime"):""%></td> 
					</tr>
					<%
									}
								}catch(SQLException e){
										e.printStackTrace();
								}finally{
									UpdateOperation.updateEndState("userinfostate");
								}
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