<!doctype html><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import="edu.bupt.display.ShowFormat"%>
<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@page import="edu.bupt.soft.OrientationCompute"%>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script type="text/javascript" src="../js/validate.js"></script>
<script src="../echarts-2.2.7/build/dist/echarts.js"></script>
</head>
<%
String weiboId=dt.toUTF(request.getParameter("weiboid"));
String result="";
	final int count = 12;
	double score = 0;
	String blog = null;
if(!weiboId.equals("")){
	ResultSet rs = new SelectOperation().selectContent(weiboId, conn, count);
	if(rs!=null){
		while(rs.next()){
			blog = rs.getString("content");
			score += new OrientationCompute().calcDSOofBlog2(blog);
		} 
	}
}
result = ShowFormat.showFormat(score/count);
%>
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
                'echarts/chart/gauge' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                		 tooltip : {
                		        formatter: "{a} <br/>{b} : {c}"
                		    },
                		    series : [
                		        {
                		            name:'<%="xxxxx"%>',
                		            type:'gauge',
                		            center : ['50%', '50%'],    // 默认全局居中
                		            radius : [0, '85%'],
                		            startAngle: 140,
                		            endAngle : -140,
                		            min: -1,                     // 最小值
                		            max: 1,                   // 最大值
                		            precision: 0,               // 小数精度，默认为0，无小数点
                		            splitNumber: 10,             // 分割段数，默认为5
                		            axisLine: {            // 坐标轴线
                		                show: true,        // 默认显示，属性show控制显示与否
                		                lineStyle: {       // 属性lineStyle控制线条样式
                		                	color: [[0.2, '#ff4500'],[0.4, 'orange'],[0.6, 'gold'],[0.8, 'turquoise'],[1, 'lightgreen']],  
                		                    width: 30
                		                }
                		            },
                		            axisTick: {            // 坐标轴小标记
                		                show: true,        // 属性show控制显示与否，默认不显示
                		                splitNumber: 5,    // 每份split细分多少段
                		                length :8,         // 属性length控制线长
                		                lineStyle: {       // 属性lineStyle控制线条样式
                		                    color: '#eee',
                		                    width: 1,
                		                    type: 'solid'
                		                }
                		            },
                		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
                		                show: true,
                		                formatter: function(v){
                		                    switch (v+''){
                		                    	case '-1': return '最高(-1.0)';
                		                        case '-0.8': return '高(-0.8)';
                		                        case '-0.4': return '较高(-0.4)';
                		                        case '0': return '中(0)';
                		                        case '0.4': return '较低(0.4)';
                		                        case '0.8': return '低(0.8)';
                		                        case '1': return '最低(1.0)';
                		                        //default: return '';
                		                    }
                		                },
                		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                		                    color: '#333'
                		                }
                		            },
                		            splitLine: {           // 分隔线
                		                show: true,        // 默认显示，属性show控制显示与否
                		                length :30,         // 属性length控制线长
                		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                		                    color: '#eee',
                		                    width: 2,
                		                    type: 'solid'
                		                }
                		            },
                		            pointer : {
                		                length : '80%',
                		                width : 8,
                		                color : 'auto'
                		            },
                		            title : {
                		                show : true,
                		                offsetCenter: ['-65%', -10],       // x, y，单位px
                		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                		                    color: '#333',
                		                    fontSize : 15
                		                }
                		            },
                		            detail : {
                		                show : true,
                		                backgroundColor: 'rgba(0,0,0,0)',
                		                borderWidth: 0,
                		                borderColor: '#ccc',
                		                width: 100,
                		                height: 40,
                		                offsetCenter: ['-60%', 10],       // x, y，单位px
                		                formatter:'{value}',
                		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                		                    color: 'auto',
                		                    fontSize : 30
                		                }
                		            },
                		            data:[{value: <%=result%>, name: '情感危险等级'}]
                		        }
                		    ]
                   
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博舆情等级查询</div></td>
    </tr>
    <tr><td>
    微博账号：<input type="text" name="weiboid" value="<%=weiboId%>">
    危险等级：
    <select name="rank">
    <option value="">等级</option>
    <option value="高">高</option>
    <option value="中">中</option>
    <option value="低">低</option>
    </select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询" onClick="chaxun();">
    </td></tr>
    <tr>
        <td>
        	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>