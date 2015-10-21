package edu.soft;

public class CondUtil {

	//为了增加根据单位分级汇总的查询，而增加的函数。
	public StringBuffer In(StringBuffer sb,String field,String param){
		StringBuffer result=sb;
		try{
			if(param!=null&&!param.equals("")){
				result.append(" AND ").append(field).append(" IN ").append(param);
			}
		}catch(Exception e){
			System.out.println("获取条件函数：In() 发生错误："+e.getMessage());
		}
		return result;
	}
	public StringBuffer Eq(StringBuffer sb,String field,String param){//查询条件的拼接StringBuffer版
		StringBuffer result=sb;
		try{
			if(param!=null&&!param.equals("")){
				result.append(" AND ").append(field).append("='").append(param).append("'");
			}
		}catch(Exception e){
			System.out.println("获取条件函数：Eq() 发生错误："+e.getMessage());
		}
		return result;
	}
	public StringBuffer Between(StringBuffer sb,String field,String param1,String param2){//查询条件的计算：在一个区间内 BETWEEN AND 
		StringBuffer result=sb;
		try{
			if(param1!=null&&!param1.equals("")&&param2!=null&&!param2.equals("")){
				result.append(" AND (").append(field).append(" BETWEEN ").append(param1).append(" AND ").append(param2).append(")");
			}
		}catch(Exception e){
			System.out.println("获取条件函数：Between() 发生错误："+e.getMessage());
		}
		return result;
	}
	public StringBuffer Like(StringBuffer sb,String field,String param){//查询条件的拼接StringBuffer版--带模糊查询功能
		StringBuffer result=sb;
		try{
			if(param!=null&&!param.equals("")){//下面拼接查询条件LIKE
				StringBuffer buffer=new StringBuffer();
				for(int i=0;i<param.length();i++){
					buffer.append(param.substring(i,i+1)).append("%");
				}
				result.append(" AND ").append(field).append(" LIKE '%").append(buffer).append("%'");
			}
		}catch(Exception e){
			System.out.println("获取条件函数：Like() 发生错误："+e.getMessage());
		}
		return result;
	}
	//额外，为了录井公司增加的，获取下属单位的条件。
	public StringBuffer makeStringBuffer(StringBuffer sbCond,String userlb,String unitname,String ids) throws Exception{
		if(unitname.equals("设备安全科")){return sbCond;}
		if(userlb.equals("录井队")){
			sbCond=Eq(sbCond,"LRDW",unitname);
		}else if(userlb.equals("分公司")||userlb.equals("项目部")){
			if(!ids.equals("()")){
				//sbCond=Eq(sbCond,"LRDW","(SELECT MC FROM U_ORGANIZATION WHERE ID IN "+ids+")");//单独的函数限制
				sbCond.append(" AND LRDW IN (SELECT MC FROM U_ORGANIZATION WHERE ID IN "+ids+")");
			}
		}
		return sbCond;
	}
}