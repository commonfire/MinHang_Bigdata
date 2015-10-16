package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;


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
	
	public static ResultSet selectAtuser(String userID,String topN,Connection conn){
		ResultSet rs = null;
		String[] parameters = new String[]{userID,topN};
		try {
			String sql = "select * from (select userID,atuser,atuserID,count(*) as totalNumber from t_user_weibocontent_atuser where userID=? group by atuserID,userID,atuser order by totalNumber desc) where rownum<=?";
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
	
	//判断是否已经爬取，避免重复爬取
	public static boolean containsField(String field,String value,String tableName,Connection conn){
		String[] parameters = new String[]{value};
		boolean result = false;
		try {
			ResultSet rs = SQLHelper.executeQuery("select count(*) as count from "+tableName+" where "+field+" = ?", parameters, conn);
			rs.next();
			int count = rs.getInt("count");
			if(count!=0) result = true;
			else result = false;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}


	
	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
//		Connection conn = SQLHelper.getConnection();
//    	System.out.println(SelectOperation.containsField("keyword","翟金顺","t_user_keyword", conn));
//		conn.close();

	}

}
