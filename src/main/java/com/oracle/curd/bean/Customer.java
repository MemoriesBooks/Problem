package com.oracle.curd.bean;

import java.io.Serializable;

public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer user_id;      //用户Id
	private String user_code;     //用户账号
	private String user_name;     //用户名字
	private String user_password; //用户密码
	private Integer user_state;   //用户状态״̬
	private String user_age;	//用户年龄
	private String user_sex;	//用户性别
	//将Customer中user_id,user_code,user_name以键值对的形式返回
	@Override
	  public String toString() { 
	    return "Customer [user_id=" + user_id + ", user_code=" + user_code + ", user_name=" + user_name 
	        + "]"; 
	  } 
	public Integer getUser_id() {
		return user_id;
	} //对外返回值
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}//赋值
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public Integer getUser_state() {
		return user_state;
	}
	public void setUser_state(Integer user_state) {
		this.user_state = user_state;
	}
	public String getUser_age() {
		return user_age;
	}
	public void setUser_age(String user_age) {
		this.user_age = user_age;
	}
	public String getUser_sex() {
		return user_sex;
	}
	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}
}
