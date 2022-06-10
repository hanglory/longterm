package com.harmony.longterm.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.harmony.longterm.vo.BoardVO;

/**
 * <pre>
 * 설명 : 게시판 DAO
 * com.harmony.longterm.dao
 *   |_ CafeBoardDAO.java
 * </pre>
 * @Author  : kkh
 * @Date    : 2022. 2. 20.
 * @History
 *  이름     : 일자          : 변경내용
 * ------------------------------------------------------
 *  kkh : 2022. 2. 20. : 신규 개발.
 */
@Repository
public class BoardDao  {

	@Autowired
	private SqlSessionTemplate sqlSession;

    /** MAPPER_PATH */
    private final String MAPPER_PATH = "bbs.";

    /**
     * <PRE>
     * 설명 : 게시물 건수 조회
     * </PRE>
     * @param boardVO
     * @return int
     * @throws Exception
     */
	public int selectBoardTotCnt(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectBoardTotCnt", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 목록 조회
	 * </PRE>
	 * @param boardVO
	 * @return BoardVO
	 * @throws Exception
	 */
	public List<BoardVO> selectBoardList(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectList(MAPPER_PATH + "selectBoardList", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 조회
	 * </PRE>
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoard(BoardVO boardVO) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectBoard", boardVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 저장
	 * </PRE>
	 * @param boardVO
	 * @return int
	 */
	public int insertBoard(BoardVO boardVO) {
		return this.sqlSession.insert(MAPPER_PATH + "insertBoard", boardVO);
	}


	/**
	 * <PRE>
	 * 설명 : 게시물 수정
	 * </PRE>
	 * @param boardVO
	 */
	public void updateBoard(BoardVO boardVO) {
		this.sqlSession.update(MAPPER_PATH + "updateBoard", boardVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 수정
	 * </PRE>
	 * @param boardVO
	 */
	public void updateBoardViewCnt(BoardVO boardVO) {
		this.sqlSession.update(MAPPER_PATH + "updateBoardViewCnt", boardVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 삭제
	 * </PRE>
	 * @param boardVO
	 */
	public void deleteBoard(BoardVO boardVO) {
		this.sqlSession.delete(MAPPER_PATH + "deleteBoard", boardVO);
	}

}
