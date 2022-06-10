package com.harmony.longterm.vo;

public class HoldingCarVO {
	/**	상품이름	*/
	private String fullname;
	/**	닉네임	*/
	private String link_url;
	public HoldingCarVO() {}

	public HoldingCarVO(String fullname, String link_url) {
		this.fullname = fullname;
		this.link_url = link_url;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}
	
}
