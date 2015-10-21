package edu.soft;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class MyString {

	//通过表名，产生一个新的ID
    public static int getNewID(Statement stmt,String tableName) throws Exception{
    	int id=0;
    	ResultSet rs=stmt.executeQuery((new StringBuilder("SELECT NVL(MAX(ID),0)+1 AS ID FROM ")).append(tableName).toString());
    	if(rs.next()){
    		id=rs.getInt("ID");
    	}
    	rs=null;//释放内存
    	return id;
    }
    public String[] toArray(String str) {
        //这里为了避免数组不越界，使用列表
        ArrayList<String> list = new ArrayList<String>();
        StringTokenizer st = new StringTokenizer(str, ",");
        int iIndex = 0;
        while (st.hasMoreTokens()) {
            list.add(iIndex++, st.nextToken());
        }
        String resultStr[] = new String[iIndex];
        for (int i = 0; i < iIndex; i++) {
        	resultStr[i] = (String) list.get(i);
        }
        return resultStr;
    }
    //转换成数组的函数，重载
    public String[] toArray(String str, String token) {
        //这里为了避免数组不越界，使用列表
        ArrayList<String> list = new ArrayList<String>();
        StringTokenizer st = new StringTokenizer(str, token);
        int iIndex = 0;
        while (st.hasMoreTokens()) {
            list.add(iIndex++, st.nextToken());
        }
        String resultStr[] = new String[iIndex];
        for (int i = 0; i < iIndex; i++) {
        	resultStr[i] = (String) list.get(i);
        }
        return resultStr;
    }
    //转换为百分比
    public String toRatio(float f, int i) {
        String str = "";
        str = (new BigDecimal(f * 100)).setScale(i, 5) + "%";
        return str;
    }
    //转换为百分比
    public String toRatio(double f, int i) {
        String str = "";
        str = (new BigDecimal(f * 100)).setScale(i, 5) + "%";
        return str;
    }
    //格式化数字
    public String format(float f, int i) {
        String fTemp = "";
        fTemp = String.valueOf((new BigDecimal(f)).setScale(i, 5));
        if (Float.parseFloat(fTemp) == 0.0F)
            fTemp = "";
        return fTemp;
    }
    //格式化数字
    public String format(double f, int i) {
        String fTemp = "";
        fTemp = String.valueOf((new BigDecimal(f)).setScale(i, 5));
        if (Float.parseFloat(fTemp) == 0.0F)
            fTemp = "";
        return fTemp;
    }
    //转换GB2312编码
    public String toGB2312(String s) throws UnsupportedEncodingException {
        String ss = s;
        if (ss != null) {
            ss = new String(ss.getBytes("ISO8859-1"), "GBK");
            return ss;
        } else {
            return "";
        }
    }
    //转换为ISO8859-1编码
    public String toISO8859_1(String s) throws UnsupportedEncodingException {
        String ss = s;
        if (ss != null) {
            ss = new String(ss.getBytes("GB2312"), "ISO8859-1");
            return ss;
        } else {
            return "";
        }
    }
    //转换为UTF-8编码
    public String toUTF(String s) throws UnsupportedEncodingException {
        String ss = s;
        if (ss != null) {
            ss = new String(ss.getBytes("ISO8859-1"), "UTF-8");
            return ss;
        } else {
            return "";
        }
    }
    //判断是否为空函数
    public String isNull(String o) throws UnsupportedEncodingException {
        if (o == null)
            return "";
        else
            return o;
    }
    //判断是否为空
    public String isNull(double o) throws UnsupportedEncodingException {
        if (o != 0.0D)
            return String.valueOf(o);
        else
            return "";
    }
    public String isNull(float o) throws UnsupportedEncodingException {
        if (o != 0.0F)
            return String.valueOf(o);
        else
            return "";
    }
    public String isNull(long o) throws UnsupportedEncodingException {
        if (o != 0L)
            return String.valueOf(o);
        else
            return "";
    }
    public String isNull(int o) throws UnsupportedEncodingException {
        if (o != 0)
            return String.valueOf(o);
        else
            return "";
    }
}