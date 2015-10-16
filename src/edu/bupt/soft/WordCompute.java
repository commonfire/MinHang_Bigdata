package edu.bupt.soft;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

/**
 * 用于网页微博句子信息展示
 * @author zjd
 */
public class WordCompute {
	
	/**
	 * 计算情感词语的分数
	 * @param sentiWords       待计算情感词语
	 * @param sentimentWords   情感词库词语
	 * @return                 情感词语的分数
	 */
	public static double calSentiWord(Vector<String> sentiWords,ArrayList<SentimentWordItem> sentimentWords){
		double score = 0;      
		double result = 0;     
		if(sentiWords.size()!=0){
			for(int i = 0; i<sentiWords.size();i++){
				for(int j = 0;j<sentimentWords.size();j++){
					if(sentiWords.get(i).equals(sentimentWords.get(j).getPhrase())){
						if(sentimentWords.get(j).getPolar()==1||sentimentWords.get(j).getPolar()==0){		
							score += sentimentWords.get(j).getPower()/9;	                                    //该词语为褒义1或中性0，未考虑褒贬双意
							//System.out.println("word:"+sentimentWords.get(j).getPower()/9+"index:"+j+1);
						}        
						if(sentimentWords.get(j).getPolar()==2||sentimentWords.get(j).getPolar()==0){           //该词语为贬义2或中性0
							score -= sentimentWords.get(j).getPower()/9;	                                    //负数表示极性反转
							//System.out.println("word:"+sentimentWords.get(j).getPower()/9+"index:"+j+1);
						}
					}
				}	
			}
		   result = score/sentiWords.size();
		}
		return result;
	}
	
	
	/**
	 * 计算非情感词语的分数
	 * @param nonSentiWords         待计算非情感词语
	 * @param positiveWords         褒义基准词表
	 * @param negativeWords         贬义基准词表
	 * @param sentimentWords        情感词库词语
	 * @return                      非情感词语的分数
	 */
	public static double calNonSentiWord(Vector<String> nonSentiWords,ArrayList<BaseWordItem> positiveWords,ArrayList<BaseWordItem> negativeWords,ArrayList<SentimentWordItem> sentimentWords){
		double score = 0;      
		if(nonSentiWords.size()!=0){
			for(int i = 0;i<nonSentiWords.size();i++){
				score += new HowNetSimilarity().getWordAvgDSO(nonSentiWords.get(i), positiveWords, negativeWords, sentimentWords);		
			}
			score /= nonSentiWords.size();
		}
		return score;
	}
	
	/**
	 * 计算句子舆情等级（75%情感比例）
	 * @param sentiScore           情感词语的分数
	 * @param nonSentiScore        非情感词语的分数
	 * @return
	 */
	public static double calSentence(double sentiScore,double nonSentiScore){
		double score = 0.75*sentiScore + 0.75*nonSentiScore;
		return score;
	}
	
	public static void main(String[] args) {
		Vector<String> a = new Vector<>();
		a.add("一不小心");
		ArrayList<SentimentWordItem> sentimentWords = new OrientationCompute().sentimentWords;
		calSentiWord(a, sentimentWords);
	}
	

}
