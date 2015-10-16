<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="../../css/main.css" type="text/css"/>
<link rel="StyleSheet" href="../dtree/dtree.css" type="text/css"/>
<script type="text/javascript" src="../dtree/dtree.js"></script>
<script type="text/javascript" src="../../js/forms.js"></script>
<script type="text/javascript" src="../../js/dtree_common.js"></script>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<jsp:useBean id="find" class="edu.soft.FindUtil" scope="page"/>
<title>分配角色</title>
</head>

<body onLoad="oo();">
<form name="myForm" method="post" action="">
<%
String userid=request.getParameter("userid");
ResultSet rs1=stmt.executeQuery("SELECT ROLEID FROM U_AUTHS WHERE USERID='"+userid+"'");
StringBuffer buffer=new StringBuffer();
while(rs1.next()){
	buffer.append(dt.isNull(rs1.getString("ROLEID"))).append(",");
}
String rolestr="";
//如果菜单字符串的长度大于等于1的话
if(buffer.length()>=1){
	rolestr=buffer.substring(0,buffer.length()-1);
}
String[] useridArr=find.getNames(stmt,"U_USERS","ID");
String[] usernameArr=find.getNames(stmt,"U_USERS","USERNAME");
%>
<input type="hidden" name="rolestr" value="<%=rolestr%>"/>
<table align="center" width="95%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="50"><div align="center"></div>
			<table cellspacing="1" border="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff">
				<tr>
					<td bgcolor="#e0f0ff">分配给用户：</td>
					<td>
					<select name="userid">
					<%for(int i=0;i<useridArr.length;i++){%>
					<option value="<%=useridArr[i]%>" <%if(userid.equals(useridArr[i])){out.print("selected");}%>><%=usernameArr[i]%></option>
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
  		d.add('0',-1,"角色列表","");
		d.config.target = "mainFrame";
		d.config.useCheckBox=true;
		d.config.imageDir = '../dtree/img1';
		d.reSetImagePath();
		d.config.folderLinks = true;
		d.config.closeSameLevel = true;
		d.config.check=true;//显示复选框
		d.config.mycheckboxName="ids";//设置<input type='checkbox' name="ids"/>name的属性
		var isOpen;
		<%ResultSet rs=stmt.executeQuery("SELECT * FROM U_ROLES");
		while(rs.next()){%>
		d.add('<%=rs.getString("ID")%>','0','<%=rs.getString("ROLENAME")%>',"");
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
      <input name="cmdCancel" type="button" class="btn_2k3" value="取消" onClick="Cancel('users_list.jsp');"></td>
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
	document.myForm.action="assignRoles_save.jsp?rolestr="+result;
	document.myForm.submit();
}
function oo(){
	var rolestr=document.myForm.rolestr.value;
	d.setCheck("0,"+rolestr);
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