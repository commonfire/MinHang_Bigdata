package edu.bupt.display;

import java.text.DecimalFormat;

public class ShowFormat {
	/**
	 * 将数字保留小数点后4位
	 * @param num    待转换的数字
	 * @return       转换后的数字
	 */
	public static String showFormat(double num){
		DecimalFormat df = new DecimalFormat("#0.0000");
		String showNum = df.format(num);
		return showNum;
	}
	
	public static void main(String[] args) {
		System.out.println(ShowFormat.showFormat(0));
	}
}

