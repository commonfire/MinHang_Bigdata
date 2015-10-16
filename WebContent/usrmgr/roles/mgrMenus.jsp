<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<title>菜单管理</title>
<link rel="StyleSheet" href="../../css/main.css" type="text/css"/>
<link rel="StyleSheet" href="../dtree/dtree.css" type="text/css"/>
<script type="text/javascript" src="../dtree/dtree.js"></script>
<script type="text/javascript" src="../../js/forms.js"></script>
<script type="text/javascript" src="../../js/dtree_common.js"></script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="find" class="edu.soft.FindUtil" scope="page"/>
</head>
<body onLoad="oo();">
<form name="myForm" method="post" action="">
<%
String roleid=request.getParameter("roleid");
ResultSet rs1=stmt.executeQuery("SELECT MENUID FROM U_RESOURCES WHERE ROLEID='"+roleid+"'");
StringBuffer buffer=new StringBuffer();
while(rs1.next()){
	buffer.append(dt.isNull(rs1.getString("MENUID"))).append(",");
}
String menustr="";
//如果菜单字符串的长度大于等于1的话
if(buffer.length()>=1){
	menustr=buffer.substring(0,buffer.length()-1);
}
String[] roleidArr=find.getNames(stmt,"U_ROLES","ID");
String[] rolenameArr=find.getNames(stmt,"U_ROLES","ROLENAME");
%>
<input type="hidden" name="menustr" value="<%=menustr%>"/>
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center"></div>
			<table cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
				<tr>
					<td bgcolor="#e0f0ff">分配给角色：</td>
					<td>
					<select name="roleid">
					<%for(int i=0;i<roleidArr.length;i++){%>
					<option value="<%=roleidArr[i]%>" <%if(roleid.equals(roleidArr[i])){out.print("selected");}%>><%=rolenameArr[i]%></option>
					<%}%>
					</select></td>
				</tr>
			</table>
		</td>
	</tr>
    <tr>
      <td><div class="dtree">
		<script>
		d = new dTree('d');
		d.config.target = "mainFrame";
		d.config.useCheckBox=true;
		d.config.imageDir = '../dtree/img1';
		d.reSetImagePath();
		d.config.folderLinks = true;
		d.config.closeSameLevel = true;
		d.config.check=true;//显示复选框
		d.config.mycheckboxName="ids";//设置<input type='checkbox' name="ids"/>name的属性
		var isOpen;
		<%ResultSet rs=stmt.executeQuery("SELECT * FROM U_MENUS ORDER BY ID,MENUORDER");
		while(rs.next()){%>
		d.add('<%=rs.getString("ID")%>','<%=rs.getString("PID")%>','<%=rs.getString("MENUNAME")%>',"");
		<%}%>
		document.write(d);
		d.openAll();
		</script>
		</div></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><input name="cmdOK" type="button" class="btn_2k3"value="确定" onClick="subtest();">&nbsp;
      <input name="cmdCancel" type="button" class="btn_2k3" value="取消" onClick="Cancel('roles_list.jsp');"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
<script language="javascript">
function subtest(){
	var result="";
	var subids = document.all("ids");
	for(var i=0;i<subids.length;i++){
		if(subids[i].checked){
			if(result!=""){result=result+",";}
			result+=subids[i].value;
		}
	}
	document.myForm.action="mgrMenus_save.jsp?menustr="+result;
	document.myForm.submit();
}
function oo(){
	var menustr=document.myForm.menustr.value;
	d.setCheck(menustr);
	/*var menuarray=menustr.split(",");
	for(var i=0;i<menuarray.length;i++){
		d.setCheck(menuarray[i]);
	}*/
}
</script>
<%
rs.close();
rs=null;
%>
</form>
</body>
</html>
<%@ include file="../../inc/conn_close.jsp"%>