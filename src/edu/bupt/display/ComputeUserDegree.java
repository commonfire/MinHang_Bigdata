package edu.bupt.display;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Stack;
import java.util.Vector;

import edu.bupt.jdbc.InsertOperation;
import edu.bupt.jdbc.SQLHelper;
import edu.bupt.jdbc.SelectOperation;
import edu.bupt.soft.OrientationCompute;

public class ComputeUserDegree {
	
	/**
	 * 计算用户信息表中各用户的舆情等级值
	 * @param count  统计用户微博条数
	 * @throws Exception 
	 */
	public void computeUserDegree(final int count) throws Exception{
		Connection conn = SQLHelper.getConnection();
		ResultSet rs =  SelectOperation.selectUid(conn);
		ResultSet rs1 = null;
		String userID = null;
		String blog = null;
		String result="0";  //记录各用户的舆情等级值
		PreparedStatement ps = conn.prepareStatement("update t_user_info set degree=? where userID=?");
		if(rs!=null){
			while(rs.next()){
				double score = 0;
				userID = rs.getString("userID");
				rs1 = SelectOperation.selectContent(userID, conn, count);
				if(rs1!=null){
					while(rs1.next()){
						Clob clob = rs1.getClob("content");
						if(clob!=null) blog = clob.getSubString((long)1,(int)clob.length());
						else blog = null;
						//System.out.println(blog);
						score += new OrientationCompute().calcDSOofBlog2(blog);
					} 
				}
				result = ShowFormat.showFormat(score/count);
				InsertOperation.insertUserDegree(userID, result, ps, conn);
				//System.out.println("!!!!!!"+userID+":"+result);
			}
		}
		ps.close();
		conn.close();
	}
	
	
	public static void main(String[] args) throws Exception {
		 new ComputeUserDegree().computeUserDegree(5);
		 
	}

}
