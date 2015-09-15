<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>  
<%@page import="java.util.Map.*"%>   
<%@page import="edu.bupt.display.AtuserCircle"%>
<%@ include file="../inc/conn_oracle.jsp"%> 
<%
	//String userID = request.getParameter("uid")!=null?request.getParameter("uid"):null;
	String userID = "3655612552";
	String mainUser = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	if(userID!=null){
//		ResultSet rs = SelectOperation.selectAlias(userID, conn);
//		if(rs!=null){
//			rs.next();
//			mainUser = rs.getString("userAlias");
//		}else{
//			mainUser = userID;
//		}
		mainUser = "北邮-民航";
		rs1 = SelectOperation.selectAtuser(userID,"5",conn);
		rs2 = SelectOperation.selectAtuser(userID,"5",conn);
	}
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div id="main" style="height:400px"></div>
</body>

<script src="echarts/build/dist/echarts.js"></script>
<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: 'echarts/build/dist'
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
                			                while(rs1.next()){
                			                	out.print("{category:1, name: '"+rs1.getString("ATUSER")+"',value :"+rs1.getString("TOTALNUMBER")+"},");
                			                }
                			                %>
                			            ],
                			            links : [
                			                 <%
                			                 while(rs2.next()){
                			                	 out.print("{source:'"+rs2.getString("ATUSER")+"',target:'"+mainUser+"（主用户）',weight:"+rs2.getString("TOTALNUMBER")+",name:'"+rs2.getString("TOTALNUMBER")+"次'},");
                			                 }
                			                 %>                			                  
                			                
                			            ]
                			        }
                			    ]

                };
                 
                myChart.setOption(option); // 为echarts对象加载数据
                var ecConfig = require('echarts/config');
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