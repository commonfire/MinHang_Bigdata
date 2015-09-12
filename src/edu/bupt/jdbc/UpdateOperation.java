package edu.bupt.jdbc;


public class UpdateOperation {
	public static void updateEndState(String state){
		SQLHelper.executeUpdate("update \"t_spider_state\" set \""+state+"\"=0", null);
	}
	
	public static void main(String[] args){
    	//UpdateOperation.updateEndState("searchstate");
    }

}
