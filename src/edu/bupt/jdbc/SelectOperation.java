package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SelectOperation {
	
	public static ResultSet selectUserid(String userAlias,Connection conn){
		String[] str = new String[]{userAlias};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select \"userID\" from \"t_user_info\" where \"userAlias\" = ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectAlias(String userID,Connection conn){
		String[] str = new String[]{userID};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select userAlias from t_user_info where userID = ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return rs;
	}
	
	public static ResultSet selectUidBasedKeyword(String keyword,Connection conn){
		String[] str = new String[]{keyword};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select \"userID\",\"userAlias\" from \"t_user_keyword\" where \"keyword\"= ? order by \"publishTime\" desc", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	//获取用户关系信息
	public static ResultSet selectRelationuid(String userID,Connection conn){
		String[] str = new String[]{userID,userID};
		ResultSet rs = null;
		try {
			String sql = "select \"followID\" as \"relation\" from \"t_user_follow4\" where \"userID\"= ? union select \"followerID\" as \"relation\" from \"t_user_follower4\" where \"userID\"= ?";
			rs = SQLHelper.executeQuery(sql, str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectAtuser(String userID,String topN,Connection conn){
		ResultSet rs = null;
		String[] str = new String[]{userID,topN};
		try {
			String sql = "select * from (select userID,atuser,atuserID,count(*) as totalNumber from t_user_weibocontent_atuser where userID=? group by atuserID,userID,atuser order by totalNumber desc) where rownum<=?";
			rs = SQLHelper.executeQuery(sql, str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	//获取微博信息
	public static ResultSet selectWeibo(String userID,Connection conn){
		String[] str = new String[]{userID};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from \"t_user_weibocontent\" where \"userID\" = ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectContent(String id,Connection conn){
		String[] str = new String[]{id};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select \"content\" from \"t_user_weibocontent\" where \"id\"= ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet selectContent(String id,Connection conn,int count){
		String[] str = new String[]{id};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select \"content\" from \"t_user_weibocontent\" where \"id\"= ? limit " + count, str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	
	public static ResultSet selectWeiboBasedUid(String uid,Connection conn){
		String[] str = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_weibocontent where userID= ? order by publishTime desc", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	//获取用户信息
	public static ResultSet selectUserinfo(String uid,Connection conn){
		String[] str = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from t_user_info where userID= ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	public static ResultSet selectUserinfo(String uid,Connection conn,int count){
		String[] str = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from \"t_user_info\" where \"userID\"= ? limit "+count, str, conn);
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
			result = SQLHelper.executeQuery1("select * from \"t_spider_state\"", null, conn,column);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	

	
	
	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Connection conn = SQLHelper.getConnection();
		ResultSet rs = selectAtuser("3655612552", "5",conn);
		rs.next();
		System.out.println(rs.getString("atuser"));
		conn.close();
	}

}
