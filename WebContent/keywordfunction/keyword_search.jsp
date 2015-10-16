<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.bupt.display.ExecuteShell" %>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
	<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
	<title>关键词搜索用户</title>
	
	<script language="javascript">
		function keywordSearch(){
			document.myForm.action="";
			document.myForm.submit();
		}
		
	</script>
</head>
<body>

<form  name="myForm" method="post" action="">
<%
	//获取网页上输入的信息
	request.setCharacterEncoding("utf-8");
    String keyword = request.getParameter("keyword")!=null?request.getParameter("keyword"):"";
    session.setAttribute("keyword", keyword);
%>
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博关键词搜索</div></td>
    </tr>
	<tr>
		<td>
		请输入查询关键词：<input type="text" class="input-medium search-query" name="keyword" value=<%=session.getAttribute("keyword") %>>
		<input type="submit" name="cmdQuery" class="btn_2k3" value="查询" onClick="keywordSearch();">
		</td>
	</tr>
	<tr>
		<td>
		<table align="center" width="100%" class="datalist" >
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">关键词</th>
					<th scope="col">用户昵称</th>
			     	<th scope="col">查询发布微博</th>  
			     	<th scope="col">查询用户信息</th>  
			     	<th scope="col">查询用户朋友圈</th> 
				</tr>
			</thead>
			<tbody>
				<!-- 表格开始  JSP动态生成 -->
				<%
				if(keyword!=""){					
					if(!SelectOperation.containsField("keyword", keyword, "t_user_keyword", conn)){
						Thread.sleep(300*1000);  //5min interval
						ExecuteShell.executeShell(keyword,"keyuser");	
						while(true){
								int searchstate = SelectOperation.selectEndState("searchstate",conn);
								if(searchstate==1) break;	
						}
					}
					ResultSet rs = SelectOperation.selectUidBasedKeyword(keyword, conn);
					if(rs!=null){
						try{
							while(rs.next()){%>
				<tr class="text-center" id="<%=rs.getRow()%>">
					<td><%=rs.getRow()%></td>
					<td><%=keyword%></td>
					<td><%=rs.getString("userAlias")!=null?rs.getString("userAlias"):""%></td> 
				    <td><a href=<%="keyword_weibo.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
				    <td><a href=<%="keyword_userinfo.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
				    <td><a href=<%="../friendcircle/atuser_circle_full.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
				</tr>
				<%
							}
						}catch(SQLException e){
							e.printStackTrace();
						}finally{
							UpdateOperation.updateEndState("searchstate");
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