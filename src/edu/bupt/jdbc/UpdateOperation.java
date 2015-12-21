package edu.bupt.jdbc;


public class UpdateOperation {
	
	public static void updateEndState(String state){
		SQLHelper.executeUpdate("update t_spider_state set "+state+"=0", null);
	}
	
	//如果一条数据在表中已经存在,对其做update,如果不存在,将新的数据插入.
	public static void mergeLastSearchTime(String uid,long lastTimeStamp){
		String lastTimeStampStr = String.valueOf(lastTimeStamp);
		String[] parameters = new String[]{uid,lastTimeStampStr,lastTimeStampStr};
		String sql = "merge into T_USER_LASTSEARCHTIME t1 "
    			 + "using (select ? as userID,? as lastSearchTime from dual) t2 "
    	 		 + "on (t1.userID = t2.userID) "
    	 		 + "when matched then update set t1.lastSearchTime = ? "
    	 		 + "when not matched then insert (t1.userID,t1.lastSearchTime) values(t2.userID,t2.lastSearchTime)";
		SQLHelper.executeUpdate(sql, parameters);
	}
	
	public static void main(String[] args){
//   	UpdateOperation.updateEndState("searchstate");
//		mergeLastSearchTime("111", 123456789l);
    }

}
