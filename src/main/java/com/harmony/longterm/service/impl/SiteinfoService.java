package com.harmony.longterm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.harmony.longterm.dao.SiteinfoDao;
import com.harmony.longterm.service.ISiteinfoService;
import com.harmony.longterm.vo.SiteinfoVO;

@Service
public class SiteinfoService implements ISiteinfoService {

	@Autowired
	private SiteinfoDao siteinfoDao;
	
	@Override
	public int selectSiteinfoTotCnt(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		return siteinfoDao.selectSiteinfoTotCnt(siteinfoVO);
	}

	@Override
	public List<SiteinfoVO> selectSiteinfoList(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		return siteinfoDao.selectSiteinfoList(siteinfoVO);
	}

	@Override
	public SiteinfoVO selectSiteinfo(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		return siteinfoDao.selectSiteinfo(siteinfoVO);
	}

	@Override
	public int insertSiteinfo(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		return siteinfoDao.insertSiteinfo(siteinfoVO);
	}

	@Override
	public void deleteSiteinfo(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		siteinfoDao.deleteSiteinfo(siteinfoVO);
	}

	@Override
	public void updateSiteinfo(SiteinfoVO siteinfoVO) throws Exception {
		// TODO Auto-generated method stub
		siteinfoDao.updateSiteinfo(siteinfoVO);
	}

}
