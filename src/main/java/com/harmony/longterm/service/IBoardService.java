package com.harmony.longterm.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.vo.BoardVO;

public interface IBoardService {
	public int selectBoardTotCnt(Map<String,Object> map) throws Exception;
	public List<BoardVO> selectBoardList(Map<String, Object> map) throws Exception;
	public int insertBoard(BoardVO boardVO) throws Exception;
	public void deleteBoard( BoardVO boardVO) throws Exception;
	public void updateBoard( BoardVO boardVO) throws Exception;
	public void updateBoardViewCnt(BoardVO boardVO) throws Exception;
	public String uploadAddFile(MultipartFile multipartFile, BoardVO boardVO) throws Exception;
	
}
