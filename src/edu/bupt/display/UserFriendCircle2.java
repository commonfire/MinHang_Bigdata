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


public class UserFriendCircle2 {
	
	/**
	 * 发现某用户朋友社交圈
	 * @param uid   用户uid
	 * @return 某用户朋友社交圈数组链表
	 */
	public static HashSet<HashMap<String,HashSet<String>>> buildFriendCircle(String userID,Connection conn){   //HashSet<HashMap<String,ArrayList<String>>>
		HashSet<HashMap<String,HashSet<String>>> resultSet = new HashSet<>();
		HashMap<String,HashSet<String>> map = null;
		HashMap<String,Boolean> firstMap = new HashMap<>();  //存储用户第一级关系
		HashMap<String,Boolean> secondMap = null;  //存储用户第二级关系
		HashMap<HashMap<String,Boolean>,String> outerMap = new HashMap<>(); //存储用户第一级关系和第二级关系
		ResultSet rs = null;
		HashSet<String> set = null;
		 try {
			 	rs = SelectOperation.selectRelationuid(userID, conn);
			    while(rs.next()) firstMap.put(rs.getString("relation"), false);
			    outerMap.put(firstMap,userID);
			    for(String uid : firstMap.keySet()){    //遍历第一级所以uid
			    	rs = SelectOperation.selectRelationuid(uid, conn);  //选取指定uid的粉丝或关注用户（统称为relation）
			    	map = new HashMap<>();
			    	secondMap = new HashMap<>();
			    	while(rs.next()){
				  		secondMap.put(rs.getString("relation"), false);
			    		for(HashMap<String,Boolean>innerMap : outerMap.keySet()){
				    		if(innerMap.get(rs.getString("relation"))!=null&&!rs.getString("relation").equals(userID)){    
				    			if(outerMap.get(innerMap).equals(userID)){  //第一级关系
			    					map.put(userID, new HashSet<String>(Arrays.asList(uid)));
			    					set = map.get(userID);
				    				set.add(rs.getString("relation"));
				    				map.put(userID,set);

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
				    				if(!map.containsKey(outerMap.get(innerMap))){
					    				map.put(outerMap.get(innerMap), new HashSet<String>(Arrays.asList(rs.getString("relation"))));
					    			}else{
					    				set = map.get(outerMap.get(innerMap));
					    				set.add(rs.getString("relation"));
					    				map.put(outerMap.get(innerMap),set);
					    			
					    			}
				    				
				    			}
				    		}
				    	}	
			    	}
			    	outerMap.put(secondMap, uid);
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
//		Set<String> h1 = new HashSet<String>(Arrays.asList("1","3"));
//		Set<String> h2 = new HashSet<String>(Arrays.asList("2","1"));
//		HashMap<Set,Boolean> map = new HashMap<>();
//		map.put(h1, true);
//		HashMap<HashMap,Integer> map2 = new HashMap<>();
//		map2.put(map, 1);
//		System.out.println(map2.get(map));
//		for(Set s : map.keySet()){
//			System.out.println(s);
//		} 
//		if(map.containsKey(h2)){
//			System.out.println("true");
//		}
		
		Connection conn = SQLHelper.getConnection();
		System.out.println(UserFriendCircle2.buildFriendCircle("3655612552", conn));
		conn.close();
	}

}
