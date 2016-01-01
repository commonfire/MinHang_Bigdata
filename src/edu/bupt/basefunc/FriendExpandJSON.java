package edu.bupt.basefunc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;

/**
 * @author zjd
 *  人物节点扩展JSON数据
 *
 */
public class FriendExpandJSON {
	
	/**
	 * 将数据库用户关系数据转换为JSON数据格式
	 * @param userAlias  用户昵称
	 * @param rsRelation 用户关系查询数据结果集
	 * @return   转换后的JSON格式数据用以处理右键扩展用户关系图谱
	 * @throws SQLException 
	 */
	public static String friendExpandJSON(String userAlias ,ResultSet rsRelation) throws SQLException{
		String result = "0";
		StringBuilder nodeBuilder = new StringBuilder();
		StringBuilder linkBuilder = new StringBuilder();
		
		if(null == rsRelation || !rsRelation.next()) return "0";
		rsRelation.beforeFirst();
		
		ResultSetMetaData rsRelationMetaData = rsRelation.getMetaData();
		while(rsRelation.next()){
			String targetName = rsRelation.getString(rsRelationMetaData.getColumnLabel(2));  //获取@用户昵称
			String totalNumber = rsRelation.getString(rsRelationMetaData.getColumnLabel(4)); //获取@用户数量
			nodeBuilder.append("{\"category\":\"3\",\"name\":\""+targetName+"\",\"value\":\""+totalNumber+"\"},");
//			linkBuilder.append("{\"source\":\""+userName+"\",\"target\":\""+targetName+"\",\"weight\":\""+totalNumber+"\"},");
			linkBuilder.append("{\"source\":\""+userAlias+"\",\"target\":\""+targetName+"\",\"weight\":\""+totalNumber+"\",\"name\":\""+totalNumber+"次\",\"itemStyle\":{\"normal\":{\"width\":"+totalNumber+"}}},");
		}
		String nodeStr = nodeBuilder.toString();
		String linkStr = linkBuilder.toString();
		if(!nodeStr.equals("") && !linkStr.equals("")){
			result = "{\"nodes\":["+nodeStr.substring(0, nodeStr.length()-1)+"],\"links\":["+linkStr.substring(0, linkStr.length()-1)+"]}";
		}		
		return result;
	}
	
	public static void main(String[] args) throws SQLException {
		/*String userID = "11";
		Connection conn = SQLHelper.getConnection();
		ResultSet rs1 = SelectOperation.selectAtuser(userID,"5",conn);
		ResultSet rs2 = SelectOperation.selectAlias(userID, conn);

		System.out.println(friendExpandJSON(rs2, rs1));

		conn.close();*/
	}

}
