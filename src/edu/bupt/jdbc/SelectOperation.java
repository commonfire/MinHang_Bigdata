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
			rs = SQLHelper.executeQuery("select \"userAlias\" from \"t_user_info\" where \"userID\" = ?", str, conn);
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
			rs = SQLHelper.executeQuery("select \"userID\",\"userAlias\" from \"t_user_keyword\" where \"keyword\"= ? order by \"time\" desc", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
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
			rs = SQLHelper.executeQuery("select * from \"t_user_weibocontent\" where \"userID\"= ? order by \"time\" desc", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	public static ResultSet selectUserinfo(String uid,Connection conn){
		String[] str = new String[]{uid};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select * from \"t_user_info\" where \"userID\"= ?", str, conn);
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
//		Class.forName("com.mysql.jdbc.Driver");
//		String url="jdbc:mysql://10.108.147.198:3306/weiboanalysis";
//		String dbusername="root";
//		String dbpassword="root";
		String drivername="oracle.jdbc.driver.OracleDriver";
		Class.forName(drivername);
		System.out.println("stage1");
		String url="jdbc:oracle:thin:@10.108.144.99:1521/orcl";
		String username="ZTQ";
		String password="fnl12345678";
		Connection conn=null;
		conn = DriverManager.getConnection(url, username, password);
		System.out.println("stage2");

		
		for(int i = 0;i<10;i++){
			int r = SelectOperation.selectEndState("searchstate",conn);
			System.out.println(r);
		}
		conn.close();
	}

}
