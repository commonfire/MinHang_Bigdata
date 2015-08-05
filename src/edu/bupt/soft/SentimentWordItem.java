package edu.bupt.soft;

/**
 * 情感词词库的每个条目
 * @author DELL
 *
 */
public class SentimentWordItem {
	private int polar;
	private float power;
	private String phrase;
	
	public int getPolar() {
		return polar;
	}
	public void setPolar(int polar) {
		this.polar = polar;
	}
	public float getPower() {
		return power;
	}
	public void setPower(int power) {
		this.power = power;
	}
	public String getPhrase() {
		return phrase;
	}
	public void setPhrase(String phrase) {
		this.phrase = phrase;
	}
		

}
