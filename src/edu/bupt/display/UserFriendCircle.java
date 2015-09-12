package edu.bupt.display;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;


public class UserFriendCircle {
	
	/**
	 * 发现某用户朋友社交圈
	 * @param uid    用户uid
	 * @param topN   获取前N名at次数的用户  
	 * @param conn   数据库连接  
	 * @return       某用户朋友社交圈的用户名和互动频数
	 */
	public static HashMap<String, HashMap<String, Integer>> buildFriendCircle(String userID,int topN,Connection conn){
		 ArrayList<String> atuser_list = new ArrayList<String>();
	     HashMap<String, HashMap<String, Integer>> outer_map = new HashMap<String, HashMap<String, Integer>>();
	     HashMap<String, Integer> inner_map = new HashMap<String, Integer>();
	     try {
	    	 	ResultSet rs = SelectOperation.selectWeibo(userID, conn);
	    	 	while(rs.next()){
			 		String atuser = rs.getString("atuser");
			 		atuser_list = AtuserCircle.filterAtuserData(atuser);
			 		if(atuser_list!=null){ 
			 			for(String atuser2:atuser_list){
			 				if(inner_map.containsKey(atuser2)){
			 					inner_map.put(atuser2, inner_map.get(atuser2)+1);  //注意不可以使用++，其只对变量有作用
			 				}else{
			 					inner_map.put(atuser2, 1);
			 				}
			 			}
			 		}
			 		String repostuser = rs.getString("repostuser");
			 		if(repostuser!=null){
		 				if(inner_map.containsKey(repostuser)){
		 					inner_map.put(repostuser, inner_map.get(repostuser)+1);   //注意不可以使用++，其只对变量有作用
		 				}else{
		 					inner_map.put(repostuser, 1);
		 				}
			 		}	
			 }
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	    
	    outer_map.put(userID,AtuserCircle.sortUserMap(inner_map,topN));
		return outer_map;  
	}
	
	public static void main(String[] args) throws SQLException {
		 HashMap<String, HashMap<String, Integer>> test_map = new HashMap<String, HashMap<String, Integer>>();
		 Connection conn = SQLHelper.getConnection();
		 test_map = UserFriendCircle.buildFriendCircle("3655612552",5,conn);
		 System.out.println(test_map);
		 conn.close();
	}
	
	
}