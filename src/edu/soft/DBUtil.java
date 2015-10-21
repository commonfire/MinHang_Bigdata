package edu.soft;

import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;

public class DBUtil {
	//保存函数
	public void save(Connection conn,List<FileItem> list,HttpServletRequest request,String fieldname[],String tablename,String[] typename,int ID) throws InstantiationException, IllegalAccessException, ClassNotFoundException, UnsupportedEncodingException{
		save(conn,list,request,fieldname,tablename,typename,ID,"UTF-8",true);
	}
	//保存函数
	public void save(Connection conn,List<FileItem> list,HttpServletRequest request,String fieldname[],String tablename,String[] typename,int ID,String encoding,boolean isID) throws InstantiationException, IllegalAccessException, ClassNotFoundException, UnsupportedEncodingException
	{
		try{
			request.setCharacterEncoding(encoding);
		    int iLength = 0;
		    for(int i = 0; i < fieldname.length; i++)
		        if(fieldname[i] != null && !fieldname[i].equals(""))
		            iLength++;
		    //根据是否含有ID，选择不同的计算方式
		    StringBuffer bufferNameStr;//名称字符串参数
		    StringBuffer bufferQuesStr;//问号字符串参数
		    if(isID){//如果含有ID
		    	bufferNameStr=new StringBuffer("ID,");
			    bufferQuesStr=new StringBuffer("?,");
		    }else{
			    bufferNameStr=new StringBuffer("");
			    bufferQuesStr=new StringBuffer("");
		    }
		    for(int i = 0; i < iLength; i++){
		    	bufferNameStr.append(fieldname[i]).append(",");
		    	bufferQuesStr.append("?,");
		    }
		    String fieldNameStr = bufferNameStr.substring(0, bufferNameStr.length() - 1);
		    String questionStr = bufferQuesStr.substring(0, bufferQuesStr.length() - 1);
		    
		    String sql = "INSERT INTO "+tablename+" ("+fieldNameStr+" ) VALUES ("+questionStr+")";
		    PreparedStatement pstmtInsert = conn.prepareStatement(sql);
		    String value[] = fieldname;
		    edu.soft.CommonUtils cu=new edu.soft.CommonUtils();
		    for(int i = 0; i < iLength; i++)
		    {
		        //value[i] = dt.toUTF(request.getParameter(fieldname[i]));
		    	value[i]=cu.getFieldValue(list, fieldname[i],encoding);//使用带编码的取数据方法
		    }
		    //========================================================================
		    //下面开始赋值操作
		    //做一个基础参数
		    int baseFrom=0;
		    if(isID){
		    	pstmtInsert.setInt(1,ID);
		    	baseFrom=1;
		    }else{
		    	//do nothing
		    }
		    //下面的设置应该从第2个开始，也就是i+2;
		    for(int i = 0; i < iLength; i++){
		    	//判断数据类型
		    	if(typename[i].equalsIgnoreCase("D")){
		    		//需要转换为Java.sql.Date
		    		java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
		    		if(value[i].equals("")){
		    			pstmtInsert.setDate(i+baseFrom+1, null);
		    		}else{
			    		java.util.Date d=df.parse(value[i]);
			    		java.sql.Date sd= new java.sql.Date(d.getTime());
			    		pstmtInsert.setDate(i+baseFrom+1, sd);
			    		sd=null;d=null;
		    		}
		    	}else if(typename[i].equalsIgnoreCase("DL")){
		    		java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    		if(value[i].equals("")){
		    			pstmtInsert.setDate(i+baseFrom+1, null);
		    		}else{
			    		java.util.Date d=df.parse(value[i]);
						java.sql.Timestamp sd= new java.sql.Timestamp(d.getTime());
						pstmtInsert.setTimestamp(i+baseFrom+1, sd);
						sd=null;d=null;
		    		}
		    	}else if(typename[i].equals("BLOB")){
		    		StringReader sr = new StringReader(value[i]);
		    		pstmtInsert.setCharacterStream(i+baseFrom+1,sr,value[i].length());
		    	}else{
		    		pstmtInsert.setString(i+baseFrom+1, value[i]);
		    	}
		    }
		    //执行更新语句。
		    pstmtInsert.executeUpdate();
		    pstmtInsert=null;//释放内存
		}catch(Exception e){
			System.out.println("DBUtil--save()--发生错误！！！"+e.getMessage());
		}
	}
	
