<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="edu.bupt.display.ShowFormat"%>
<%@ include file="../inc/conn.jsp"%>
<%@ include file="../inc/pages.jsp"%>
<%@ include file="../utils/utils.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博信息查询</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="pages" class="edu.soft.OraclePages" scope="page"/>
<jsp:useBean id="orientationcompute" class="edu.bupt.soft.OrientationCompute" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script type="text/javascript" src="../js/forms.js"></script>
<script type="text/javascript" src="../js/validate.js"></script>
</head>
<%
HashMap map=new HashMap();
ResultSet rsAlias=stmt.executeQuery("SELECT * FROM T_USER_INFO");
while(rsAlias.next()){
	map.put(rsAlias.getString("USERID"),rsAlias.getString("USERALIAS"));
}
String page_url="weibo_info_list.jsp";
int intPage=pages.getPage(request,"page");
String userID=dt.toUTF(request.getParameter("uid"));
String cond="";
if(!userID.equals("")){
	cond=cond+" AND USERID LIKE '%"+userID+"%'";
}
%>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="90%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博信息查询</div></td>
    </tr>
    <tr><td>
    微博账号：<input type="text" name="uid" value="<%=userID%>">
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询" onClick="chaxun();">
    </td></tr>
    <tr><td>
    	<table align="center" width="100%" class="datalist">
            <tr>
                <th scope="col" nowrap>序号</th>
                <th scope="col">昵称</th>
                <th scope="col">微博账号</th>
                <th scope="col">微博内容</th>
                <th scope="col">发布时间</th>
                <th scope="col" nowrap>算法1<br>得分</th>
                <th scope="col" nowrap>计算<br>过程</th>
            </tr>
            <%
			String sql="select * from T_USER_WEIBOCONTENT where 1=1 "+cond+" ORDER BY PUBLISHTIME DESC";
			intRowCount=pages.getRowCount(stmt,sql);
			intPageCount=pages.getPageCount(intRowCount,intPageSize);
			if(intPage>intPageCount){intPage=intPageCount;}//控制分页的页码
			//获取分页的SQL语句
			String dbsql=pages.getPageSQL(sql,intRowCount,intPageSize,intPage);
			ResultSet rs=stmt.executeQuery(dbsql);
			//out.print(dbsql);
			int num=1;
			while(rs.next()){
			%>
            <tr>
                <td><div align="center"><%=(intPage-1)*intPageSize+num++%></div></td>
                <td><div align="center"><%=dt.isNull((String)map.get(rs.getString("userid")))%></div></td>
                <td><div align="center">&nbsp;<%=rs.getString("userid").replace(userID,"<font color=red><b>"+userID+"</b></font>")%>&nbsp;</div></td>
                <td><div align="left"><%=dt.isNull(rs.getString("content"))%>&nbsp;</div></td>
                <td nowrap><div align="left"><%=rs.getString("PUBLISHTIME").replace(" ","<br>")%>&nbsp;</div></td>
                <td nowrap><div align="center"><%=ShowFormat.showFormat(orientationcompute.calcDSOofBlog1(rs.getString("content")))%></div></td>
                <td><div align="center"><a href="weibo_info_detail.jsp?id=<%=dt.isNull(rs.getString("ID"))%>">详细</a></div></td>
            </tr>
            <%}%>
          </table>
    </td></tr>
    <input type="hidden" name="num" value="<%=num%>">
    <tr><td><%@ include file="../inc/pagination.jsp"%></td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>