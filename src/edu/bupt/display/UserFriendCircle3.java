package edu.bupt.display;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;


public class UserFriendCircle3 {
	
	/**
	 * 发现某用户朋友社交圈
	 * @param uid   用户uid
	 * @return 某用户朋友社交圈数组链表
	 */
	public static HashSet<HashMap<String,HashSet<String>>> buildFriendCircle(String userID,Connection conn){   //HashSet<HashMap<String,ArrayList<String>>>
		HashSet<HashMap<String,HashSet<String>>> resultSet = new HashSet<>();
		HashMap<String,HashSet<String>> map = null;
		HashSet<String> firstSet = new HashSet<>();  //存储用户第一级关系
		HashSet<String> secondSet = null;  //存储用户第二级关系
		HashMap<HashSet<String>,String> outerMap = new HashMap<>(); //存储用户第一级关系和第二级关系
		ResultSet rs = null;
		HashSet<String> set = null;
		 try {
			 	rs = SelectOperation.selectRelationuid(userID, conn);
			    while(rs.next()) firstSet.add(rs.getString("relation"));
			    outerMap.put(firstSet,userID);
			    for(String uid : firstSet){    //遍历第一级所以uid
			    	rs = SelectOperation.selectRelationuid(uid, conn);  //选取指定uid的粉丝或关注用户（统称为relation）
			    	map = new HashMap<>();
			    	secondSet = new HashSet<>();
			    	while(rs.next()){
			    		secondSet.add(rs.getString("relation"));
			    		for(HashSet<String>innerSet : outerMap.keySet()){
				    		if(innerSet.contains(rs.getString("relation"))&&!rs.getString("relation").equals(userID)){    
				    			if(outerMap.get(innerSet).equals(userID)){  //第一级关系
				    				if(!map.containsKey(userID)){
				    					map.put(userID, new HashSet<String>(Arrays.asList(uid)));
				    					set = map.get(userID);
					    				set.add(rs.getString("relation"));
					    				map.put(userID,set);
				    				}else{
				    					set = map.get(userID);
					    				set.add(rs.getString("relation"));
					    				map.put(userID,set);
				    				}
				    				
					    			if(!map.containsKey(uid)){
					    				map.put(uid, new HashSet<String>(Arrays.asList(rs.getString("relation"))));
					    			}else{
					    				set = map.get(uid);
					    				set.add(rs.getString("relation"));
					    				map.put(uid,set);
					    			}
				    			}else{
				    				if(!map.containsKey(uid)){
					    				map.put(uid, new HashSet<String>(Arrays.asList(rs.getString("relation"))));
					    			}else{
					    				set = map.get(uid);
					    				set.add(rs.getString("relation"));
					    				map.put(uid,set);
					    			}
				    				if(!map.containsKey(outerMap.get(innerSet))){
					    				map.put(outerMap.get(innerSet), new HashSet<String>(Arrays.asList(rs.getString("relation"))));
					    			}else{
					    				set = map.get(outerMap.get(innerSet));
					    				set.add(rs.getString("relation"));
					    				map.put(outerMap.get(innerSet),set);		    			
					    			}
				    				
				    			}
				    		}
				    	}	
			    	}
			    	outerMap.put(secondSet, uid);
			    	if(!map.isEmpty()){
			    		resultSet.add(map);
			    	}	    	
			    }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
	}
	
	public static void addEdge(Map map,ArrayList<String> list,ResultSet r,String param){

	}
	
	public static void main(String args[]) throws SQLException{
		Connection conn = SQLHelper.getConnection();
		System.out.println(UserFriendCircle3.buildFriendCircle("3655612552", conn));
		conn.close();
	}

}
