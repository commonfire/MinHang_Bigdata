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
ArrayList titleList=new ArrayList();
ArrayList cntList=new ArrayList();
ResultSet rs=stmt.executeQuery("select t,count(*) cnt from (select birthday,nian,(case when (nian>=0 and nian<1) then '10后' when (nian>=1 and nian<2) then '00后' when (nian>=2 and nian<3) then '90后' when (nian>=3 and nian<4) then '80后' when (nian>=4 and nian<5) then '70后' end) T from (select birthday,((2019-substr(birthday,0,instr(birthday,'年')-1))/10) nian from T_USER_INFO t where birthday like '%年%月%日')) group by t");
while(rs.next()){
	titleList.add(rs.getString("t"));
	cntList.add(rs.getString("cnt"));
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
		
		var option = {
			tooltip: {
				show: true
			},
			legend: {
				data:['微博账号危险等级按年龄分布']
			},
			toolbox: {
				show : true,
				feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			xAxis : [
				{
					type : 'category',
					//data : ["10后","00后","90后","80后","70后","60后"]
					data:[<%
					for(int i=0;i<titleList.size();i++){
						if(i<titleList.size()-1){out.print("\""+titleList.get(i)+"\",");}else{
							out.print("\""+titleList.get(i)+"\"");
						}
					}
					%>]
				}
			],
			yAxis : [
				{
					type : 'value'
				}
			],
			series : [{
				name:'微博账号年龄分布',
				type:'bar',
				itemStyle: {// 系列级个性化样式，纵向渐变填充
					normal: {
						barBorderColor:'red',
						barBorderWidth: 1,
						color : (function (){
							var zrColor = require('zrender/tool/color');
							return zrColor.getLinearGradient(
								0, 400, 0, 300,
								[[0, 'green'],[1, 'yellow']]
							)
						})()
					},
					emphasis: {
						barBorderWidth: 1,
						barBorderColor:'green',
						color: (function (){
							var zrColor = require('zrender/tool/color');
							return zrColor.getLinearGradient(
								0, 400, 0, 300,
								[[0, 'red'],[1, 'orange']]
							)
						})(),
						label : {
							show : true,
							position : 'top',
							formatter : "{a} {b} {c}",
							textStyle : {
								color: 'blue'
							}
						}
					}
				},
					"data":[<%
					for(int i=0;i<cntList.size();i++){
						if(i<cntList.size()-1){out.print(cntList.get(i)+",");}else{
							out.print(cntList.get(i));
						}
					}
					%>],
					markPoint : {
						data : [
							{name : '年最高', value : 12, xAxis: 3, yAxis: 15, symbolSize:18}
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
    	<td height="50"><div align="center" class="tableTitle">微博账号年龄分析</div></td>
    </tr>
    <tr><td>
    危险等级：
    <select name="rank"></select>
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