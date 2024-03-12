package com.harmony.longterm.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.harmony.longterm.vo.ApiRecvDataVO;
import com.harmony.longterm.vo.BoardVO;

/**
 * <pre>
 * 설명 : 외부사 API DAO
 * com.harmony.longterm.dao
 * </pre>
 * @Author  : kkh
 * @Date    : 2023. 5. 24.
 * @History
 *  이름     : 일자          : 변경내용
 * ------------------------------------------------------
 *  kkh : 2023. 5. 24. : 신규 개발.
 */
@Repository
public class ApiDao  {

	@Autowired
	private SqlSessionTemplate sqlSession;

    /** MAPPER_PATH */
    private final String MAPPER_PATH = "api.";


    
	/**
	 * <PRE>
	 * 설명 : 외주에서 받은 데이타 내역 리스트
	 * </PRE>
	 * @param Map
	 * @return ApiHyundaiVO
	 * @throws Exception
	 */
	public List<ApiRecvDataVO> selectApiRecvDataList(Map<String, Object> map) throws Exception{
		return this.sqlSession.selectList(MAPPER_PATH + "selectApiRecvDataList", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 현대케피탈에서 받은 데이타 저장
	 * </PRE>
	 * @param boardVO
	 * @return int
	 */
	public int insertApiRecvData(ApiRecvDataVO apiRecvDataVO) {
		return this.sqlSession.insert(MAPPER_PATH + "insertApiRecvData", apiRecvDataVO);
	}


	/**
	 * <PRE>
	 * 설명 : 게시물 수정
	 * </PRE>
	 * @param boardVO
	 */
	public void updateApiRecvData(Map<String, Object> map) {
		this.sqlSession.update(MAPPER_PATH + "updateApiRecvData", map);
	}
	
	/**
	 * <PRE>
	 * 설명 : 게시물 삭제
	 * </PRE>
	 * @param boardVO
	 */
	public void deleteApiRecvData(ApiRecvDataVO apiRecvDataVO) {
		this.sqlSession.delete(MAPPER_PATH + "deleteApiRecvData", apiRecvDataVO);
	}

}
