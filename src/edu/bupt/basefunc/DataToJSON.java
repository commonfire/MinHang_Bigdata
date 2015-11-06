package edu.bupt.basefunc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;

/**
 * @author zjd
 * 数据格式JSON转换
 *
 */
public class DataToJSON {
	
	/**
	 * 将数据库用户关系数据转换为JSON数据格式
	 * @param rsUserName 用户昵称查询数据结果集
	 * @param rsRelation 用户关系查询数据结果集
	 * @return   转换后的JSON格式数据用以处理右键扩展用户关系图谱
	 * @throws SQLException 
	 */
	public static String friendExpandJSON(ResultSet rsUserName ,ResultSet rsRelation) throws SQLException{
		String result = null;
		StringBuilder nodeBuilder = new StringBuilder();
		StringBuilder linkBuilder = new StringBuilder();
		
		if(null ==rsUserName || null == rsRelation) return "{\"result\":\"0\"}";
		ResultSetMetaData rsUserNameMetaData = rsUserName.getMetaData();
		rsUserName.next();
		String userName = rsUserName.getString(rsUserNameMetaData.getColumnLabel(1));  //获取用户昵称
		
		ResultSetMetaData rsRelationMetaData = rsRelation.getMetaData();
		while(rsRelation.next()){
			String targetName = rsRelation.getString(rsRelationMetaData.getColumnLabel(2));  //获取@用户昵称
			String totalNumber = rsRelation.getString(rsRelationMetaData.getColumnLabel(4)); //获取@用户数量
			nodeBuilder.append("{\"category\":\"3\",\"name\":\""+targetName+"\",\"value\":\""+totalNumber+"\"},");
			linkBuilder.append("{\"source\":\""+userName+"\",\"target\":\""+targetName+"\",\"weight\":\""+totalNumber+"\"},");
		}
		String nodeStr = nodeBuilder.toString();
		String linkStr = linkBuilder.toString();
		result = "{\"nodes\":["+nodeStr.substring(0, nodeStr.length()-1)+"],\"links\":["+linkStr.substring(0, linkStr.length()-1)+"]}";
		return result;
	}
	
	public static void main(String[] args) throws SQLException {
		String userID = "1152369551";
		Connection conn = SQLHelper.getConnection();
		ResultSet rs1 = SelectOperation.selectAtuser(userID,"5",conn);
		ResultSet rs2 = SelectOperation.selectAlias(userID, conn);
		
//		while(rs1.next()){
//			System.out.println(rs1.getString("atuser"));
//		}	
//		while(rs2.next()){
//			System.out.println(rs2.getString("userAlias"));
//		}
		System.out.println(friendExpandJSON(rs2, rs1));
		
	}

}
