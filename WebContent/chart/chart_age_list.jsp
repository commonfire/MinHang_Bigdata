<!doctype html><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博列表</title>
<jsp:useBean id="dt" class="edu.soft.MyString" scope="page"/>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script src="../echarts-2.2.7/build/dist/echarts.js"></script>
<script src="../js/html5.js"></script>
<%
ArrayList<String> titleList=new ArrayList<String>();
Hashtable<String,Integer> map=new Hashtable<String,Integer>();
ResultSet rs=stmt.executeQuery("select t,count(*) cnt from (select birthday,nian,(case when (nian>=0 and nian<1) then '10' when (nian>=1 and nian<2) then '00' when (nian>=2 and nian<3) then '90' when (nian>=3 and nian<4) then '80' when (nian>=4 and nian<5) then '70' when (nian>=5 and nian<6) then '60' end) T from (select birthday,((2019-substr(birthday,0,instr(birthday,'年')-1))/10) nian from T_USER_INFO t where birthday like '%年%月%日')) group by t order by t desc");
while(rs.next()){
	map.put(rs.getString("T"),rs.getInt("CNT"));//放到MAP里面
}
//map.put("10后",15);
titleList.add("10");
titleList.add("00");
titleList.add("90");
titleList.add("80");
titleList.add("70");
titleList.add("60");
//titleList.add("60前");
//titleList.add("未知");
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
				data:['微博账号年龄分布']
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
			grid: {
				borderWidth: 0,
				y: 80,
				y2: 60
			},
			xAxis : [
				{
					type : 'category',
					show:false,
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
					type : 'value',
					show:false
				}
			],
			series : [{
				name:'微博账号年龄分布',
				type:'bar',
				itemStyle: {
                normal: {
                    color: function(params) {
                        // build a color map as your need.
                        var colorList = [
                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                        ];
                        return colorList[params.dataIndex]
                    },
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}后\n{c}人'
                    }
                }
            },
			"data":[<%
			for(int i=0;i<titleList.size();i++){
				if(i<titleList.size()-1){
					if(map.containsKey(titleList.get(i))){
						out.print(map.get(titleList.get(i))+",");
					}else{out.print(0+",");}
				}else{
					if(map.containsKey(titleList.get(i))){
						out.print(map.get(titleList.get(i)));
					}else{out.print(0);}
				}
			}
			%>]
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