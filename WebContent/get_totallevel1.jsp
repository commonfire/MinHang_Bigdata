<%@page import="edu.bupt.display.ShowFormat"%>
<%@page import="edu.bupt.jdbc.SelectWeibo"%>
<%@page import="edu.bupt.soft.OrientationCompute"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!String result = null; 
   String userID = null;
%>

<%

    userID = request.getParameter("userID");
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
        	out.write(String.valueOf(result));
        	//System.out.println(result);
   
  }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<!-- 
<script src="jquery-2.0.3/jquery-2.0.3.min.js"></script>
<script src="highcharts/js/highcharts.js"></script>
-->
<script type="text/javascript" src="http://cdn.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
<!--  <script type="text/javascript" src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>  -->
<script type="text/javascript" src="highcharts/js/highcharts.js"></script>  
  <script>
  $(function () {
	    $('#container').highcharts({
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: '微博言论等级'
	        },
	        xAxis: {
	            categories: ['用户<%=userID%>']
	        },
	        credits: {
	            enabled: false
	        },
	        series: [{
	            //name: 'John',
	           // data: [-0.003]
	           name: '微博舆情指数',
	           data: [<%=result%>]
	        }]
	    });
	});				
  </script>
</head>
<body>
  <div id="container" style="min-width:700px;height:400px"></div>
</body>
</html>
