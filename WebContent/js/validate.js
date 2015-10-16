function OpenWin(){//打开窗口：选择单位
	var url=arguments[0];
	var w=screen.width;
	var h=screen.height;
	var left=(w-800)/2;
	var top=(h-600)/2;
	open(url,"newwin","width=800,height=600,left="+left+",top="+top+",location=yes,status=yes,scrollbars=yes,resizable=yes");
}
//函数的重载，JavaScript只能通过里面的arguments.length来判断参数的个数。
//使用arguments[i]来操作形参。###注意：定义相同名字的函数，只调用最后一个函数。
function chaxun(){
	if(arguments.length==0){
		document.myForm.action="";
		document.myForm.submit();
	}else if(arguments.length==1){
		document.myForm.action=arguments[0]+"?page=1";
		document.myForm.submit();
	}else if(arguments.length==2){
		document.myForm.action=arguments[0]+"?page=1"+"&rank="+arguments[1];
		document.myForm.submit();
	}
}
//取消，返回到上一页
function Cancel(url){
	document.myForm.action=url;
	document.myForm.submit();
}
function GoTo(){
	//只有两种情况 1、GoTo(url,intPage) 2、GoTo(url)
	if(arguments.length==2){
		var url=arguments[0];
		var intPage=arguments[1];
		document.myForm.action=url+"?page="+intPage;
		document.myForm.submit();
	}else{
		//有一个参数
		var url=arguments[0];
		document.myForm.action=url+"?page="+document.myForm.page.value;
		document.myForm.submit();
	}
}
//☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
//参数url 代表需要转向的url页面地址  张培颖 修改之后，Add可以直接提交至URL页面。
function IsNum(s){//判断是否是数字
	if(s!=null && s!=""){
		return !isNaN(s);
	}
	return false;
}
/*
"^\d+$"　　//非负整数（正整数 + 0）
"^[0-9]*[1-9][0-9]*$"　　//正整数 
"^((-\\d+)|(0+))$"　　//非正整数(负整数 + 0)
"^-[0-9]*[1-9][0-9]*$"　　//负整数
"^-?\\d+$"　　　　//整数
"^\\d+(\\.\\d+)?$"　　//非负浮点数（正浮点数 + 0） 
"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$"　//正浮点数
"^((-\\d+(\\.\\d+)?)|(0+(\\.0+)?))$"　　//非正浮点数（负浮点数 + 0）
"^(-(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*)))$"//负浮点数
"^(-?\\d+)(\\.\\d+)?$"　　//浮点数*/
function IsInteger(str){
	var r = /^\d+$/;　　//正整数+0
	return r.test(str); //str为你要判断的字符 执行返回结果 true 或 false
}
function Add(url){
	if(arguments.length==1){
		document.myForm.action=url;
		document.myForm.submit();
	}
}
//编辑
function Edit(url){
	//这里需要判断，如果选中了多于一条记录的情况，则提示用户，只能编辑一条数据。
	var num=document.myForm.num.value;
	var ids="";
	for(var i=1;i<num;i++){
		if(document.myForm("xh"+i).checked){
			ids=ids+document.myForm("xh"+i).value+",";
		}
	}
	//如果ids不是空，则去掉后面的一个,
	if(ids!=""){
		//需要注意的是 字符串的长度应该是length，没有括号
		ids=ids.substring(0,ids.length-1);
	}
	if(ids.indexOf(",")!=-1){
		alert("只能选择一条记录进行编辑!");
		return;
	}
	//定义是否选择记录的标志
	var isChoose=false;
	for(var i=1;i<num;i++){
		if(document.myForm("xh"+i).checked){
			isChoose=true;
			document.myForm.action=url+"?id="+document.myForm("xh"+i).value;
			document.myForm.submit();
		}
	}
	if(!isChoose){
		window.alert("请先选择要编辑的记录!");
	}
}
//日期格式：YYYY-MM-DD
function isdate(strDate){
	if(strDate.length!=10){return false;}
	var strSeparator="-"; //日期分隔符
	var strDateArray;
	var intYear;
	var intMonth;
	var intDay;
	var boolLeapYear;
	strDateArray = strDate.split(strSeparator);
	if(strDateArray.length!=3) return false;   
	intYear = parseInt(strDateArray[0],10);
	intMonth = parseInt(strDateArray[1],10);
	intDay = parseInt(strDateArray[2],10);
	
	if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) return false;
	if(intMonth>12||intMonth<1) return false;
	if((intMonth==1||intMonth==3||intMonth==5||intMonth==7||intMonth==8||intMonth==10||intMonth==12)&&(intDay>31||intDay<1)) return false;
	if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30||intDay<1)) return false;
	if(intMonth==2){
	if(intDay<1) return false;
	boolLeapYear = false;
	if((intYear%100)==0){
	if((intYear%400)==0) boolLeapYear = true;
	}else{
	if((intYear%4)==0) boolLeapYear = true;
	}
	if(boolLeapYear){
	if(intDay>29) return false;
	}else{
	if(intDay>28) return false;
	}
	}
	return true;
}
//判断输入框中输入的日期格式是否为年月日时分秒 即 yyyy-mm-dd hh:mi:ss
function istime(dateString){
	if(dateString=="")return false;
	//年月日时分秒正则表达式
	var r=dateString.match(/^(\d{1,4})\-(\d{1,2})\-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/); 
	if(r==null){
		//alert("请输入格式正确的日期\n\r日期格式：yyyy-mm-dd\n\r例    如：2008-08-08\n\r");
		return false;
	}
	var d=new Date(r[1],r[2]-1,r[3],r[4],r[5],r[6]);     
	var num = (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[2]&&d.getDate()==r[3]&&d.getHours()==r[4]&&d.getMinutes()==r[5]&&d.getSeconds()==r[6]);
	if(num==0){
		//alert("请输入格式正确的日期\n\r日期格式：yyyy-mm-dd\n\r例    如：2008-08-08\n\r");
	}
	return (num!=0);
}
//2011-09-25需要增加一个重载函数，因为要进行表单数据的验证。
function Save(url,formatstr){
	if(arguments.length==1){
		if(window.confirm("是否确认数据准确无误？")){
			window.myForm.action=url;
			window.myForm.submit();
		}
	}else if(arguments.length==2){//如果带有三个字符串，需要进行验证。
		fArray=formatstr.split(";");//总共有多少个文本域需要验证
		for(var i=0;i<fArray.length;i++){
			var each=fArray[i].split(",");
			var inputid=each[0];//输入的ID
			var format=each[1];//格式字符串
			var caption=each[2];//标题内容
			if(format=="NUM"){
				if(!IsNum(document.getElementById(inputid).value)){
					alert("请输入"+caption+",格式为数字!");
					document.getElementById(inputid).select();
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="IFNUM"){
				//可以为空，如果不为空，就必须为数字。  2011-10-12 张培颖
				if(document.getElementById(inputid).value!=""){
					if(!IsNum(document.getElementById(inputid).value)){
						alert(caption+"的格式为数字!");
						document.getElementById(inputid).select();
						document.getElementById(inputid).focus();
						return;
					}
				}
			}else if(format=="NOTNULL"){//不允许为空
				if(document.getElementById(inputid).value==""){
					alert(caption+"为必填项!请输入"+caption+"!");	
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="INT"){
				//是否为正整数
				if(!IsInteger(document.getElementById(inputid).value)){
					alert(caption+"必须输入正整数!");
					document.getElementById(inputid).select();
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="SELECT"){//必须选择的项
				//是否选择了数据
				if(document.getElementById(inputid).value==""){
					alert("必须选择"+caption+"!");
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="DATE"){//日期验证格式是否正确
				//是否选择日期
				if(!isdate(document.getElementById(inputid).value)){
					alert("必须选择或输入"+caption+"!");
					document.getElementById(inputid).select();
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="TIME"){//日期验证格式是否正确
				//是否选择日期
				if(!istime(document.getElementById(inputid).value)){
					alert("必须选择"+caption+"!");
					document.getElementById(inputid).select();
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="DOC"){//只能是doc类型的文档
				//只能上传word文档
				if(document.getElementById(inputid).value.substr(document.getElementById(inputid).value.lastIndexOf(".")).toLowerCase()!=".doc"){
					alert("只能上传doc类型的文档，请重新选择文件!");
					document.getElementById(inputid).select();
					document.getElementById(inputid).focus();
					return;
				}
			}else if(format=="IFDOC"){//如果有，则只能是doc类型的文档
				if(document.getElementById(inputid).value!=""){//如果上传了，则就需要做限制
					if(document.getElementById(inputid).value.substr(document.getElementById(inputid).value.lastIndexOf(".")).toLowerCase()!=".doc"){
						alert("只能上传doc类型的文档，请重新选择文件!");
						document.getElementById(inputid).select();
						document.getElementById(inputid).focus();
						return;
					}
				}
			}
		}
		//验证完毕，提示用户确认数据是否正确。
		if(window.confirm("是否确认数据准确无误？")){
			window.myForm.action=url;
			window.myForm.submit();
		}
	}
}
//所有的删除函数均调用这一个函数，如果有多个参数，只是函数重载的问题。
function Del(){
	//计算要删除的集合
	var count=document.myForm.num.value;
	var ids="";
	var rows="";
	for(var i=1;i<count;i++){
		if(document.myForm("xh"+i).checked){
			ids=ids+document.myForm("xh"+i).value+",";
			rows=rows+i+",";
		}
	}
	//如果ids不是空，则去掉后面的一个,
	if(ids!=""){
		//需要注意的是 字符串的长度应该是length，没有括号
		ids=ids.substring(0,ids.length-1);
	}
	if(rows!=""){
		//需要注意的是 字符串的长度应该是length，没有括号
		rows=rows.substring(0,rows.length-1);
	}
	if(ids==""){
		alert("请您选择要删除的记录~~~");
	}else{
		//提示，你确实要删除  提示
		if(window.confirm("你确实要删除第"+rows+"行？")){
			//提交至删除页面
			if(arguments.length==1){//只有一个参数
				var url=arguments[0];
				window.myForm.action=url+"?id="+ids;
				window.myForm.submit();
			}else if(arguments.length==2){//含有两个参数
				var url=arguments[0];
				var page=arguments[1];
				window.myForm.action=url+"?id="+ids+"&page="+page;
				window.myForm.submit();
			}
		}
	}
}
//全选
function SellAll(){
	//首先，取出选择的ID
	var num=document.myForm.num.value;
	//alert(num);
	//对每一个选择的ID进行
	for(var i=1;i<num;i++){
		document.myForm("xh"+i).checked=true;
	}
}
//全选
function InvertAll(){
	//首先，取出选择的ID
	var num=document.myForm.num.value;
	//对每一个选择的ID进行
	for(var i=1;i<num;i++){
		document.myForm("xh"+i).checked=!document.myForm("xh"+i).checked;
	}
}