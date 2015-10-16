package edu.bupt.soft;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import edu.bupt.jdbc.SQLHelper;

public class AccountOrientationCompute extends OrientationCompute {
	
	/**
	 * 计算给定微博账号的情感得分
	 * @param userid       给定微博账号uid
	 * @param topN		      获取时间排序前topN的微博分析
	 * @return			      返回该用户的情感分数
	 */
	public double calAccountOrientation(String userid,int topN){
    	Connection conn = SQLHelper.getConnection();
    	String blogcontent = null;
    	double score = 0;
    	String sql = "select content from t_user_weibocontent where userID = "+userid+" order by publishTime desc limit "+topN;
		ResultSet rs;
		try {
			rs = SQLHelper.executeQuery(sql, null, conn);
			while(rs.next()){
				blogcontent = rs.getString("content");
				score += calcDSOofBlog1(blogcontent);
			}	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return score;
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return score/topN;
	}
	
	public void processAccountOrientation(){
		Connection conn = SQLHelper.getConnection();
    	String sql1 = "select userID from t_user_info";
    	String sql2 = "insert ignore into t_user_info(userID,degree) values(?,?)";
		ResultSet rs;
		String userid = null;
		double score = 0;
		try {
			rs = SQLHelper.executeQuery(sql1, null, conn);
			while(rs.next()){
				userid = rs.getString("userID");
				score = calAccountOrientation(userid, 10);
				SQLHelper.executeUpdate(sql2, new String[]{String.valueOf(score),userid});
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	

	public static void main(String[] args) throws SQLException {
//		System.out.println(new AccountOrientationCompute().calAccountOrientation("1736439373", 10));
		//new AccountOrientationCompute().processAccountOrientation();

	}

}
