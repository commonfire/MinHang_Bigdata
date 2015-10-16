<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map.*"%>
<%@ page import="edu.bupt.display.AtuserCircle"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ include file="../inc/conn.jsp"%> 
<%
	String userID = request.getParameter("uid")!=null?request.getParameter("uid"):"";//weibo uid
	String mainUser = null;//nickname 
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	if(!userID.equals("")){
		ResultSet rs = SelectOperation.selectAlias(userID, conn);
		if(rs.next()){
			mainUser = rs.getString("userAlias");
		}else{
			mainUser = userID;
		}
		session.setAttribute("userID", userID);
		rs1 = SelectOperation.selectAtuser(userID,"5",conn);
		rs2 = SelectOperation.selectAtuser(userID,"5",conn);
	}else{
		mainUser = "";
		session.setAttribute("userID", "");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<title>微博账号人物关系分析</title>
</head>
<body>
	<form name="myForm" method="post" action="">
	<table align="center" width="80%" border="0">
		<tr>
    		<td height="50"><div align="center" class="tableTitle">微博账号人物关系分析</div></td>
    	</tr>
    	<tr><td>
    		微博账号：<input type="text" name="uid" value=<%=session.getAttribute("userID") %>>
    		<input type="button" name="cmdQuery" class="btn_2k3" value="查询" onClick="atuserSearch();">
    	</td></tr>
    	<tr><td>
    		<div id="main" style="height:400px"></div>
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
                			        //data:['家人','朋友']
                			        data:['微博@用户']
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
                			                    name: '微博@用户'
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
                			                        //r: 30
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
                			                {category:0, name: '<%=mainUser%>'+'（主用户）', value : 10, label: '<%=mainUser%>'+'\n（主用户）'},
                			                <%
                			                if(rs1!=null){
	                			                while(rs1.next()){
	                			                	out.print("{category:1, name: '"+rs1.getString("ATUSER")+"',value :"+rs1.getString("TOTALNUMBER")+"},");
	                			                }
                			                }
                			                %>
                			            ],
                			            links : [
                			                 <%
                			                 if(rs2!=null){
	                			                 while(rs2.next()){
	                			                	 out.print("{source:'"+rs2.getString("ATUSER")+"',target:'"+mainUser+"（主用户）',weight:"+rs2.getString("TOTALNUMBER")+",name:'"+rs2.getString("TOTALNUMBER")+"次'},");
	                			                 }
                			                 }
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