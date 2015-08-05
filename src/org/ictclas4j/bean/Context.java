package org.ictclas4j.bean;

public class Context {
	//关键词
	private int key;

	private int[][] contextArray;// The context array
	//一个标签的词频
	private int[] freq;// The total number a tag appears
	//所有标记的词频的总和
	private int totalFreq;// The total number of all the tags

	public int[][] getContextArray() {
		return contextArray;
	}

	public void setContextArray(int[][] contextArray) {
		this.contextArray = contextArray;
	}

	public int[] getFreq() {
		return freq;
	}

	public void setFreq(int[] freq) {
		this.freq = freq;
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public int getTotalFreq() {
		return totalFreq;
	}

	public void setTotalFreq(int totalFreq) {
		this.totalFreq = totalFreq;
	} 

}