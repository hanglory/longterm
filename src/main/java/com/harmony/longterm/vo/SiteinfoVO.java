package com.harmony.longterm.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SiteinfoVO {
	private String id;
	private String title;
	private String start_date;
	private String end_date;
	private String left_postion;
	private String top_postion;
	private String width;
	private String height;
	private String contents;
	private String link_url;
	private String pc_type;
	private String resultCode;
	private int page;
	private int count;
}