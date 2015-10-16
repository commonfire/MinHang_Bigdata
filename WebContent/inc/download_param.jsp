<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.io.*"%><%@ include file="../inc/conn.jsp"%><jsp:useBean id="dt" scope="page" class="edu.soft.MyString"/><%
	//经常修改的变量在这里定义
	/*String tableName="ZJFWJBXX_FLA";
	String fileFieldName="FILEBLOB";
	String fileTitleName="FILENAME";
	String fileFieldExtName="FILEEXT";*/
	String tableName=dt.isNull(request.getParameter("tableName"));
	//String fileFieldName=dt.isNull(request.getParameter("fieldName"));
	//String fileTitleName=dt.isNull(request.getParameter("titleName"));
	//String fileFieldExtName=dt.isNull(request.getParameter("extName"));
	String fileFieldName="FILEBLOB";
	String fileTitleName="FILENAME";
	String fileFieldExtName="FILEEXT";
	//取出上页传递过来的参数
	String id=request.getParameter("id");
try{
	String fileName="";
	String name="";
	String ext="";
	//下面取出文件名称和扩展名
	ResultSet rs=stmt.executeQuery("SELECT * FROM "+tableName+" WHERE FKID="+id);
	if(rs.next()){
		name=dt.isNull(rs.getString(fileTitleName));
		ext=dt.isNull(rs.getString(fileFieldExtName));
	}
	fileName=name+"."+ext;
	rs.close();
	rs=null;
	response.setContentType("application/x-msdownload");
	//要彻底解决中文问题,需要使用字符集转换
	response.setHeader("Content-Disposition","attachment; filename=\"" +new String(fileName.getBytes("GB2312"),"iso8859-1")+ "\"");
	PreparedStatement ps=conn.prepareStatement("SELECT * FROM "+tableName+" WHERE FKID=?");
	ps.setInt(1,Integer.parseInt(id));
	rs=ps.executeQuery();
	rs.next();
	java.io.OutputStream os = response.getOutputStream(); //不加此行将只能下载文本文件.下载jpg等就会出现打不开的现象.
	InputStream fis =rs.getBinaryStream(fileFieldName);
	byte[] b = new byte[1024];
	int i=0;
	while((i=fis.read(b))>0){ 
		os.write(b,0,i);
	}
	fis.close();
	os.flush();
	os.close();
	ps.close();
}catch(Exception e){
	System.out.println ("IOException." + e );
} 
%><%@ include file="../inc/conn_close.jsp"%>