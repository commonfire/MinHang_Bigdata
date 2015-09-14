
//使用ajax进行远程服务器条目删除请求，并对返回的结果进行处理
function getItemLevel(id){
	var xmlhttp = createXMLHTTP();
	var ID=String(id);
	xmlhttp.open("POST", "detail_list.jsp", true);
//	xmlhttp.onreadystatechange=function(){	
//		if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
//			var result=xmlhttp.responseText.replace(/[\r\n]/g,"");  //去除回车换行
//			alert(result);		
//		}
//	};
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("id="+ID);
}

//生成ajax连接
function createXMLHTTP(){
	var xmlHttp=null;
	if (window.XMLHttpRequest) {
		xmlHttp= new XMLHttpRequest();	
	}else{
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}		
	return xmlHttp;
}