package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnect {
	static String drivername="com.mysql.jdbc.Driver";
	static String url="jdbc:mysql://10.108.147.198:3306/weiboanalysis";
//	static String url="jdbc:mysql://localhost:3306/weiboanalysis";
	static String username="root";
	static String password="root";
	
	static{
		try {
			//加载MySql的驱动类
			Class.forName(drivername);
			System.out.println("load driver success");
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
		}
	}
	
	public static Connection getConnection() {
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(url,username,password);
//			System.out.println("connect DB success");
//			Statement stmt = conn.createStatement();
//			stmt.execute("set character_set_client = utf8");
//			stmt.execute("set character_set_connection = utf8");
//			stmt.execute("set character_set_database = utf8");
//			stmt.execute("set character_set_server = utf8");
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("connection fail, check url/username/password");
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void main(String[] args) {
		
//		JDBCConnect.getConnection();
		
	}

}
