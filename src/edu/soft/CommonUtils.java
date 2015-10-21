package edu.soft;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

public class CommonUtils {
	//普通格式的取字段
	public String getFieldValue(List<FileItem> list,String fieldname) throws UnsupportedEncodingException{
		String result="";
		for (FileItem item : list) {
			if (item.isFormField()) {
				if(fieldname.equals(item.getFieldName())){
					result = item.getString("UTF-8");// 处理中文
				}
			}
		}
		return result;
	}
	//带编码格式的取字段
	public String getFieldValue(List<FileItem> list,String fieldname,String encoding) throws UnsupportedEncodingException{
		String result="";
		for (FileItem item : list) {
			if (item.isFormField()) {
				if(fieldname.equals(item.getFieldName())){
					result = item.getString(encoding);// 处理中文
				}
			}
		}
		return result;
	}
}