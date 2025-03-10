package com.harmony.longterm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gabia.api.ApiClass;
import com.gabia.api.ApiResult;
import com.harmony.longterm.service.IBoardService;
import com.harmony.longterm.service.IUsedCarService;
import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.BoardVO;
import com.harmony.longterm.vo.UsedCarVO;
import com.mysql.cj.util.StringUtils;
import com.runa.api.RunaApiClass;
import com.runa.api.RunaApiResult;

@Controller
@RequestMapping({"/bbs"})
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	
	@Autowired
	private IBoardService boardService;
	
	@Autowired
	private IUsedCarService usedCarService;
	
	@Resource(name = "configProps")
	private Properties properties;

	/*    */   @RequestMapping({"/", "/{menu}"})
	/*    */   public String index(HttpServletRequest request, @PathVariable(value = "menu", required = false) String menu) {
	/* 33 */     if (menu == null) menu = "main"; 
	/* 34 */     String prefix = "bbs.";
	/*    */     
	/* 36 */     if (menu.contains("admin"))
	/*    */     {
	/* 38 */       return "redirect:/admin/";
	/*    */     }
	/* 40 */     if (menu.contains("member"))
	/*    */     {
	/* 42 */       return "redirect:/member/";
	/*    */     }
	/* 40 */     if (menu.contains("bbs"))
	/*    */     {
	/* 42 */       return "redirect:/bbs/";
	/*    */     }

	/* 44 */     Device device = DeviceUtils.getCurrentDevice(request);
	/* 45 */     if (device.isMobile()) {
	/* 48 */       prefix = "m-bbs.";
	/* 49 */     } else if (device.isTablet()) {
	/* 50 */       prefix = "m-bbs.";
	/* 51 */ //      logger.debug("tablet");
	/*    */     } 
	/*    */     
	/* 57 */ //    logger.debug(String.valueOf(prefix) + menu);
	/* 58 */     return String.valueOf(prefix) + menu;
	/*    */   }	
	
	/**
	 * <pre>
	 * 설명 : 자료실 LIST
	 * </pre>
	 * @param request
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping({"/board"})
	public String noticeList(HttpServletRequest request, Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,  @RequestParam(value = "bd_type", defaultValue = "1") Integer bd_type,@RequestParam(value = "search", defaultValue = "") String search ) throws Exception {
	  search = search.trim();
	  HashMap<String, Object> queryMap = new HashMap<>();
	  if (page.intValue() < 1) page = Integer.valueOf(1);
	  HttpSession session = request.getSession();
     String prefix = "bbs.";
     Device device = DeviceUtils.getCurrentDevice(request);
     if (device.isMobile()) {
       prefix = "m-bbs.";
     } else if (device.isTablet()) {
       prefix = "m-bbs.";
     } 
	  
	  int pageSize = 20;
	  Paging paging = new Paging();
	  paging.setPageNo(page.intValue());
	  paging.setPageSize(pageSize);
		  
	  queryMap.put("page", Integer.valueOf((page.intValue() - 1) * 20));
	  queryMap.put("count", Integer.valueOf(pageSize));
	  queryMap.put("bd_type", bd_type);
	  queryMap.put("search", search);
	  queryMap.put("bd_isdel", "0");
		  
	  int count = boardService.selectBoardTotCnt(queryMap);
	  paging.setTotalCount(count);

	  List<BoardVO> boardVO = boardService.selectBoardList(queryMap);
		  
	  model.addAttribute("boardVO", boardVO);
	  model.addAttribute("paging", paging);
	  model.addAttribute("userLevel", session.getAttribute("userLevel"));
		  
	  return String.valueOf(prefix) +"board";
	}		
	/**
	 * <pre>
	 * 설명 : FaQ게시판 LIST
	 * </pre>
	 * @param request
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping({"/board_faq"})
	public String boardFaqList(HttpServletRequest request, Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,  @RequestParam(value = "bd_type", defaultValue = "2") Integer bd_type,@RequestParam(value = "search", defaultValue = "") String search ) throws Exception {
	  search = search.trim();
	  HashMap<String, Object> queryMap = new HashMap<>();
	  if (page.intValue() < 1) page = Integer.valueOf(1);
	  HttpSession session = request.getSession();
	  
	  int pageSize = 20;
	  Paging paging = new Paging();
	  paging.setPageNo(page.intValue());
	  paging.setPageSize(pageSize);
		  
	  queryMap.put("page", Integer.valueOf((page.intValue() - 1) * 20));
	  queryMap.put("count", Integer.valueOf(pageSize));
	  queryMap.put("bd_type", bd_type);
	  queryMap.put("search", search);
	  queryMap.put("bd_isdel", "0");
		  
	  int count = boardService.selectBoardTotCnt(queryMap);
	  paging.setTotalCount(count);
		  
	  List<BoardVO> boardVO = boardService.selectBoardList(queryMap);
	  model.addAttribute("boardVO", boardVO);
	  model.addAttribute("paging", paging);
	  model.addAttribute("userLevel", session.getAttribute("userLevel"));
	  model.addAttribute("bd_type", bd_type);

	     String prefix = "bbs.";
	     Device device = DeviceUtils.getCurrentDevice(request);
	     if (device.isMobile()) {
	       prefix = "m-bbs.";
	     } else if (device.isTablet()) {
	       prefix = "m-bbs.";
	     } 

	  return String.valueOf(prefix) + "board_faq";
	}		

	@RequestMapping({"/smsSendAjax"})
	@ResponseBody
	public Map<String, Object> smsSendAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   
	   String authNumber = Utils.randomAlphaNumeric(4);
	   String strMsg = "하모니렌트카 인증번호는["+authNumber+"]입니다.";
	   param.put("message", strMsg);
	   resultMap = boardService.sendSms(request, param);
	   resultMap.put("authKey", authNumber);
	   return resultMap;
/*	   
	   String api_id = "inacar2011";		// sms.gabia.com 이용 ID
	   String api_key = "0e79114156e076bad7b1b06a1d94d7ae";	// 환결설정에서 확인 가능한 SMS API KEY
	   String resultXml = "";
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//	   param.get("phoneNo")
	   if(param.get("phoneNo").toString().length() < 12) {
		   resultMap.put("smsCode", "9999");	//핸드폰 번호가 올바르지 않음.
		   logger.debug("핸드폰 번호가 올바르지 않음:"+param.get("phoneNo").toString());
		   return resultMap;
	   }

//	   resultMap.put("test", "resultXml");
//	   if( 1 == 1)
//		   return resultMap;
	   
	   ApiClass api = new ApiClass(api_id, api_key);
	   long timeInMillis =System.currentTimeMillis();
	   Date timeInDate = new Date(timeInMillis); 
       String timeInFormat = sdf.format(timeInDate);

       String authNumber = Utils.randomAlphaNumeric(4);
       String clientIP = Utils.getClientIP(request);
	   System.out.println("timeMillis=" + timeInFormat);
	   // 단문 발송 테스트
	   String arr[] = new String[7];
	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat;	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] = "하모니렌트카 인증번호는["+authNumber+"]입니다.";	// 본문 (90byte 제한)
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] = param.get("phoneNo").toString();			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   String responseXml = api.send(arr);
	   System.out.println("response xml : \n" + responseXml);

	   ApiResult res = api.getResult( responseXml );
	   logger.debug( "code = [" + res.getCode() + "] mesg=[" + res.getMesg() + "]" );

	   if( res.getCode().compareTo("0000") == 0 )
	   {
//	   		resultXml = api.getResultXml(responseXml);
//	   		resultMap.put("seneResultXml", resultXml);
//	   		logger.debug("Send result xml : " + resultXml);
	   }
	   resultMap.put("smsCode", res.getCode());
	   resultMap.put("keyValue", timeInMillis);
	   resultMap.put("authKey", authNumber);

	   return resultMap;
*/
   }	
	@RequestMapping({"/smsSendHelpAjax"})
	@ResponseBody
	public Map<String, Object> smsSendHelpAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	
	   String authNumber = Utils.randomAlphaNumeric(4);
	   String strMsg = param.get("customerNm").toString() +"님 상담 요청 완료되었습니다.\n -하모니렌트카-";
	   param.put("message", strMsg);
	   resultMap = boardService.sendSms(request, param);
	   
	   strMsg = "이름 : "+param.get("customerNm").toString() +"\n"
		   		+ "연락처 : "+param.get("phoneNo").toString()+"\n"
		   		+ "구분 : "+param.get("carKindSel").toString()+"\n"
		   		+ "\n"
		   		+ "상담요청 접수되었습니다. ";	// 본문 (90byte 제한)
	   param.put("message", strMsg);
	   param.put("phoneNo", "01022528373");
	   resultMap = boardService.sendSms(request, param);
	   resultMap.put("authKey", authNumber);

	   
	   return resultMap;

