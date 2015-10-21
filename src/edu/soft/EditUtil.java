package edu.soft;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

public class EditUtil {

	//进行编辑页面的重构函数
	public HashMap<String,String> getEdit(Statement stmt,String sql,String fieldStr) throws Exception{
		HashMap<String,String> map=new HashMap<String,String>();
		String[] array=fieldStr.split(",");
		ResultSet rs=stmt.executeQuery(sql);
		edu.soft.MyString dt=new edu.soft.MyString();
		if(rs.next()){
			for(int i=0;i<array.length;i++){
				map.put(array[i],dt.isNull(rs.getString(array[i])));
			}
		}
		return map;
	}
	//进行编辑页面的重构函数--包含数据类型的函数
	public HashMap<String,String> getEdit(Statement stmt,String sql,String fieldStr,String typeStr) throws Exception{
		HashMap<String,String> map=new HashMap<String,String>();
		String[] array=fieldStr.split(",");
		String[] typeArr=typeStr.split(",");
		ResultSet rs=stmt.executeQuery(sql);
		edu.soft.MyString dt=new edu.soft.MyString();
		if(rs.next()){
			for(int i=0;i<array.length;i++){
				if(typeArr[i].equals("C")){
					map.put(array[i],dt.isNull(rs.getString(array[i])));
				}else if(typeArr[i].equals("D")){
					map.put(array[i],dt.isNull(rs.getDouble(array[i])));
				}else if(typeArr[i].equals("I")){
					map.put(array[i],dt.isNull(rs.getInt(array[i])));
				}
			}
		}
		return map;
	}
}