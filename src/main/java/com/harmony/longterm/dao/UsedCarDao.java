package com.harmony.longterm.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.harmony.longterm.vo.UsedCarVO;

/**
 * <pre>
 * 설명 : 게시판/신차리스트 DAO
 * com.harmony.longterm.dao
 *   |_ UsedCarDao.java
 * </pre>
 * @Author  : KKH
 * @Date    : 2022. 02. 10
 * @History
 *  이름     : 일자          : 변경내용
 * ------------------------------------------------------
 *  KKH : 2022. 02. 10. : 신규 개발.
 */
@Repository
public class UsedCarDao  {

	@Autowired
	private SqlSessionTemplate sqlSession;

    /** MAPPER_PATH */
    private final String MAPPER_PATH = "usedcar.";

    /**
     * <PRE>
     * 설명 : 게시물 건수 조회
     * </PRE>
     * @param cafeBoardBaseVO
     * @return
     * @throws Exception
     */
	public int selectUsedCarTotCnt(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectUsedCarTotCnt", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 목록 조회
	 * </PRE>
	 * @param cafeBoardBaseVO
	 * @return
	 * @throws Exception
	 */
	public List<UsedCarVO> selectUsedCarList(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectList(MAPPER_PATH + "selectUsedCarList", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 조회
	 * </PRE>
	 * @param cafeBoardBaseVO
	 * @return
	 * @throws Exception
	 */
	public UsedCarVO selectUsedCar(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectUsedCar", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 저장
	 * </PRE>
	 * @param cafeBoardVO
	 */
	public int insertUsedCar(UsedCarVO usedCarVO) {
		return this.sqlSession.insert(MAPPER_PATH + "insertUsedCar", usedCarVO);
	}


	/**
	 * <PRE>
	 * 설명 : 게시물 수정
	 * </PRE>
	 * @param cafeBoardVO
	 */
	public void updateUsedCar(UsedCarVO usedCarVO) {
		this.sqlSession.update(MAPPER_PATH + "updateUsedCar", usedCarVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 수정
	 * </PRE>
	 * @param cafeBoardVO
	 */
	public void updateUsedCarViewCnt(Map<String, Object> map) {
		this.sqlSession.update(MAPPER_PATH + "updateUsedCarViewCnt", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 삭제
	 * </PRE>
	 * @param cafeBoardVO
	 */
	public void deleteUsedCar(UsedCarVO usedCarVO) {
		this.sqlSession.delete(MAPPER_PATH + "deleteUsedCar", usedCarVO);
	}

}
