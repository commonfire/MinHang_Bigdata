<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>  
<%@page import="java.util.Map.*"%>   
<%@page import="edu.bupt.display.RepostCircle"%>
<%@ include file="../inc/conn.jsp"%>
 
    
<%
     HashMap<String, HashMap<String, Integer>> outer_map = new HashMap<String, HashMap<String, Integer>>();
     outer_map = new RepostCircle().getTopRepostUser("2728266823",5,conn);
     HashMap<String, Integer> inner_map = outer_map.get("2728266823");
//     System.out.println(inner_map);
     String[] repostuser = new String[5];
     Integer[] repostcounter = new Integer[5];
     Integer i = 0;
     for(String user:inner_map.keySet()){
     	if (i<5){
     		repostuser[i] = user ;
     		repostcounter[i] = inner_map.get(user);
     		i++;
     	}else break;
     	
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
                			        text: '微博转发用户关系',
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
                			        data:['微博转发用户']
                			    },
                			    series : [
                			        {
                			            type:'force',
                			            name : "微博转发用户关系",
                			            ribbonType: false,
                			            categories : [
                			                {
                			                    name: '主人物'
                			                },
                			                {
                			                    name: '微博转发用户'
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
                			                {category:0, name: '东哥byr'+'（主用户）', value : 10, label: '东哥byr\n（主用户）'},
                			                {category:1, name: '<%=repostuser[0]%>',value : <%=repostcounter[0]%>},
                			                {category:1, name: '<%=repostuser[1]%>',value : <%=repostcounter[1]%>},
                			                {category:1, name: '<%=repostuser[2]%>',value : <%=repostcounter[2]%>},
                			                {category:1, name: '<%=repostuser[3]%>',value : <%=repostcounter[3]%>},
                			                {category:1, name: '<%=repostuser[4]%>',value : <%=repostcounter[4]%>},
                			            ],
                			            links : [
                			                {source : '<%=repostuser[0]%>', target : '东哥byr'+'（主用户）', weight : <%=repostcounter[0]%>, name: '<%=repostcounter[0]%>次'},
                			                {source : '<%=repostuser[1]%>', target : '东哥byr'+'（主用户）', weight : <%=repostcounter[1]%>, name: '<%=repostcounter[1]%>次'},
                			                {source : '<%=repostuser[2]%>', target : '东哥byr'+'（主用户）', weight : <%=repostcounter[2]%>, name: '<%=repostcounter[2]%>次'},
                			                {source : '<%=repostuser[3]%>', target : '东哥byr'+'（主用户）', weight : <%=repostcounter[3]%>, name: '<%=repostcounter[3]%>次'},
                			                {source : '<%=repostuser[4]%>', target : '东哥byr'+'（主用户）', weight : <%=repostcounter[4]%>, name: '<%=repostcounter[4]%>次'},
                			                
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