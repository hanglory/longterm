package com.harmony.longterm.controller;

import java.io.UnsupportedEncodingException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.harmony.longterm.service.IApiService;
import com.harmony.longterm.service.IBoardService;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.vo.ApiRecvDataVO;
import com.harmony.longterm.vo.HyundaiCapitalVO;
import com.mysql.cj.util.StringUtils;

@RequestMapping("/API")
@Controller
public class ApiController {

	@Autowired
	private SqlSessionTemplate sqlSession;	

	@Autowired
	private IApiService apiService;
	
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
//	public Map<String, Object> hyundaicapitalReq(HttpServletRequest request, Model model, @RequestBody HyundaiCapitalVO hyundaiCapitalVO) throws Exception {
	public Map<String, Object> hyundaicapitalReq(HttpServletRequest request, @RequestParam(required = false) Map<String, String> params,  @RequestBody(required = false)  HashMap<String, String> map , Model model) throws Exception {
	//	HyundaiCapitalVO hyundaiCapitalVO = new HyundaiCapitalVO();
		
		logger.debug(params.toString());
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int result = 0;
		
		String pmlnMrknChnlCd = "";		// 프라임론마캐팅 채널코드(필수)
		String cnslAplNo = "";			// 상담신청번호 (필수)
		String agmAgrmDt = "";			// 약관동의일자 (필수)
		String offrPrdtCd = "";			// 오퍼상품코드 (필수)
		String custNm = "";				// 고객명 (필수)
		String custCtifCn = "";			// 고객연락처
		String cnslVhtpNm = "";			// 상담차종명
		String drotRsnCd = "";			// 탈락사유코드
		String custSgmnCd = "";			// 고객세그먼트코드
		
		returnMap.put("code", "40099");
		returnMap.put("message","파라미터 오류 입니다.");

		if(map != null ) {
			logger.debug(map.toString());
			pmlnMrknChnlCd 	= map.get("pmlnMrknChnlCd");
			cnslAplNo 	= map.get("cnslAplNo");
			agmAgrmDt 	= map.get("agmAgrmDt");
			offrPrdtCd 	= map.get("offrPrdtCd");
			custNm 	= map.get("custNm");	//암호화
			custCtifCn 	= map.get("custCtifCn");		//암호화
			cnslVhtpNm 	= map.get("cnslVhtpNm");	//암호화
			drotRsnCd 	= map.get("drotRsnCd");		//암호화
			custSgmnCd = map.get("custSgmnCd");
			result = 1;
			//logger.info(null, null, null)
			if (StringUtils.isNullOrEmpty(pmlnMrknChnlCd) ) {
				returnMap.put("code", "40011");				
				returnMap.put("message","프라임론마케팅채널코드 값이 누락 되었습니다.");
				result = -1;
			}
			if (StringUtils.isNullOrEmpty(agmAgrmDt)) {
				returnMap.put("code", "40011");				
				returnMap.put("message","약관동의일자 값이 누락 되었습니다.");
				result = -1;
			}
			if (StringUtils.isNullOrEmpty(offrPrdtCd)) {
				returnMap.put("code", "40011");				
				returnMap.put("message","오퍼상품코드 값이 누락 되었습니다.");
				result = -1;
			}
			if (StringUtils.isNullOrEmpty(cnslAplNo)) {
				returnMap.put("code", "40011");				
				returnMap.put("message","상담신청번호 값이 누락 되었습니다.");
				result = -1;
			}
			if (StringUtils.isNullOrEmpty(custNm)) {
				returnMap.put("code", "40011");				
				returnMap.put("message","고객명 값이 누락 되었습니다.");
				result = -1;
			}
		}
		if(result == 1) {
			ApiRecvDataVO apiRecvDataVO= new ApiRecvDataVO();
			apiRecvDataVO.setCoop_cd("HD");
			apiRecvDataVO.setPlfm_mrkn_chnl_cd(pmlnMrknChnlCd);
			apiRecvDataVO.setAffl_acpt_req_no(cnslAplNo);
			apiRecvDataVO.setAgm_agrm_dt(agmAgrmDt);
			apiRecvDataVO.setOffr_prdt_cd(offrPrdtCd);
			apiRecvDataVO.setCust_nm(custNm);
			apiRecvDataVO.setCust_ctif_cn(custCtifCn);
			apiRecvDataVO.setCnsl_vhtp_nm(cnslVhtpNm);
			apiRecvDataVO.setDrot_rsn_cd(drotRsnCd);
			apiRecvDataVO.setCust_sgmn_cd(custSgmnCd);
			
			result = this.sqlSession.insert("api.insertApiRecvData", apiRecvDataVO);
			if (result > 0 ) {
				returnMap.put("code", "20000");
				returnMap.put("message", "");
			}else {
				returnMap.put("code", "40099");
				returnMap.put("message", "입력 오류 입니다.");				
			}
		}
		logger.debug(returnMap.toString());
		
		return returnMap;
	}	

	/** 
	 * <PRE>
	 * 설명 : SK렌터카에서 데이타 받아서 DB에 저장 처리
	 * </PRE>
	 * @param ApiRecvDataVO
	 * @return Map (status,message,timestamp)
	 *		120000	응답완료
	 *		240000	응답실패
	 * @throws Exception 
	 */	
	
