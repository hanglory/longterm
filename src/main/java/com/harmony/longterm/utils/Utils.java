package com.harmony.longterm.utils;

import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.harmony.longterm.controller.BoardController;

/**
 * @author 고경환
 *
 */
public class Utils {
	
	private static final Logger logger = LoggerFactory.getLogger(Utils.class);

	/**
	 * 파일명 및 확장자 확인
	 * @param fileName
	 * @return
	 * 0000 : 정상
	 * 0001 : 파일명 수용 불가
	 * 0002 : 파일 확장자 수용 불가
	 */
	public static String checkFileName(String fileName, String regexFileName, String regexFileExtension) {
		String valid = "0000"; //OK

		Pattern p = Pattern.compile(regexFileName);
		Matcher matcher = p.matcher(fileName);
		if(!matcher.matches()) {
			return "0001";
		}
		String fileExtensionRegex = ".*\\.(" + regexFileExtension + ")$";
		
		p = Pattern.compile(fileExtensionRegex);
		matcher = p.matcher(fileName);
		if(!matcher.matches()) {
			return "0002";
	    }
		return valid;
	}
	
	/** 
	 * <PRE>
	 * 설명 : 모바일 여부
	 * </PRE>
	 * @param request
	 * @return 
	 */
	public static boolean isMobile(HttpServletRequest request) {
		String userAgent = request.getHeader("user-agent");
		boolean mobile1 = userAgent.matches(
				".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		if (mobile1 || mobile2) {
			return true;
		}
		return false;
	}
	
	/** 
	 * <PRE>
	 * 설명 : 모바일 여부
	 * </PRE>
	 * @param pUserAgent
	 * @return 
	 */
	public static boolean isMobile(String pUserAgent) {
		String userAgent = pUserAgent.toLowerCase();
		boolean mobile1 = userAgent.matches(
				".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		if (mobile1 || mobile2) {
			return true;
		}
		return false;
	}	
	/**
	 * @param bbsFunction
	 * @param functionIdBbsViewFormDetail
	 * @param functionId
	 * @return null이면 존재하지 않거나 펑션사용여부가 N 임
	 * @throws Exception
	 * @설명 bbs가 가지고 있는 bbsFunction들을 가져오고 뷰의 BbsContentFunctionDetail과 비교하여서 사용이 가능한 BbsContentFunctionDetailVO객체를 넘겨줌
	 */
//	public static BbsContentFunctionDetailVO getFunctionIdBbsContentFunctionDetailVO (Map<String, BbsFunctionVO> bbsFunction, Map<String, BbsContentFunctionDetailVO> functionIdBbsViewFormDetail , String functionId) throws Exception{
//		BbsContentFunctionDetailVO result = null;
//		if(functionId != null) {
//			try {
//				if(bbsFunction.get(functionId) != null && bbsFunction.get(functionId).getAplcYn().equals(Const.COMMON_N)) {
//					return null;
//				} else if(functionIdBbsViewFormDetail.get(functionId) != null) {
//					result = functionIdBbsViewFormDetail.get(functionId); 
//				}
//				
//			}catch (Exception e) {
//				throw new Exception("C110002");
//			}
//		}
//		return result;
//	}

	/**
	 * 입력으로 넘어온 bbs에 해당 function을 사용하는지 확인 : bbsFunction
	 * @param functionId
	 * @param bbs
	 * @return
	 */
//	public static boolean checkFunction(String functionId, BbsVO bbs) {
//		boolean isUse = false;
//		Map<String, BbsFunctionVO> bbsFunctions = bbs.getBbsFunction();
//		if(bbsFunctions != null && !bbsFunctions.isEmpty()) {
//			BbsFunctionVO bbsFunction = bbsFunctions.get(functionId);
//			if(bbsFunction != null) {
//				if(bbsFunction.getAplcYn().equals(Const.COMMON_Y)){
//					isUse = true;
//				}
//			}
//		}
//		return isUse;
//	}
	
	
	/**
	* Null String을 "" String으로 바꿔준다.
	* @author 민선기 : 기존 NBBS에 있는 소스 가져옴
	*
	* @param String str	 Null 문자열 
	*
	* @return String "' 문자열
	*/
	public static String NVL(String str, String replace){
		if(str == null || str.length() <= 0)
			return replace;
		else 
			return str;
	}

	public static int getByteLength(String str){
		int strLength = 0;
		char tempChar[] = new char[str.length()];
		
		for (int i = 0; i < tempChar.length; i++) {
			tempChar[i] = str.charAt(i);
			
			if (tempChar[i] < 128) {
				strLength++;
			}else{
				strLength += 2;
			}
		}
		
		return strLength;
	}	

	public static String urlPaxDecode(String url) throws Exception {
		if(url == null) {
			return "";
		}
		
		url = URLDecoder.decode(url, "UTF-8");
		url = url.replace("\ufeff", "");//BOM
		url = url.replace("\u200B", "");//&#8203;
		url = Utils.htmlspecialchars(url);

//		url = url.replaceAll("%PP_%", "&lt;");
//		url = url.replaceAll("%_PP%", "&gt;");
//		url = url.replaceAll("%P_%", "<");
//		url = url.replaceAll("%_P%", ">");
//		url = url.replaceAll("%href_P%", "href=");
		
		return url;
	}
	
	/**
	 * <PRE>
	 * 설명 : html spechialchars replace
	 * </PRE>
	 * @param str
	 * @return
	 */
	public static String htmlspecialchars(String str){
		try{

			if(str == null) {
				return "";
			}
			
			str = str.replace((char)8211, '-' );
			
		}catch(Exception e){}
		
		return str;
	}
	
	/**
	 * <PRE>
	 * 설명 : html 태그 제거
	 * </PRE>
	 * @param String
	 * @return String
	 */
	public static String removeHtmlTag(String html){
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}
	


	/**
	 * <PRE>
	 * 설명 : 랜덤한 숫자 만들기(자리수 만큼)
	 * </PRE>
	 * @param int : 원하는 자릿수
	 * @return String
	 */
	public static String randomAlphaNumeric(int count) {
		String NUMERIC_STRING = "0123456789";
		StringBuilder builder = new StringBuilder();

		while (count-- != 0) {
        	int character = (int) (Math.random() * NUMERIC_STRING.length());
			builder.append(NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	}
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	    logger.info("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	        logger.info("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	        logger.info(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	        logger.info("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        logger.info("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	        logger.info("> getRemoteAddr : "+ip);
	    }
	    logger.info("> Result : IP Address : "+ip);

	    return ip;
	}

	/**
	 * <PRE>
	 * 설명 : array안에 같은 숫자가 있는지 비교
	 * </PRE>
	 * @param int[] : int값 array
	 * @param int : 찾을 숫자
	 * @return int : 같은수를 리턴, 없으면 -1
	 */	
	public static int findInt(int[] array, int value) {
		for (int i = 0; i < array.length; i++) {
			if (array[i] == value) {
				return i;
			}
		} 
		return -1;
   }
	
}