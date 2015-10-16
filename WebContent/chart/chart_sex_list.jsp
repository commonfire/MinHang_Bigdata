<!doctype html><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script src="../echarts-2.2.7/build/dist/echarts.js"></script>
<script src="../js/html5.js"></script>
<%
HashMap<String,String> map=new HashMap<String,String>();
ResultSet rs=stmt.executeQuery("select count(*) N,sex from T_USER_INFO group by sex");
while(rs.next()){
	map.put(rs.getString("SEX"),rs.getString("N"));
}
%>
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
		'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
	],
	function (ec) {
		// 基于准备好的dom，初始化echarts图表
		var myChart = ec.init(document.getElementById('main')); 		
		option = {
		/*title: {
			x: 'center',
			text: '微博账号男女比例分析对比图',
			subtext: '数据来自网络爬虫',
			link: 'http://echarts.baidu.com/doc/example.html'
		},*/
		tooltip: {
			trigger: 'item'
		},
		toolbox: {
			show: true,
			feature: {
				dataView: {show: true, readOnly: false},
				restore: {show: true},
				saveAsImage: {show: true}
			}
		},
		calculable: true,
		grid: {
			borderWidth: 1,
			y: 80,
			y2: 60
		},
		xAxis: [
			{
				type: 'category',
				show: false,//是否显示坐标轴
				data: ['男生', '女生']
			}
		],
		yAxis: [
			{
				type: 'value',
				show: true
			}
		],
		series: [
			{
				name: '微博账号男女比例分析对比图',
				type: 'bar',
				itemStyle: {
					normal: {
						color: function(params) {
							// build a color map as your need.
							var colorList = [
							  '#FF0000','#00FF00','#FCCE10','#E87C25','#27727B',
							   '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
							   '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
							];
							return colorList[params.dataIndex]
						},
						label: {
							show: true,
							position: 'top',
							formatter: '{b}\n{c}'
						}
					}
				},
				data: [<%=map.get("男")%>,<%=map.get("女")%>],
				markPoint: {
					tooltip: {
						trigger: 'item',
						backgroundColor: 'rgba(0,0,0,0)',
						formatter: function(params){
							return '<img src="' 
									+ params.data.symbol.replace('image://', '')
									+ '"/>';
						}
					},
					data: [
						{xAxis:0, y: 350, name:'男', symbolSize:20, symbol: 'image://../asset/ico/折线图.png'},
						{xAxis:1, y: 350, name:'女', symbolSize:20, symbol: 'image://../asset/ico/柱状图.png'}
					]
				}
			}
		]
	};
	// 为echarts对象加载数据 
	myChart.setOption(option); 
	}
);
</script>
</head>

<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">微博账号男女分布比例</div></td>
    </tr>
    <tr><td>
    危险等级：
    <select name="rank">
    <option value="">等级</option>
    <option value="高">高</option>
    <option value="中">中</option>
    <option value="低">低</option>
    </select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询">
    </td></tr>
    <tr><td>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div></td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>