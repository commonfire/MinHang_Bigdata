<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*"%>
<%@ include file="../../inc/conn.jsp"%>
<%@ include file="../../inc/pages.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="td" class="edu.soft.MyDate" scope="page"/>
<jsp:useBean id="condutil" class="edu.soft.CondUtil" scope="page"/>
<jsp:useBean id="pages" class="edu.soft.OraclePages" scope="page"/>
<script type="text/javascript" src="../../js/validate.js"></script>
<title>用户列表</title>
</head>
<%
String page_url="users_list.jsp";
int intPage=pages.getPage(request,"page");
ResultSet rsInner;
String param_username=dt.toUTF(request.getParameter("param_username"));
StringBuffer buffer=new StringBuffer();
condutil.Like(buffer,"USERNAME",param_username);
String cond=buffer.toString();
%>
<body>
<form name="myForm" method="post" action="">
<table width="100%" border="0">
	<tr>
		<td height="40"><div align="center" class="tableTitle">用户列表</div></td>
	</tr>
	<tr>
		<td>
		用户名：
		<input name="param_username" type="text" class="textinput" id="param_username" onKeyDown="javascript:if(event.keyCode==13)chaxun('<%=page_url%>')" value="<%=param_username%>" size="20"/><input type="button" class="btn_2k3" name="cmd1" value="查询" onClick="chaxun('<%=page_url%>');"></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#c0de98">
				<tr>
					<td height="26" nowrap class="rowstyle"><div align="center">序号</div></td>
					<td nowrap class="rowstyle"><div align="center">用户名</div></td>
					<td nowrap class="rowstyle"><div align="center">密码</div></td>
					<td nowrap class="rowstyle"><div align="center">真实姓名</div></td>
					<td nowrap class="rowstyle"><div align="center">单位名称</div></td>
					<td nowrap class="rowstyle"><div align="center">电话号码</div></td>
					<td nowrap class="rowstyle"><div align="center">IP地址</div></td>
					<td nowrap class="rowstyle"><div align="center">Email</div></td>
					<td nowrap class="rowstyle"><div align="center">用户类别</div></td>
		            <td nowrap class="rowstyle"><div align="center">角色名称</div></td>
		            <td nowrap class="rowstyle"><div align="center">分配角色</div></td>
				</tr>
				<%
				String sql = "SELECT ID,USERNAME,PASSWORD,REALNAME,TELEPHONE,IPADDR,EMAIL,CATEGORY,(SELECT MC FROM U_ORGANIZATION WHERE ID=UNITID) UNITNAME FROM U_USERS WHERE 1=1 "+cond+" ORDER BY ID DESC";
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
				<td nowrap class="rowcellstyle"><input type="checkbox" name="xh<%=num%>" value="<%=rs.getInt("ID")%>"/><%=(intPage-1)*intPageSize+num++%></td>
			    <td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("USERNAME"))%>&nbsp;</div></td>
				<td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("PASSWORD"))%>&nbsp;</div></td>
				<td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("REALNAME"))%>&nbsp;</div></td>
				<td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("UNITNAME"))%></td>
				<td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("TELEPHONE"))%>&nbsp;</div></td>
				<td nowrap class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("IPADDR"))%>&nbsp;</div></td>
				<td class="rowcellstyle"><div align="left">&nbsp;<%=dt.isNull(rs.getString("EMAIL"))%>&nbsp;</div></td>
				<td class="rowcellstyle"><div align="center">&nbsp;<%=dt.isNull(rs.getString("CATEGORY"))%>&nbsp;</div></td>
			    <td class="rowcellstyle"><div align="center">&nbsp;<%
				//根据用户ID == 计算角色名称，依次列出来：管理员、作业大队
				rsInner=stmt2.executeQuery("SELECT * FROM U_ROLES WHERE ID IN (SELECT ROLEID FROM U_AUTHS WHERE USERID="+rs.getInt("ID")+")");
				while(rsInner.next()){
					out.println(dt.isNull(rsInner.getString("ROLENAME"))+"&nbsp;");
				}
				%>&nbsp;</div></td>
			    <td class="rowcellstyle"><div align="center"><a href="assignRoles.jsp?userid=<%=rs.getInt("ID")%>">分配角色</a></div></td>
			</tr>
			<%}%>
		</table></td>
    </tr>
	<input type="hidden" name="num" value="<%=num%>">
    <tr><td><%@ include file="../../inc/pagination.jsp"%></td></tr>
	<tr>
		<td>
			<div align="left">
			<input type="button" name="cmdAdd" class="btn_2k3" value="增加" onClick="Add('users_input.jsp');"/>
			<input type="button" name="cmdEdit" class="btn_2k3" value="编辑" onClick="Edit('users_edit.jsp');"/>
			<input type="button" name="cmdDel" class="btn_2k3" value="删除" onClick="Del('users_del.jsp');"/>
			<input type="button" name="cmdAll" class="btn_2k3" value="全选" onClick="SellAll();"/>
			<input type="button" name="cmdInvert" class="btn_2k3" value="反选" onClick="InvertAll();"/>
			</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>