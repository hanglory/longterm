package com.harmony.longterm.vo;

import lombok.Data;

@Data
public class BankAccountVO {
	private String seqno;	// 번호
	private String bank_name;	// 은행명
	private String account;		// 계좌번호
	private String carno;		// 고객번호
	private String user_name;	// 연결계좌 실명
	private String reg_id;		// 발금자 ID Level 5 이상인 사람
	private String memo;		// 
	private String used_code;	// 0-발급전, 1-사용, 2-이용자지정
	private String recv_date;	// reg_id가 등록된 시간
	private String name;		// 발급자 이름
	private String charge;		// 영업사원 번호
	private String ag;		// 에이전시번호
	
	private String resultCode;  // 실행결과 코드
}
