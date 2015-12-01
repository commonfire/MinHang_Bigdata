<%@page import="edu.bupt.jdbc.SelectOperation"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="edu.bupt.display.ShowFormat"%>
<%@ page import="edu.bupt.soft.WordCompute"%>
<%@ page import="edu.bupt.soft.OrientationCompute"%>
<%@ page import="edu.bupt.soft.SentenceProcessor"%>
<%@ page import="edu.bupt.soft.SentimentWordItem"%>
<%@ page import="edu.bupt.soft.BaseWordItem"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.ansj.test.WordSegAnsj"%>
<%@ include file="../inc/conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/inputstyle.css" type="text/css"/>
<link rel="stylesheet" href="../css/table_basic.css" type="text/css"/>

<title>微博内容打分详情</title>
</head>
<body>
<form name="myForm" method="post" action="">
<table align="center" width="80%" border="0">
	<tr>
    	<td height="50"><div align="center" class="tableTitle">舆情等级计算过程</div></td>
    </tr>
<tr><td>
  <table align="center" width="100%" class="datalist">
	<tr>
		<th scope="col">序号</th>
		<th scope="col">句子</th>
		<th scope="col">分词之后</th>
		<th scope="col">情感词汇</th>
		<th scope="col">非情感词汇</th>
		<th scope="col">观点句</th>
		<th scope="col">情感词分数</th>
		<th scope="col">非情感词分数</th>
		<th scope="col">句子舆情等级</th>
	</tr>
    <%! static  ArrayList<SentimentWordItem> sentimentWords = OrientationCompute.sentimentWords;
        static  ArrayList<BaseWordItem> positiveWords = OrientationCompute.positiveWords;
        static  ArrayList<BaseWordItem> negativeWords = OrientationCompute.negativeWords;
    %>
	<%
		String weiboID=request.getParameter("id");
		String weiboContent="";
		ResultSet rs= SelectOperation.selectContent(weiboID,conn);   //stmt.executeQuery("select content from t_user_weibo where id="+weiboID);       //从数据库中选取指定id的微博内容
		if(rs!=null){
			try{
			if(rs.next()){
			String blogContent = rs.getString("content");
		    ArrayList<String> sentences = new SentenceProcessor().SplitToSentences(blogContent);    //获取指定微博的分句
		    System.out.println(sentences);
			for(int i = 0;i<=sentences.size()-1;i++){
			if((i+1)%2!=0){
				double sentiScore = WordCompute.calSentiWord(WordSegAnsj.getSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords), sentimentWords);
			    double nonSentiScore = WordCompute.calNonSentiWord(WordSegAnsj.getNonSentimentWord(WordSegAnsj.split(sentences.get(i)),sentimentWords), positiveWords, negativeWords, sentimentWords);
	%>
	   <tr><!-- 奇数行 -->  
		<td><%=i+1%></td>
		<td><%=sentences.get(i)%></td>   <!-- 获得指定微博的分句句子 -->
		<td><%=WordSegAnsj.splitOriginal(sentences.get(i))%></td>  <!-- 将句子进行原始切词 -->
		<td><%=WordSegAnsj.getSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords)%></td>      <!-- 显示句子中的情感词汇 -->
		<td><%=WordSegAnsj.getNonSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords)%></td>   <!-- 显示句子中的非情感词汇 -->
		<td><%=new SentenceProcessor().isSentimentSentences(sentences.get(i), sentimentWords)%></td>  <!-- 获得是否为观点句的判断 -->
		<td><%=ShowFormat.showFormat(sentiScore)%></td>   <!-- 显示情感词平均分 -->
		<td><%=ShowFormat.showFormat(nonSentiScore)%></td>   <!-- 显示非情感词平均分 -->
		<td><%=ShowFormat.showFormat(WordCompute.calSentence(sentiScore, nonSentiScore))%></td>     <!-- 显示句子的舆情等级 -->
	   </tr>
	    <%
	    	}else{
	    	    	double sentiScore = WordCompute.calSentiWord(WordSegAnsj.getSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords), sentimentWords);
	    		    double nonSentiScore = WordCompute.calNonSentiWord(WordSegAnsj.split(sentences.get(i)), positiveWords, negativeWords, sentimentWords);
	    %>
	   <tr class="altrow"><!-- 偶数行 -->
		<td><%=i+1%></td>
		<td><%=sentences.get(i)%></td>
		<td><%=WordSegAnsj.splitOriginal(sentences.get(i))%></td>
		<td><%=WordSegAnsj.getSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords)%></td>
		<td><%=WordSegAnsj.getNonSentimentWord(WordSegAnsj.splitOriginal(sentences.get(i)), sentimentWords)%></td>   
		<td><%=new SentenceProcessor().isSentimentSentences(sentences.get(i), sentimentWords)%></td>
		<td><%=ShowFormat.showFormat(sentiScore)%></td>
		<td><%=ShowFormat.showFormat(nonSentiScore)%></td>
		<td><%=ShowFormat.showFormat(WordCompute.calSentence(sentiScore, nonSentiScore))%></td>
	   </tr>
	     <%}
		  }
		 }
		}catch(SQLException e){
       	 e.printStackTrace();
        }
       } %>
</table>
</td></tr>
</table>
</form>
</body>
</html>
<%@ include file="../inc/conn_close.jsp"%>