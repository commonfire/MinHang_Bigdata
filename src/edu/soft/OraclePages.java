package edu.soft;

import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;

public class OraclePages
{
    //获取当前的页码
    public static int getPage(HttpServletRequest request, String page){
        String strPage = request.getParameter(page);
        int intPage = 0;
        if(strPage == null || strPage.equals("")){
            intPage = 1;
        }else{
        	try{
	        	//转换成整数页码
	            intPage = Integer.parseInt(strPage);
	            if(intPage < 1){
	            	intPage = 1;
	            }
        	}catch(NumberFormatException nfe){
        		System.out.println("OraclePages.getPage()出错!"+nfe.getMessage());
        	}
        }//返回结果
        return intPage;
    }
    //计算记录的总条数
    public static int getRowCount(Statement stmt,String sql){
    	int intRowCount = 0;
    	ResultSet rs;
    	try{
    		rs = stmt.executeQuery((new StringBuilder("SELECT MAX(ROWNUM) C FROM (SELECT A.*,ROWNUM FROM (")).append(sql).append(") A)").toString());
    		if(rs.next()){
    			intRowCount=rs.getInt("C");
    		}
    	}catch(Exception e){
    		System.out.println("计算记录总条数发生错误!!!");
    	}finally{
    		rs=null;//释放内存
    	}
    	return intRowCount;
    }
    /**
     * //计算分页的SQL语句
     * @param sql   SQL语句
     * @param intRowCount	记录的总条数
     * @param intPageSize	每页的记录条数
     * @param intPage		当前的页码
     * @return	SQL语句
     */
    public static String getPageSQL(String sql,int intRowCount,int intPageSize,int intPage){
    	//计算应该有多少页
    	int intPageCount = ((intRowCount + intPageSize) - 1) / intPageSize;
        if(intPage > intPageCount){
            intPage = intPageCount;
        }
        int qpage = (intPage - 1) * intPageSize;//前一页
        int hpage = qpage + intPageSize;		//后一页
        String dbsql = (new StringBuilder("SELECT * FROM (SELECT A.*,ROWNUM R FROM (")).append(sql).append(") A WHERE ROWNUM<=").append(hpage).append(") B WHERE R>").append(qpage).toString();
        return dbsql;
    }
    //计算总共多少页
    public static int getPageCount(int intRowCount,int intPageSize){
    	int intPageCount = ((intRowCount + intPageSize) - 1) / intPageSize;
    	return intPageCount;
    }
}