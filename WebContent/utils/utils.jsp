<%@ page 
	import="java.sql.*"
	import="java.util.*"
	import="java.servlet.*"
	import="edu.soft.MyString"
%>
<%!
//��ȡ�ֶ�ֵ�������ʾ
public static String getAlias(Statement stmt,String userid) throws Exception{
	String useralias="";
	ResultSet rs=stmt.executeQuery("SELECT * FROM T_USER_INFO WHERE USERID='"+userid+"'");
	if(rs.next()){
		useralias=rs.getString("useralias");
	}
	return useralias;
}
%>