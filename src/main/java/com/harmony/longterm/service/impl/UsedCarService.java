package com.harmony.longterm.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.dao.UsedCarDao;
import com.harmony.longterm.service.IUsedCarService;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.UsedCarVO;
import com.mysql.cj.util.StringUtils;

@Service
public class UsedCarService implements IUsedCarService {

	@Resource(name="configProps")
    private Properties props;
	
	
	
	private static final String DATA_GUBUN = "|";
	private static final String DATA_NEXT = "\r\n";

	@Value("#{configProps['BOARD_FILE_SIZE'] }") private String BOARD_FILE_SIZE;
	@Value("#{configProps['BOARD_COMMENT_FILE_SIZE'] }") private String BOARD_COMMENT_FILE_SIZE;
	@Value("#{configProps['BOARD_FILE_DIR'] }") private String BOARD_FILE_DIR;
	@Value("#{configProps['BOARD_FILE_URL'] }") private String BOARD_FILE_URL;
	@Value("#{configProps['BOARD_FILE_TEMP_DIR'] }") private String BOARD_FILE_TEMP_DIR;
	@Value("#{configProps['BOARD_FILE_THUMBNAIL_DIR'] }") private String BOARD_FILE_THUMBNAIL_DIR;
	@Value("#{configProps['BOARD_FILE_THUMBNAIL_URL'] }") private String BOARD_FILE_THUMBNAIL_URL;
	@Value("#{configProps['BOARD_COMMENT_IMG_DIR'] }") private String BOARD_COMMENT_IMG_DIR;
	@Value("#{configProps['BOARD_COMMENT_IMG_URL'] }") private String BOARD_COMMENT_IMG_URL;

	@Value("#{configProps['file.img.exp'] }") private String imgExp;

