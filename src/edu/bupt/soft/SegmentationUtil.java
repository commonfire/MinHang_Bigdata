package edu.bupt.soft;

import java.util.LinkedHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.ictclas4j.bean.SegResult;
import org.ictclas4j.segment.Segment;

public class SegmentationUtil {
	//定义变量
	public static Segment seg=new Segment(1);
	public static String regEx="/[a-zA-Z]+ *";
	public static Pattern p=Pattern.compile(regEx);
	//分词的函数--带有词性标注
	public static String getResult(String src){
		SegResult sr=seg.split(src);
		String result=sr.getFinalResult();
		return result;
	}
	//获取分词的结果--不带有词性标注
	public static String getResultNoPOS(String src){
		//匹配字符串
		Matcher m=p.matcher(getResult(src));
		//把词性标记替换为 空格
		String result=m.replaceAll(" ");
		return result;
	}
	//获取词串类序列--这个方法有问题。
	public static String getPosList(String src){
		String reg="\u4e00-\u9fa5";
		Pattern pattern=Pattern.compile(reg);
		//匹配字符串
		Matcher m=pattern.matcher(getResult(src));
		//把词性标记替换为 空格
		String result=m.replaceAll(" ");
		return result;
	}
	public static String[] getWords(String sentence){
		//StringTokenizer st=new StringTokenizer(sentence," ");
		return sentence.split(" ");
	}
	
	public static void main(String[] args){
		String source="我是一名石油大学的老师。";
		String result=getResultNoPOS(source);
		System.out.println(result);
	}
}