/*	  2023. 05. 01 KKH 문자전송 서비스 클레스로 처리
	   String api_id = "inacar2011";		// sms.gabia.com 이용 ID
	   String api_key = "0e79114156e076bad7b1b06a1d94d7ae";	// 환결설정에서 확인 가능한 SMS API KEY
	   String resultXml = "";
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	   if(param.get("phoneNo").toString().length() < 12) {
		   resultMap.put("smsCode", "9999");	//핸드폰 번호가 올바르지 않음.
		   logger.debug("핸드폰 번호가 올바르지 않음:"+param.get("phoneNo").toString());
		   return resultMap;
	   }


	   ApiClass api = new ApiClass(api_id, api_key);
	   long timeInMillis =System.currentTimeMillis();
	   Date timeInDate = new Date(timeInMillis); 
       String timeInFormat = sdf.format(timeInDate);

       String authNumber = Utils.randomAlphaNumeric(4);
       String clientIP = Utils.getClientIP(request);
	   System.out.println("timeMillis=" + timeInFormat);
	   // 단문 발송 테스트
	   String arr[] = new String[7];
	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat;	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] = "이름 : "+param.get("customerNm").toString() +"\n"
		   		+ "연락처 : "+param.get("phoneNo").toString()+"\n"
		   		+ "구분 : "+param.get("carKindSel").toString()+"\n"
		   		+ "\n"
		   		+ "상담요청 접수되었습니다. ";	// 본문 (90byte 제한)
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] = "01022528373";			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   String responseXml = api.send(arr);
	   System.out.println("response xml : \n" + responseXml);

	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat+"1";	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] = param.get("customerNm").toString() +"님 상담 요청 완료되었습니다.\n -하모니렌트카-";
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] = param.get("phoneNo").toString();			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   responseXml = api.send(arr);	   
	   ApiResult res = api.getResult( responseXml );
	   logger.debug( "code = [" + res.getCode() + "] mesg=[" + res.getMesg() + "]" );

	   resultMap.put("smsCode", res.getCode());
	   resultMap.put("keyValue", timeInMillis);
	   resultMap.put("authKey", authNumber);

	   return resultMap;
*/
   }
	@RequestMapping({"/banksmsSendAjax"})
	@ResponseBody
	public Map<String, Object> banksmsSendAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   
	   String authNumber = Utils.randomAlphaNumeric(4);
	   String strMsg = "하모니렌트카 인증번호는["+authNumber+"]입니다.";
	   param.put("message", strMsg);
	   resultMap = boardService.sendSms(request, param);
	   resultMap.put("authKey", authNumber);
	   return resultMap;
