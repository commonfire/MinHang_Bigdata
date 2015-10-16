<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" href="css/inputstyle.css" type="text/css"/>
	<link rel="stylesheet" href="css/table_basic.css" type="text/css"/>
	<title>微博舆情等级分析</title>
	
	<script language="javascript">
		function queryEmotion(){
			document.myForm.action="";
			document.myForm.submit();
		}
		
		function queryTotalLevel(){
			document.myForm.action="get_totallevel.jsp";
			document.myForm.submit();
		}
		
	</script>
</head>
<body>
<form name="myForm" method="post" action="" >
<%
	//获取网页上输入的信息
	request.setCharacterEncoding("utf-8");
    String userAlias1 = request.getParameter("userAlias1")!=null?request.getParameter("userAlias1"):"";
    session.setAttribute("userAlias1", userAlias1);

	//根据微博账号，计算用户ID
	String userID1 = null;
	ResultSet rs1 =  SelectOperation.selectUserid(userAlias1, conn);                  
	if(rs1!=null&&rs1.next()){
		userID1 = rs1.getString("userID");
	}else{
		userID1 = "";
	}
	

	
%>
<table align="center" width="80%" border="0">
	<tr>
		<td>
		请输入微博账号：<input type="text" class="input-medium search-query" name="userAlias1" value=<%=session.getAttribute("userAlias1") %>>
		<input type="button" name="btnOK" class="btn_2k3" value="查询" onClick="queryEmotion();">
		</td>
	</tr>
	<tr>
		<td>
		查询言论等级：<input type="text" class="input-medium search-query" name="userAlias2" >
		<input type="button" name="btnOK" class="btn_2k3" value="查询" onClick="queryTotalLevel();">
		</td>
	</tr>
	<tr>
		<td>
		<table align="center" width="100%" class="datalist" >
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">微博ID</th>
					<th scope="col">微博内容</th>
					<th scope="col">发布时间</th>
					<th scope="col">操作</th>
				</tr>
			</thead>
			<tbody>
				<!-- 表格开始  JSP动态生成 -->
				<%
				if(userID1!=null){
					ResultSet rs = SelectOperation.selectWeibo(userID1, conn);        
					if(rs!=null){
						try{
							while(rs.next()){%>
				<tr class="text-center" id="<%=rs.getRow()%>">
					<td><%=rs.getRow()%></td>
					<td><%=userID1%></td>
					<td><%=rs.getString("content")!=null?rs.getString("content"):""%></td>
					<td><%=rs.getString("time")!=null?rs.getString("time"):"" %></td> 
					<td><a href=<%="detail_list.jsp?id="+rs.getInt("id")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>
				</tr>
				<%
							}
						}catch(SQLException e){
							e.printStackTrace();
						}
					}
				}
				%> 
				<!-- 表格结束 -->
			</tbody>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>