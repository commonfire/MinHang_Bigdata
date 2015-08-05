package edu.bupt.soft;

import java.sql.ResultSet;
import java.util.ArrayList;

import edu.bupt.jdbc.JDBCConnect;
import edu.bupt.jdbc.SelectOperation;
import ruc.irm.similarity.word.hownet2.concept.LiuConceptParser;


public class HowNetSimilarity {
	
	 private static final int BASEWORD_COUNT = 40;  //褒/贬基准词表词数

	public HowNetSimilarity() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 根据基准词库计算词语语义倾向值，原始算法
	 * @param word              待计算词语
	 * @param positiveWords     褒义基准词表
	 * @param negativeWords     贬义基准词表
	 * @return                  返回该词语的语义倾向值,范围为[-1,1]
	 */
	public double getWordDSO(String word,ArrayList<BaseWordItem> positiveWords,ArrayList<BaseWordItem> negativeWords){
		double positiveSum = 0;   //词语与褒义基准词语义相似度之和
		double negativeSum = 0;   //词语与贬义基准词语义相似度之和
		double value = 0;         //词语的语义倾向值
		LiuConceptParser lParser = null;
		lParser = LiuConceptParser.getInstance();
		for(int p=0,n=0;p<positiveWords.size()&&n<negativeWords.size();p++,n++){
			positiveSum += lParser.getSimilarity(word, positiveWords.get(p).getPhrase());
			negativeSum += lParser.getSimilarity(word, negativeWords.get(n).getPhrase());
		}
		value = (positiveSum - negativeSum)/BASEWORD_COUNT;
		return value;	
	}
	
	
	/**
	 * 根据基准词库计算词语语义倾向值之算法改进1：先判断它的褒贬然后再统一计算它的舆情等级值
	 * @param word              待计算词语
	 * @param positiveWords     褒义基准词表
	 * @param negativeWords     贬义基准词表
	 * @return                  返回该词语的语义倾向值,范围为[-1,1]
	 */
	public double getWordDSO1(String word,ArrayList<BaseWordItem> positiveWords,ArrayList<BaseWordItem> negativeWords){
		double positiveSum = 0;   //词语与褒义基准词语义相似度之和
		double negativeSum = 0;   //词语与贬义基准词语义相似度之和
		double result = 0;         //词语的语义倾向值
		LiuConceptParser lParser = null;
		lParser = LiuConceptParser.getInstance();
		for(int p=0,n=0;p<positiveWords.size()&&n<negativeWords.size();p++,n++){
			positiveSum += lParser.getSimilarity(word, positiveWords.get(p).getPhrase());
			negativeSum += lParser.getSimilarity(word, negativeWords.get(n).getPhrase());
		}
		
		if(positiveSum > negativeSum){    //先判断它的褒贬然后再统一计算它的舆情等级值
			result = positiveSum/BASEWORD_COUNT;  //1(power:9/9)*positiveSum/BASEWORD_COUNT
			//System.out.println("positive");
		}
		if(negativeSum >positiveSum){ 
			result = -1*negativeSum/BASEWORD_COUNT;
			//System.out.println("negative");
		}
		return result;	
	}
	
	
	/**
	 * 根据情感词库计算词语语义倾向值之算法改进2：与情感词库中所有词计算其相似度。取其相似度最大的一个词的舆情等级*相似度值
	 * @param word              待计算词语
	 * @param sentimentWords    情感词词表
	 * @return                  返回该词语的语义倾向值,范围为[-1,1]
	 */
	public double getWordDSO2(String word,ArrayList<SentimentWordItem> sentimentWords){

		double value = 0;         //词语与基准词相似度值
		double maxValue = 0;      //词语与基准词相似度最大的值
		int tag = 0;              //记录最相似的情感值位置
		double result = 0;        //词语的情感倾向值
		LiuConceptParser lParser = null;
		lParser = LiuConceptParser.getInstance();
		for(int s = 0;s < sentimentWords.size();s++){
			value = lParser.getSimilarity(word, sentimentWords.get(s).getPhrase());
			if(value > maxValue){
				maxValue = value;
				tag = s;
			}
		}
		if(sentimentWords.get(tag).getPolar()==1){                       //该词语为褒义1或褒贬两性0
			result = maxValue*sentimentWords.get(tag).getPower()/9;      //词语与基准词的最大相似度乘以相应的power值作为词语的情感倾向值
		}        
		if(sentimentWords.get(tag).getPolar()==2){                        //该词语为贬义2或褒贬两性0
			result = -1*maxValue*sentimentWords.get(tag).getPower()/9;	  //负数表示极性反转
		}	
		//System.out.println(sentimentWords.get(tag).getPhrase());
		return result;	
	}
	
	
    /**
     * 计算词语语义倾向值算法改进3：将三种词语情感值算法结果取平均值
     * @param word                 待计算词语
     * @param positiveWords        褒义基准词表
     * @param negativeWords        贬义基准词表
     * @param sentimentWords       情感词词表
     * @return                     三种词语情感值算法平均值
     */
    public double getWordAvgDSO(String word,ArrayList<BaseWordItem> positiveWords,ArrayList<BaseWordItem> negativeWords,ArrayList<SentimentWordItem> sentimentWords){
    	double result1 = this.getWordDSO(word, positiveWords, negativeWords);
    	double result2 = this.getWordDSO1(word, positiveWords, negativeWords);
    	double result3 = this.getWordDSO2(word, sentimentWords);
    	double result = (result1+result2+result3)/3;   	
    	return result;
    }
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	
		JDBCConnect.getConnection();
		String sql1 = "select * from positive_baseword";
		ResultSet rs1 = SelectOperation.selectOnes(sql1);
		ArrayList<BaseWordItem> positiveWords =  new SentenceProcessor().getBaseWords(rs1); 
		
		String sql2 = "select * from negative_baseword";
		ResultSet rs2 = SelectOperation.selectOnes(sql2);
		ArrayList<BaseWordItem> negativeWords =  new SentenceProcessor().getBaseWords(rs2); 
		
		String sql3 = "select * from emotion_dictionary";
		ResultSet rs3 = SelectOperation.selectOnes(sql3);
		ArrayList<SentimentWordItem> sentimentWords = new SentenceProcessor().getSentimentWords(rs3);
		
		
//		double value = new HowNetSimilarity().getWordDSO("烦", positiveWords, negativeWords);
//		double value1 = new HowNetSimilarity().getWordDSO1("烦", positiveWords, negativeWords);
//		double value2 = new HowNetSimilarity().getWordDSO2("郁闷", sentimentWords);
		double value3 = new HowNetSimilarity().getWordAvgDSO("恶毒", positiveWords, negativeWords, sentimentWords);
//		System.out.println("未改进,范围为[-1,1]:"+value);
//		System.out.println("改进算法1,范围为[-1,1]:"+value1);
//		System.out.println("改进算法2,范围为[-1,1]:"+value2);
		System.out.println("平均3种算法,范围为[-1,1]:"+value3);
		
	}

}
