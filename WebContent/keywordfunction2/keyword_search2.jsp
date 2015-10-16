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

<style type="text/css" media="screen">
#loadDiv {
position:fixed;
z-index:999;
width:expression(document.body.clientWidth);
height:expression(document.body.clientHeight);
background-color:#FFFFFF;
width:100%;
height:100%;
}
.loadDiv-fix{width: 250px;height: 80px; line-height: 80px; position: absolute; left: 50%; margin-left: -125px; top: 50%; margin-top: -50px; background: rgba(0,0,0,0); border-radius: 6px; color: #fff; padding-left: 110px; box-sizing:border-box; font-size: 1.6rem;}
.loadDiv-fix .load{width: 30px; height: 30px; display: block; position: absolute; left: 70px; top: 25px; -webkit-animation:myfirst 1.5s linear infinite ;}  
.loadDiv-fix .loading{width: 80px; height: 80px; display: block; position: absolute; left: 10px; top: 0px;-webkit-animation:mysec 2s linear infinite ;}  
</style>

<title>关键词搜索用户</title>
	
</head>
<body>
<!-- 爬取信息提示 -->
 <div id="loadDiv">
        <div class="loadDiv-fix">
            <img class="load" src="../images/crawler_load.gif" />
            <div align="center"><font size='3' color='black'>正在爬取中....</font></div>
        </div>
</div>

<form  name="myForm" method="post" action="">
<%
	//获取网页上输入的信息
	request.setCharacterEncoding("utf-8");
    String keyword = request.getParameter("keyword")!=null?request.getParameter("keyword"):"";
    session.setAttribute("keyword", keyword);
    int searchstate = 0;
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
					//Thread.sleep(300*1000);  //5min interval
					ExecuteShell.executeShell(keyword,"keyuser");	
					while(true){
							searchstate = SelectOperation.selectEndState("searchstate",conn);
							if(searchstate==1) break;	
					}
					System.out.println("searchstate:"+searchstate);
					ResultSet rs = SelectOperation.selectUidBasedKeyword(keyword, conn);
					if(rs!=null){
						try{
							while(rs.next()){%>
				<tr class="text-center" id="<%=rs.getRow()%>">
					<td><%=rs.getRow()%></td>
					<td><%=keyword%></td>
					<td><%=rs.getString("userAlias")!=null?rs.getString("userAlias"):""%></td> 
				    <td><a href=<%="keyword_weibo2.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
				    <td><a href=<%="keyword_userinfo2.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
				    <td><a href=<%="../friendcircle2/atuser_circle_full2.jsp?uid="+rs.getString("userID")+"&alias="+rs.getString("userAlias")%>><input name="cmdQuery" type="button" class="btn_2k3" value="查询"></a></td>  
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

<script language="javascript">
		function keywordSearch(){
			document.myForm.action="";
			document.myForm.submit();
			show();
		}
		
</script>

 <script>
     var yes = 0;
     console.log(yes);
     var loadDiv = document.getElementById('loadDiv');
     loadDiv.style.display='none';
     function show(){
            loadDiv.style.display='block';
            statechange();
        }
    function statechange(){
            yes = <%=searchstate%>;
            if(yes != 1){setTimeout(show, 1000);}
            else{ loadDiv.style.display='none';yes = 0;return ;}
           
        }
</script>


</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>