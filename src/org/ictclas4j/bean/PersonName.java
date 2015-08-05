package org.ictclas4j.bean;

/**
 * 人名
 * 
 * @author 张培颖
 * 
 */
public class PersonName {
	//首名字
	private String firstName;
	//中间名字
	private String midName;
	//后面的名字
	private String lastName;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMidName() {
		return midName;
	}

	public void setMidName(String midName) {
		this.midName = midName;
	}
}