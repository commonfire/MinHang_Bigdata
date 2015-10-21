package edu.soft;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

public class FindUtil {
	//计算单位名称
	public String getUnitname(Statement stmt,String xd,HttpSession session) throws Exception{
		String unitid="";
		if(!xd.equals("")){//是单独打开的小队的页面
			//根据数据库中的数据，取出用户类别和单位ID
			ResultSet rsXd=stmt.executeQuery("SELECT * FROM U_USERS WHERE UNITID='"+xd+"'");
			if(rsXd.next()){
				unitid=rsXd.getString("UNITID");
			}
			rsXd=null;
		}else{
			unitid=getSessionById(session,"unitid");//获取UnitId
		}
		String unitname=getValueBySQL(stmt,"SELECT MC FROM U_ORGANIZATION WHERE ID="+unitid,"MC");
		return unitname;
	}
	//计算用户类别
	public String getUserlb(Statement stmt,String xd,HttpSession session) throws Exception{
		String userlb="";
		if(!xd.equals("")){//是单独打开的小队的页面
			//根据数据库中的数据，取出用户类别和单位ID
			ResultSet rsXd=stmt.executeQuery("SELECT * FROM U_USERS WHERE UNITID='"+xd+"'");
			if(rsXd.next()){
				userlb=rsXd.getString("LB");//用户类别
			}
			rsXd=null;
		}else{
			userlb=getSessionById(session,"userlb");//用户类别
		}
		return userlb;
	}
	//包括自己和下属所有单位的IDS.
	public String getSubordinateIdsContains_Advanced(Statement stmt,String unitname) throws Exception{
		StringBuffer buffer=new StringBuffer("(1,");
		ResultSet rs=stmt.executeQuery("select id from u_organization where mc='"+unitname+"' union select id from u_organization where pid=(select id from u_organization where mc='"+unitname+"') union select id from u_organization where pid in (select id from u_organization where pid in (select id from u_organization where mc='"+unitname+"')) union (select id from u_organization where pid in (select id from u_organization where pid in (select id from u_organization where pid in (select id from u_organization where mc='"+unitname+"'))))");
		while(rs.next()){
			buffer.append(rs.getInt("ID")).append(",");
		}
		//特殊处理，如果是：南方项目部、胜利油区、新疆项目部、东北项目部、长庆项目部
		MyString dt=new MyString();
		if(unitname.equals(dt.isNull("南方项目部"))||unitname.equals(dt.isNull("胜利油区"))||unitname.equals(dt.isNull("新疆项目部"))||unitname.equals(dt.isNull("东北项目部"))||unitname.equals(dt.isNull("长庆项目部"))){
			buffer.append("3,");
		}
		//三分公司项目部:管理一部、管理二部、管理三部
		if(unitname.equals(dt.isNull("管理一部"))||unitname.equals(dt.isNull("管理二部"))||unitname.equals(dt.isNull("管理三部"))){
			buffer.append("4,");
		}
		String result=null;
		if(buffer.length()>1){result=buffer.substring(0,buffer.length()-1);}
		return result+")";
	}
	//取出包括ID=1和自己本身的ID列表 2013-05-07 张培颖 重构代码 重载函数
	public String getSubordinateIdsContains(Statement stmt,String unitname) throws Exception{
		StringBuffer buffer=new StringBuffer("(1,");
		ResultSet rs=stmt.executeQuery("select id from u_organization where mc='"+unitname+"' union select id from u_organization where pid=(select id from u_organization where mc='"+unitname+"') union select id from u_organization where pid in (select id from u_organization where pid in (select id from u_organization where mc='"+unitname+"'))");
		while(rs.next()){
			buffer.append(rs.getInt("ID")).append(",");
		}
		String result=buffer.toString();
		if(result.length()>1){result=result.substring(0,result.length()-1);}
		return result+")";
	}
	//取出所有下属单位的ID列表 2013-03-29 张培颖
	public String getSubordinateIds(Statement stmt,String unitname) throws Exception{
		StringBuffer buffer=new StringBuffer("(");
		ResultSet rs=stmt.executeQuery("select id from u_organization where pid=(select id from u_organization where mc='"+unitname+"') union select id from u_organization where pid in (select id from u_organization where pid in (select id from u_organization where mc='"+unitname+"'))");
		while(rs.next()){
			buffer.append(rs.getInt("ID")).append(",");
		}
		String result=buffer.toString();
		if(result.length()>1){result=result.substring(0,result.length()-1);}
		return result+")";
	}
	//获取Session中的数据。
	public String getSessionById(HttpSession ses,String key) throws Exception{
		edu.soft.MyString dt=new edu.soft.MyString();
		String result="";
		result=dt.isNull((String)ses.getAttribute(key));
		return result;
	}
	//根据SQL，取出指定列的值  用于取出单位名称
	public String getValueBySQL(Statement stmt,String sql,String columnName) throws Exception{
		String result="";
		ResultSet rs=stmt.executeQuery(sql);
		if(rs.next()){
			result=rs.getString(columnName);
		}rs=null;
		return result;
	}
	//根据表名称，取出指定列的数组
	public String[] getNames(Statement stmt,String tableName,String columnName) throws Exception{
		ArrayList<String> list=new ArrayList<String>();
		ResultSet rs=stmt.executeQuery("SELECT "+columnName+" FROM "+tableName+" ORDER BY ID");
		while(rs.next()){
			list.add(rs.getString(columnName));
		}rs=null;
		String[] Array=new String[list.size()];
		for(int i=0;i<list.size();i++){
			Array[i]=(String)list.get(i);
		}
		list.clear();list=null;
		return Array;
	}
	//根据SQL语句进行查询
	public static String[] getNamesBySQL(Statement stmt,String sql,String columnName) throws Exception{
		ArrayList<String> list=new ArrayList<String>();
		ResultSet rs=stmt.executeQuery(sql);
		while(rs.next()){
			list.add(rs.getString(columnName));
		}rs=null;//释放空间
		String[] Array=new String[list.size()];
		for(int i=0;i<list.size();i++){
			Array[i]=(String)list.get(i);
		}
		list.clear();list=null;//释放空间
		return Array;
	}
}