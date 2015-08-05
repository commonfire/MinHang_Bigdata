package edu.bupt.soft;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

public class SentenceProcessor {

	public String[] delimiter=new String[]{"。","；","！","？",".",";","!","?"};
	
	/**
	 * 输入一篇博客，返回一个句子的列表
	 * @param blogContent  输入博文内容
	 * @return  返回分割的句子列表
	 */
	public ArrayList<String> SplitToSentences(String blogContent){
		ArrayList<String> sentenceList = new ArrayList<String>();
		String[] sentenceArray = blogContent.split("。|；|！|？|\\.|;|!|\\?");
		sentenceList = new ArrayList<String>(Arrays.asList(sentenceArray));
			for(int i = sentenceList.size()-1;i>=0;i--){
				if(sentenceList.get(i).equals("")){
					sentenceList.remove(sentenceList.get(i));
				}	
			}
		//System.out.println("文本分句："+sentenceList);
		return sentenceList;
	}
	

	/**
	 * 访问数据库进行数据提取，返回情感词表中的情感词列表
	 * @param rs 数据库查询结果集
	 * @return   从数据库提取的情感词列表
	 */
	public ArrayList<SentimentWordItem> getSentimentWords(ResultSet rs){
		ArrayList<SentimentWordItem> sentimentWordsList = new ArrayList<SentimentWordItem>();
		try {
				while(rs.next()){
				SentimentWordItem wordEntry = new SentimentWordItem();
				wordEntry.setPhrase(rs.getString("phrase"));
				wordEntry.setPower(rs.getInt("power"));
				wordEntry.setPolar(rs.getInt("polar"));
				sentimentWordsList.add(wordEntry);
			   }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sentimentWordsList;
	}
	
	/**
	 * 访问数据库进行数据提取，返回褒义/贬义基准词词表
	 * @param rs 数据库查询结果集
	 * @return   从数据库提取的褒义/贬义基准词
	 */
	public ArrayList<BaseWordItem> getBaseWords(ResultSet rs){
		ArrayList<BaseWordItem> baseWordsList = new ArrayList<BaseWordItem>();
		try {
				while(rs.next()){
				BaseWordItem wordItem = new BaseWordItem();
				wordItem.setPhrase(rs.getString("phrase"));
				wordItem.setPower(rs.getInt("power"));
				baseWordsList.add(wordItem);
			   }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return baseWordsList;
	}
	
	
	/**
	 * 输入一个句子列表，返回观点句子列表
	 * @param sentenceList    输入句子列表  
	 * @param sentimentWords  输入情感词表
	 * @return                返回观点句子列表  
	 */
	public ArrayList<String> getSentimentSentences(ArrayList<String> sentenceList, ArrayList<SentimentWordItem> sentimentWords){
		ArrayList<String> sentimentList = new ArrayList<String>();
		if(sentenceList.size()!=0){
			for (int i = 0;i < sentenceList.size();i++){
	        	for(int j = 0; j < sentimentWords.size();j++){
	        		if(sentenceList.get(i).contains(sentimentWords.get(j).getPhrase())){
	        			sentimentList.add(sentenceList.get(i));
	        		}
	        	}
	        }
		}
		return sentimentList;
	}
	

	/**
	 * 输入一个句子列表，返回非观点句子列表
	 * @param sentenceList    输入句子列表  
	 * @param sentimentWords  输入情感词表
	 * @return                返回非观点句子列表  
	 */
	public ArrayList<String> getNonSentimentSentences(ArrayList<String> sentenceList, ArrayList<SentimentWordItem> sentimentWords){
		ArrayList<String> nonSentimentList = new ArrayList<String>();      	
        	for(int i = sentenceList.size()-1;i >= 0;i--){
            	for(int j = 0; j < sentimentWords.size();j++){
            		if(sentenceList.get(i).contains(sentimentWords.get(j).getPhrase())){
            			sentenceList.remove(i);
            			break;
            	  }
            	}
            }
        	nonSentimentList = sentenceList;
		return nonSentimentList;
	}
	
	/**
	 * 输入一个句子，返回判断该句是否为情感句结果
	 * @param sentence        输入句子 
	 * @param sentimentWords  输入情感词表
	 * @return                返回判断该句是否为情感句结果
	 */
	public String isSentimentSentences(String sentence, ArrayList<SentimentWordItem> sentimentWords){
                String result = "否";
	        	for(int j = 0; j < sentimentWords.size();j++){
	        		if(sentence.contains(sentimentWords.get(j).getPhrase())){
	        			result = "是";   //该句是观点句
	        		}
	        	}
	        	return result;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
/////////////////////////////////////////////////////文本分句测试////////////////////////////////////////////////////////////////		
		//String testBlog = "测试分割句子1，测试分割句子2。测试分割句子3!测试分割句子4;测试分割句子5.测试分割句子6?";
		//String testBlog ="中文测试测试，测试测试。\n测试测试？   测试测试测试测试！测试测试测试测试；English_testtesttest,    testtesttest. testtesttest testtesttesttesttesttest! testtesttest; 前面空格出现了！！连续符号~~";    
		//String testBlog ="中文测试测试，测试测试。\n测试测试";
		//System.out.println(testBlog);

		//数据库连接
//		JDBCConnect.getConnection();
//		String selectSql = "select * from t_user_weibo where id = 1";
//		ResultSet rs = SelectOperation.selectOnes(selectSql);
//		try {
//				rs.next();
//				String testBlog = rs.getString("content");
//				System.out.println(testBlog);
//				ArrayList<String> sentencelist = new SentenceProcessor().SplitToSentences(testBlog);	
//				String sql = "insert into blog(content) values (?)";
//				List<Object> param = new ArrayList<Object>();
//						
//				param.add(sentencelist.get(1));
//				InsertOperation.insertOne(sql, param);		
//			} catch (SQLException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		
/////////////////////////////////////////////////////获取情感表测试////////////////////////////////////////////////////////////////		
//		JDBCConnect.getConnection();
//		String selectSql = "select * from emotion_dictionary";
//		ResultSet rs = SelectOperation.selectOnes(selectSql);
//		ArrayList<String> test_emotion = new SentenceProcessor().getSentimentWords(rs);
//		System.out.println(test_emotion);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		
/////////////////////////////////////////////////////获取观点句子测试////////////////////////////////////////////////////////////////		
		//数据库连接
//		JDBCConnect.getConnection();
//		String selectSql = "select * from t_user_weibo where id = 1";
//		ResultSet rs = SelectOperation.selectOnes(selectSql);
//		try {
//			rs.next();
//			String testBlog = rs.getString("content");
//			ArrayList<String> sentenceList = new SentenceProcessor().SplitToSentences(testBlog);	
//			ArrayList<String> sentimentList = new ArrayList<String>();
//			
//			String selectSql1 = "select * from emotion_dictionary";
//			ResultSet rs_w = SelectOperation.selectOnes(selectSql1);
//			ArrayList<String> sentimentWords = new SentenceProcessor().getSentimentWords(rs_w);
//	
//			sentimentList = new SentenceProcessor().getSentimentSentences(sentenceList, sentimentWords);
//			System.out.println(sentimentList.get(0));
//	
//		}catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		
/////////////////////////////////////////////////////获取非观点句子测试////////////////////////////////////////////////////////////////		
//数据库连接
//		JDBCConnect.getConnection();
//		String selectSql = "select * from t_user_weibo where id = 1";
//		ResultSet rs = SelectOperation.selectOnes(selectSql);
//		try {
//			rs.next();
//			String testBlog = rs.getString("content");
//			ArrayList<String> sentenceList = new SentenceProcessor().SplitToSentences(testBlog);	
//			ArrayList<String> sentimentList = new ArrayList<String>();
//
//			String sql = "select * from emotion_dictionary";
//			ResultSet rs1 = SelectOperation.selectOnes(sql);
//			ArrayList<SentimentWordItem> sentimentWords = new SentenceProcessor().getSentimentWords(rs1);
//			
//			sentimentList = new SentenceProcessor().getSentimentSentences(sentenceList, sentimentWords);
//		 	System.out.println(sentimentList);
//
//		}catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

      //System.out.println(new SentenceProcessor().SplitToSentences(""));
//      ArrayList<String> sentenceList = new ArrayList<String>();
//      System.out.println(sentenceList.size());
//      sentenceList.add("高兴");
//      System.out.println(sentenceList.size());
//      sentenceList.remove(0);
//      System.out.println(sentenceList.size());
 //     System.out.println((new SentenceProcessor().getSentimentSentences(sentenceList, sentimentWords)).size());
//      System.out.println((new SentenceProcessor().getNonSentimentSentences(sentenceList, sentimentWords)));
	}

}
