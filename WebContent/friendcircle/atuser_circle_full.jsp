<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>  
<%@ page import="java.util.Map.*"%>   
<%@ page import="java.util.*"  %>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="edu.bupt.basefunc.basicFun" %>>
<%@ page import="edu.bupt.display.AtuserCircle"%>
<%@ page import="edu.bupt.display.ExecuteShell"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ include file="../inc/conn.jsp"%> 
<%
	String userID = request.getParameter("uid")!=null?request.getParameter("uid"):"";
	String mainUser = request.getParameter("alias")!=null?request.getParameter("alias"):"";
	JSONObject jsonObjAll = new JSONObject();
	JSONObject cateObject = new JSONObject();
	
	//String allCate = "USERID,USERALIAS,LOCATION,SEX,BRIEF";
	//String cateChinese = "用户ID,昵称,住址,性别,简介";
	String allCate = "USERID,USERALIAS,LOCATION,SEX,BIRTHDAY,BRIEF,DOMAIN,BLOG";
	String cateChinese = "用户ID,昵称,住址,性别,生日,简介,个人域名,博客";
	String[] cateList = allCate.split(",");
	String[] cateChineseList=cateChinese.split(",");
	HashMap<String,String> userInfoCateMap = new HashMap<String,String>();
	userInfoCateMap = basicFun.cateMapBuild(cateList,cateChineseList);
	session.setAttribute("userID", userID);
	ResultSet rs1 = null;
	HashMap<String,ArrayList<HashMap<String,String>>> realationMap = null;
	HashMap<String,String>  userMap = null;   //用户昵称与相应at总数(totalNumber)
	HashMap<String,Integer> userCate = null;  //用户颜色节点等级
	HashMap<String,HashMap<String,String>>  usrInfoMap  = null;
	String strInfo  = null;
	
	HashMap<String,String> id_name_map = new HashMap<String,String>();
	ArrayList<String> idFinalArray = new ArrayList<String>();
	
	if(!userID.equals("")){
		//如果主用户信息没有爬取，则爬取主用户信息
		if(mainUser.equals("")){
			ResultSet rs = SelectOperation.selectAlias(userID, conn);
			if(rs!=null){
				rs.next();
				mainUser = rs.getString("userAlias");
			}
		}
		if(!SelectOperation.containsField("userID", userID, "t_user_weibocontent_atuser", conn)){
			System.out.println("!!!!!!"+userID);
			ExecuteShell.executeShell(userID,"weibocontent_userinfo");	//爬取用户第一层关系
			while(true){
					int searchstate = SelectOperation.selectEndState("contentstate",conn);
					if(searchstate==1) break;	
			}
			UpdateOperation.updateEndState("contentstate");
		}

		rs1 = SelectOperation.selectAtuser(userID,"5",conn);  //从数据库中获取用户第二层关系

		realationMap = new HashMap<String,ArrayList<HashMap<String,String>>>();		
		userMap  = new HashMap<String,String>();
		userCate = new HashMap<String,Integer>();  
		usrInfoMap  = new HashMap<String,HashMap<String,String>>();  
		ArrayList<HashMap<String,String>> list1 = new ArrayList<HashMap<String,String>>();
		realationMap.put(mainUser,list1); 		
		basicFun.expandInfoMap(usrInfoMap, userID, cateList, mainUser, conn);
		
		if(rs1!=null){
			while(rs1.next()){
				String atuserID = rs1.getString("ATUSERID");
				String name1  = rs1.getString("ATUSER");
				String number = rs1.getString("TOTALNUMBER");
				if(!userMap.containsKey(name1) || userCate.get(name1)!=1) {
					userCate.put(name1,1);
					userMap.put(name1,number);
				}					
					
				if(!SelectOperation.containsField("userID", atuserID, "t_user_weibocontent_atuser", conn)){
					System.out.println(rs1.getString("atuserID")+":"+rs1.getString("atuser"));
					ExecuteShell.executeShell(rs1.getString("atuserID"),"weibocontent_userinfo"); //爬取用户第二层关系
					while(true){
						int contentstate = SelectOperation.selectEndState("contentstate",conn);
						if(contentstate==1) break;			
					}
					UpdateOperation.updateEndState("contentstate");
				}
				basicFun.expandRelationMap(realationMap, mainUser, name1, number);
				ResultSet rsinfotemp = SelectOperation.selectUserinfo(atuserID, conn);				
				basicFun.expandInfoMap(usrInfoMap, cateList, name1, rsinfotemp);			
				ResultSet rsTemp = SelectOperation.selectAtuser(atuserID,"5",conn);
				if(rsTemp!=null){
					while(rsTemp.next()){
						String thirdLayerUid = rsTemp.getString("ATUSERID") ;
						String atuser = rsTemp.getString("ATUSER");
						String number1 = rsTemp.getString("TOTALNUMBER");
						//ResultSet rsinfotempThird = SelectOperation.selectUserinfo(secondLayerUid, conn);	
						HashMap<String,String> mapTemp1 = new HashMap<String,String>();
						mapTemp1.put(atuser,number1);
						if(!userCate.containsKey(atuser)){
							userCate.put(atuser,2);						
						}
						
						userMap.put(atuser,number1);
						if(!realationMap.containsKey(atuser)){  //the important code!
							realationMap.get(name1).add(mapTemp1);
						}
						if(!usrInfoMap.containsKey(atuser)){
							id_name_map.put(thirdLayerUid,atuser);
							idFinalArray.add(thirdLayerUid);
						}
						/* 
						if(!usrInfoMap.containsKey(atuser)){
							basicFun.expandInfoMap(usrInfoMap, thirdLayerUid, cateList, atuser, conn);
						} */
					}
				}
			}			
		}
		
			String idFinalString = idFinalArray.toString();
		    idFinalString = idFinalString.replaceAll("\\s","");
			/* System.out.println("********"+idFinalString);
 			ExecuteShell.executeShell(idFinalString,"userinfo_list"); //爬取用户第三层关系
			while(true){
				int userinfostate = SelectOperation.selectEndState("userinfostate",conn);
				if(userinfostate==1) break;			
			}
			UpdateOperation.updateEndState("userinfostate");  */

		for(String id : idFinalArray){
			 basicFun.expandInfoMap(usrInfoMap, id, cateList, id_name_map.get(id), conn);
		 }   
		
/* 		String[] abc= {"2319864160"};
		for(String id : abc){
			 basicFun.expandInfoMap(usrInfoMap, id, cateList, id_name_map.get(id), conn);
		 }   */
		
		 cateObject = basicFun.MapToJSONObj(userInfoCateMap);
		 jsonObjAll = basicFun.MapToJSONObj(usrInfoMap);	
		// System.out.println(usrInfoMap);
		
	}
