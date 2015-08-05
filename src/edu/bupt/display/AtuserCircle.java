package edu.bupt.display;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import edu.bupt.jdbc.SelectWeibo;

/**
 * @author DELL
 *
 */
public class AtuserCircle {
	
	/**
	 * 过滤并结构化某用户的at用户列表
	 * @param atuserString  待处理的at用户数据
	 * @return	过滤并结构化的at用户数据
	 */
	private ArrayList<String> filterAtuserData(String atuserString){
		ArrayList<String> resultlist = new ArrayList<String>();
		if(atuserString!=""){
			if(atuserString.startsWith("@")){
				if(atuserString.contains("O")){
					resultlist.add(atuserString.substring(1,atuserString.indexOf(" ")));
					return resultlist;
				}else{
					String tmp = atuserString.replace(" ", "");
					StringBuffer tmpbuffer = new StringBuffer(tmp);
					tmpbuffer.deleteCharAt(0);
					tmp = tmpbuffer.toString();
					Collections.addAll(resultlist, tmp.split("@"));
					return resultlist;
				}
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	/**
	 * 将结果排序，获取topN的排序结果
	 * @param map   待排序的数据
	 * @param topN  排名前N名
	 * @return      topN的排序结果
	 */
	public static HashMap<String,Integer> sortUserMap(HashMap<String,Integer> map,int topN){
		Integer flag = 1;
		LinkedHashMap<String, Integer> sortedN_map = new LinkedHashMap<String, Integer>();
		List<Map.Entry<String,Integer>> list = new ArrayList<Map.Entry<String,Integer>>(map.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
			@Override
			public int compare(Entry<String, Integer> o1,
					Entry<String, Integer> o2) {
				// 降序排列
				return o2.getValue().compareTo(o1.getValue());
			}
		});
		for (Map.Entry<String, Integer>entry:list){
			if(flag <= topN){
				sortedN_map.put(entry.getKey(), entry.getValue());
				flag++;
			}else break;
		}
		return sortedN_map;
	}



	/**
	 * 获得某用户at用户次数topN的用户
	 * @param userID  某用户的userID
	 * @param topN    获取前N名at次数的用户   
	 * @return        某用户与其at次数topN的用户名和相应at次数
	 */
	public HashMap<String, HashMap<String, Integer>> getTopAtUser(String userID,int topN){	
		 ArrayList<String> atuser_list = new ArrayList<String>();
	     HashMap<String, HashMap<String, Integer>> outer_map = new HashMap<String, HashMap<String, Integer>>();
	     HashMap<String, Integer> inner_map = new HashMap<String, Integer>();
		 try {
			    ResultSet rs = new SelectWeibo().selectWeibo(userID);
			 	while(rs.next()){
			 		String atuser = rs.getString("atuser");
			 		atuser_list = this.filterAtuserData(atuser);
			 		if(atuser_list!=null){
			 			for(String atuser2:atuser_list){
			 				if(inner_map.containsKey(atuser2)){
			 					inner_map.put(atuser2, inner_map.get(atuser2)+1);  //注意不可以使用++，其只对变量有作用
			 				}else{
			 					inner_map.put(atuser2, 1);
			 				}
			 			}
			 		}
			 }
			 outer_map.put(userID,sortUserMap(inner_map,topN));
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return outer_map;
	}

	
	public static void main(String[] args) {
		
		try {
			 HashMap<String, HashMap<String, Integer>> test_map = new HashMap<String, HashMap<String, Integer>>();
			 test_map = new AtuserCircle().getTopAtUser("2728266823", 5);
			 System.out.println(test_map);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
}
