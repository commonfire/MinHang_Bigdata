<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<%@ include file="../../inc/pages.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<script type="text/javascript" src="../../js/forms.js"></script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="td" class="edu.soft.MyDate" scope="page"/>
<jsp:useBean id="pages" class="edu.soft.OraclePages" scope="page"/>
<title>角色列表</title>
</head>
<%
int intPage=pages.getPage(request,"page");

StringBuffer sbCond=new StringBuffer();
//sbCond=getConditionBlur(sbCond,"ROLENAME",param_role);
String cond=sbCond.toString();
%>
<body>
<form name="myForm" method="post" action="">
<table width="100%" border="0">
	<tr>
		<td height="40"><div align="center" class="tableTitle">角色列表</div></td>
	</tr>
	<tr>
		<td>
		角色名称：
		<input name="param_role" type="text" class="textinput" id="param_role" onKeyDown="javascript:if(event.keyCode==13)chaxun('roles_list.jsp')" value="" size="20"/>
		<input type="button" class="btn_2k3" name="cmd1" value="查询" onClick="chaxun('roles_list.jsp');"></td>
    </tr>
	<tr>
		<td>
			<table width="100%" cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
				<tr bgcolor="#e0f0ff">
					<td nowrap><div align="center">序号</div></td>
					<td nowrap><div align="center">角色名称</div></td>
					<td nowrap><div align="center">角色描述</div></td>
					<td nowrap><div align="center">资源列表</div></td>
				</tr>
				<%
				String sql = "SELECT * FROM U_ROLES WHERE 1=1 "+cond+" ORDER BY ID DESC";
				intRowCount=pages.getRowCount(stmt,sql);
				intPageCount=pages.getPageCount(intRowCount,intPageSize);
				//获取分页的SQL语句
				String dbsql=pages.getPageSQL(sql,intRowCount,intPageSize,intPage);
				ResultSet rs=stmt.executeQuery(dbsql);
				int num=1;
				while(rs.next()){
				%>
			<tr>
				<td nowrap><input type="checkbox" name="xh<%=num%>" value="<%=rs.getInt("ID")%>"/><%=(intPage-1)*intPageSize+num++%></td>
			    <td nowrap><div align="center">&nbsp;<%=dt.isNull(rs.getString("ROLENAME"))%>&nbsp;</div></td>
				<td nowrap><div align="center">&nbsp;<%=dt.isNull(rs.getString("ROLEDESC"))%>&nbsp;</div></td>
				<td nowrap><div align="center"><a href="mgrMenus.jsp?roleid=<%=rs.getInt("ID")%>">分配资源</a></div></td>
			  </tr>
			<%}%>
		</table></td>
    </tr>
	<input type="hidden" name="num" value="<%=num%>"><%String page_url="roles_list.jsp";%>
    <tr><td><%@ include file="../../inc/pagination.jsp"%></td></tr>
	<tr>
		<td>
			<div align="left">
			<input type="button" name="cmdAdd" class="btn_2k3" value="增加" onClick="Add('roles_input.jsp');"/>
			<input type="button" name="cmdEdit" class="btn_2k3" value="编辑" onClick="Edit('roles_edit.jsp');"/>
			<input type="button" name="cmdDel" class="btn_2k3" value="删除" onClick="Del('roles_del.jsp');"/>
			<input type="button" name="cmdAll" class="btn_2k3" value="全选" onClick="SellAll();"/>
			<input type="button" name="cmdInvert" class="btn_2k3" value="反选" onClick="InvertAll();"/>
			</div>
		</td>
	</tr>
</table>
<input type="hidden" name="param_page" value="<%=intPage%>"/>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>