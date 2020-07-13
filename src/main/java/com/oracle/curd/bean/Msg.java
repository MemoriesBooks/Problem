package com.oracle.curd.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

	//定义一个返回的状态码
	private int code;
	//定义返回的信息
	private String msg;
	//定义用户需要返回的数据
	private Map<String, Object> extend = new HashMap<String, Object>();
	//编写执行成功的方法
	public static Msg success(){
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("处理成功!");
		return msg;
	}
	//编写执行失败的方法
	public static Msg fail(){
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("处理失败!");
		return msg;
	}
	//编写一个添加数据的方法，希望此方法是可以完成链式编程
	public Msg add(String key,Object value){
		this.getExtend().put(key, value);
		return this;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
}
