package edu.bupt.basefunc;
import java.util.*;
import org.json.*;
import edu.bupt.jdbc.*;
import java.sql.*;
public class basicFun {	
	public static HashMap<String,String> cateMapBuild(String[] cateList,String[] cateChineseList){
		HashMap<String,String> userInfoCateMap = new HashMap<String,String>();
		for(int i=0;i<cateList.length;i++){
			userInfoCateMap.put(cateList[i], cateChineseList[i]);
		}
		return userInfoCateMap;
	}
	
	public static JSONObject MapToJSONObj (Map map) throws JSONException{
		JSONObject jsonObj = new JSONObject();
		Set<String> keys = map.keySet();	
		for(String key : keys){
			if(key != null){
				jsonObj.put(key,map.get(key));
			}
		}
		return jsonObj;
	}
	
	public static void expandInfoMap(Map usrInfo,String userId,String[] cateList,String user,Connection conn) throws SQLException{
		HashMap<String,String> mapInfoTempSecond = new HashMap<String,String>();
		ResultSet rsinfotemp= SelectOperation.selectUserinfo(userId, conn);
		if(rsinfotemp != null){
			while(rsinfotemp.next()){
				for(String cate : cateList){
					try {
						mapInfoTempSecond.put(cate,rsinfotemp.getString(cate));
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}	
			}
		}
		usrInfo.put(user,mapInfoTempSecond);
	}
	public static void expandInfoMap(Map usrInfo,String[] cateList,String atuser,ResultSet rsinfotemp) throws SQLException{
		HashMap<String,String> mapInfoTempSecond = new HashMap<String,String>();
		while(rsinfotemp.next()){
			for(String cate : cateList){
				try {
					mapInfoTempSecond.put(cate,rsinfotemp.getString(cate));
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
		}
		usrInfo.put(atuser,mapInfoTempSecond);
	}
	
	public static void expandRelationMap(HashMap<String,ArrayList<HashMap<String,String>>> map,String mainUser,String name1,String number){
		ArrayList<HashMap<String,String>> list2 = new ArrayList<HashMap<String,String>>();
		map.put(name1,list2);
		HashMap<String,String> mapTemp = new HashMap<String,String>();			
		mapTemp.put(name1,number);				
		map.get(mainUser).add(mapTemp);		
	}
	
	public static void main(String[] args) {
		
	}
	
	
}
