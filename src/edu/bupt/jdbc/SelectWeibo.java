package edu.bupt.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class SelectWeibo {
	
	public ResultSet selectWeibo(String userID){
		List<Object> list = new ArrayList<Object>();
		list.add(userID);
		//ResultSet rs = SelectOperation.selectOnes("select id,content,time,atuser,repostuser,userID from t_user_weibo where userID = ?",list);	
		ResultSet rs = SelectOperation.selectOnes("select id,content,time,userID from t_user_weibo where userID = ?",list);	
	    return rs;
	}
	
	public ResultSet selectUserid(String userAlias){
		List<Object> list = new ArrayList<Object>();
		list.add(userAlias);
		ResultSet rs = SelectOperation.selectOnes("select userID from t_user_info where userAlias = ?",list);
		return rs;
	}
	
	public ResultSet selectWeiboForLevel(String id){
		List<Object> list = new ArrayList<Object>();
		list.add(id);
		ResultSet rs = SelectOperation.selectOnes("select content from t_user_weibo where id = ?", list);	
	    return rs;
	}
	
	public ResultSet selectWeiboForLevel(String userID,int count){
		List<Object> list = new ArrayList<Object>();
		list.add(userID);
		ResultSet rs = SelectOperation.selectOnes("select content from t_user_weibo where userID = ? limit "+count, list);	
	    return rs;
	}
	
	public ResultSet selectUserInfo(int count) throws SQLException{
		ResultSet rs = SelectOperation.selectOnes("select location from t_user_info limit "+count);
	    return rs;
	}
	
	public static void main(String[] args) throws SQLException {
//		ResultSet rs = new SelectWeibo().selectUserInfo(5);
//		while(rs.next()){
//			System.out.println(rs.getString("location"));
//			System.out.println(rs.getRow());
//		}
		
	String a = "完美";
	String b = "完美无瑕";
	if(a.contains(b)) System.out.println("hello");
	else System.out.println("no");
	}

}
