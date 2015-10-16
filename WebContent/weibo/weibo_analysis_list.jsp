<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
</head>

<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博账号危险等级分析</div></td>
    </tr>
    <tr><td>
    微博账号：<input type="text" name="weiboid" value="">
    性别：<select name="sex">
    <option value="">性别</option>
    <option value="男">男</option>
    <option value="女">女</option>
    </select>
    危险等级：<select name="rank"></select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询">
    </td></tr>
    <tr><td>
    	<table align="center" width="100%" class="datalist">
            <tr>
                <th scope="col">序号</th>
                <th scope="col">昵称</th>
                <th scope="col">微博账号</th>
                <th scope="col">出生日期</th>
                <th scope="col">性别</th>
                <th scope="col">注册时间</th>
                <th scope="col">危险等级</th>
            </tr>
            <%
			ResultSet rs=stmt.executeQuery("select * from t_user_info where 1=1 ");
			int row=1;
			while(rs.next()){
			%>
            <tr>
                <td><div align="center"><%=row++%></div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("useralias")%></div></td>
                <td><div align="center">&nbsp;<%=rs.getString("userid")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("birthday")%>&nbsp;</div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("sex")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("registertime")%>&nbsp;</div></td>
                <td><div align="center">xx</div></td>
            </tr>
            <%}%>
          </table>
    </td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>