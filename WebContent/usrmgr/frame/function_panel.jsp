<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head><title></title>
<meta http-equiv=content-type content="text/html;charset=utf-8">
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<script>
var menu_id=1;
//----------- 设置选择的演示 -----------
function setPointer(element,over_flag,menu_id_over){
	if(menu_id!=menu_id_over){// 判断当前位置是否已经被选中
		if(over_flag==1)
			element.className='menu_operation_3';      // 鼠标进入显示颜色  
		else
			element.className='menu_operation_2';      // 鼠标离开显示演示  
	}
}
//----------- 初始话显示面板 -------------
var init_flag=0;
function init_menu(){
 // init_flag++;
 // if(init_flag==2)
     view_menu(1);
}
//------------ 查看面板中的页 ------------
function view_menu(id){
//if(menu_id==id)
// return;
	menu_id=id;
	for(i=1;i<=4;i++){
		menu_i="menu_"+i;
		if(i==id){
			color_i='menu_operation_1';
		}else{
			color_i="menu_operation_2";// 鼠标离开显示演示 #EEEEEE
		}
	}
	if(id==1){// 功能菜单
		frame1.rows="74,*,0,0,0,40";
		menu_page.location="about:blank";    // 清空临时
	}else if(id==2){// 在线人员
		user_online.location="/frame/bottom_menu_a.jsp";   // 强制刷新
		frame1.rows="74,0,*,0,0,40";
		menu_page.location="about:blank";    // 清空临时
	}else if(id==3){// 帮助支持 
		frame1.rows="74,0,0,*,0,40";
		menu_page.location="about:blank";    // 清空临时
	}else if(id==4){// 快捷方式 
		menu_page.location="/frame/bottom_menu_a.jsp";
		frame1.rows="74,0,0,0,*,40";
	}
}
</script>
<!-- 普通状态登录 -->
<%
String isMain=dt.toUTF(request.getParameter("isMain"));
%>
</head>
<frameset id="frame1" border="1" framespacing="0" rows="74,*,0,0,0,40" frameborder="no" cols="*">
	<frame name="menu_info" src="menu_info.jsp" frameborder="0" noresize scrolling="no">
	<frame name="menu_main" src="menu.jsp?isMain=<%=isMain%>" frameborder="0" noresize>
	<frame name="user_online" src="" frameborder="0" noresize>
	<frame name="help" src="help.jsp" frameborder="0" noresize>
	<frame name="menu_page" src="" frameborder="0" noresize>
	<frame name="menu_operation" src="menu_operation.jsp" frameborder="0" noresize scrolling="no">
</frameset>
</html>