/*	   
	   String api_id = "inacar2011";		// sms.gabia.com 이용 ID
	   String api_key = "0e79114156e076bad7b1b06a1d94d7ae";	// 환결설정에서 확인 가능한 SMS API KEY
	   String resultXml = "";
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//	   param.get("phoneNo")
	   if(param.get("phoneNo").toString().length() < 12) {
		   resultMap.put("smsCode", "9999");	//핸드폰 번호가 올바르지 않음.
		   logger.debug("핸드폰 번호가 올바르지 않음:"+param.get("phoneNo").toString());
		   return resultMap;
	   }

//	   resultMap.put("test", "resultXml");
//	   if( 1 == 1)
//		   return resultMap;
	   
	   ApiClass api = new ApiClass(api_id, api_key);
	   long timeInMillis =System.currentTimeMillis();
	   Date timeInDate = new Date(timeInMillis); 
       String timeInFormat = sdf.format(timeInDate);

       String authNumber = Utils.randomAlphaNumeric(4);
       String clientIP = Utils.getClientIP(request);
	   System.out.println("timeMillis=" + timeInFormat);
	   // 단문 발송 테스트
	   String arr[] = new String[7];
	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat;	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] = "하모니렌트카 인증번호는["+authNumber+"]입니다.";	// 본문 (90byte 제한)
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] = param.get("phoneNo").toString();			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   String responseXml = api.send(arr);
	   System.out.println("response xml : \n" + responseXml);

	   ApiResult res = api.getResult( responseXml );
	   logger.debug( "code = [" + res.getCode() + "] mesg=[" + res.getMesg() + "]" );

	   if( res.getCode().compareTo("0000") == 0 )
	   {
//	   		resultXml = api.getResultXml(responseXml);
//	   		resultMap.put("seneResultXml", resultXml);
//	   		logger.debug("Send result xml : " + resultXml);
	   }
	   resultMap.put("smsCode", res.getCode());
	   resultMap.put("keyValue", timeInMillis);
	   resultMap.put("authKey", authNumber);

	   return resultMap;
*/
   }
	
	@RequestMapping({"/banksmsSendHelpAjax"})
	@ResponseBody
	public Map<String, Object> banksmsSendHelpAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   String api_id = "inacar2011";		// sms.gabia.com 이용 ID
	   String api_key = "0e79114156e076bad7b1b06a1d94d7ae";	// 환결설정에서 확인 가능한 SMS API KEY
	   String resultXml = "";
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	   if(param.get("phoneNo").toString().length() < 10) {
		   resultMap.put("smsCode", "9999");	//핸드폰 번호가 올바르지 않음.
		   logger.debug("핸드폰 번호가 올바르지 않음:"+param.get("phoneNo").toString());
		   return resultMap;
	   }


	   ApiClass api = new ApiClass(api_id, api_key);
	   long timeInMillis =System.currentTimeMillis();
	   Date timeInDate = new Date(timeInMillis); 
       String timeInFormat = sdf.format(timeInDate);

       String authNumber = Utils.randomAlphaNumeric(4);
       String clientIP = Utils.getClientIP(request);
       
       
       
	   System.out.println("timeMillis=" + timeInFormat);
	   // 단문 발송 테스트
	   String arr[] = new String[7];
	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat;	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] = " "+param.get("customerNm").toString() +"고객님"+ "\n"
		   		+ "우리은행 전용계좌 : "+param.get("carKindSel").toString()+ "입니다." + "\n"
		   		+ "\n"
		   		+ "감사합니다. -하모니렌트카-";	// 본문 (90byte 제한)
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] =  param.get("phoneNo").toString(); //"01022528373";			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   String responseXml = api.send(arr);
	   System.out.println("response xml : \n" + responseXml);

	   arr[0] = "sms";							// 발송 타입 sms or lms
	   arr[1] = timeInFormat+"1";	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
	   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
	   arr[3] =  " "+param.get("customerNm").toString() +"고객님"+ "\n"
		   		+ "우리은행 전용계좌 : "+param.get("carKindSel").toString()+ "입니다." + "\n"
		   		+ "\n"
		   		+ "감사합니다. -하모니렌트카-";
	   arr[4] = "1661-9763";			// 발신 번호
	   arr[5] = param.get("authNumber").toString();			// 수신 번호
	   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

	   responseXml = api.send(arr);	   
	   ApiResult res = api.getResult( responseXml );
