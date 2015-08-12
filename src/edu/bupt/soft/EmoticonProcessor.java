package edu.bupt.soft;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import edu.bupt.jdbc.SQLHelper;

public class EmoticonProcessor {
	
	/**
	 * 计算给定微博句子中出现的表情符号以及出现次数
	 * @param bloContent      给定微博句子内容
	 * @param emoticonMap     表情基准词库
	 * @return				    返回表情符号及相应出现次数
	 */
	public static HashMap<String,Integer> emoticonFilter(String sentence){
		HashMap<String,Integer> resultmap = new HashMap<String,Integer>();
		Pattern p = Pattern.compile("\\[(.*?)\\]");   //注意方括号要进行转义，通过两个斜杠
		if(sentence!=""){
			Matcher m = p.matcher(sentence);
			while(m.find()){
				if(resultmap.containsKey(m.group(1))){
					resultmap.put(m.group(1), resultmap.get(m.group(1))+1);
				}
				else{
					resultmap.put(m.group(1),1);
				}
			}
			return resultmap;
		}else{
			return null;
		}
		
	}
	
	/**
	 * 计算给定微博句子的表情得分
	 * @param sentence         给定微博句子内容
	 * @param emoticonmap      表情基准词库
	 * @return  			      返回指定微博句子的表情得分
	 */
	public static double calEmoticon(String sentence,HashMap<String, Float> emoticonmap){
		HashMap<String, Integer> resultmap = emoticonFilter(sentence);
		double score = 0;
		int count = 0;
		if(resultmap!=null){
			for(String key : resultmap.keySet()){
				count += resultmap.get(key);
				score += emoticonmap.get(key)*resultmap.get(key);
			}
			score /=count;
		}
		return score;
	}
	
	
	public static void main(String[] args) throws SQLException {
//		Connection conn = SQLHelper.getConnection();
//    	String sql = "select * from emoticon_baseword";
//    	ResultSet rs = SQLHelper.executeQuery(sql, null, conn);
//		HashMap<String, Float> emoticonmap = new SentenceProcessor().getEmoticons(rs);
//		System.out.println(new EmoticonProcessor().calEmoticon("[礼物][神马]", emoticonmap));
	}
}
