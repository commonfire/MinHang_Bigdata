<!doctype html><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
</head>
<%
HashMap map=new HashMap();
ResultSet rsAlias=stmt.executeQuery("SELECT * FROM T_USER_INFO");
while(rsAlias.next()){
	map.put(rsAlias.getString("USERID"),rsAlias.getString("USERALIAS"));
}
ArrayList<String> list=new ArrayList<String>();
Hashtable<String,String> hashtable=new Hashtable<String,String>();
ResultSet rs=stmt.executeQuery("select count(*) N,userid from T_USER_WEIBOCONTENT where (sysdate-TO_DATE(substr(publishtime,0,10),'YYYY-MM-DD'))<30 group by userid order by N desc");
while(rs.next()){
	list.add(rs.getString("userid"));
	hashtable.put(rs.getString("userid"),rs.getString("N"));
}
%>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博账号活跃分子</div></td>
    </tr>
    <tr><td>
    危险等级：
    <select name="rank">
    <option value="">等级</option>
    <option value="高">高</option>
    <option value="中">中</option>
    <option value="低">低</option>
    </select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询">
    </td></tr>
    <tr>
        <td>
        	<table align="center" width="100%" class="datalist">
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <th><%if(i<list.size()){out.print(list.get(i));}%></th>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <td>昵称：<%if(i<list.size()){out.print(dt.isNull((String)map.get(list.get(i))));}%></td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <td>头像：</td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <td>发表帖子数：<%if(i<list.size()){out.print(hashtable.get(list.get(i)));}%></td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <td>最后发帖时间：</td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=0;i<4;i++){%>
                    <td>民航相关度：<%for(int k=0;k<3;k++){%><img src="star.png">&nbsp;<%}%></td>
                    <%}%>
                </tr>
                <!--第二行-->
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <th><%if(i<list.size()){out.print(list.get(i));}%></th>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <td>昵称：<%if(i<list.size()){out.print(dt.isNull((String)map.get(list.get(i))));}%></td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <td>头像：</td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <td>发表帖子数：<%if(i<list.size()){out.print(hashtable.get(list.get(i)));}%></td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <td>最后发帖时间：</td>
                    <%}%>
                </tr>
                <tr>
                	<%for(int i=4;i<8;i++){%>
                    <td>民航相关度：<%for(int k=0;k<3;k++){%><img src="star.png">&nbsp;<%}%></td>
                    <%}%>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>