	//更新函数
	public void update(Connection conn,List<FileItem> list,HttpServletRequest request,String fieldname[],String tablename,String[] typename,String sid,String ID) throws InstantiationException, IllegalAccessException, ClassNotFoundException, UnsupportedEncodingException{
		update(conn,list,request,fieldname,tablename,typename,sid,ID,"UTF-8");
	}	
	//更新函数 2013-10-16 张培颖 优化代码   --显式释放内存
	public void update(Connection conn,List<FileItem> list,HttpServletRequest request,String fieldname[],String tablename,String[] typename,String sid,String ID,String encoding) throws InstantiationException, IllegalAccessException, ClassNotFoundException, UnsupportedEncodingException
	{
		try{
			request.setCharacterEncoding(encoding);
		    int iLength = 0;
		    for(int i = 0; i < fieldname.length; i++)
		        if(fieldname[i] != null && !fieldname[i].equals(""))
		            iLength++;
		    StringBuffer bufferSQL=new StringBuffer("update " + tablename + " set ");
		    for(int i = 0; i < iLength; i++){
		    	//这里需要判断是否是日期格式、字符格式、数字格式、长日期格式
		    	bufferSQL.append(fieldname[i]).append("=?,");
		    }
		    //去掉后面的一个，
		    String sql = bufferSQL.substring(0, bufferSQL.length() - 1)+ " where " + sid + "=?";
		    String value[] = fieldname;
		    //edu.soft.MyString dt = new edu.soft.MyString();
		    edu.soft.CommonUtils cu=new edu.soft.CommonUtils();
		    for(int i = 0; i < iLength; i++)
		    {
		    	//value[i] = dt.isNull(request.getParameter(fieldname[i]));
		    	value[i]=cu.getFieldValue(list, fieldname[i],encoding);//使用带编码的方法
		    }
		    PreparedStatement pstmtUpdate = conn.prepareStatement(sql);
		    //下面的设置应该从第1个开始，也就是i+1;
		    for(int i = 0; i < iLength; i++){
		    	//判断数据类型
		    	if(typename[i].equalsIgnoreCase("D")){
		    		//需要转换为Java.sql.Date
		    		java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
		    		if(value[i].equals("")){
		    			pstmtUpdate.setDate(i+1, null);
		    		}else{
			    		java.util.Date d=df.parse(value[i]);
			    		java.sql.Date sd= new java.sql.Date(d.getTime());
			    		pstmtUpdate.setDate(i+1, sd);
			    		sd=null;d=null;df=null;
		    		}
		    	}else if(typename[i].equalsIgnoreCase("DL")){
		    		java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    		if(value[i].equals("")){
		    			pstmtUpdate.setDate(i+1, null);
		    		}else{
			    		java.util.Date d=df.parse(value[i]);
						java.sql.Timestamp sd= new java.sql.Timestamp(d.getTime());
			    		pstmtUpdate.setTimestamp(i+1, sd);
			    		sd=null;d=null;df=null;
		    		}
		    	}else if(typename[i].equals("BLOB")){
		    		StringReader sr = new StringReader(value[i]);
		    		pstmtUpdate.setCharacterStream(i+1,sr,value[i].length());
		    	}else{
		    		pstmtUpdate.setString(i+1, value[i]);
		    	}
		    }
		    pstmtUpdate.setString(iLength+1,ID);
		    pstmtUpdate.executeUpdate();//提交数据库。
		    pstmtUpdate=null;
		}catch(Exception e){
			System.out.println("DBUtil--update()--发生错误！！！"+e.getMessage());
		}
	}
}