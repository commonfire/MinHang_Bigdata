<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>信息展示区域</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script language="javascript">
// ----------- 设置Cookie
function setCookie(name,value) {
	var today = new Date();
	var expires = new Date();
	expires.setTime(today.getTime() + 1000*60*60*24*365);
	parent.document.cookie = name + "=" + escape(value) + "; expires=" + expires.toGMTString();
}
// ------------ 读取Cookie
function getCookie(Name) {
	var search = Name + "=";
	if(document.cookie.length > 0) {
		offset = document.cookie.indexOf(search);
		if(offset != -1) {
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if(end == -1) end = document.cookie.length;
			return unescape(document.cookie.substring(offset, end));
		}else return('');
	}else return('');
}
// ------------ 刷新帮助页面
function open_link_id(LINK_ID){
	if(getCookie("SHOW_HELP")==1) this.help.location="../help/help.jsp?LINK_ID="+LINK_ID;  // 如果帮助界面显示刷新页面
	setCookie("HELP_LINK_ID",LINK_ID);           // 保存打开帮助的LINK_ID 
}
// ------------ 帮助显示与隐藏模式切换
function show_help(){
	if(table.rows.split(",")[2]=="0")     // 通过判断帮助控制条，来判断帮助是否显示  //if(getCookie("SHOW_HELP")==0)
	{
		//--------- 显示帮助
		//var hloc=this.help.location+"";                                                     // 地址转换为字符串  
		//if(!hloc.indexOf(getCookie("HELP_LINK_ID"))>-1)                  // 通过地址参数判断是否已经打开(避免重复刷新)
		this.help.location="../help/help.jsp?LINK_ID="+getCookie("HELP_LINK_ID"); // 打开COOKIE存储的HELP_LINK_ID  
		table.rows="3,*,*,3";
		setCookie("SHOW_HELP",1);           // 保存记录
	}else{ //-------- 隐藏帮助
		table.rows="3,*,0,3";
		setCookie("SHOW_HELP",0);           // 保存记录
	}
}
// ------------ 帮助面板点击帮助内容显示主操作区帮助
function fullshow_help(){
	if(table.rows.split(",")[2]=="0") table.rows="3,*,*,3";    //  
}
//------------ 关闭帮助 ------------
function close_help(){
	table.rows="3,*,0,3";        // 设置框架页
	setCookie("SHOW_HELP",0);           // 保存记录 
}
//------------ 增大帮助视图 ------------
function zoom_help()
{
	//var row = parseInt(parent.table.rows.split(",")[3])+35;  // 截取数组第4位，增大数值
	var row = this.help.document.body.clientHeight+40;         // 直接读帮助取框架页高度，增大数值
	table.rows = this.table.rows.split(",")[0]+","+this.table.rows.split(",")[1]+","+row+","+this.table.rows.split(",")[3];
}
//------------ 缩小帮助视图 ------------
function shrink_help()
{
	var row = this.help.document.body.clientHeight-40; // 直接读帮助取框架页高度，减小数值
	table.rows = this.table.rows.split(",")[0]+","+this.table.rows.split(",")[1]+","+row+","+this.table.rows.split(",")[3];
}
setCookie("HELP_LINK_ID", "0010");           // 保存帮助首页的LINK_ID，初始LINK_ID 
</script>
</head>
<frameset border="0" name="table" framespacing="0" rows="3,*,0,3" frameborder="0" cols="*">
	<frame name="table_top" src="table_top.jsp" frameborder="0" noresize scrolling="no">
	<frame name="table_main" src="" frameborder="no" noresize>
	<frame name="help" src="" frameborder="no" noresize>
	<frame name="table_bottom" src="table_bottom.jsp" frameborder="no" noresize scrolling="no">
</frameset><noframes></noframes>
</html>