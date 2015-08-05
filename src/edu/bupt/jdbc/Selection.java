package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Selection {
	
	public static ResultSet selectUserid(String userAlias,Connection conn){
		String[] str = new String[]{userAlias};
		ResultSet rs = null;
		try {
			rs = SQLHelper.executeQuery("select userID from t_user_info where userAlias = ?", str, conn);
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
			rs = SQLHelper.executeQuery("select id,content,time,userID from t_user_weibo where userID = ?", str, conn);
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
			rs = SQLHelper.executeQuery("select content from t_user_weibo where id= ?", str, conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	
	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://10.108.147.198:3306/weiboanalysis";
		String dbusername="root";
		String dbpassword="root";
		Connection conn=null;
		conn = DriverManager.getConnection(url, dbusername, dbpassword);
		//ResultSet rs = Selection.selectUserid("飞友杂志", conn);
		ResultSet rs = Selection.selectContent("8585", conn);
		rs.next();
		System.out.println(rs.getString("content"));
		conn.close();
	}

}
