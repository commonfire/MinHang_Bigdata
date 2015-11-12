package org.ansj.test;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import java.util.Vector;

import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;

import edu.bupt.soft.OrientationCompute;
import edu.bupt.soft.SentimentWordItem;

public class WordSegAnsj {
	
	
	/**
	 * 调用Ansj接口对句子进行分词操作，去掉原来分词后的“/词性”字样，未做词性的过滤
	 * @param str   待分的句子
	 * @return      返回分词结果
	 */
	public static Vector<String> splitOriginal(String str) {
		Vector<String> strSeg = new Vector<String>();                //对输入的句子进行分词的结果
		List<Term> parse = ToAnalysis.parse(str);
		Iterator<Term> itParse = parse.iterator();
		String tmpStr = null;
		while(itParse.hasNext()){
			tmpStr = String.valueOf(itParse.next());
			if(tmpStr.indexOf("/")!=-1){  //如果存在"/"
               strSeg.add(tmpStr.substring(0, tmpStr.indexOf("/")));  //去掉原来分词后的“/词性”
			}
			else{
				strSeg.add(tmpStr);
			}
		}
		return strSeg;
	}
	
	
	
	/**
	 * 调用Ansj接口对句子进行分词操作，只保留名动形副的词语
	 * @param str    待切词的句子
	 * @return       返回分词结果
	 */
	public static Vector<String> split(String str){
		Vector<String> strSeg = new Vector<String>();
		List<Term> parse = ToAnalysis.parse(str);
		Iterator<Term> itParse = parse.iterator();
		String tmpStr = null;
		String tmpStr1 = null;
		while(itParse.hasNext()){
			tmpStr = String.valueOf(itParse.next());
			if(tmpStr.indexOf("/")!=-1){   //如果存在"/"
				tmpStr1 = tmpStr.substring(tmpStr.indexOf("/")+1, tmpStr.length());
				if(tmpStr1.startsWith("n")){      //保留名词
					strSeg.add(tmpStr.substring(0, tmpStr.indexOf("/")));
				}else if(tmpStr1.startsWith("a")){  //保留形容词
					strSeg.add(tmpStr.substring(0, tmpStr.indexOf("/")));
				}else if(tmpStr1.equals("d")){  //保留副词
					strSeg.add(tmpStr.substring(0, tmpStr.indexOf("/")));
				}else if(tmpStr1.startsWith("v")){ //保留动词
					strSeg.add(tmpStr.substring(0, tmpStr.indexOf("/")));
				}
			}
		}
		return strSeg;
	}
	
	
	/**
	 * 获得分词后的结果中含有的情感词
	 * @param words             分好的词语集合
	 * @param sentimentWords    已知的情感词库
	 * @return                  分词结果中的情感词
	 */
	public static Vector<String> getSentimentWord(Vector<String> words,ArrayList<SentimentWordItem> sentimentWords){
		Vector<String> sentiWord = new Vector<String>();
		for(int i = 0;i<words.size();i++){
			for(int j = 0;j<sentimentWords.size();j++){
				if(words.get(i).contains(sentimentWords.get(j).getPhrase())){
					sentiWord.add(words.get(i));
				}
			}
		}
		return sentiWord;
	}
	
	/**
	 * 获得分词后的结果中含有的非情感词
	 * @param words             分好的词语集合
	 * @param sentimentWords    已知的情感词库
	 * @return                  分词结果中的非情感词
	 */
	public static Vector<String> getNonSentimentWord(Vector<String> words,ArrayList<SentimentWordItem> sentimentWords){
		outer:for(int i =words.size()-1;i>=0;i--){
			for(int j = 0;j<sentimentWords.size();j++){
				if(words.get(i).contains(sentimentWords.get(j).getPhrase())){
					words.remove(i);
					break outer;
				}
			}
		}
		return words;
	}
	
	
	
	public static void main(String[] args) throws IOException {
//		HashSet<String> all = new HashSet<String>();
////		all.add("这是一个计算机和服务。");
//		all.add("连续符号~~");
////		all.add("他说的确实在理");
////		all.add("长春市长春节讲话");
//
//		long start = System.currentTimeMillis();
//		for (String string : all) {
//			System.out.println(string);
//			List<Term> parse = ToAnalysis.parse(string) ;
//			System.out.println(parse);
//			//System.out.println(NlpAnalysis.parse(string));
//		}
//		System.out.println("消耗时间(ms):"+(System.currentTimeMillis() - start));
//		System.out.println(ToAnalysis.parse("这是一个计算机和服务。"));
//		System.out.println(WordSegment.splitOriginal("这是一个计算机和服务。"));
//		ArrayList<SentimentWordItem> sentimentWords = new OrientationCompute().sentimentWords;
			
//		List<Term> parse = ToAnalysis.parse("00:19:53 时速:9.22km/h");
//		System.out.println(parse);
		
//		String a = "00:19:53 时速:9.22km/h";
//		String[] phrase = a.split("[^\u4E00-\u9FA5]");
//		for(String s : phrase){
//			if(!"".equals(s)) System.out.println(s);
//		}	

		
	}

}
