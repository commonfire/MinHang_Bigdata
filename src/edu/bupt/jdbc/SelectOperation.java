package edu.bupt.jdbc;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.LinkedTransferQueue;
import java.util.concurrent.TransferQueue;


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
			if(rs.next()){
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
	
	public static ResultSet selectUid(String userAlias, Connection conn){
		String[] parameters = new String[]{userAlias,userAlias};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("SELECT USERID FROM (SELECT USERID FROM T_USER_INFO WHERE USERALIAS = ? UNION SELECT USERID FROM T_PUBLICUSER_INFO WHERE USERALIAS = ?)", parameters, conn);
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
	
	
	/**
	  * 获取@用户
	 * @param userID            用户uid
	 * @param currentTimeStamp  当前时间戳
	 * @param topN              选取前topN名
	 * @param inType            选择近一天/周/月
	 * @param conn              数据库连接
	 * @return                  数据库结果集
	 */
	public static ResultSet selectAtuser(String userID,Long currentTimeStamp,String topN,String inType,Connection conn){
		ResultSet rs = null;
		String sql = null;
		String inTime = null;
		String[] parameters = new String[]{userID,String.valueOf(currentTimeStamp),topN};
		try {
			if("day".equals(inType)){   //最近一天发表
				inTime = "86400000";
			}else if("week".equals(inType)){  //最近一周发表
				inTime = "604800000";
			}else if("month".equals(inType)){    //"month",最近一月发表
				inTime = "2592000000"; //6-0
			}else{
				inTime = String.valueOf(Long.MAX_VALUE); //for test usage 
			}
			sql = "SELECT * FROM (SELECT USERID,ATUSER,ATUSERID,COUNT(*) AS TOTALNUMBER FROM T_USER_WEIBOCONTENT_ATUSER WHERE USERID=? AND ATUSER != 'NullUser' AND ATUSERID IS NOT NULL AND ATUSERID !=0 AND ? - PUBLISHTIMESTAMP < "+inTime+" GROUP BY ATUSERID,USERID,ATUSER ORDER BY TOTALNUMBER DESC) WHERE ROWNUM <=?";
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
			sql = "SELECT * FROM (SELECT USERID,ATUSER,ATUSERID,COUNT(*) AS TOTALNUMBER FROM T_USER_WEIBOCONTENT_ATUSER WHERE USERID=? AND ATUSER != 'NullUser' AND ATUSERID IS NOT NULL AND ATUSERID !=0 GROUP BY ATUSERID,USERID,ATUSER ORDER BY TOTALNUMBER DESC) WHERE ROWNUM <=?";
			rs = SQLHelper.executeQuery(sql, parameters, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	//获取@某用户的相关微博
	public static ResultSet selectAtuserWeibo(String userAlias,Connection conn){
		ResultSet rs = null;
		String sql = null;
		String[] parameters = new String[]{userAlias};
		try {
			sql = "SELECT A.CONTENT from T_USER_WEIBOCONTENT A,T_USER_WEIBOCONTENT_ATUSER B where B.ATUSER=? and A.PUBLISHTIMESTAMP = B.PUBLISHTIMESTAMP";
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

	public static ResultSet selectUserinfoByAlias(String alias,Connection conn){
		String[] parameters = new String[]{alias};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_info where userAlias= ?", parameters, conn);
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
	
	//获取用户属性
	public static String selectUserProperty(String value, String field, Connection conn){
		String result = null;
		String[] parameters = new String[]{value,value};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("SELECT PROPERTY FROM (SELECT PROPERTY FROM T_USER_INFO WHERE "+field+"=? UNION SELECT PROPERTY FROM T_PUBLICUSER_INFO WHERE "+field+"=?)", parameters, conn);
			if(rs.next()){
				result = rs.getString("PROPERTY");
				if(null == result) result = ""; //此时账号没有属性，即一般用户
			} 
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	
	//获取爬虫结束状态
	public static int selectEndState(String column,Connection conn){
		int result = 0;
		try {
			result = SQLHelper.executeQuery1("SELECT * FROM T_SPIDER_STATE", null, conn,column);
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
	
	//查询某用户是否爬取过，根据用户uid或用户昵称
	public static boolean containsUser(String value, String field,Connection conn){
		String[] parameters = new String[]{value,value};
		boolean result = false;
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("SELECT COUNT(*) AS COUNT FROM (SELECT USERID FROM T_USER_INFO WHERE "+field+"=? UNION SELECT USERID FROM T_PUBLICUSER_INFO WHERE "+field+"=?)", parameters, conn);
			rs.next();
			int count = rs.getInt("COUNT");
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
	
	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException, UnsupportedEncodingException {
   	//Connection conn = SQLHelper.getConnection();
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
		//System.out.println(selectUserPropert
	}
}
