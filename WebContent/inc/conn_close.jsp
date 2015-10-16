<%@ page language="java" import="java.sql.*"%>
<%
}catch(Exception e){
	System.out.println(request.getRequestURI()+"Error:"+e.getMessage());
	e.printStackTrace();
}finally{
	stmt2.close();
	stmt.close();
	conn.close();
	in.close();
}
%>