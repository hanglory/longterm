package com.harmony.longterm.vo;

import lombok.Data;

@Data
public class BoardSearchVO {
		private String searchKey;
		private String searchValue;
		private String articleFlag;			//이전,다음 구분자
		private String searchBcId;
		private String searchBdNo;
		private String searchBctNo;
		private String searchBdFno;
		private String searchBdThread;
		private String formType;
		private String searchBdIsnotice;
		private String pagintionFlag;
		private String searchOrder;

		private String servletPath;

		private String id;	// 게시판구분아이디

		private String noLayout; // 레이아웃 사용여부
		
		private boolean isConts = false; // 글내용 포함여부
}
