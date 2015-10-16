<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../css/main.css" type="text/css"/>
<script type="text/javascript" src="../../js/marquee.js"></script>
<title>底部状态条</title>
<script language="JavaScript">
function killErrors(){
  return true;
}
window.onerror = killErrors;
</script>
</head>

<body onselectstart="return false" leftmargin=0 topmargin=0 marginheight="0" marginwidth="0">
<table class="small" height="20" cellspacing="0" cellpadding="0" width="100%" background="../images/sb_bg.gif" border="0">
  <tbody>
  <tr>
    <td width="6"><img height="20" src="../images/sb_bg.gif" width="6"></td>
    <td style="cursor: hand" width="85"><!-- <a class=sb_online_text title=显示在线用户 
      onclick=javascript:show_online();>共<input class=sb_online_num 
      id=user_count1 readonly size=3>人在线</a> --></td>
    <td align="middle" width="38"><span id="new_sms"></span></td>
    <td align="middle" width="57"><span id="new_letter"></span></td>
    <td class="sb_center_text" title="点击这里刷新主操作区" onclick=javascript:parent.table_index.table_main.location.reload(); nowrap align="middle">
	<b><font color="#FFFFFF">
      <script language="javascript">
	  new marquee('status_text');status_text.init(new Array("中国民航大学&nbsp;&nbsp;2015-2020 版权所有"));</script>
	</font></b></td>
    <td valign=center nowrap align=middle width=65><!-- <a style="color: #d50000" 
      href="http://202.194.158.167:81/include/act.php" 
      target=table_main><b>软件购买</b></a> --></td>
    <td valign=center nowrap align=middle width=65><!--< a style="color: #d50000" 
      href="http://www.hcesoft.com/gbook" target=table_main><b>服务中心</b></a> --> </td>
    <td nowrap align=right width=25><!-- <a 
      href="http://202.194.158.167:81/include/downfile/" target=table_main><img 
      height=16 alt=常用下载 src="../images/downfile.gif" width=16 
      border=0></a> --></td>
    <td nowrap align=right width=25><!-- <a 
      href="http://202.194.158.167:81/frame/help/" target=_blank><img height=16 
      alt=帮助支持 src="../images/help.gif" width=16 border=0></a> --></td>
    <td nowrap align=right width=25><!-- <a 
      href="http://202.194.158.167:81/frame/about.php" target=table_main><img 
      height=16 alt=版权信息 src="../images/i_about.gif" width=16 
      border=0></a> --></td>
    <td width=6>&nbsp;</td></tr></tbody></table>
	<script>
		window.settimeout('this.location.reload();',3600000);
	</script>
</body>
</html>