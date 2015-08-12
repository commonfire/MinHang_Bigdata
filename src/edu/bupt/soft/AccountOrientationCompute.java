package edu.bupt.soft;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

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
    	String sql = "select content from t_user_weibo where userID = "+userid+" order by time desc limit "+topN;
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
		return score;
	}
	
	
	public static void main(String[] args) {
		System.out.println(new AccountOrientationCompute().calAccountOrientation("1736439373", 10));
	}

}
