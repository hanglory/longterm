package com.harmony.longterm.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.dao.BoardDao;
import com.harmony.longterm.service.IBoardService;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.BoardVO;
import com.harmony.longterm.vo.UsedCarVO;
import com.mysql.cj.util.StringUtils;

@Service
public class BoardService implements IBoardService {

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

	
}
