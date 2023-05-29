package com.harmony.longterm.vo;

import lombok.Data;

@Data
public class ApiRecvDataVO {
	private String coopFlag;		// HD-현대케피탈, SK- SK렌트카
	private String plfmMrknChnlCd;	// 프라임론 마케팅 채널코드 (3)
	private String afflAcptReqNo;	// 제휴접수요청번호 (20) - 년도(4)+월(2)+일(2)+일련번호(12)
	private String agmAgrmDt;		// 약관동의 일자(8) - YYYYMMDD
	private String offrPrdtCd;		// 오퍼상품코드(2)
	private String custNo;			// 고객번호(10)
	private String custNm;			// 고객명 (100) - 암호화
	private String custCtifCn;		// 고객연락처내용 (50) - 암호화
	private String cnslVhtpNm;		// 상담차종명(50)
	private String drotRsnCd;		// 탈락사유코드(2)
	private String custSgmnCd;		// 고객세그먼트 코드(1)
	private String assetNo; 		// 자산번호(SK)
	private String gndr; 			// 성별 암호화(SK)
	private String brthdt; 			// 생년월일 암호화(SK)
}
