package edu.bupt.soft;

import java.io.IOException;
import java.io.StringReader;
import java.util.Vector;

import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;

import edu.bupt.soft.SentSimilarity;;



/**
 * 中文分词 
 * @author: zjd
 */
public class WordSegment {

	/**
	 * 分词
	 * @author: zjd
	 * @param str    待分词的句子
	 * @return       句子分词后的词语结果
	 */
public static Vector<String> split( String str ) {
	
	Vector<String> strSeg = new Vector<String>() ;           //对输入的句子进行分词的结果
	
	try {
		
	    StringReader reader = new StringReader( str ); 
	    IKSegmenter ik = new IKSegmenter(reader,true);    //当为true时，分词器进行最大词长切分 
	    Lexeme lexeme = null ;			
		
	    while( ( lexeme = ik.next() ) != null ) {
			strSeg.add( lexeme.getLexemeText() ); 
		}			
		
	    if( strSeg.size() == 0 ) {
	    	return null ;
	    }
	    
 	    //分词后显示结果
	   // System.out.println( "分词结果：" + strSeg );
	    
	} catch ( IOException e1 ) {
		e1.printStackTrace();
	}
	return strSeg;
}
	
	public static void main(String[] args) {
		
		//分词
//		Vector<String> strs1 = split( "//" ) ;
//		Vector<String> strs2 = split( "我今天很高兴" ) ;
//		System.out.println(strs1.size());
		
//		//计算句子相似度
//		double similarity = 0 ;
//		try {
//			similarity = SentSimilarity.getSimilarity( strs1 , strs2 );
//		} catch (Exception e) {
//			System.out.println( e.getMessage() );
//		}
//		
//		System.out.println( "句子相似度：" + similarity );
	}

}
