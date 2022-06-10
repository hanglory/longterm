package com.harmony.longterm.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BoardVO {
	private String bd_no;
	private String bd_reguser;
	private String bd_title;
	private String bd_contents;
	private String bd_regdate;
	private String bd_isnotice;
	private String bd_type;
	private String bd_filename;
	private String bd_filelink;
	private String bd_viewcnt;
	private String bd_isdel;
	private String resultCode;
	private String detailDesc;

	private String imgChartURL;
	private String commentImgURL;
	private String attechFileURL;
	private String[] attechFileBfNos;
	private MultipartFile attechFiles;
}