%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<link rel="stylesheet" href="../css/jquery.webui-popover.min.css" type="text/css"/>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../js/json2.js"></script>
<script type="text/javascript" src="../js/zfunc.js"></script>
<title>用户微博人物关系分析</title>
</head>
<body>
	<form name="myForm" method="post" action="">
	<div id="tableContent" style="display:block;width:300px;position:absolute; top:50%; left:50%;"></div>
	<table align="center" width="80%" border="0">
		<tr>
    		<td height="50"><div align="center" class="tableTitle"><%=mainUser%>用户微博人物关系分析</div></td>
		</tr>
    	<tr><td>
    		微博账号：<input type="text" name="uid" value=<%=session.getAttribute("userID") %>>
    		<input type="button" name="cmdQuery" class="btn_2k3" value="查询" onClick="atuserSearch();">
    	</td></tr>
    	<tr><td>
    		<div id="main" style="height:500px"></div>
    	</td></tr>
	</table>
	</form>
</body>

<script language="javascript">
		function atuserSearch(){
			document.myForm.action="";
			document.myForm.submit();
		}
		
</script>



<script src="../echarts-2.2.7/build/dist/echarts.js"></script>
<script type="text/javascript">

        // 路径配置
        require.config({
            paths: {
                echarts: '../echarts-2.2.7/build/dist'
            }
        });
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/force', // 按需加载模块
                'echarts/chart/chord'
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                			    title : {
                			        text: '微博@用户关系',
                			        subtext: '数据来自新浪微博',
                			        x:'right',
                			        y:'bottom'
                			    },
                			    tooltip : {
                			        trigger: 'item',
                			        formatter: '{a} : {b}'
                			    },
                			    toolbox: {
                			        show : true,
                			        feature : {
                			            restore : {show: true},
                			            magicType: {show: true, type: ['force', 'chord']},
                			        }
                			    },
                			    legend: {
                			        x: 'left',
                			        data:['微博一级@用户','微博二级@用户']
                			    },
                			    series : [
                			        {
                			            type:'force',
                			            name : "微博@用户关系",
                			            ribbonType: false,
                			            categories : [
                			                {
                			                    name: '主人物'
                			                },
                			                {
                			                    name: '微博一级@用户'
                			                },
                			                {
                			                    name: '微博二级@用户'
                			                }
                			            ],
                			            itemStyle: {
                			                normal: {
                			                    label: {
                			                        show: true,
                			                        textStyle: {
                			                            color: '#333'
                			                        }
                			                    },
                			                    nodeStyle : {
                			                        brushType : 'both',
                			                        borderColor : 'rgba(255,215,0,0.4)',
                			                        borderWidth : 1
                			                    },
                			                    linkStyle: {
                			                        type: 'curve'
                			                    }
                			                },
                			                emphasis: {
                			                    label: {
                			                        show: false
                			                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                			                    },
                			                    nodeStyle : {
                			                        //r: 100
                			                    },
                			                    linkStyle : {}
                			                }
                			            },
                			            useWorker: false,
                			            minRadius : 20,
                			            maxRadius : 30,
                			            gravity: 1.1,
                			            scaling: 1.1,
                			            roam: 'move',
                			            nodes:[
												{category:0,name: '<%=mainUser%>',value :6},
                			                <%
//                 			                while(rs1.next()){
//                 			                	out.print("{category:1, name: '"+rs1.getString("ATUSER")+"',value :"+rs1.getString("TOTALNUMBER")+"},");	
//                  			                }
											if(userMap!=null){
													Set<String> nameset = userMap.keySet();
													for(String name : nameset){
														String number = userMap.get(name);
														out.print("{category:"+userCate.get(name)+",name: '"+name+"',value :"+number+"},");
														//System.out.println("{category:"+userCate.get(name)+",name: '"+name+"',value :"+number+"},");
													}
											}else{System.out.println("No users!!!");}
                			                %>
                			            ],
                			            links : [
                			                 <%
//                 			                 while(rs2.next()){
//                 			                	 out.print("{source:'"+rs2.getString("ATUSER")+"',target:'"+mainUser+"（主用户）',weight:"+rs2.getString("TOTALNUMBER")+",name:'"+rs2.getString("TOTALNUMBER")+"次'},");
//                 			                 }
                			              if(realationMap!=null){
	                			                 Set<String> keySet = realationMap.keySet();
	                			                 for(String key : keySet){
	                			                	 ArrayList<HashMap<String,String>> list = realationMap.get(key);
	                			                	 for(HashMap<String,String>  maptemp : list){
	                			                		String name = maptemp.keySet().iterator().next();
	                			                	 	//out.print("{source:'"+name+"',target:'"+key+"',weight:"+maptemp.get(name)+",name:'"+maptemp.get(name)+"次'},");	
	                			                	 	out.print("{source:'"+name+"',target:'"+key+"',weight:"+maptemp.get(name)+",name:'"+maptemp.get(name)+"次'"+",itemStyle:{normal:{width:"+maptemp.get(name)+"}}"+"},");	
	                			                	 	//System.out.println("{source:"+name+",target: '"+key+"',weight :"+userMap.get(name)+"},");
	                			                	 }
	                			                 }
											}//else{System.out.println("No Users!!!");}
                			                 %>                			                                 			                
                			            ]
                			        }
                			    ]

                };
                 
                myChart.setOption(option); // 为echarts对象加载数据
                var ecConfig = require('echarts/config');
                var jsonObj = <%=jsonObjAll%>           
                var cateObj =<%=cateObject%>
                var infoJson =JSON.stringify(jsonObj);
                console.log(infoJson);
                //var jsonObj2 = jsonObj["北邮-民航"];
                //console.log(jsonObj2["SEX"].toString());
                //var jsonString2 = JSON.stringify(jsonObj2);
                //console.log(jsonString2);
                var catelist1 = '<%=allCate%>'
                var cateArray = catelist1.split(",");
                var catenum = cateArray.length;
              
                function show(usrName){
        		 	var table = document.getElementById('tableContent');
        		 	if(table.style.display=='block' & table.getAttribute('usrName') == usrName){
        		 		table.setAttribute('style',"display:none;width:300px;position:relative; top:30%; left:10%;");		 		
        		 	}else{
        		 		var name  = 'CateName'
        		 		var value = 'Value'     		 		
        		 		var content = document.getElementById('tableContent').innerHTML;
        		 		table.setAttribute('usrName', usrName)        		 		
        		 		content="<table class="+"'table'"+"><thead><tr ><th>"+"基   本   信   息"+"</th></tr></thead><tbody>";        		 		       		 
        		 		for(var i =0 ;i<catenum;i++){
        		 			var cate1 = cateArray[i];
        		 			if(jsonObj[usrName][cate1]!=null ){
        		 				if(trim(jsonObj[usrName][cate1])!=""){
		        		 			var htmlStr = "<tr><td style='width:100px'>"+cateObj[cate1]+"："+"</td><td><B>"+jsonObj[usrName][cate1]+"</B></td></tr>";       		 			
		        		 			content = content + htmlStr;
        		 				}
        		 			}
        		 		}
        		 		content = content + "</tbody></table>";
        		        document.getElementById('tableContent').innerHTML=content;
        		        //console.log(table.getAttribute('uid'));	 		
        		 		table.setAttribute('style',"display:block;width:300px;position:absolute; top:30%; left:10%;");
        		 	}        		 	
        		 }
               
                function focus(param) {                	
                    var data = param.data;
                    var links = option.series[0].links;
                    var nodes = option.series[0].nodes;
                    if (
                        data.source !== undefined
                        && data.target !== undefined
                    ) { //点击的是边                   	
                        var sourceNode = nodes.filter(function (n) {return n.name == data.source})[0];
                        var targetNode = nodes.filter(function (n) {return n.name == data.target})[0];
                        console.log("选中了边 " + sourceNode.name + ' -> ' + targetNode.name + ' (' + data.weight + ')');
                    } else { // 点击的是点
                        console.log("选中了" + data.name + '(' + data.value + ')');
                    	
                    	show(data.name,catenum);
                    	var info = '<%=usrInfoMap%>';
                    	var uidlist = '<%=usrInfoMap.keySet()%>';
                    	/* console.log(uidlist);
                    	console.log("uuuuuuuuuuuuuuu"+uidlist.length);
                    	for(var id in uidlist){
                    		console.log("XXXXXXX"+uidlist[id]);                  
                    	}  */
                    	option.series[0].nodes.push({category:2,name: 'dsb',value :1});
                    	myChart.setOption(option); 
						console.log("123");
						console.log(option.series[0].nodes);
                    }
                }
                myChart.on(ecConfig.EVENT.CLICK, focus)
                myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
                    console.log(myChart.chart.force.getPosition());
                });
            }
        );
    </script>
</html>
<%@ include file="../inc/conn_close.jsp"%>