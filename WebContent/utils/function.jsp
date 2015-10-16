<%@ page 
	import="java.sql.*"
	import="java.util.*"
	import="java.servlet.*"
	import="edu.soft.MyString"
%>
<%!
//获取字段值的数组表示
public static String[] getNamesOrderById(Statement stmt,String tableName,String columnName) throws Exception{
	ArrayList list=new ArrayList();
	ResultSet rs=stmt.executeQuery("SELECT "+columnName+" FROM "+tableName+" ORDER BY ID");
	while(rs.next()){
		list.add(rs.getString(columnName));
	}
	String[] Array=new String[list.size()];
	for(int i=0;i<list.size();i++){
		Array[i]=(String)list.get(i);
	}
	return Array;
}
//根据SQL语句进行查询
public static String[] getNamesBySQL(Statement stmt,String sql,String columnName) throws Exception{
	ArrayList list=new ArrayList();
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		list.add(rs.getString(columnName));
	}
	String[] Array=new String[list.size()];
	for(int i=0;i<list.size();i++){
		Array[i]=(String)list.get(i);
	}
	return Array;
}
//获取字段值的数组表示
public static String[] getNames(Statement stmt,String tableName,String columnName) throws Exception{
	ArrayList list=new ArrayList();
	ResultSet rs=stmt.executeQuery("SELECT "+columnName+" FROM "+tableName+" ORDER BY "+columnName);
	while(rs.next()){
		list.add(rs.getString(columnName));
	}
	String[] Array=new String[list.size()];
	for(int i=0;i<list.size();i++){
		Array[i]=(String)list.get(i);
	}
	return Array;
}
//进行编辑页面的重构函数
public HashMap<String,String> getEdit(Statement stmt,String sql,String str) throws Exception{
	HashMap<String,String> map=new HashMap<String,String>();
	String[] array=str.split(",");
	ResultSet rs=stmt.executeQuery(sql);
	MyString dt=new MyString();
	if(rs.next()){
		for(int i=0;i<array.length;i++){
			map.put(array[i],dt.isNull(rs.getString(array[i])));
		}
	}
	return map;
}
//进行编辑页面的重构函数--包含数据类型的函数
public HashMap<String,String> getEdit(Statement stmt,String sql,String str,String typeStr) throws Exception{
	HashMap<String,String> map=new HashMap<String,String>();
	String[] array=str.split(",");
	String[] typeArr=typeStr.split(",");
	ResultSet rs=stmt.executeQuery(sql);
	MyString dt=new MyString();
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
//〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓
public StringBuffer getCondition(StringBuffer sb,String field,String param){//查询条件的拼接StringBuffer版
	StringBuffer result=sb;
	try{
		if(param!=null&&!param.equals("")){
			result.append(" AND ").append(field).append("='").append(param).append("'");
		}
	}catch(Exception e){
		System.out.println("获取条件函数：getCondition StringBuffer 版 发生错误："+e.getMessage());
	}
	return result;
}
public StringBuffer getCondition(StringBuffer sb,String field,String param1,String param2){//查询条件的计算：在一个区间内 BETWEEN AND 
	StringBuffer result=sb;
	try{
		if(param1!=null&&!param1.equals("")&&param2!=null&&!param2.equals("")){
			result.append(" AND (").append(field).append(" BETWEEN ").append(param1).append(" AND ").append(param2).append(")");
		}
	}catch(Exception e){
		System.out.println("获取条件函数：getCondition StringBuffer BETWEEN _ AND 版 发生错误："+e.getMessage());
	}
	return result;
}
public StringBuffer getConditionBlur(StringBuffer sb,String field,String param){//查询条件的拼接StringBuffer版--带模糊查询功能
	StringBuffer result=sb;
	try{
		if(param!=null&&!param.equals("")){//下面拼接查询条件LIKE
			String param_like="";
			for(int i=0;i<param.length();i++){
				param_like=param_like+param.substring(i,i+1)+"%";
			}
			result.append(" AND ").append(field).append(" LIKE '%").append(param).append("%'");
		}
	}catch(Exception e){
		System.out.println("获取条件函数：getCondition StringBuffer 版--带模糊查询功能 发生错误："+e.getMessage());
	}
	return result;
}
public String fetchBasePath(HttpServletRequest _request){//取出当前的路径basePath
	String basePath="";
	try{
		basePath = _request.getScheme()+"://"+_request.getServerName()+":"+_request.getServerPort()+_request.getContextPath()+"/";
	}catch(Exception e){
		System.out.println("函数fetchBasePath发生错误:"+e.getMessage());
	}
	return basePath;
}
//2011-04-19 张培颖 目的：为了调整list页面的显示效果。要没有数据，就显示空格。
public String space(String str){
	if(str.equals("")){
		return "&nbsp;";
	}else{
		return str;
	}
}
%>