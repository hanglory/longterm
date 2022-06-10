package com.harmony.longterm.service.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.service.ISummernoteService;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.ImageUtil;
import com.harmony.longterm.utils.OpenGraph;
import com.harmony.longterm.vo.SummernoteVO;
import com.mysql.cj.util.StringUtils;

@Service
public class SummernoteService implements ISummernoteService {

	
	@Resource(name = "configProps")
	private Properties properties;
	
	/**
	 * <PRE>
	 * 설명 :  썸머노트 이미지 저장
	 * </PRE>
	 * @see com.moneta.pro.common.service.ISummernoteService#imgFileUpload(org.springframework.web.multipart.MultipartFile, com.moneta.pro.common.domain.SummernoteVO)
	 */
	@Override
	public SummernoteVO imgFileUpload(MultipartFile imageFile, SummernoteVO summernoteVO) throws Exception {
		if(StringUtils.isNullOrEmpty(summernoteVO.getGroup1Id()) || StringUtils.isNullOrEmpty(summernoteVO.getGroup2Id())) {
			summernoteVO.setResultCode("NOT_KEY");
			return summernoteVO;
		}
		
		if (imageFile.getSize() < Integer.parseInt((String)properties.get("summernote.image.file.size")) ) {
			String dir = (String) properties.get("summernote.image.file.path");
			dir = dir + summernoteVO.getGroup1Id() + File.separator + summernoteVO.getGroup2Id() + File.separator;
			
			//. 포함
			String extendName = imageFile.getOriginalFilename().substring(imageFile.getOriginalFilename().lastIndexOf("."), imageFile.getOriginalFilename().length());

			//날짜 + 고객id + .확장자
			String fileName = DateUtil.getTodayWithHMS3() + extendName;

			//CAFE_UPLOAD_PATH
			summernoteVO.setFileURL((String) properties.get("summernote.image.file.url") + summernoteVO.getGroup1Id() + "/" + summernoteVO.getGroup2Id() + "/");
			summernoteVO.setFileName(fileName);
		
			File directory = new File(dir);
			if ( ! directory.isDirectory()) {
				directory.mkdirs();
			}

			saveImgFile(imageFile, dir + fileName);

		} else {
			summernoteVO.setResultCode("MAX_SIZE");
		}

		return summernoteVO;
	}

