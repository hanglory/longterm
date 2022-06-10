package com.harmony.longterm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.harmony.longterm.vo.SiteinfoVO;


@Repository
public class SiteinfoDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

    /** MAPPER_PATH */
    private final String MAPPER_PATH = "siteadm.";

    /**
     * <PRE>
     * 설명 : 팝업레이어 건수 조회
     * </PRE>
     * @param map
     * @return	int
     * @throws Exception
     */
	public int selectSiteinfoTotCnt(SiteinfoVO siteinfoVO) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectSiteinfoTotCnt", siteinfoVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 팝업레이어 목록 조회
	 * </PRE>
	 * @param map
	 * @return List<SiteinfoVO>
	 * @throws Exception
	 */
	public List<SiteinfoVO> selectSiteinfoList(SiteinfoVO siteinfoVO) throws Exception{
		return this.sqlSession.selectList(MAPPER_PATH + "selectSiteinfoList", siteinfoVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 팝업레이어 단건 조회
	 * </PRE>
	 * @param map
	 * @return SiteinfoVO
	 * @throws Exception
	 */
	public SiteinfoVO selectSiteinfo(SiteinfoVO siteinfoVO) throws Exception{
		return this.sqlSession.selectOne(MAPPER_PATH + "selectSiteinfo", siteinfoVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 팝업레이어 저장
	 * </PRE>
	 * @param siteinfoVO
	 */
	public int insertSiteinfo(SiteinfoVO siteinfoVO) {
		return this.sqlSession.insert(MAPPER_PATH + "insertSiteinfo", siteinfoVO);
	}


	/**
	 * <PRE>
	 * 설명 : 팝업레이어 수정
	 * </PRE>
	 * @param siteinfoVO
	 */
	public void updateSiteinfo(SiteinfoVO siteinfoVO) {
		this.sqlSession.update(MAPPER_PATH + "updateSiteinfo", siteinfoVO);
	}
	
	/**
	 * <PRE>
	 * 설명 : 팝업레이어 삭제
	 * </PRE>
	 * @param id
	 */
	public void deleteSiteinfo(SiteinfoVO siteinfoVO) {
		this.sqlSession.delete(MAPPER_PATH + "deleteSiteinfo", siteinfoVO);
	}

}
