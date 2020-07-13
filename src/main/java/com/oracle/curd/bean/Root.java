package com.oracle.curd.bean;

import java.io.Serializable;

public class Root implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer root_id;  //管理员id
	private String root_code; //管理员账号
	private String root_password;  //管理员密码
	private String root_name; //管理员名字
	public Integer getRoot_id() {
		return root_id;
	}
	public void setRoot_id(Integer root_id) {
		this.root_id = root_id;
	}
	public String getRoot_code() {
		return root_code;
	}
	public void setRoot_code(String root_code) {
		this.root_code = root_code;
	}
	public String getRoot_password() {
		return root_password;
	}
	public void setRoot_password(String root_password) {
		this.root_password = root_password;
	}
	public String getRoot_name() {
		return root_name;
	}
	public void setRoot_name(String root_name) {
		this.root_name = root_name;
	}

}
