package com.harmony.longterm.vo;

import lombok.Data;

@Data
public class ApiRecvDataVO {
	private String seqno;		//유니크 번호
	private String coop_cd;		// HD-현대케피탈, SK- SK렌트카
	private String plfm_mrkn_chnl_cd;	// 프라임론 마케팅 채널코드 (3)
	private String affl_acpt_req_no;	// 제휴접수요청번호 (20) - 년도(4)+월(2)+일(2)+일련번호(12)
	private String agm_agrm_dt;		// 약관동의 일자(8) - YYYYMMDD
	private String offr_prdt_cd;		// 오퍼상품코드(2)
	private String cust_no;			// 고객번호(10)
	private String cust_nm;			// 고객명 (100) - 암호화
	private String cust_ctif_cn;		// 고객연락처내용 (50) - 암호화
	private String cnsl_vhtp_nm;		// 상담차종명(50)  (SK-차량번호)
	private String drot_rsn_cd;		// 탈락사유코드(2)
	private String cust_sgmn_cd;		// 고객세그먼트 코드(1)
	private String reg_date;			//등록일(현대캐피탈)
	private String asset_no; 		// 자산번호(SK)
	private String gndr; 			// 성별 암호화(SK)
	private String brthdt; 			// 생년월일 암호화(SK)
	private String cntr_term_mm;		// 계약기간(SK)
	private String prms_dtc;		// 약정주행거리(SK)
	private String impsnl;			// 대물보험(SK)
	private String pldg_rt;			//보증금율(SK)
	private String rgl_rent_amt;	//표눚렌탈료(SK)
	private String status;			//상태변경값(SK)
	private String memo;			//메모(SK)
	private String manager;			//담당자
	private	String dec_cust_nm;		//고객명 복호화 된값
}
