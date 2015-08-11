package edu.bupt.soft;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import edu.bupt.jdbc.SQLHelper;

public class EmoticonProcessor {
	
	/**
	 * 计算给定微博中出现的表情符号以及出现次数
	 * @param bloContent      给定微博内容
	 * @param emoticonMap     表情基准词库
	 * @return				    返回表情符号及相应出现次数
	 */
	public HashMap<String,Integer> emoticonFilter(String blogContent){
		HashMap<String,Integer> resultmap = new HashMap<String,Integer>();
		Pattern p = Pattern.compile("\\[(.*?)\\]");  //注意方括号要进行转义，通过两个斜杠
		if(blogContent!=""){
			Matcher m = p.matcher(blogContent);
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
	
	
	
	
	public static void main(String[] args) throws SQLException {
		Connection conn = SQLHelper.getConnection();
    	String sql = "select * from emoticon_baseword";
    	ResultSet rs = SQLHelper.executeQuery(sql, null, conn);
		HashMap<String, Float> emoticonMap = new SentenceProcessor().getEmoticons(rs);
		System.out.println(new EmoticonProcessor().emoticonFilter("[喵喵][doge][doge][doge]") );
		
	}
}
