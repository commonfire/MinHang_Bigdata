package edu.bupt.basefunc;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * 用户信息JSON数据
 * @author zjd
 *
 */
public class UserInfoJSON {
	/**
	 * @param userAlias    用户昵称
	 * @param rsUserInfo   用户数据库信息
	 * @return             用户信息JSON数据
	 * @throws SQLException
	 * @throws JSONException
	 */
	public static String userinfoJSON(String userAlias, ResultSet rsUserInfo) throws SQLException, JSONException{
		JSONObject jsonObject = new JSONObject();
		String[] chkeyAll = "用户ID,昵称,住址,性别,生日,简介,个人域名,博客".split(",");
		String[] enkeyAll  = "USERID,USERALIAS,LOCATION,SEX,BIRTHDAY,BRIEF,DOMAIN,BLOG".split(",");
		if(rsUserInfo.next()){
			for(int i = 0; i < chkeyAll.length; i++){
				try {
					jsonObject.put(chkeyAll[i], rsUserInfo.getString(enkeyAll[i]));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return jsonObject.toString();
	}
	
	public static void main(String[] args) throws JSONException {
	}
}
