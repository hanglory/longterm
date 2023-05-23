package com.runa.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.harmony.longterm.controller.AdminController;

public class RunaApiClass {
	private static final Logger logger = LoggerFactory.getLogger(RunaApiClass.class);

	
	private final static String HOST = "https://jupiter.lunasoft.co.kr";
	private final static String API_URL = "/api/AlimTalk/message/send";
	
	private final static String USER_ID = "harmony";
	private final static String API_KEY = "6tp863yggwrzrqrzcxgbo7jb5zssvv8cffyzusna";
	private final static String URL_PC = "https://harmonyrentcar.com";
	private final static String URL_MOBILE = "https://harmonyrentcar.com";
	
	private final static String ALIM_TMP01 = "안녕하세요!\r\n"
			+ "#{shop_name}입니다.#{name}님의 견적문의가 완료되었습니다..\r\n"
			+ "잠시만 기다려주시면 고객님의 연락처 #{tel_num}으로 #{re_credit} 장기렌트 상담 도와드리도록 하겠습니다.\r\n"
			+ "\r\n"
			+ "문의사항 1661-9763\r\n"
			+ "\r\n"
			+ "신용무관 즉시출고를 기본으로 하는 \"하모니렌트카\"\r\n"
			+ "#{url}";
	
	private final static String SMS_TMP01 = "안녕하세요!\r\n"
			+ "#{shop_name}입니다. #{name}님의 견적문의가 완료되었습니다..\r\n"
			+ "잠시만 기다려주시면 고객님의 연락처 #{tel_num}으로 #{re_credit} 장기렌트 상담 도와드리도록 하겠습니다.\r\n"
			+ "\r\n"
			+ "문의사항 1661-9763\r\n"
			+ "\r\n"
			+ "신용무관 즉시출고를 기본으로 하는 \"하모니렌트카\"\r\n"
			+ "#{url}";
	
	public RunaApiResult sendAlimTok(Map<String, Object> param) {
		// http 통신 세팅
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		
		Map<String, Object> runaMap = new HashMap<String, Object>();
		Map<String, Object> messageMap = new HashMap<String, Object>(); 
		List<Map<String, Object>> messageList = new ArrayList<>();
		
		// 템플릿 내용 치환
		Map<String, String> tmpParmm = new HashMap<String, String>();
		String alimMsg = ALIM_TMP01;
		String smsMsg = SMS_TMP01;
		tmpParmm.put("key", "shop_name");
		tmpParmm.put("value", "하모니렌트카");
		
		alimMsg = replaceTemplateToParam(alimMsg, tmpParmm);
		smsMsg = replaceTemplateToParam(smsMsg, tmpParmm);
		
		tmpParmm.put("key", "name");
		tmpParmm.put("value", String.valueOf(param.get("customerNm")));
		
		alimMsg = replaceTemplateToParam(alimMsg, tmpParmm);
		smsMsg = replaceTemplateToParam(smsMsg, tmpParmm);
		
		tmpParmm.put("key", "tel_num");
		tmpParmm.put("value", String.valueOf(param.get("phoneNo")));
		
		alimMsg = replaceTemplateToParam(alimMsg, tmpParmm);
		smsMsg = replaceTemplateToParam(smsMsg, tmpParmm);
		
		tmpParmm.put("key", "re_credit");
		tmpParmm.put("value", String.valueOf(param.get("carKindSel")));
		
		alimMsg = replaceTemplateToParam(alimMsg, tmpParmm);
		smsMsg = replaceTemplateToParam(smsMsg, tmpParmm);
		
		tmpParmm.put("key", "url");
		tmpParmm.put("value", "https://harmonyrentcar.com");
		
		alimMsg = replaceTemplateToParam(alimMsg, tmpParmm);
		smsMsg = replaceTemplateToParam(smsMsg, tmpParmm);
		
		
		
		
		
		messageMap.put("no", "0");						// 	0?
		messageMap.put("tel_num", param.get("phoneNo"));
		messageMap.put("msg_content",alimMsg);
		messageMap.put("sms_content", smsMsg);
		messageMap.put("use_sms", "1");					// 알림톡 실패 시, sms 송신 여부(현재사용)
		
		messageList.add(messageMap);
		
		runaMap.put("userid", USER_ID);
		runaMap.put("api_key", API_KEY);
		runaMap.put("template_id", "50034");			// 견적문의 템플릿 아이디(템플릿 변경시 바꿔야함)
		runaMap.put("messages", messageList);
		
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(runaMap, headers);
		
		RunaApiResult runaApiResult = restTemplate.postForObject(HOST + API_URL, request, RunaApiResult.class);
		
		
		return runaApiResult;
	}
	
	
	private String replaceTemplateToParam(String tmp, Map<String, String> param) {
		String message = "";
		String key = param.get("key");
		String value = param.get("value");
			
		String target  = "#{" + key + "}";
		message = tmp.replace(target, value);

		return message;
	}
	
	
	
	

}
