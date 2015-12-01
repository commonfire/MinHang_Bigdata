<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<%@ include file="../utils/function.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script type="text/javascript" src="../js/validate.js"></script>
</head>
<%
String cond="";
String weiboid=dt.toUTF(request.getParameter("weiboid"));
String sf=dt.toUTF(request.getParameter("sf"));
String sex=dt.toUTF(request.getParameter("sex"));
String[] sfArr=getNamesOrderById(stmt,"b_provinces","mc");
if(!weiboid.equals("")){
	cond=cond+" AND USERID LIKE '%"+weiboid+"%'";
}
if(!sf.equals("")){
	cond=cond+" AND LOCATION LIKE '%"+sf+"%'";
}
if(!sex.equals("")){
	cond=cond+" AND SEX = '"+sex+"'";
}
%>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博账号查询列表</div></td>
    </tr>
    <tr><td>
    微博账号：<input type="text" name="weiboid" value="<%=weiboid%>">
    性别：<select name="sex">
    <option value="">性别</option>
    <option value="男" <%if(sex.equals("男")){out.print("selected");}%>>男</option>
    <option value="女" <%if(sex.equals("女")){out.print("selected");}%>>女</option>
    </select>
    省份：<select name="sf">
    <option value="">省份</option>
    <%for(int i=0;i<sfArr.length;i++){%>
    <option value="<%=sfArr[i]%>" <%if(sf.equals(sfArr[i])){out.print("selected");}%>><%=sfArr[i]%></option>
    <%}%>
    </select>
    危险等级：<select name="rank">
    <option value="">等级</option>
    <option value="高">高</option>
    <option value="中">中</option>
    <option value="低">低</option>
    </select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询" onClick="chaxun();">
    </td></tr>
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
                <th scope="col">危险等级</th>
            </tr>
            <%
			ResultSet rs=stmt.executeQuery("select * from t_user_info where 1=1 "+cond);
			int row=1;
			while(rs.next()){
			%>
            <tr>
                <td><div align="center"><%=row++%></div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("useralias")%></div></td>
                <td><div align="center">&nbsp;<%=rs.getString("userid").replace(weiboid,"<font color=red><b>"+weiboid+"</b></font>")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("birthday")%>&nbsp;</div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("location")%></div></td>
                <td><div align="left">&nbsp;&nbsp;<%=rs.getString("sex")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getString("registertime")%>&nbsp;</div></td>
                <td><div align="center">&nbsp;<%=rs.getDouble("degree")%>&nbsp;</div></div></td>
            </tr>
            <%}%>
          </table>
    </td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>