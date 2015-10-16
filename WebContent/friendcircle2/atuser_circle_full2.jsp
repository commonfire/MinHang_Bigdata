<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>  
<%@ page import="java.util.Map.*"%>   
<%@ page import="java.util.*"  %>
<%@ page import="edu.bupt.display.AtuserCircle"%>
<%@ page import="edu.bupt.display.ExecuteShell"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ include file="../inc/conn.jsp"%> 
<%
	String userID = request.getParameter("uid")!=null?request.getParameter("uid"):"";
	String mainUser = request.getParameter("alias")!=null?request.getParameter("alias"):"";
	session.setAttribute("userID", userID);
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	HashMap<String,ArrayList<HashMap<String,String>>> map = null;
	HashMap<String,String>  userSet = null;
	HashMap<String,Integer> userCate = null;
	if(!userID.equals("")){
		if(mainUser.equals("")){
			ResultSet rs = SelectOperation.selectAlias(userID, conn);
			if(rs!=null){
				rs.next();
				mainUser = rs.getString("userAlias");
			}
		}

		ExecuteShell.executeShell(userID,"keyweibocontent");	//爬取用户第一层关系
		while(true){
				int searchstate = SelectOperation.selectEndState("contentstate",conn);
				if(searchstate==1) break;	
		}
		UpdateOperation.updateEndState("contentstate");
		
		rs1 = SelectOperation.selectAtuser(userID,"5",conn);  //从数据库中获取用户第二层关系

		map = new HashMap<String,ArrayList<HashMap<String,String>>>();		
		userSet  = new HashMap<String,String>();
		userCate = new HashMap<String,Integer>();
		userSet.put(mainUser,"5");
		userCate.put(mainUser,0);
//		System.out.print(userCate.get(mainUser));
//		System.out.println(mainUser);
		ArrayList<HashMap<String,String>> list1 = new ArrayList<HashMap<String,String>>();
		map.put(mainUser,list1);		
		if(rs1!=null){
			while(rs1.next()){
				String atuserID = rs1.getString("ATUSERID");
				String name1  = rs1.getString("ATUSER");
				String number = rs1.getString("TOTALNUMBER");
//				System.out.println(userid+name1+number);
				if(!userSet.containsKey(name1) || userCate.get(name1)!=1) {userCate.put(name1,1);}
				userSet.put(name1,number);
				
				ArrayList<HashMap<String,String>> list2 = new ArrayList<HashMap<String,String>>();
				map.put(name1,list2);
				HashMap<String,String> mapTemp = new HashMap<String,String>();			
				mapTemp.put(name1,number);
//				System.out.println(map.get(mainUser));
				map.get(mainUser).add(mapTemp);
//	 			System.out.println(map.get(mainUser).get(0).keySet());
		
				System.out.println(rs1.getString("atuserID")+":"+rs1.getString("atuser"));
				ExecuteShell.executeShell(rs1.getString("atuserID"),"keyweibocontent"); //爬取用户第二层关系
				while(true){
					int contentstate = SelectOperation.selectEndState("contentstate",conn);
					if(contentstate==1) break;;			
				}
				UpdateOperation.updateEndState("contentstate");				

				ResultSet rsTemp = SelectOperation.selectAtuser(atuserID,"5",conn);
				if(rsTemp!=null){
					while(rsTemp.next()){
						String atuser = rsTemp.getString("ATUSER");
						String number1 = rsTemp.getString("TOTALNUMBER");
						HashMap<String,String> mapTemp1 = new HashMap<String,String>();
						mapTemp1.put(atuser,number1);
						if(!userCate.containsKey(atuser)){userCate.put(atuser,2);}
						
						userSet.put(atuser,number1);
						
						if(!map.containsKey(atuser)){			
							map.get(name1).add(mapTemp1);
						}
					}
				}
			}
			
		}
	}
%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<title>用户微博人物关系分析</title>
</head>
<body>
	<form name="myForm" method="post" action="">
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
											if(userSet!=null){
													Set<String> nameset = userSet.keySet();
													for(String name : nameset){
														String number = userSet.get(name);
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
                			              if(map!=null){
	                			                 Set<String> keySet = map.keySet();
	                			                 for(String key : keySet){
	                			                	 ArrayList<HashMap<String,String>> list = map.get(key);
	                			                	 for(HashMap<String,String>  maptemp : list){
	                			                		String name = maptemp.keySet().iterator().next();
	                			                	 	out.print("{source:'"+name+"',target:'"+key+"',weight:"+userSet.get(key)+",name:'"+userSet.get(key)+"次'},");
	                			                	 }
	                			                 }
											}//else{System.out.println("No Users!!!");}
                			                 %>                			                  
                			                
                			            ]
                			        }
                			    ]

                };
                 
                myChart.setOption(option); // 为echarts对象加载数据
                var ecConfig = require('../echarts-2.2.7/config');
              	
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