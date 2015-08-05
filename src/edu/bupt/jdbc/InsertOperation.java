package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;


public class InsertOperation {
	
	private static Connection conn=JDBCConnect.getConnection();
	private static PreparedStatement pstm =null;
	/**
	 * 完成向数据库中插入一条数据的功能
	 * @param sql 传递要执行的sql语句
	 * @param param  需要插入的数据，顺序与sql中的占位符保持一致
	 * @return  返回插入操作执行成功与否
	 */
	public static boolean insertOne(String sql,List<Object> param){
		if (param.size()<=0) {
			return false;
		}		
		try {
			 pstm=conn.prepareStatement(sql);
			for (int i = 0; i < param.size() ; i++) {
				set(i+1, param.get(i));
			}
			pstm.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();			
			return false;
		}
		
		return true;
	}
	
	/**
	 * @param index 指示所填充的位置 
	 * @param obj	在指示位置填充的数据
	 * @throws SQLException 
	 */
	private static void set(int index,Object obj) throws SQLException{
		String valType=obj.getClass().getSimpleName();
		switch (valType) {
		case "String":
			pstm.setString(index, (String)obj);
			break;
		case "Integer":
			pstm.setInt(index, (int)obj);
			break;
		default:
			break;
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
