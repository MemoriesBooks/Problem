package com.oracle.curd.bean;

public class Record {
	private Integer id;
	private String event;
	private String event_time;
	private String event_ip;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getEvent_time() {
		return event_time;
	}
	public void setEvent_time(String event_time) {
		this.event_time = event_time;
	}
	public String getEvent_ip() {
		return event_ip;
	}
	public void setEvent_ip(String event_ip) {
		this.event_ip = event_ip;
	}

}
