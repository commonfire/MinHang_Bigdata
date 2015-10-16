package edu.bupt.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;


public class InsertOperation {
	public static void insertUserDegree(String userID,String degree,PreparedStatement ps,Connection conn) throws SQLException{
		String[] parameters = {degree,userID};
		SQLHelper.executeUpdate(parameters, conn, ps);
	}
}