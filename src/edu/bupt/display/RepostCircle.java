package edu.bupt.display;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;

public class RepostCircle {
	
	/**
	 * 获得某用户转发用户次数topN的用户
	 * @param userID   某用户的userID
	 * @param topN     获取前N名转发次数的用户   
	 * @param conn     数据库连接  
	 * @return         某用户与其转发次数topN的用户名和相应转发次数
	 */
	public HashMap<String,HashMap<String,Integer>> getTopRepostUser(String userID,int topN,Connection conn){
	     HashMap<String, HashMap<String, Integer>> outer_map = new HashMap<String, HashMap<String, Integer>>();
	     HashMap<String, Integer> inner_map = new HashMap<String, Integer>();
		 try {
			    ResultSet rs = SelectOperation.selectWeibo(userID, conn);
			 	while(rs.next()){
			 		String repostuser = rs.getString("repostuser");
			 		if(repostuser!=null&&repostuser!=""){
		 				if(inner_map.containsKey(repostuser)){
		 					inner_map.put(repostuser, inner_map.get(repostuser)+1);   //注意不可以使用++，其只对变量有作用
		 				}else{
		 					inner_map.put(repostuser, 1);
		 				}
			 		}
			 }
			 outer_map.put(userID,AtuserCircle.sortUserMap(inner_map,topN));
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return outer_map;
	}
	
	public static void main(String[] args) throws SQLException {
		Connection conn = SQLHelper.getConnection();
		HashMap<String, HashMap<String, Integer>> test_map = new HashMap<String, HashMap<String, Integer>>();
		 test_map = new RepostCircle().getTopRepostUser("3655612552", 5,conn);
		 conn.close();
		 System.out.println(test_map);
	}

}
