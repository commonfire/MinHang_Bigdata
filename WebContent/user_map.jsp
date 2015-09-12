<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>  
<%@page import="edu.bupt.display.UserMap"%>
<%@ include file="../inc/conn_oracle.jsp"%>

<%
    HashMap<String,Integer> usermap = new HashMap<String, Integer>();
	usermap = new UserMap().getUserGeoInfo("",69,conn);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="main" style="height:800px"></div>
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
                'echarts/chart/map', // 按需加载模块
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                	    title : {
                	        text: '新浪微博用户全国分布图',
                	        subtext: '来自新浪微博数据',
                	        x:'center'
                	    },
                	    tooltip : {
                	        trigger: 'item'
                	    },
                	    legend: {
                	        orient: 'vertical',
                	        x:'left',
                	        data:['微博用户数']
                	    },
                	    dataRange: {
                	        min: 0,
                	        max: 20,                  //坐标范围
                	        x: 'left',
                	        y: 'bottom',
                	        text:['高','低'],           // 文本，默认为数值文本
                	        calculable : true
                	    },
                	    toolbox: {
                	        show: true,
                	        orient : 'vertical',
                	        x: 'right',
                	        y: 'center',
                	        feature : {
                	            mark : {show: true},
                	            dataView : {show: true, readOnly: false},
                	            restore : {show: true},
                	            saveAsImage : {show: true}
                	        }
                	    },
                	    roamController: {
                	        show: true,
                	        x: 'right',
                	        mapTypeControl: {
                	            'china': true
                	        }
                	    },
                	    series : [
                	        {
                	            name: '微博用户数',
                	            type: 'map',
                	            mapType: 'china',
                	            roam: false,
                	            itemStyle:{
                	                normal:{label:{show:true}},
                	                emphasis:{label:{show:true}}
                	            },
                	            data:[
                	                  {name: '北京',value: <%=usermap.get("北京")==null?0:usermap.get("北京")%>},
                	                  {name: '天津',value: <%=usermap.get("天津")==null?0:usermap.get("天津")%>},
                	                  {name: '上海',value: <%=usermap.get("上海")==null?0:usermap.get("上海")%>},
                	                  {name: '重庆',value: <%=usermap.get("重庆")==null?0:usermap.get("重庆")%>},
                	                  {name: '河北',value: <%=usermap.get("河北")==null?0:usermap.get("河北")%>},
                	                  {name: '河南',value: <%=usermap.get("河南")==null?0:usermap.get("河南")%>},
                	                  {name: '云南',value: <%=usermap.get("云南")==null?0:usermap.get("云南")%>},
                	                  {name: '辽宁',value: <%=usermap.get("辽宁")==null?0:usermap.get("辽宁")%>},
                  	                  {name: '黑龙江',value: <%=usermap.get("黑龙江")==null?0:usermap.get("黑龙江")%>},
                  	                  {name: '湖南',value: <%=usermap.get("湖南")==null?0:usermap.get("湖南")%>},
                  	                  {name: '安徽',value: <%=usermap.get("安徽")==null?0:usermap.get("安徽")%>},
                  	                  {name: '山东',value: <%=usermap.get("山东")==null?0:usermap.get("山东")%>},
                  	                  {name: '新疆',value: <%=usermap.get("新疆")==null?0:usermap.get("新疆")%>},
                  	                  {name: '江苏',value: <%=usermap.get("江苏")==null?0:usermap.get("江苏")%>},
                  	                  {name: '浙江',value: <%=usermap.get("浙江")==null?0:usermap.get("浙江")%>},
                  	                  {name: '江西',value: <%=usermap.get("江西")==null?0:usermap.get("江西")%>},
                  	                  {name: '湖北',value: <%=usermap.get("湖北")==null?0:usermap.get("湖北")%>},
                  	                  {name: '广西',value: <%=usermap.get("广西")==null?0:usermap.get("广西")%>},
                  	                  {name: '甘肃',value: <%=usermap.get("甘肃")==null?0:usermap.get("甘肃")%>},
                  	                  {name: '山西',value: <%=usermap.get("山西")==null?0:usermap.get("山西")%>},
                  	                  {name: '内蒙古',value: <%=usermap.get("内蒙古")==null?0:usermap.get("内蒙古")%>},
                  	                  {name: '陕西',value: <%=usermap.get("陕西")==null?0:usermap.get("陕西")%>},
                  	                  {name: '吉林',value: <%=usermap.get("吉林")==null?0:usermap.get("吉林")%>},
                  	                  {name: '福建',value: <%=usermap.get("福建")==null?0:usermap.get("福建")%>},
                  	                  {name: '贵州',value: <%=usermap.get("贵州")==null?0:usermap.get("贵州")%>},
                  	                  {name: '广东',value: <%=usermap.get("广东")==null?0:usermap.get("广东")%>},
                  	                  {name: '青海',value: <%=usermap.get("青海")==null?0:usermap.get("青海")%>},
                  	                  {name: '西藏',value: <%=usermap.get("西藏")==null?0:usermap.get("西藏")%>},
                  	                  {name: '四川',value: <%=usermap.get("四川")==null?0:usermap.get("四川")%>},
                  	                  {name: '宁夏',value: <%=usermap.get("宁夏")==null?0:usermap.get("宁夏")%>},
                  	                  {name: '海南',value: <%=usermap.get("海南")==null?0:usermap.get("海南")%>},
                  	                  {name: '台湾',value: <%=usermap.get("台湾")==null?0:usermap.get("台湾")%>},
                  	                  {name: '香港',value: <%=usermap.get("香港")==null?0:usermap.get("香港")%>},
                  	                  {name: '澳门',value: <%=usermap.get("澳门")==null?0:usermap.get("澳门")%>}
                	            ]
                	        }
                	    ]
                	};
  
                myChart.setOption(option); // 为echarts对象加载数据
            }
        );
    </script>
</html>
<%@ include file="../inc/conn_close.jsp"%>