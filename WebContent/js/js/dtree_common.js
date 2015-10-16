function d1openTo(nId,check) {
		for (var n=0; n<d1.aNodes.length; n++) {
			if (d1.aNodes[n].id == nId) {
				nId=n;
				break;
			}
		}
	var cn=d1.aNodes[nId];
	document.all["menuck_"+d1.aNodes[nId].id].checked=check
	if (cn.pid==d1.root.id) return;	
	d1openTo(cn.pid, check);
}
//自己增加的函数
function selectChild(id,check){
	for (var n=0; n<d1.aNodes.length; n++) {
		if (d1.aNodes[n].pid == id ) {	
			document.all["menuck_"+d1.aNodes[n].id].checked=check
			selectChild(d1.aNodes[n].id,check);		
		}
	}
}
function setSelect(menuid){
	document.all["menuck_"+menuid].checked=! document.all["menuck_"+menuid].checked;	
	if(document.all["menuck_"+menuid].checked){
		d1openTo(menuid,document.all["menuck_"+menuid].checked);
        //调用写的脚本语言函数
		selectChild(menuid,document.all["menuck_"+menuid].checked);	
	}
	else d1closeAllChildren(menuid,document.all["menuck_"+menuid].checked);
}
function d1closeAllChildren(id,check){				
	for (var n=0; n<d1.aNodes.length; n++) {
		if (d1.aNodes[n].pid == id ) {	
			document.all["menuck_"+d1.aNodes[n].id].checked=check
			d1closeAllChildren(d1.aNodes[n].id,check);		
		}
	}
}
function d1openTo(nId,check){
	for(var n=0; n<d1.aNodes.length; n++){
		if(d1.aNodes[n].id == nId){
			nId=n;
			break;
		}
	}
	var cn=d1.aNodes[nId];
	document.all["menuck_"+d1.aNodes[nId].id].checked=check
	if(cn.pid==d1.root.id) return;	
	d1openTo(cn.pid, check);
}
//选中菜单
function selectmenu(menuid){
	document.myForm.selectmenu.value=menuid;
}