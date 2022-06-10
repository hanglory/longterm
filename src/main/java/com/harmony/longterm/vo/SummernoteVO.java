package com.harmony.longterm.vo;


import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SummernoteVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String group1Id;
	private String group2Id;
	private String fileURL;
	private String fileName;
	private String url;
	private String videoType;
	private String videoUrl;
	private String resultCode;
	private String resultMsg;
	public void setResultCode(String resultCode2) {
		// TODO Auto-generated method stub
		
	}

}