	@RequestMapping({ "/skRentCarReq" })
	@ResponseBody
	public Map<String, Object> skRentCarReq(HttpServletRequest request, @RequestParam(required = false) Map<String, String> params, @RequestBody(required = false)  HashMap<String, String> map, Model model) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		ApiRecvDataVO apiRecvDataVO = new ApiRecvDataVO();

		logger.debug("cnt_id="+request.getParameter("cntId"));
		String cntrId 	= "";
		String carNo 	= "";
		String assetNo 	= "";
		String agreeYn 	= "";
		String custNm 	= "";	//암호화
		String gndr 	= "";		//암호화
		String birthDt 	= "";	//암호화
		String hpNo 	= "";		//암호화
		String cntrTermMm = "";
		String prmsDtc = "";
		String impsnl = "";
		String pldgRt = "";
		String rglRentAmt = "";

		if (map != null) {
			logger.debug(map.toString());
		
			cntrId 	= map.get("cntrId");
			carNo 	= map.get("carNo");
			assetNo 	= map.get("asset_no");
			agreeYn 	= map.get("agree_yn");
			custNm 	= map.get("custNm");	//암호화
			gndr 	= map.get("gndr");		//암호화
			birthDt 	= map.get("brthDt");	//암호화
			hpNo 	= map.get("hpNo");		//암호화
			cntrTermMm = map.get("cntrTermMm");
			prmsDtc = map.get("prmsDtc");
			impsnl = map.get("impsnl");
			pldgRt = map.get("pldgRt");
			rglRentAmt = map.get("rglRentAmt");
		}
		apiRecvDataVO.setCoop_cd("SK");
		apiRecvDataVO.setAffl_acpt_req_no(cntrId);
		apiRecvDataVO.setAsset_no(assetNo);
		apiRecvDataVO.setAgm_agrm_dt(agreeYn);
		apiRecvDataVO.setCust_nm(custNm);
		apiRecvDataVO.setGndr(gndr);
		apiRecvDataVO.setBrthdt(birthDt);
		apiRecvDataVO.setCust_ctif_cn(hpNo);
		apiRecvDataVO.setPrms_dtc(prmsDtc);
		apiRecvDataVO.setImpsnl(impsnl);
		apiRecvDataVO.setPldg_rt(pldgRt);
		apiRecvDataVO.setRgl_rent_amt(rglRentAmt);
		apiRecvDataVO.setCnsl_vhtp_nm(carNo);
		apiRecvDataVO.setCntr_term_mm(cntrTermMm);
		
		if(cntrId == null || cntrId.equals("") ) {
			returnMap.put("status", "240000");
			returnMap.put("message", "응답실패");
			returnMap.put("timestamp", DateUtil.getTodayWithHMS());
		}else {
			int result = this.sqlSession.insert("api.insertApiRecvData", apiRecvDataVO);
			returnMap.put("status", "120000");
			returnMap.put("message", "응답완료");
			returnMap.put("timestamp", DateUtil.getTodayWithHMS());
		}
		logger.debug(returnMap.toString());
		return returnMap;
	}
/*	
	@RequestMapping({ "/skRentCarReq" })
	@ResponseBody
	public Map<String, Object> skRentCarReq(HttpServletRequest request, @RequestParam(required = false) Map<String, String> params, @RequestBody(required = false) Map<String, Object> jsonData, Model model) throws Exception {
	    // GET 방식 처리
	    if (request.getMethod().equals("GET")) {
	        // GET 데이터 출력
	        if (params != null) {
	            for (String parameterName : params.keySet()) {
	                String parameterValue = params.get(parameterName);
	                logger.debug(parameterName + "=" + parameterValue);
	            }
	        }
	    }

	    // POST 방식 및 JSON 데이터 처리
	    if (request.getMethod().equals("POST")) {
	        // JSON 데이터 출력
	        if (jsonData != null) {
	            for (String key : jsonData.keySet()) {
	                Object value = jsonData.get(key);
	                logger.debug(key + "=" + value);
	            }
	        }
	    }	
	
	    Map<String, Object> returnMap = new HashMap<String, Object>();

//			int result = this.sqlSession.insert("api.insertApiRecvData", apiRecvDataVO);
			returnMap.put("status", "120000");
			returnMap.put("message", "응답완료");
			returnMap.put("timestamp", DateUtil.getTodayWithHMS());
//		}

	    return returnMap;
	}
*/
	
	/* 2023.06.06 KKH api_recv_data 테이블 값 UPdate
	 * param : seqno - 고유번호
	 * 			status - 상태 변경 값
	 * return : Map ("resultCode","0000") - 성공
	 *              ("keyValue","밀리세컨드시간") 전송키값         
	 *              */

	@RequestMapping({"/apiRecvDataUpdateAjax"})
	@ResponseBody
	public Map<String, Object> apiRecvDataUpdateAjax(HttpServletRequest request, Model model, @RequestBody(required = false) HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   if(param == null) {
			  resultMap.put("resultCode", "9999");
			  return resultMap;
	   }else {
		   if( param.get("seqno") == null || param.get("seqno").equals("")) {
			  resultMap.put("resultCode", "7777");
			  return resultMap;
		   }
		   
		   if(param.get("cntrReqSts") == null || param.get("cntrReqSts").equals("")) {
			   resultMap.put("resultCode", "8888");
		   }else {
			   
			   apiService.updateApiRecvData(request, param);
			   resultMap.put("resultCode","0000");
			   
		   }
	   }
	   return resultMap;
	}			

	
	
	
}
