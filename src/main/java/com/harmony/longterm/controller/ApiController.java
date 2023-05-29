package com.harmony.longterm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.harmony.longterm.vo.ApiRecvDataVO;
import com.mysql.cj.util.StringUtils;

@RequestMapping("/API")
@Controller
public class ApiController {

	@Autowired
	private SqlSessionTemplate sqlSession;	
	
	static final Logger logger = LoggerFactory.getLogger(ApiController.class);
	/** 
	 * <PRE>
	 * 설명 : 현대 캐피탈사에서 데이타 받아서 DB에 저장 처리
	 * </PRE>
	 * @param ApiRecvDataVO
	 * @return Map 
	 *		20000	정상 (응답 메시지 없음)
	 *		40011	필수값누락
	 *		40012	데이터타입오류
	 *		40013	데이터길이오류
	 *		40099	기타
	 * @throws Exception 
	 */	
	@RequestMapping({ "/hyundaicapitalReq" })
	@ResponseBody
	public Map<String, Object> hyundaicapitalReq(HttpServletRequest request, Model model,
			@ModelAttribute ApiRecvDataVO apiRecvDataVO) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();

		//logger.info(null, null, null)
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getPlfmMrknChnlCd())) {
			returnMap.put("code","40011");
			returnMap.put("message","프라임론마케팅채널코드 값이 누락 되었습니다.");
		}
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getAfflAcptReqNo())) {
			returnMap.put("code","40011");
			returnMap.put("message","제휴접속요청번호 값이 누락 되었습니다.");
		}
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getAgmAgrmDt())) {
			returnMap.put("code","40011");
			returnMap.put("message","약관동의일자 값이 누락 되었습니다.");
		}
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getOffrPrdtCd())) {
			returnMap.put("code","40011");
			returnMap.put("message","오퍼상품코드 값이 누락 되었습니다.");
		}
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getCustNo())) {
			returnMap.put("code","40011");
			returnMap.put("message","고객번호 값이 누락 되었습니다.");
		}
		if (StringUtils.isNullOrEmpty(apiRecvDataVO.getCustNm())) {
			returnMap.put("code","40011");
			returnMap.put("message","고객명 값이 누락 되었습니다.");
		}
		int result = this.sqlSession.insert("api.insertApiRecvData", apiRecvDataVO);
		return returnMap;
	}	

	/** 
	 * <PRE>
	 * 설명 : 현대 캐피탈사에서 데이타 받아서 DB에 저장 처리
	 * </PRE>
	 * @param ApiRecvDataVO
	 * @return Map 
	 *		20000	정상 (응답 메시지 없음)
	 *		40011	필수값누락
	 *		40012	데이터타입오류
	 *		40013	데이터길이오류
	 *		40099	기타
	 * @throws Exception 
	 */	
	@RequestMapping({ "/skRentCarReq" })
	@ResponseBody
	public Map<String, Object> skRentCarReq(HttpServletRequest request, Model model) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();

		String cntrId 	= request.getParameter("cntrId");
		String carNo 	= request.getParameter("carNo");
		String assetNo 	= request.getParameter("asset_no");
		String agreeYn 	= request.getParameter("agree_yn");
		String custNm 	= request.getParameter("custNm");
		String gndr 	= request.getParameter("gndr");
		String birthDt 	= request.getParameter("brthDt");
		String hpNo 	= request.getParameter("hpNo");
		String cntrTermMm = request.getParameter("cntrTermMm");
		String prmsDtc = request.getParameter("prmsDtc");
		String impsnl = request.getParameter("impsnl");
		String pldgRt = request.getParameter("pldgRt");
		String rglRentAmt = request.getParameter("rglRentAmt");

		//int result = this.sqlSession.insert("api.insertApiRecvData", apiRecvDataVO);
		return returnMap;
	}	
		

}