//	   logger.debug( "code = [" + res.getCode() + "] mesg=[" + res.getMesg() + "]" );

	   resultMap.put("smsCode", res.getCode());
	   resultMap.put("keyValue", timeInMillis);
	   resultMap.put("authKey", authNumber);

	   return resultMap;

   }
	
	
	
	@RequestMapping({"/smsSendPdfAjax"})
	@ResponseBody
	public Map<String, Object> smsSendPdfAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   
	   String authNumber = Utils.randomAlphaNumeric(4);
	   String strMsg = "하모니 렌트카 견적서 다운로드URL : https://www.harmonyrent.co.kr/total/pdfForm?id="+param.get("id").toString() +"";
	   param.put("message", strMsg);
	   resultMap = boardService.sendSms(request, param);
	   resultMap.put("authKey", authNumber);
	   return resultMap;
	
	}

	/* 2023.05.01 KKH SMS 전송옹 컨트롤로 
	 * param : message - 문자내용(90바이트) 90바이트 이상이면 자동으로 LMS로 전환
	 * 			title - lms전송시 문자 내용 전달
	 *         phoneNo - 문자 수신자 전화 번호
	 * return : Map ("smsCode","0000") - 성공
	 *              ("keyValue","밀리세컨드시간") 전송키값         
	 *              */
	
	@RequestMapping({"/onlySmsSendAjax"})
	@ResponseBody
	public Map<String, Object> onlySmsSendAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   if(param.get("message") == null || param.get("message").equals("")) {
		   resultMap.put("smsCode", "8888");
		   
	   }else {
		   resultMap = boardService.sendSms(request, param);
		   
	   }
	   return resultMap;
   }

	/* 2023.05.01 KKH LMS 전송옹 컨트롤로 
	 * param : message - 문자내용(90바이트 이상)
	 * 			title - LMS수신시 표시되는 이름
	 *         phoneNo - 문자 수신자 전화 번호
	 * return : Map ("smsCode","0000") - 성공
	 *              ("keyValue","밀리세컨드시간") 전송키값         
	 *              */
	
	@RequestMapping({"/onlyLmsSendAjax"})
	@ResponseBody
	public Map<String, Object> onlyLmsSendAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {

	   Map<String, Object> resultMap = new HashMap<String,Object>();
	   
	   if( param.get("title") == null || param.get("title").equals("")) {
		  resultMap.put("smsCode", "7777");
		  return resultMap;
	   }
	   
	   if(param.get("message") == null || param.get("message").equals("")) {
		   resultMap.put("smsCode", "8888");
	   }else {
		   resultMap = boardService.sendLms(request, param);
		   
	   }
	   return resultMap;
   }	

	
		/**
		 * <pre>
		 * 설명 : 전문가카페 공지사항 상세
		 * </pre>
		 * @param request
		 * @param model
		 * @return
		 * @throws Exception
		 */
	
	@RequestMapping({"/boardAction"})
	@ResponseBody
	public Map<String, Object> boardAction(HttpServletRequest request, Model model, @ModelAttribute BoardVO boardVO) throws Exception {
		
		HttpSession session = request.getSession();
		Map<String, Object> objectAsMap = new HashMap<String,Object>();

		if (session.getAttribute("userLevel") == null || Integer.parseInt(session.getAttribute("userLevel").toString()) <= 0) {
			objectAsMap.put("resultCode","NOT_USER");
			return objectAsMap;
		}
		boardVO.setBd_reguser(session.getAttribute("userId").toString());
		if( StringUtils.isNullOrEmpty(boardVO.getBd_no()) ){
			//첨부파일
			MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;
			MultipartFile attechFiles = multipartRequest.getFile("attechFiles");
			boardVO.setAttechFiles(attechFiles);

			if(attechFiles != null) {
				String resultCd = boardService.uploadAddFile(attechFiles, boardVO);
				objectAsMap.put("resultCode", resultCd);
//					return objectAsMap;
			}
		}
		
		int bd_no = boardService.insertBoard(boardVO);
		if(bd_no > 0) {
			objectAsMap.put("resultCode", "0000");	
		}

		return objectAsMap;
	}

	@RequestMapping({"/usedcarDetail"})
	public String usedcarReal(HttpServletRequest request,@RequestParam HashMap<String, Object> map, Model model, @RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "car_id", defaultValue = "") String id, @RequestParam(value = "rentfee_hi", defaultValue = "") String rentfee_hi,@RequestParam(value = "rentfee_my", defaultValue = "") String rentfee_my,@RequestParam(value = "rentfee_ou", defaultValue = "") String rentfee_ou, @RequestParam(value = "rentfee_no", defaultValue = "") String rentfee_no) throws Exception {

			int pageSize = 200;
			Paging paging = new Paging();
//			paging.setPageNo(page.intValue());
//			paging.setPageSize(pageSize);

			HashMap<String, Object> queryMap = new HashMap<>();
			queryMap.put("page", 1);
			queryMap.put("count", Integer.valueOf(pageSize));
			queryMap.put("id", id);
			queryMap.put("sell_state", "판매중");

			
			usedCarService.updateUsedCarViewCnt(queryMap);
			
			UsedCarVO usedCarVO = usedCarService.selectUsedCar(queryMap);
// 렌트료 비슷한 차량 1건 광고
			map.put("rentfee_min", usedCarVO.getRentfee());
			map.put("orderby", "rentfee" );
			map.put("page", 0);
			map.put("count", 1);
			map.put("notid", id);
			map.put("sell_state", "판매중");
			map.put("car_type", usedCarVO.getCar_type());
			List<UsedCarVO> usedCarVOPop = usedCarService.selectUsedCarList(map);
			
			model.addAttribute("usedCarVOPop", usedCarVOPop);
			model.addAttribute("usedCarVO", usedCarVO);
			model.addAttribute("queryMap", queryMap);
			model.addAttribute("reqParam", map);
//			logger.debug(usedCarVO.toString());
		     String prefix = "bbs.";
		     Device device = DeviceUtils.getCurrentDevice(request);
		     if (device.isMobile()) {
		       prefix = "m-bbs.";
		     } else if (device.isTablet()) {
		       prefix = "m-bbs.";
		     } 
//		     logger.debug(String.valueOf(prefix) + "usedcarDetail");
			return String.valueOf(prefix) + "usedcarDetail";     
	}
	   @RequestMapping({"/usedcarAjax"})
	   @ResponseBody
	   public List<UsedCarVO> usedcarAjax(Model model,@RequestBody HashMap<String, Object> map) throws Exception {

			int pageSize = Integer.parseInt(map.get("pageSize").toString());
			int page = Integer.parseInt(map.get("page").toString());
			Paging paging = new Paging();
			paging.setPageNo(page);
			paging.setPageSize(pageSize);
	/*
			HashMap<String, Object> queryMap = new HashMap<>();
			queryMap.put("page", 1);
			queryMap.put("count", Integer.valueOf(pageSize));
			queryMap.put("maker", maker);
			queryMap.put("trim_name", trim_name);
			queryMap.put("deposit", deposit);
			queryMap.put("rentfee_min", rentfee_min);
			queryMap.put("rentfee_max", rentfee_max);
			queryMap.put("sell_state", "판매중");
	*/

			map.put("sell_state", "판매중");
			map.put("page", (page-1)*pageSize);
			map.put("count", Integer.valueOf(pageSize));
			int count = usedCarService.selectUsedCarTotCnt(map);
			paging.setTotalCount(count);

			List<UsedCarVO> usedCarVO = usedCarService.selectUsedCarList(map);
			if(usedCarVO.size() > 0)
				usedCarVO.get(0).setPaging(paging);
			return usedCarVO;     
	   }
	   
	   @PostMapping({"/smsAlimTokAjax"})
	   @ResponseBody
	   public Map<String, Object> alimTokSendAjax(HttpServletRequest request, Model model, @RequestBody HashMap<String, Object> param) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String,Object>();
		   
		   if(param.get("phoneNo").toString().length() < 10) {
			   resultMap.put("code", "9999");	//핸드폰 번호가 올바르지 않음.
			   logger.debug("핸드폰 번호가 올바르지 않음:"+param.get("phoneNo").toString());
			   return resultMap;
		   }
		   
		   RunaApiClass runaApi = new RunaApiClass();
		   RunaApiResult apiResult = runaApi.sendAlimTok(param);
		   
		   if("0".equals(apiResult.getCode())) {
			   resultMap.put("code", "1");
			   resultMap.put("msg", "success");
		   } else {
			   resultMap.put("code", "-1");
			   resultMap.put("msg", "fail");
		   }
		   
		   
		   return resultMap;   
	   }
	   

	   
	
}
	
	
	
