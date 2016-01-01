package edu.bupt.basefunc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import edu.bupt.jdbc.SQLHelper;

public class Filter {
		/**
		 * 过滤数据库中含有的用户uid
		 * @param originalUidStr 未过滤的用户uid列表
		 * @param conn    数据库连接对象
		 * @return 已过滤的字符串形式用户uid列表
		 * @throws SQLException 
		 */
		public static String filterContainedUid(List<String> originalUidStr, Connection conn) throws SQLException{
	   	List<String> result = new ArrayList<>();
	   	ResultSet rs = null;
	   	String sql = "select count(*) from (select userID from t_user_info where userID=? union select userID from t_publicuser_info where userID=?)";
	   	for(String uid : originalUidStr){
	   		String[] parameters = {uid,uid};
		   	try {
					rs = SQLHelper.executeQuery(sql, parameters, conn);
					rs.next();
					int count = rs.getInt(1);
					if(0 == count) result.add(uid); //该用户uid没有爬取过
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	   		}
			if(0 == result.size()) return "";
			return result.toString().replaceAll("\\s", "");
		}
		
		public static void main(String[] args) throws SQLException {
	/*	  	Connection conn = SQLHelper.getConnection();
		  	String[] s = {"5680880622","2609648351","2855893887","2968634427","3247610470","2608693591","1974808274","1732370473","1937280734","3044746573","1948630450","1808084593","2143550005"};
		  	//String[] s = {"3655612552"};
		  	System.out.println(filterContainedUid(Arrays.asList(s)));
		  	if("".equals(filterContainedUid(Arrays.asList(s))))
		  	System.out.println("dd");
		   conn.close();*/
		}
}
