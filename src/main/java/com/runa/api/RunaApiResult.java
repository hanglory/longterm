package com.runa.api;

public class RunaApiResult {
	
	private String code;
	private String msg;
	
	public RunaApiResult() {
		this.code = "1";
		this.msg = "";
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getCode() {
		return code;
	}
	
	public String getMsg() {
		return msg;
	}

}
