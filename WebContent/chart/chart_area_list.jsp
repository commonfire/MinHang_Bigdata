<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ include file="../inc/conn.jsp"%>
<%@ include file="../utils/function.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微博账号地区分布</title>
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>
<script type="text/javascript" src="../js/validate.js"></script>
<script src="../echarts-2.2.7/build/dist/echarts.js"></script>
<%
ResultSet rs=stmt.executeQuery("select count(*) N,b.mc from T_USER_INFO a, b_provinces b where a.location like '%' || b.mc || '%' group by b.mc order by count(*) desc");
ArrayList mcList=new ArrayList();
ArrayList nList=new ArrayList();
while(rs.next()){
	mcList.add(rs.getString("MC"));
	nList.add(rs.getString("N"));
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
		'echarts/chart/map'
	],
	function (ec) {
		// 基于准备好的dom，初始化echarts图表
		var myChart = ec.init(document.getElementById('main')); 
		//准备数据部分代码
		option = {
			series : [    
				{
					name: '账号地域分布',
					type: 'map',
					mapType: 'china',
					itemStyle:{
						normal:{label:{show:true}},color: 'orange',borderColor:'lightgreen',emphasis:{label:{show:true}}
					},
					data:[
					<%for(int i=0;i<mcList.size();i++){%>
					{name:'<%=mcList.get(i)%>',value:'<%=nList.get(i)%>',itemStyle: {normal: {color: '#32cd32',label: {show: true,textStyle: {color: '#FF0000',fontSize: 12}}}}}<%if(i!=mcList.size()-1){out.print(",");}%>
					<%}%>
					]
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
    	<td height="50" colspan="2"><div align="center" class="tableTitle">微博账号地区分布情况</div></td>
    </tr>
    <tr><td>
    危险等级：
    <select name="rank">
    <option value="">等级</option>
    <option value="高">高</option>
    <option value="中">中</option>
    <option value="低">低</option>
    </select>
    <input name="cmdQuery" type="button" class="btn_2k3" value="查询" onClick="chaxun();">
    </td></tr>
    <tr><td>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div></td>
    <td>
    	<table width="100%" class="datalist">
			<%
            for(int i=0;i<mcList.size()/2;i++){
            %>
            <tr>
                <th><%if(i<mcList.size()){out.print(mcList.get(i));}%></th>
                <td><a href="chart_area_detail.jsp?mc=" target="_blank"><%if(i<nList.size()){out.print(nList.get(i));}%></a></td>
                <th><%if(i+1<mcList.size()){out.print(mcList.get(i+1));}%></th>
                <td><a href="chart_area_detail.jsp?mc=%>" target="_blank"><%if(i+1<nList.size()){out.print(nList.get(i+1));}%></a></td>
            </tr>
            <%}%>
        </table>
    </td>
    </tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>