<%@page import="edu.bupt.display.ShowFormat"%>
<%@page import="edu.bupt.jdbc.SelectWeibo"%>
<%@page import="edu.bupt.soft.OrientationCompute"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!String result = null; 
%>

<%
    request.setCharacterEncoding("utf-8");
    String userAlias2 = request.getParameter("userAlias2")!=null?request.getParameter("userAlias2"):"";
    System.out.println(userAlias2);
  //根据查询言论等级输入的账号，计算用户ID
  	String userID = null;
  	ResultSet rs0 = new SelectWeibo().selectUserid(userAlias2);
  	if(rs0!=null&&rs0.next()){
  		userID = rs0.getString("userID");
  	}else{
  		userID = "";
  	}
  	
  	
    if(userID!=null){
    	final int count = 12;
    	double score = 0;
    	String blog = null;
    	ResultSet rs = new SelectWeibo().selectWeiboForLevel(userID,count);
        if(rs!=null){
        	while(rs.next()){
            	blog = rs.getString("content");
            	//System.out.println(blog);
                score += new OrientationCompute().calcDSOofBlog2(blog);
         } 
        }
         	result = ShowFormat.showFormat(score/count);
        	//System.out.println(result);
   
  }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微博言论等级</title>
</head>
<body>
当前微博账号：<%=userAlias2 %>
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
                		            name:'<%=userAlias2%>',
                		            type:'gauge',
                		            center : ['50%', '50%'],    // 默认全局居中
                		            radius : [0, '75%'],
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
                		                        case '-0.8': return '高';
                		                        case '-0.4': return '较高';
                		                        case '0': return '中';
                		                        case '0.4': return '较低';
                		                        case '0.8': return '低';
                		                        default: return '';
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
</html>
