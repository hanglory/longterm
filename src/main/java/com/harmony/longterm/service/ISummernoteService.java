package com.harmony.longterm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.vo.SummernoteVO;

public interface ISummernoteService {

	/** 
	 * <PRE>
	 * 설명 : 썸머노트 이미지 저장
	 * </PRE>
	 * @param imageFile
	 * @param summernoteVO
	 * @return
	 * @throws Exception 
	 */
	public SummernoteVO imgFileUpload(MultipartFile imageFile, SummernoteVO summernoteVO) throws Exception;

	/** 
	 * <PRE>
	 * 설명 : 썸머노트 동영상 검증
	 * </PRE>
	 * @param summernoteVO
	 * @return
	 * @throws Exception 
	 */
	public SummernoteVO getVideoTag(SummernoteVO summernoteVO) throws Exception;
	
	/** 
	 * <PRE>
	 * 설명 : 썸머노트 URL 검증
	 * </PRE>
	 * @param url
	 * @return
	 * @throws Exception 
	 */
	public Map<String, List<String>> opengraph(String url) throws Exception;

	/** 
	 * <PRE>
	 * 설명 : 썸머노트 종목차트삽입
	 * </PRE>
	 * @param request
	 * @return url
	 */
	public Map<String, String> candleChartAjax(HttpServletRequest request) throws Exception;
}

