package com.harmony.longterm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.harmony.longterm.utils.VOUtils;
import com.harmony.longterm.vo.SummernoteVO;
import com.harmony.longterm.service.ISummernoteService;

@RequestMapping("/editor")
@Controller
public class SummernoteController {

	@Autowired
	private ISummernoteService summernoteService;

    /** 
     * <PRE>
     * 설명 : 썸머노트 이미지 저장
     * </PRE>
     * @param request
     * @param summernoteVO
     * @return
     * @throws Exception 
     */
    @RequestMapping("/imgFileUploadAjax")
    @ResponseBody
    public Map<String, Object> imgFileUploadAjax(MultipartHttpServletRequest request, SummernoteVO summernoteVO) throws Exception{
		List<MultipartFile> files = request.getFiles("uploadImageFiles");
    	List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if(files == null || files.size() <= 0) {
			summernoteVO.setResultCode("UPLOAD_FAIL");
			Map<String, Object> objectAsMap = VOUtils.convert(summernoteVO, new String[]{"resultCode", "fileURL", "fileName"});
			return objectAsMap;
		} else {
			Map<String, Object> returnMap = new HashMap<String, Object>();
			for (MultipartFile file : files) {
				summernoteVO = summernoteService.imgFileUpload(file, summernoteVO);
				String resultCode = summernoteVO.getResultCode();
				if (resultCode != null && !"".equals(resultCode)) {
					returnMap.put("resultCode", resultCode);
					return returnMap;
				}
				Map<String, Object> objectAsMap = VOUtils.convert(summernoteVO, new String[]{"resultCode", "fileURL", "fileName"});
				fileList.add(objectAsMap);
			}
			returnMap.put("fileList", fileList);
			returnMap.put("resultCode", "");
			return returnMap;
		}
    	
    }
    
	/** 
	 * <PRE>
	 * 설명 : 썸머노트 동영상 검증
	 * </PRE>
	 * @param summernoteVO
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/videoAjax")
	@ResponseBody
	public Map<String, Object> videoAjax(SummernoteVO summernoteVO) throws Exception {
		summernoteVO = summernoteService.getVideoTag(summernoteVO);
		Map<String, Object> objectAsMap = VOUtils.convert(summernoteVO, new String[]{"resultCode", "videoType", "videoUrl"});
		return objectAsMap;
	}

	/** 
	 * <PRE>
	 * 설명 : 썸머노트 URL 검증
	 * </PRE>
	 * @param url
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/opengraphAjax")
	@ResponseBody
	public Map<String,List<String>> opengraphAjax(@RequestParam("url") String url) throws Exception {
		return summernoteService.opengraph(url);
	}
	
	/** 
	 * <PRE>
	 * 설명 : 썸머노트 종목차트삽입
	 * </PRE>
	 * @param request
	 * @return url
	 * @throws  
	 */
	@RequestMapping("/candleChartAjax")
	@ResponseBody
	public Map<String, String> candleChartAjax(HttpServletRequest request) throws Exception {
		return summernoteService.candleChartAjax(request);
	}

}
