package edu.soft;

import java.util.*;

public class MyDate {
  public MyDate() {
  }
  //根据增加、减少几天，计算日期
  public String getAddRQ(String rq,int days){
	java.util.GregorianCalendar now_Time=new java.util.GregorianCalendar();
	int y=Integer.parseInt(rq.substring(0,4));
	int m=Integer.parseInt(rq.substring(5,7));
	int d=Integer.parseInt(rq.substring(8,10));
	now_Time.set(y, m-1, d);
	
    now_Time.add(Calendar.DATE,days);//日期自动减相减
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
	String result=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));
	return result;
  }
  public String getPreviousWeekFrom(){
    java.util.GregorianCalendar now_Time=new java.util.GregorianCalendar();
    now_Time.add(Calendar.DATE,-7);//日期自动减1
    //计算是星期几，然后确定开始时间
    int i=now_Time.get(java.util.Calendar.DAY_OF_WEEK);
    now_Time.add(Calendar.DATE,1-i);
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
    String Current_Date=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));
    return Current_Date;
  }
  public String getPreviousWeekTo(){
    java.util.GregorianCalendar now_Time=new java.util.GregorianCalendar();
    now_Time.add(Calendar.DATE,-7);//日期自动减1
    //计算是星期几，然后确定开始时间
    int i=now_Time.get(java.util.Calendar.DAY_OF_WEEK);
    now_Time.add(Calendar.DATE,7-i);
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
    String Current_Date=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));
    return Current_Date;
  }
  //增加函数，取得上一个月的日期
  public int getPreviousMonth(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    now_Time.add(java.util.Calendar.MONTH,-1);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    return month;
  }
  //增加一个函数，根据第几周计算日期：比如：第1周-〉2004-01-01
  public String getRQ(int i,String year){
    String str=new String("");
    java.util.GregorianCalendar gc=new java.util.GregorianCalendar();
    //计算天数
    int iCount=(i-1)*7;
    gc.set(Calendar.YEAR,Integer.parseInt(year));
    gc.set(Calendar.MONTH,0);
    gc.set(Calendar.DATE,1);
    gc.add(Calendar.DATE,iCount);
    String y=String.valueOf(gc.get(Calendar.YEAR));
    String m=String.valueOf(gc.get(Calendar.MONTH)+1);
    String d=String.valueOf(gc.get(Calendar.DATE));
    //计算长格式的字符串
    if(m.length()==1){m="0"+m;}
    if(d.length()==1){d="0"+d;}
    str=y+"-"+m+"-"+d;
    return str;
  }
  //增加一个函数，根据年月输出本月的天数
  public int getMaxday(String y,String m){
    java.util.GregorianCalendar gc=new java.util.GregorianCalendar();
    gc.set(Calendar.YEAR,Integer.parseInt(y));
    gc.set(Calendar.MONTH,Integer.parseInt(m)-1);
    int i=gc.getActualMaximum(Calendar.DATE);
    return i;
  }
  //增加一个函数，根据年月日输出2004-01-01格式的字符串
  public String toLongDate(String y,String m,String d){
    String str=new String("");
    String strmonth=new String("");
    String strday=new String("");
    if(m.length()==1){strmonth="0"+m;}else{strmonth=m;}
    if(d.length()==1){strday="0"+d;}else{strday=d;}
    str=y+"-"+strmonth+"-"+strday;
    return str;
  }
  //增加一个函数，取得当前的年份
  public String getYear(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int year=now_Time.get(java.util.Calendar.YEAR);
    String s=String.valueOf(year);
    return s;
  }
  //取得当前的月份
  public String getMonth(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    String s=String.valueOf(month);
    return s;
  }
  //取得当前的天
  public String getDay(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int day=now_Time.get(java.util.Calendar.DATE);
    String s=String.valueOf(day);
    return s;
  }
  //增加一个函数，输入参数两个日期，输出：天数
  public int minusDate(String strDate1,String strDate2){
    int intReturn =0;
    java.sql.Date date1 = null;
    java.sql.Date date2 = null;
    try{
      date1 = java.sql.Date.valueOf(strDate1.substring(0,10));
      date2 = java.sql.Date.valueOf(strDate2.substring(0,10));
          int thevalue = (int)((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 *24) + 0.5);
      intReturn = thevalue;
    }catch(Exception ex){
      ex.printStackTrace();
    }
    return intReturn;
  }
  //返回昨天日期，返回2004-08-14
  public String getYesterday(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    now_Time.add(Calendar.DATE,-1);//日期自动减1
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
    String Current_Date=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));
    return Current_Date;
  }
  //取得日期，返回2004-08-15
  public String getDate(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
    String Current_Date=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));
    return Current_Date;
  }
  //取得时间，返回2004-08-15 00：00：00
  public String getTime(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int year=now_Time.get(java.util.Calendar.YEAR);
    int month=now_Time.get(java.util.Calendar.MONTH)+1;
    int day=now_Time.get(java.util.Calendar.DATE);
    String Current_Date=String.valueOf(year)+"-"+((month<10) ? "0"+String.valueOf(month) : String.valueOf(month))+"-"+((day<10) ? "0"+String.valueOf(day) : String.valueOf(day));

    int hour=now_Time.get(java.util.Calendar.HOUR_OF_DAY) ;
    int minute=now_Time.get(java.util.Calendar.MINUTE);
    int second=now_Time.get(java.util.Calendar.SECOND);
    String Current_Time=((hour<10) ? "0"+String.valueOf(hour) : String.valueOf(hour))+":"+((minute<10) ? "0"+String.valueOf(minute) : String.valueOf(minute))+":"+(( second<10) ? "0"+String.valueOf(second) : String.valueOf(second)) ;
    //out.print(Current_Date+" "+Current_Time+"<br>");
    String strTime = Current_Date+" "+Current_Time;
    return strTime;
  }
  //取得具体时间，返回00:00:00
  public String getHour(){
    java.util.Calendar now_Time=java.util.Calendar.getInstance();
    int hour=now_Time.get(java.util.Calendar.HOUR_OF_DAY) ;
    int minute=now_Time.get(java.util.Calendar.MINUTE);
    int second=now_Time.get(java.util.Calendar.SECOND);
    String Current_Time=((hour<10) ? "0"+String.valueOf(hour) : String.valueOf(hour))+":"+((minute<10) ? "0"+String.valueOf(minute) : String.valueOf(minute))+":"+(( second<10) ? "0"+String.valueOf(second) : String.valueOf(second)) ;
    return Current_Time;
  }
  public static void main(String[] args){
	  MyDate my=new MyDate();
	  System.out.println(my.getHour());
  }
}