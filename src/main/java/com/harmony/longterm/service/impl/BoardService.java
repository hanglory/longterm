package com.harmony.longterm.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gabia.api.ApiClass;
import com.gabia.api.ApiResult;
import com.harmony.longterm.controller.BoardController;
import com.harmony.longterm.dao.BoardDao;
import com.harmony.longterm.service.IBoardService;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.BoardVO;
import com.harmony.longterm.vo.UsedCarVO;
import com.mysql.cj.util.StringUtils;

@Service
public class BoardService implements IBoardService {
	private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Resource(name="configProps")
    private Properties props;
	
	
	@Autowired
	private BoardDao boardDao;

	@Override
	public int selectBoardTotCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardTotCnt(map);
	}
	
	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardList(map);
	}
	@Override
	public int insertBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		this._decodeBoard(boardVO);
		return boardDao.insertBoard(boardVO);
	}

	@Override
	public void deleteBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		boardDao.deleteBoard(boardVO);
	}
	@Override
	public void updateBoardViewCnt(BoardVO boardVO) throws Exception {
		boardDao.updateBoardViewCnt(boardVO);
	}
	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		this._decodeBoard(boardVO);		
		boardDao.updateBoard(boardVO);

	}

	@Override
	public String uploadAddFile(MultipartFile multipartFile, BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		if (multipartFile.getSize() < (50 * 1024 * 1024)) {
			String dir = (String) props.get("BOARD_FILE_DIR");
			String url = (String) props.get("BOARD_FILE_URL");
			
			if(StringUtils.isNullOrEmpty(multipartFile.getOriginalFilename())) {
				boardVO.setResultCode("FILE_IS_NULL");
				return "File_NULL";
			}
			
			dir = dir + boardVO.getBd_reguser() + File.separator;
			url = url + boardVO.getBd_reguser() + "/";
			//. 포함
			String extendName = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
			
			String fileName = multipartFile.getOriginalFilename();
					//noticeVO.getBcId() + "_" + noticeVO.getBctNo() + "_" + noticeVO.getBdNo() + "_" + boardFileVO.getBfSNo() + "_" + custVO.getCustId() + extendName;
			
			File filePath = new File(dir);
			if (!filePath.isDirectory()) {
				filePath.mkdirs();
			}
			
			try {
				File file = new File(dir + fileName);
				multipartFile.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			boardVO.setBd_filelink(url + fileName);
			boardVO.setBd_filename(fileName);
		} else {
			boardVO.setResultCode("MAX_SIZE");
			return "MAX_SIZE";
		}

		return "0000";
	}

	private void _decodeBoard(BoardVO boardVO) throws Exception {
		if( ! StringUtils.isNullOrEmpty(boardVO.getBd_title())) {
			boardVO.setBd_title(Utils.urlPaxDecode(boardVO.getBd_title()));
		}
		
		if( ! StringUtils.isNullOrEmpty(boardVO.getBd_contents())) {
			boardVO.setBd_contents(Utils.urlPaxDecode(boardVO.getBd_contents()));
		}
	}

	public Map<String, Object> sendSms(HttpServletRequest request,Map<String, Object> map ){
		   Map<String, Object> resultMap = new HashMap<String,Object>();
		   
		   String api_id = "inacar2011";		// sms.gabia.com 이용 ID
		   String api_key = "0e79114156e076bad7b1b06a1d94d7ae";	// 환결설정에서 확인 가능한 SMS API KEY
		   String resultXml = "";
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//		   param.get("phoneNo")
		   if(map.get("phoneNo").toString().length() < 12) {
			   resultMap.put("smsCode", "9999");	//핸드폰 번호가 올바르지 않음.
			   logger.debug("핸드폰 번호가 올바르지 않음:"+map.get("phoneNo").toString());
			   return resultMap;
		   }

//		   resultMap.put("test", "resultXml");
//		   if( 1 == 1)
//			   return resultMap;
		   
		   ApiClass api = new ApiClass(api_id, api_key);
		   long timeInMillis =System.currentTimeMillis();
		   Date timeInDate = new Date(timeInMillis); 
	       String timeInFormat = sdf.format(timeInDate);

	       String clientIP = Utils.getClientIP(request);
		   System.out.println("timeMillis=" + timeInFormat);
		   // 단문 발송 테스트
		   String arr[] = new String[7];
		   arr[0] = "sms";							// 발송 타입 sms or lms
		   arr[1] = timeInFormat;	// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
		   arr[2] = clientIP;					//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
		   arr[3] = map.get("message").toString(); //"하모니렌트카 인증번호는["+authNumber+"]입니다.";	// 본문 (90byte 제한)
		   arr[4] = "1661-9763";			// 발신 번호
		   arr[5] = map.get("phoneNo").toString();			// 수신 번호
		   arr[6] = "0";					//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 

		   String responseXml = api.send(arr);
		   System.out.println("response xml : \n" + responseXml);

		   ApiResult res = api.getResult( responseXml );
		   logger.debug( "code = [" + res.getCode() + "] mesg=[" + res.getMesg() + "]" );

		   if( res.getCode().compareTo("0000") == 0 )
		   {
//		   		resultXml = api.getResultXml(responseXml);
//		   		resultMap.put("seneResultXml", resultXml);
//		   		logger.debug("Send result xml : " + resultXml);
		   }
		   resultMap.put("smsCode", res.getCode());
		   resultMap.put("keyValue", timeInMillis);
//		   resultMap.put("authKey", authNumber);
		   return resultMap;
	}
}
