<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="edu.bupt.basefunc.Filter"%>
<%@ page import="edu.bupt.basefunc.FriendExpandJSON"%>
<%@ page import="edu.bupt.display.ExecuteShell"%>
<%@ page import="edu.bupt.jdbc.UpdateOperation"%>
<%@ page import="edu.bupt.jdbc.SelectOperation"%>
<%@ include file="../inc/conn.jsp"%> 
<%
String alias = request.getParameter("alias");
String crawl = request.getParameter("crawl"); //是否需要重爬的标志
String currentTimeStampStr = request.getParameter("currentTimeStamp");
String inTime = request.getParameter("inTime");

ResultSet rsRelation = null;  //用户关系查询数据结果集
//ResultSet rsUserName = null;  //用户昵称查询数据结果集
if(null != alias && null != currentTimeStampStr && null != inTime && null!= crawl){
	//解码两次
	alias = URLDecoder.decode(alias,"UTF-8");
	alias = URLDecoder.decode(alias,"UTF-8"); //获取用户昵称
	System.out.println("!!!!"+alias);
	
	int perpageNum = -1;
	long earliestTimeStamp;     //数据库中该用户微博最早时间戳
	long currentTimeStamp = Long.valueOf(currentTimeStampStr);
	long lastTimeStamp = 0;     //上一次爬取时间戳
	long diffTimeStamp;
	final long timeThreshold = 12*3600000*20; //两次爬取时间间隔大于12*60分钟
	
	String userID = SelectOperation.selectAtUserid(alias, conn);
	String userProperty = SelectOperation.selectUserProperty(alias,"USERALIAS",conn);
	if(null == userProperty) {
		out.write("0");
		return;
	}
	else if("icon_verify_co_v".equals(userProperty)){ //该账号为公众账号
		out.write("co_verify");
		return;
	}
	else{
		if("0".equals(crawl)){ //不需要重新爬取模块
			lastTimeStamp = SelectOperation.selectLastSearchTime(userID,conn); //获取主用户上一次爬取时间戳,未爬取过该userID，则返回0
			diffTimeStamp = currentTimeStamp - lastTimeStamp;  //两次爬取时间间隔
			  if(diffTimeStamp > timeThreshold){
				  do{
						System.out.println("!!!first layer user:"+userID);
						perpageNum += 2;
					   ExecuteShell.executeShell(userID,String.valueOf(perpageNum),"weibocontent_userinfo_intime");	//爬取用户第一层关系
						while(true){
								int searchstate = SelectOperation.selectEndState("contentstate",conn);
								if(searchstate==1) break;	
						}
						UpdateOperation.updateEndState("contentstate"); 
						earliestTimeStamp = SelectOperation.getEarlistTimeStamp(userID, conn); //获取最早发表时间
//						System.out.println("earliestTimeStamp:"+earliestTimeStamp);
					}while(currentTimeStamp - earliestTimeStamp <= 155520000); //没有满足一个月发表量
					System.out.println("perpageNum:"+perpageNum);
			}
			//当前爬取工作结束,更新"上一次爬取"时间戳
			 UpdateOperation.mergeLastSearchTime(userID, currentTimeStamp);
			
			 List<String> uidList = new ArrayList<>();
			 try{
				 	ResultSet rs = SelectOperation.selectAtuser(userID, currentTimeStamp, "5", inTime,conn);
				 	while(rs.next()) uidList.add(rs.getString("ATUSERID"));

			      System.out.println("********original_ExpandStr"+uidList.toString());
					String filteredUidStr = Filter.filterContainedUid(uidList,conn); //过滤掉已爬取过的uid
		 			System.out.println("********filteredUid_ExpandStr"+filteredUidStr);
					
		 			if(!"".equals(filteredUidStr)){ 
						ExecuteShell.executeShell(filteredUidStr,"userinfo_list"); //爬取用户第三层基本信息
						while(true){
							int userinfostate = SelectOperation.selectEndState("userinfostate",conn);
							if(userinfostate==1) break;			
						}
						UpdateOperation.updateEndState("userinfostate");  
					} 
			 }catch(Exception e){
					e.printStackTrace();	
			 } 
		}	 
		else{
			do{
				System.out.println("!!!first layer user:"+userID);
				perpageNum += 2;
			   ExecuteShell.executeShell(userID,String.valueOf(perpageNum),"weibocontent_userinfo_intime");	//爬取用户第一层关系
				while(true){
						int searchstate = SelectOperation.selectEndState("contentstate",conn);
						if(searchstate==1) break;	
				}
				UpdateOperation.updateEndState("contentstate"); 
				earliestTimeStamp = SelectOperation.getEarlistTimeStamp(userID, conn); //获取最早发表时间
//				System.out.println("earliestTimeStamp:"+earliestTimeStamp);
			}while(currentTimeStamp - earliestTimeStamp <= 155520000); //没有满足一个月发表量
			System.out.println("perpageNum:"+perpageNum);
			
			//当前爬取工作结束,更新"上一次爬取"时间戳
			 UpdateOperation.mergeLastSearchTime(userID, currentTimeStamp);
			
			 List<String> uidList = new ArrayList<>();
			 try{
				 	ResultSet rs = SelectOperation.selectAtuser(userID, currentTimeStamp, "5", inTime,conn);
				 	while(rs.next()) uidList.add(rs.getString("ATUSERID"));

			      System.out.println("********original_ExpandStr"+uidList.toString());
					String filteredUidStr = Filter.filterContainedUid(uidList,conn); //过滤掉已爬取过的uid
		 			System.out.println("********filteredUid_ExpandStr"+filteredUidStr);
					
		 			if(!"".equals(filteredUidStr)){ 
						ExecuteShell.executeShell(filteredUidStr,"userinfo_list"); //爬取用户第三层基本信息
						while(true){
							int userinfostate = SelectOperation.selectEndState("userinfostate",conn);
							if(userinfostate==1) break;			
						}
						UpdateOperation.updateEndState("userinfostate");  
					} 
			 }catch(Exception e){
					e.printStackTrace();	
			 } 
		}
		
		try{
			rsRelation = SelectOperation.selectAtuser(userID, currentTimeStamp, "5", inTime, conn);
			String result = FriendExpandJSON.friendExpandJSON(alias,rsRelation); //返回JSON数据
			out.write(result); 
			rsRelation.close();
		}catch(Exception e){
			e.printStackTrace();	
		} 
	}

}else{
	out.write("0");
}

/* out.write("{\"nodes\":[{\"category\":\"2\",\"name\":\"Bill\",\"value\":\"3\"},{\"category\":\"2\",\"name\":\"Lucy\",\"value\":\"3\"}],"
	+"\"links\":[{\"source\":\"李写意\",\"target\":\"Bill\",\"weight\":\"3\"},{\"source\":\"李写意\",\"target\":\"Lucy\",\"weight\":\"3\"}]}");
 */
%>
<%@ include file="../inc/conn_close.jsp"%>
