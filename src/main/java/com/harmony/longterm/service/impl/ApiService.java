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
import com.harmony.longterm.dao.ApiDao;
import com.harmony.longterm.service.IApiService;
import com.harmony.longterm.vo.ApiRecvDataVO;

@Service
public class ApiService implements IApiService {
	private static final Logger logger = LoggerFactory.getLogger(ApiService.class);
	
	@Resource(name="configProps")
    private Properties props;
	
	
	@Autowired
	private ApiDao apiDao;

	@Override
	public List<ApiRecvDataVO> selectApiRecvDataList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return apiDao.selectApiRecvDataList(map);
	}
	@Override
	public int insertApiRecvData(ApiRecvDataVO apiHyundaiVO) throws Exception {
		// TODO Auto-generated method stub
		return apiDao.insertApiRecvData(apiHyundaiVO);
	}

	@Override
	public void deleteApiRecvData(ApiRecvDataVO apiHyundaiVO) throws Exception {
		// TODO Auto-generated method stub
		apiDao.deleteApiRecvData(apiHyundaiVO);
	}
	@Override
	public void updateApiRecvData(ApiRecvDataVO apiHyundaiVO) throws Exception {
		// TODO Auto-generated method stub
		apiDao.updateApiRecvData(apiHyundaiVO);

	}
}
