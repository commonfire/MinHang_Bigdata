function IsNum(s){//判断是否是数字
	if(s!=null && s!=""){
		return !isNaN(s);
	}
	return false;
}
function CheckForm(){
	//验证表单信息是否完整
	var studentno=document.getElementById("studentno").value;
	if(studentno==""){
		window.alert("请输入学生学号!");
		document.getElementById("studentno").focus();
		return;
	}else{
		//验证学号是否符合规范
		if(!IsNum(studentno)){
			//提示学号必须是数字
			window.alert("学号必须是数字!");
			document.getElementById("studentno").select();
			document.getElementById("studentno").focus();
			return;
		}
	}
	//转到保存页面
	document.myForm.action="student_register_save.jsp";
	document.myForm.submit();
}
//下面写菜单联动代码
function Change(){
	//取得department
	var department=document.getElementById("department").value;
	if(department=="计算机与通信工程学院"){
		//下面动态改变专业班级的值
		var dest=document.getElementById("specialityclass");
		dest.length=0;
		dest.options[dest.length]=new Option("请选择","");
		dest.options[dest.length]=new Option("a","a");//去掉回车和换行
		dest.options[dest.length]=new Option("b","b");//去掉回车和换行
		//for(var i=0;i<retArray.length;i++){
		//}
	}
}
//===================================================================
var xmlHttp;//定义一个对象
function createXMLHttpRequest(){
	if(window.ActiveXObject){//判断是否IE浏览器
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xmlHttp=new XMLHttpRequest();
	}
}
//===================================================================

//检查用户是否已经注册
function checkExist(){
	var studentno=document.getElementById("studentno").value;
	createXMLHttpRequest();
	xmlHttp.onreadystatechange=handleFunction;//函数调用
	var strurl="judge_studentno.jsp?studentno="+studentno;
	xmlHttp.open("POST",strurl,true);
	xmlHttp.send(null);
}
function handleFunction(){
	if(xmlHttp.readyState==4){//0 未初始化 1 正在装在 2 装载完毕 3 交互中 4 完成
		if(xmlHttp.status==200){// 200 OK 404 not found
			var str=xmlHttp.responseText.replace(/[\r\n]/g,"");
			//alert(str);
			if(str=="0"){
				document.getElementById("info").innerHTML="<img src='../../images/right.PNG'></img><font color=green><b>恭喜你，可以注册!</b></font>";
			}else{
				document.getElementById("info").innerHTML="<font color=red><b>该用户已经存在!</b></font>";
				document.getElementById("studentno").select();
				document.getElementById("studentno").focus();
			}
		}
	}
}