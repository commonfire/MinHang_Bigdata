<%@ page 
	import="java.sql.*"
	import="java.util.*"
	import="java.servlet.*"
	import="edu.soft.MyString"
%>
<%!
//��ȡ�ֶ�ֵ�������ʾ
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
//����SQL�����в�ѯ
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
//��ȡ�ֶ�ֵ�������ʾ
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
//���б༭ҳ����ع�����
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
//���б༭ҳ����ع�����--�����������͵ĺ���
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
//��������������������������������������������������������������������������������������������������������������������������������������������
public StringBuffer getCondition(StringBuffer sb,String field,String param){//��ѯ������ƴ��StringBuffer��
	StringBuffer result=sb;
	try{
		if(param!=null&&!param.equals("")){
			result.append(" AND ").append(field).append("='").append(param).append("'");
		}
	}catch(Exception e){
		System.out.println("��ȡ����������getCondition StringBuffer �� ��������"+e.getMessage());
	}
	return result;
}
public StringBuffer getCondition(StringBuffer sb,String field,String param1,String param2){//��ѯ�����ļ��㣺��һ�������� BETWEEN AND 
	StringBuffer result=sb;
	try{
		if(param1!=null&&!param1.equals("")&&param2!=null&&!param2.equals("")){
			result.append(" AND (").append(field).append(" BETWEEN ").append(param1).append(" AND ").append(param2).append(")");
		}
	}catch(Exception e){
		System.out.println("��ȡ����������getCondition StringBuffer BETWEEN _ AND �� ��������"+e.getMessage());
	}
	return result;
}
public StringBuffer getConditionBlur(StringBuffer sb,String field,String param){//��ѯ������ƴ��StringBuffer��--��ģ����ѯ����
	StringBuffer result=sb;
	try{
		if(param!=null&&!param.equals("")){//����ƴ�Ӳ�ѯ����LIKE
			String param_like="";
			for(int i=0;i<param.length();i++){
				param_like=param_like+param.substring(i,i+1)+"%";
			}
			result.append(" AND ").append(field).append(" LIKE '%").append(param).append("%'");
		}
	}catch(Exception e){
		System.out.println("��ȡ����������getCondition StringBuffer ��--��ģ����ѯ���� ��������"+e.getMessage());
	}
	return result;
}
public String fetchBasePath(HttpServletRequest _request){//ȡ����ǰ��·��basePath
	String basePath="";
	try{
		basePath = _request.getScheme()+"://"+_request.getServerName()+":"+_request.getServerPort()+_request.getContextPath()+"/";
	}catch(Exception e){
		System.out.println("����fetchBasePath��������:"+e.getMessage());
	}
	return basePath;
}
//2011-04-19 ����ӱ Ŀ�ģ�Ϊ�˵���listҳ�����ʾЧ����Ҫû�����ݣ�����ʾ�ո�
public String space(String str){
	if(str.equals("")){
		return "&nbsp;";
	}else{
		return str;
	}
}
%>