    @Async
    public void saveImgFile(MultipartFile imageFile, String filePath) throws Exception {
    	try {
			File file = new File(filePath);
			imageFile.transferTo(file);
//			if(imageFile.getSize() > 1048576){
				ImageUtil.resizeUploadImg(filePath);
//			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }

	/** 
	 * <PRE>
	 * 설명 : 백업(이전버전)  썸머노트 이미지 저장
	 * </PRE>
	 * @param imageFile
	 * @param summernoteVO
	 * @return
	 * @throws Exception 
	 */
	public SummernoteVO imgFileUpload_086(MultipartFile imageFile, SummernoteVO summernoteVO) throws Exception {
		if(StringUtils.isNullOrEmpty(summernoteVO.getGroup1Id()) || StringUtils.isNullOrEmpty(summernoteVO.getGroup2Id())) {
			summernoteVO.setResultCode("NOT_KEY");
			return summernoteVO;
		}
		
		if (imageFile.getSize() < Integer.parseInt((String)properties.get("summernote.image.file.size")) ) {
			String dir = (String) properties.get("summernote.image.file.path");
			dir = dir + summernoteVO.getGroup1Id() + File.separator + summernoteVO.getGroup2Id() + File.separator;
			
			//. 포함
			String extendName = imageFile.getOriginalFilename().substring(imageFile.getOriginalFilename().lastIndexOf("."), imageFile.getOriginalFilename().length());

			//날짜 + 고객id + .확장자
			String fileName = DateUtil.getTodayWithHMS3() + extendName;

			//CAFE_UPLOAD_PATH
			summernoteVO.setFileURL((String) properties.get("summernote.image.file.url") + summernoteVO.getGroup1Id() + "/" + summernoteVO.getGroup2Id() + "/");
			summernoteVO.setFileName(fileName);
		
			File directory = new File(dir);
			if ( ! directory.isDirectory()) {
				directory.mkdirs();
			}

			try {
				File file = new File(dir + fileName);
				imageFile.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		} else {
			summernoteVO.setResultCode("MAX_SIZE");
		}

		return summernoteVO;
	}

	/**
	 * <PRE>
	 * 설명 : 썸머노트 동영상 검증
	 * </PRE>
	 * @see com.moneta.pro.common.service.ISummernoteService#getVideoTag(com.moneta.pro.common.domain.SummernoteVO)
	 */
	@Override
	public SummernoteVO getVideoTag(SummernoteVO summernoteVO) throws Exception {
		Map<String, List<String>> map = null;

		try {
			map = new OpenGraph(summernoteVO.getUrl()).getResult();
		} catch(Exception e) {
			summernoteVO.setResultCode("URL_FAIL");
			return summernoteVO;
		}
		/**
		 * 	kakao의 경우에는 metatag에 embedURL이 없음. -> 변환을해주어야함.
		 * 		전) http://tv.kakao.com/v/374626657
		 *		후) http://tv.kakao.com/embed/player/cliplink/374626657
		 */
		
		String kakaoUrl = (String) properties.get("summernote.link.kakao.urls");
		
		if(StringUtils.isNullOrEmpty(kakaoUrl)) {
			summernoteVO.setResultCode("FAIL_KAKAO_URL");
			return summernoteVO;
		}
		
		String[] kakaoUrls = kakaoUrl.split("\\|");
		
		if(summernoteVO.getUrl().indexOf(kakaoUrls[0]) != -1){
			String ogType = map.get("og:type").toString();
			
			String newUrl = summernoteVO.getUrl().replace(kakaoUrls[1], kakaoUrls[2]).replace(kakaoUrls[3], kakaoUrls[4]);

			if(!ogType.equals("video") && !ogType.equals("[video]")){
				// log.info("해당URL [" +url + "]은 og:type이 video가 아닙니다.");
				summernoteVO.setResultCode("NO_VIDEO");
				return summernoteVO;
			}else{
				summernoteVO.setVideoType(ogType);
				summernoteVO.setVideoUrl(newUrl);
			}
		}else{
			//한글값을 인코딩한다.
			String ogType = null;
			String ogVideo = null;
			String ogVideoUrl = null;
			
			List<String> ogTypeList = map.get("og:type");
			if(ogTypeList != null) {
				for(String type : ogTypeList) {
					ogType = type;
					break;
				}
			}
			
			List<String> ogVideoList = map.get("og:video");
			if(ogVideoList != null) {
				for(String video : ogVideoList) {
					ogVideo = video;
					break;
				}
			}
			
			if(StringUtils.isNullOrEmpty(ogVideo)) {
				List<String> ogVideoUrlList = map.get("og:video:url");
				if(ogVideoUrlList != null) {
					for(String videoUrl : ogVideoUrlList) {
						ogVideoUrl = videoUrl;
						break;
					}
				}
			}else {
				ogVideoUrl = ogVideo;
			}
			
			if(ogType == null || ogType.indexOf("video") < 0){
				//log.info("해당URL [" +url + "]은 og:type이 video가 아닙니다.");
				summernoteVO.setResultCode("NO_VIDEO");
				return summernoteVO;
			}else{
				//자동재생 false
				if(ogVideoUrl.indexOf("isAutoPlay=false") != -1){
					ogVideoUrl = ogVideoUrl.replace("isAutoPlay=true", "isAutoPlay=false");
				}else if (ogVideoUrl.indexOf("replace") != -1){
					ogVideoUrl = ogVideoUrl.replace("autoplay=1", "");
				}
				
				summernoteVO.setVideoType(ogType);
				summernoteVO.setVideoUrl(ogVideoUrl);
			}
		}

		return summernoteVO;
	}

	/**
	 * <PRE>
	 * 설명 : 썸머노트 URL 검증
	 * </PRE>
	 * @see com.moneta.pro.common.service.ISummernoteService#opengraph(java.lang.String)
	 */
	@Override
	public Map<String, List<String>> opengraph(String url) throws Exception {
		Map<String,List<String>> map = new OpenGraph(url).getResult();

		//한글값을 인코딩한다.
		String ogType = URLEncoder.encode(map.get("og:type").toString(), "UTF-8");
		String ogTitle = URLEncoder.encode(map.get("og:title").toString(), "UTF-8");
		String ogDescription = URLEncoder.encode(map.get("og:description").toString(), "UTF-8");
		String ogUrl = URLEncoder.encode(map.get("og:url").toString(), "UTF-8");
		String ogImage = URLEncoder.encode(map.get("og:image").toString(), "UTF-8");

		List<String> typeList = new ArrayList<>();
		typeList.add(ogType);
		List<String> titleList = new ArrayList<>();
		titleList.add(ogTitle);
		List<String> desList = new ArrayList<>();
		desList.add(ogDescription);
		List<String> urlList = new ArrayList<>();
		urlList.add(ogUrl);
		List<String> imageList = new ArrayList<>();
		imageList.add(ogImage);

		map.put("og:type", typeList);
		map.put("og:title", titleList);
		map.put("og:description", desList);
		map.put("og:url", urlList);
		map.put("og:image", imageList);

		return map;
	}

	/** 
	 * <PRE>
	 * 설명 : 썸머노트 종목차트삽입
	 * </PRE>
	 * @param request
	 * @return url
	 * @throws Exception 
	 */
	@Override
	public Map<String, String> candleChartAjax(HttpServletRequest request) throws Exception {
		
		
		String candleChartPath = (String) properties.get("candle.chart.path");
		String curDate = DateUtil.getCurDate("yyyyMMdd");
		String uploadPath = candleChartPath + curDate + File.separator;
		String imgChartUrl = "http://cichart.paxnet.co.kr/pax/chart/candleChart/V201717/paxCandleChartV201717Daily.jsp?abbrSymbol=";
		
		String targetUrl = "";
		URL url = null;
		String stockCode = request.getParameter("stockCode");
		
		imgChartUrl += stockCode;
			
		url = new URL(imgChartUrl);
		BufferedImage img = ImageIO.read(url);
			
		String fileName = UUID.randomUUID().toString();
			
		File f = new File(uploadPath);
		if(!f.exists())	f.mkdirs();

		uploadPath += fileName;
		
		f = new File(uploadPath+".png");
		ImageIO.write(img, "png", f);
		String candleChartUrl = (String) properties.get("candle.chart.url");
		targetUrl = candleChartUrl + "?imagePath=" + curDate + "/" + fileName + ".png";
		
		Map<String, String> chartMap = new HashMap<String, String>();
		chartMap.put("chartImageURL", targetUrl);
		
		return chartMap;
	}

}