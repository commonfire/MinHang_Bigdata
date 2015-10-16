package edu.bupt.display;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class ExecuteShell {

	/**
	 * 调用python爬虫
	 * @param param    爬虫参数
	 * @param type     爬虫功能类型
	 * @throws InterruptedException
	 */
	public static void executeShell(String param,String type) throws InterruptedException{
	    try {
	  
			  String[] command = new String[3];
			  command[0] = "/home/hadoop_user/scrapy-weibospider/scrapy.sh";
			  command[1] = param;
			  command[2] = type;  
			  Process process = Runtime.getRuntime().exec(command);
			
			  // 获取shell返回流(字节流)
			  BufferedInputStream in = new BufferedInputStream(process.getInputStream());
			  // 字节流转换字符流
			  BufferedReader br = new BufferedReader(new InputStreamReader(in));
			  String lineStr;
		      while((lineStr = br.readLine()) != null){  
		          System.out.println(lineStr);  
		      } 
	      // 关闭输入流
		   	  br.close();
		   	  in.close();
		   	  System.out.println("finished!");
	  	
	  } catch (IOException e) {
	      e.printStackTrace();
	  }
	  }
	
	
	
	public static void main(String[] args) throws InterruptedException{
	}
}
