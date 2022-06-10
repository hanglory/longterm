package com.harmony.longterm.service;

import java.util.List;

import com.harmony.longterm.vo.SiteinfoVO;

public interface ISiteinfoService {
	public int selectSiteinfoTotCnt(SiteinfoVO siteinfoVO) throws Exception;
	public List<SiteinfoVO> selectSiteinfoList(SiteinfoVO siteinfoVO) throws Exception;
	public SiteinfoVO selectSiteinfo(SiteinfoVO siteinfoVO) throws Exception;
	public int insertSiteinfo(SiteinfoVO siteinfoVO) throws Exception;
	public void deleteSiteinfo( SiteinfoVO siteinfoVO) throws Exception;
	public void updateSiteinfo( SiteinfoVO siteinfoVO) throws Exception;
}