	/** 카페홈 게시판 DAO */
	@Autowired
	private UsedCarDao usedCarDao;
		
	
	@Override
	public List<UsedCarVO> selectUsedCarList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return usedCarDao.selectUsedCarList(map);
	}

	@Override
	public void deleteUsedCar(UsedCarVO usedCarVO) throws Exception {
		// TODO Auto-generated method stub
		usedCarDao.deleteUsedCar(usedCarVO);
	}

	@Override
	public String uploadCommentImg(MultipartFile multipartFile, UsedCarVO usedCarVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * <PRE>
	 * 설명 : 카페홈 공지사항 게시물 수정
	 * </PRE>
	 * @see com.moneta.pro.cafehome.cafeboard.service.ICafeBoardService#updateNotice(com.moneta.framework.nauth.datamodel.LoginCustVO, com.moneta.pro.cafehome.cafeboard.domain.CafeBoardVO)
	 */
	@Override
	public void updateUsedCar( UsedCarVO usedCarVO) throws Exception{
//		usedCarVO.setBcId("usedCar");
		this.saveUsedCar( usedCarVO);
	}	

	/**
	 * <PRE>
	 * 설명 : 게시물 저장 공통
	 * </PRE>
	 * @param custVO
	 * @param cafeBoardVO
	 * @throws Exception
	 */
	private void saveUsedCar( UsedCarVO usedCarVO) throws Exception{
		//디코딩
		this._decodeCafeBoard(usedCarVO);
		
		//에디터 이미지 저장
//		this.setContentsWithCreateImageFile(usedCarVO);

		if(StringUtils.isNullOrEmpty(usedCarVO.getId())) {
			//등록
			this._setInsertCafeBoard(usedCarVO);
			
			usedCarDao.insertUsedCar(usedCarVO);
			
			//update
//			this._setUpdateCafeBoard(usedCarVO);
//			cafeboardDAO.updateCafeBoard4Insert(usedCarVO);
		} else {
			//수정
			this._setInsertCafeBoard(usedCarVO);
			
			usedCarDao.updateUsedCar(usedCarVO);
		}
		
		//첨부파일
//		this.saveBoardFile(usedCarVO);
		//
		
		usedCarVO.setResultCode("0000");
	}

	/**
	 * <PRE>
	 * 설명 : 제목, 내용 urlPaxDecode
	 * </PRE>
	 * @param cafeBoardVO
	 * @throws Exception
	 */
	private void _decodeCafeBoard(UsedCarVO usedCarVO) throws Exception {
		if( ! StringUtils.isNullOrEmpty(usedCarVO.getEtc_memo())) {
			usedCarVO.setEtc_memo(Utils.urlPaxDecode(usedCarVO.getEtc_memo()));
		}
		
		if( ! StringUtils.isNullOrEmpty(usedCarVO.getDetailDesc())) {
			usedCarVO.setContents(Utils.urlPaxDecode(usedCarVO.getDetailDesc()));
		}
	}

	/**
	 * <PRE>
	 * 설명 : 게시물 저장 할 데이터 가공
	 * </PRE>
	 * @param custVO
	 * @param cafeBoardVO
	 * @throws Exception
	 */
	private void _setInsertCafeBoard( UsedCarVO usedCarVO) throws Exception {
/*		
		cafeBoardVO.setPaxId(custVO.getCustId());
		cafeBoardVO.setBdName(custVO.getNickNm());
		cafeBoardVO.setBdIp(custVO.getRequestClientIp());
*/
		if(StringUtils.isNullOrEmpty(usedCarVO.getView_cnt())) {
			usedCarVO.setView_cnt("0");
		}
		
		if(StringUtils.isNullOrEmpty(usedCarVO.getPeriod())) {
			usedCarVO.setPeriod("0");
		}
		
		if(StringUtils.isNullOrEmpty(usedCarVO.getDeposit())) {
			usedCarVO.setDeposit("0");
		}
		
		if(StringUtils.isNullOrEmpty(usedCarVO.getContents())) {
			usedCarVO.setContents("");
		}

		if(StringUtils.isNullOrEmpty(usedCarVO.getRentfee())) {
			usedCarVO.setRentfee("0");
		}

		if(StringUtils.isNullOrEmpty(usedCarVO.getRentfee_1())) {
			usedCarVO.setRentfee_1("0");
		}

		if(StringUtils.isNullOrEmpty(usedCarVO.getRentfee_24())) {
			usedCarVO.setRentfee_24("0");
		}

		if(StringUtils.isNullOrEmpty(usedCarVO.getTrim_price())) {
			usedCarVO.setTrim_price("0");
		}

	}
	
	
	/**
	 * <PRE>
	 * 설명 : 내용 및 이미지 생성
	 * </PRE>
	 * @param cafeBoardVO
	 * @throws Exception
	 */
	private void setContentsWithCreateImageFile(UsedCarVO usedCarVO) throws Exception {
		String contents = usedCarVO.getContents();

		if( ! StringUtils.isNullOrEmpty(contents)) {
//			String dir = this.CAFEHOME_BOARD_FILE_DIR + usedCarVO.getBcId() + File.separator;
			String src = "";
			String extendName = "";
			String fileName = "";
			
			Document doc = Jsoup.parse(contents);
			
			Elements images = doc.select("img");

			for(Element image : images) {
				src = image.attr("src");
				
				if(src.startsWith("data:image")) {
					//에디터
					fileName = image.attr("data-filename");
					extendName = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					fileName = DateUtil.getTodayWithHMS3() + extendName;

//					fileManager.createFileImageBase64(src, dir + fileName);
					
					//src 변경
					src = this.BOARD_FILE_URL + usedCarVO.getBcId() + "/" + fileName;
					image.attr("src", src);
				}
			
				usedCarVO.setContents(doc.body().html());
			}
		}
	}

	@Override
	public UsedCarVO selectUsedCar(Map<String, Object> map) throws Exception {
		return usedCarDao.selectUsedCar(map);
//		return null;
	}

	@Override
	public int selectUsedCarTotCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return usedCarDao.selectUsedCarTotCnt(map);
//		return 0;
	}

	@Override
	public void updateUsedCarViewCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		usedCarDao.updateUsedCarViewCnt(map);
	}	
	
}
