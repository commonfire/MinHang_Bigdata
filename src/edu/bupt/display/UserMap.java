package edu.bupt.display;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;

import edu.bupt.jdbc.SelectOperation;

/**
 * @author zjd
 * 地图上显示用户位置分布
 */
public class UserMap {
	
	/**
	 * @param origindata  数据库中原始用户数据
	 * @return            过滤后的用户地理位置数据
	 */
	public String filterData(String origindata){
		String[] result = origindata.split(" ");
		return result[0];
	}
	
	/**
	 * 统计用户分布地理位置信息
	 * @param uid        用户uid
	 * @param itemN      统计数据库中用户信息的条数
	 * @return			 地理位置及对应用户数
	 */
	public HashMap<String,Integer> getUserGeoInfo(String uid,int itemN,Connection conn){
		HashMap<String,Integer> usermap = new HashMap<String, Integer>();
		try {
			ResultSet rs = SelectOperation.selectUserinfo(uid, conn, itemN);
			while(rs.next()){
				String province = filterData(rs.getString("location"));
				if(usermap.containsKey(province)){
					usermap.put(province, usermap.get(province)+1);
				}
				else{
					usermap.put(province, 1);
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return usermap;
	}
	
//	public static void main(String[] args) {
//		HashMap<String,Integer> test = new HashMap<String, Integer>();
//		test = new UserMap().getUserGeoInfo(5);
//		System.out.println(test.get("湖南")==null?0:test.get("湖南"));
//	}

}
