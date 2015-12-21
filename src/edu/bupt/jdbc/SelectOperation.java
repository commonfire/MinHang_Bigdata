package edu.bupt.jdbc;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Scanner;


public class SelectOperation {
	
	public static ResultSet selectUserid(String userAlias,Connection conn){
		String[] parameters = new String[]{userAlias};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select userID from t_user_info where userAlias = ?", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static String selectAtUserid(String userAlias,Connection conn){
		String[] parameters = new String[]{userAlias};
		ResultSet rs = null;
		String res = null;
		try {
			rs = SQLHelper.executeQuery("select atuserID from t_user_weibocontent_atuser where atuser = ? and rownum = 1", parameters, conn);
			if(null != rs){
				rs.next();
				res = rs.getString("atuserID");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public static ResultSet selectAlias(String userID,Connection conn){
		String[] parameters = new String[]{userID};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select userAlias from t_user_info where userID = ?", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return rs;
	}
	
	
	public static ResultSet selectUid(Connection conn){
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select userID from t_user_info", null, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return rs;
	}
	
	public static ResultSet selectUidBasedKeyword(String keyword,Connection conn){
		String[] parameters = new String[]{keyword};
		ResultSet rs = null;
		try {
			//rs = SQLHelper.executeQuery("select userID,userAlias from t_user_keyword where keyword = ? order by publishTime desc", parameters, conn);
			//避免查询结果为重复的
			rs = SQLHelper.executeQuery("SELECT userID,keyword,userAlias,MAX(publishTime) as publishTime from t_user_keyword  where keyword = ? group by userID,keyword,userAlias order by publishTime desc", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	//获取用户关系信息
	public static ResultSet selectRelationuid(String userID,Connection conn){
		String[] parameters = new String[]{userID,userID};
		ResultSet rs = null;
		try {
			String sql = "select followID as relation from t_user_follow4 where userID= ? union select followerID as relation from t_user_follower4 where userID= ?";
			rs = SQLHelper.executeQuery(sql, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	/**
	  * 获取@用户
	 * @param userID            用户uid
	 * @param currentTimeStamp  当前时间戳
	 * @param topN              选取前topN名
	 * @param inType            选择近一天/周/月
	 * @param conn              数据库连接
	 * @return                  数据库结果集
	 */
	public static ResultSet selectAtuser(String userID,String currentTimeStamp,String topN,String inType,Connection conn){
		ResultSet rs = null;
		String sql = null;
		String inTime = null;
		String[] parameters = new String[]{userID,currentTimeStamp,topN};
		try {
			if("day".equals(inType)){   //最近一天发表
				inTime = "86400000";
			}else if("week".equals(inType)){  //最近一周发表
				inTime = "604800000";
			}else{      //"month",最近一月发表
				inTime = "2592000000"; //6-0
			}
			 sql = "select * from (select userID,atuser,atuserID,count(*) as totalNumber from t_user_weibocontent_atuser where userID=? and atuser != 'NullUser' and ? - publishTimeStamp < "+inTime+" group by atuserID,userID,atuser order by totalNumber desc) where rownum<=?";
			rs = SQLHelper.executeQuery(sql, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectAtuser(String userID,String topN,Connection conn){
		ResultSet rs = null;
		String sql = null;
		String[] parameters = new String[]{userID,topN};
		try {
			sql = "select * from (select userID,atuser,atuserID,count(*) as totalNumber from t_user_weibocontent_atuser where userID=? and atuser != 'NullUser' group by atuserID,userID,atuser order by totalNumber desc) where rownum<=?";
			rs = SQLHelper.executeQuery(sql, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	//获取微博信息
	public static ResultSet selectWeibo(String userID,Connection conn){
		String[] parameters = new String[]{userID};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent where userID = ?", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectContent(String id,Connection conn){
		String[] parameters = new String[]{id};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select content from t_user_weibocontent where id= ?", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectContent(String userID,Connection conn,int count){
		String[] parameters = new String[]{userID};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent where userID= ? and rownum<="+count, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	public static ResultSet selectWeiboBasedUid(String uid,Connection conn){
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent where userID= ? order by publishTime desc", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	//获取用户信息
	public static ResultSet selectUserinfo(String uid,Connection conn){
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_info where userID= ?", parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	public static ResultSet selectUserinfo(String uid,Connection conn,int count){
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_info where userID= ? limit "+count, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	//获取爬虫结束状态
	public static int selectEndState(String column,Connection conn){
		int result = 0;
		try {
			result = SQLHelper.executeQuery1("select * from t_spider_state", null, conn,column);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	//获取爬取某用户上一次爬取时间
	public static long selectLastSearchTime(String uid, Connection conn){
		long result = 0;
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		try {
			  rs = SQLHelper.executeQuery("select lastSearchTime from t_user_lastsearchtime where userID = ?",parameters, conn);
			  if(rs.next()) result = rs.getLong("lastSearchTime");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	//判断是否已经爬取，避免重复爬取
	public static boolean containsField(String field,String value,String tableName,Connection conn){
		String[] parameters = new String[]{value};
		boolean result = false;
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select count(*) as count from "+tableName+" where "+field+" = ?", parameters, conn);
			rs.next();
			int count = rs.getInt("count");
			if(count!=0) result = true;
			else result = false;
		} catch (Exception e) {
		}finally{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	//判断指定uid用户是否有atuser
	public static boolean checkNullAtuser(String uid,Connection conn){
		boolean result = false;
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent_atuser where userID= ?", parameters, conn);
			if(!rs.next()){
				result = true;
			} 
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/**
	 * 获取当前爬取微博最早时间戳
	 * @param uid       用户uid
	 * @param conn      数据库连接
	 * @return          微博最早时间戳
	 */
	public static long getEarlistTimeStamp(String uid,Connection conn){
		String[] parameters = new String[]{uid};
		ResultSet rs = null;
		long result = -155520000;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent where userID= ? order by publishTimeStamp", parameters, conn);
			if(rs.next()){
				result = Long.valueOf(rs.getString("publishTimeStamp"));
			} 
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
   	Connection conn = SQLHelper.getConnection();
/*	   System.out.println(checkNullAtuser("22222", conn));
	   //SQLHelper.executeUpdate("insert into t_user_weibocontent_atuser(userID,atuser) values(?,'NullUser') ", new String[]{"22222"});
	   if(SelectOperation.containsField("userID", "22222", "t_user_weibocontent_atuser", conn)){
		   System.out.println("contains!!");
	   }
		long currentTimeStamp = System.currentTimeMillis();
		
		ResultSet rs = SelectOperation.selectInWeek("3655612552", String.valueOf(currentTimeStamp),conn);
		while(rs.next()){
			Clob c = rs.getClob("content");
			System.out.println(c.getSubString((long)1, (int)c.length()));
		}*/
		//System.out.println(selectLastSearchTime("333",conn));
		conn.close();
	}

}
