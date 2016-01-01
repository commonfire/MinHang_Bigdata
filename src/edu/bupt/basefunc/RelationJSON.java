package edu.bupt.basefunc;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;
/**
 * 用户关系标注JSON数据
 * @author zjd
 *
 */
public class RelationJSON {
	private static final String[] friendDict = {"朋友","兄弟","哥们","一起","咱们","吃饭","自习"};
	
	/**
	 * 获取用户关系标注JSON数据
	 * @param userAlias     用户昵称
	 * @return              用户关系标注JSON数据
	 * @throws SQLException 
	 * @throws JSONException 
	 */
	public static String relationJSON(String userAlias, long currentTimeStamp, String inType, Connection conn) throws SQLException, JSONException{
		JSONObject outerJSONObj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		String uid = null;
		ResultSet rs = SelectOperation.selectUid(userAlias, conn);
		if(rs.next()) uid = rs.getString("USERID");
		//ResultSet rsAtuserTopN = SelectOperation.selectAtuser(uid, "5", conn);
		ResultSet rsAtuserTopN = SelectOperation.selectAtuser(uid, currentTimeStamp, "5", inType, conn);
		while(rsAtuserTopN.next()){
			String alias = rsAtuserTopN.getString("ATUSER");
			String userProperty = SelectOperation.selectUserProperty(alias, "USERALIAS ",conn);
			JSONObject innerJSONObj = new JSONObject();
			if("icon_verify_co_v".equals(userProperty)){ //关系连接到公众账号
				innerJSONObj.put(alias, "用户");
				jsonArray.put(innerJSONObj);
			}else{
				innerJSONObj.put(alias, getUserRelation(alias, conn));
				jsonArray.put(innerJSONObj);
			}
		}
		outerJSONObj.put(userAlias, jsonArray);
		return outerJSONObj.toString();
	}
	
	
	/**
	 *  根据微博内容获取非公众账号用户关系
	 * @param userAlias   用户昵称
	 * @param conn        数据库连接对象
	 * @return            与该用户关系
	 * @throws SQLException
	 */
	private static String getUserRelation(String userAlias, Connection conn) throws SQLException{
		String result = "普通";
		ResultSet rsAtuserWeibo = SelectOperation.selectAtuserWeibo(userAlias, conn);
		String atuserWeibo = getAtuserWeibo(rsAtuserWeibo); //@该用户的相关微博
		for(int i = 0; i <= atuserWeibo.length(); i++){
			for(String s : friendDict){
				if(-1 != atuserWeibo.substring(0, i).indexOf(s)){
					result = "好友";
					break;
				}
			}
		}
		return result;
	}
	
	/**
	 * 获取@某用户的相关微博
	 * @param rsAtuserWeibo  at某用户的相关微博结果集
	 * @return               at某用户的相关微博
	 * @throws SQLException
	 */
	private static String getAtuserWeibo(ResultSet rsAtuserWeibo) throws SQLException{
		StringBuilder sb = new StringBuilder();
		while(rsAtuserWeibo.next()){
			Clob clob = rsAtuserWeibo.getClob("CONTENT");
			if(null != clob){   //该用户发表内容为空null
				sb.append(clob.getSubString((long)1, (int)clob.length()));
			}
		}
		return sb.toString();
	}
	
	public static void main(String[] args) throws SQLException, JSONException {
//		Connection conn = SQLHelper.getConnection();
//		System.out.println(relationJSON("乐视网", conn));
//		conn.close();
	}
}
